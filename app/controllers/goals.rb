get '/goals/new' do
  erb :"goals/new"
end

post '/goals' do
  if current_user
    @user = current_user
  else
    redirect "/login"
  end

  @goal = Goal.new(params[:goal_info])
  @goal.setter = @user
  if @goal.save
    redirect "/goals/#{@goal.id}/edit"
  else
    @errors = @goal.errors.full_messages
    erb :"goals/new"
  end
end

get '/goals/:goal_id' do
  @goal = Goal.find(params[:goal_id])
  if current_user == @goal.setter
    @user = current_user
    erb :"goals/show"
  else
    redirect "/login"
  end
end

get '/goals/:goal_id/edit' do
  if current_user
    @user = current_user
  else
    redirect "/login"
  end

  @goal = Goal.find(params[:goal_id])
  erb :"goals/edit"
end

post '/goals/:goal_id' do
end