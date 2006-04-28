Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbWD1GAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWD1GAO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 02:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWD1GAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 02:00:14 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:39046 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030231AbWD1GAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 02:00:12 -0400
Message-ID: <4451B122.1010206@sw.ru>
Date: Fri, 28 Apr 2006 10:07:30 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: sekharan@us.ibm.com
CC: Andrew Morton <akpm@osdl.org>, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>	 <1145630992.3373.6.camel@localhost.localdomain>	 <1145638722.14804.0.camel@linuxchandra>	 <20060421155727.4212c41c.akpm@osdl.org>	 <1145670536.15389.132.camel@linuxchandra>	 <20060421191340.0b218c81.akpm@osdl.org> <1146189505.24650.221.camel@linuxchandra>
In-Reply-To: <1146189505.24650.221.camel@linuxchandra>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Worried.
> The object of this infrastructure is to get a unified interface for
> resource management, irrespective of the resource that is being managed.
> 
> As I mentioned in my earlier email, subsystem experts are the ones who
> will finally decide what type resource controller they will accept. With
> VM experts' direction and advice, i am positive that we will get an
> excellent memory controller (as well as other controllers).
> 
> As you might have noticed, we have gone through major changes to come to
> community's acceptance levels. We are now making use of all possible
> features (kref, process event connector, configfs, module parameter,
> kzalloc) in this infrastructure.
> 
> Having a CPU controller, two memory controllers, an I/O controller and a
> numtasks controller proves that the infrastructure does handle major
> resources nicely and is also capable of managing virtual resources.
> 
> Hope i reduced your worries (at least some :).
Not all :) Let me explain.

Until you provided something more complex then numtasks, this 
infrastructure is pure theory. For example, in your infrastracture, when 
you will add memory resource controller with data sharing, you will face 
that changing CKRM class of the tasks is almost impossible in a suitable 
way. Another possible situation: hierarchical classes with shared memory 
are even more complicated thing.

In both cases you can end up with a poor/complicated/slow solution or 
dropping some of your infrastructre features (changing class on the fly, 
hierarchy) or which is worse IMHO with incosistency between controllers 
and interfaces.

Thanks,
Kirill

