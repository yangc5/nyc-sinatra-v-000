require 'pry'

class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  post '/figures' do
    figure = Figure.create(name: params[:figure][:name])

    if params[:figure][:title_ids]
      title = Title.find(params[:figure][:title_ids][0].to_i)
      figure.titles << title
    elsif params[:title][:name]
      title = Title.create(name: params[:title][:name])
      figure.titles << title
    end

    if params[:figure][:landmark_ids]
      landmark = Landmark.find(params[:figure][:landmark_ids][0].to_i)
      figure.landmarks << landmark
    elsif params[:landmark][:name]
      landmark = Landmark.create(name: params[:landmark][:name])
      figure.landmarks << landmark
    end
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/edit'
  end

  post '/figures/:id' do
    figure = Figure.find(params[:id])
    figure.update(name: params[:figure][:name])

    if params[:figure][:title_ids]
      title = Title.find(params[:figure][:title_ids][0].to_i)
      figure.titles << title
    elsif params[:title][:name]
      title = Title.create(name: params[:title][:name])
      figure.titles << title
    end

    if params[:figure][:landmark_ids]
      landmark = Landmark.find(params[:figure][:landmark_ids][0].to_i)
      figure.landmarks << landmark
    elsif params[:landmark][:name]
      landmark = Landmark.create(name: params[:landmark][:name])
      figure.landmarks << landmark
    end

    redirect "/figures/#{figure.id}"

  end

end