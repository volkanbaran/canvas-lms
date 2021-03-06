#
# Copyright (C) 2011 Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/messages_helper')

describe 'appointment_group_published.email' do
  it "should render" do
    course_with_student(:active_all => true)
    appointment_group_model(:contexts => [@course])

    generate_message(:appointment_group_published, :email, @appointment_group, :user => @user)

    @message.subject.should include('some title')
    @message.body.should include('some title')
    @message.body.should include(@course.name)
    @message.body.should include("/appointment_groups/#{@appointment_group.id}")
  end

  it "should render for groups" do
    user = user_model
    @course = course_model
    cat = @course.group_categories.create(:name => 'teh category')
    appointment_group_model(:contexts => [@course], :sub_context => cat)

    generate_message(:appointment_group_published, :email, @appointment_group)

    @message.subject.should include('some title')
    @message.body.should include('some title')
    @message.body.should include(@course.name)
    @message.body.should include(cat.name)
    @message.body.should include("/appointment_groups/#{@appointment_group.id}")
  end
end
