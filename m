Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751622AbWFCAJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbWFCAJB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 20:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbWFCAJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 20:09:01 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:28132 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751609AbWFCAJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 20:09:00 -0400
Message-ID: <4480D319.8040403@bigpond.net.au>
Date: Sat, 03 Jun 2006 10:08:57 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: sekharan@us.ibm.com, balbir@in.ibm.com, dev@openvz.org,
       Andrew Morton <akpm@osdl.org>, Srivatsa <vatsa@in.ibm.com>,
       Sam Vilain <sam@vilain.net>, ckrm-tech@lists.sourceforge.net,
       Balbir Singh <bsingharora@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ckrm-tech] [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	 <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>	 <661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com>	 <44781167.6060700@bigpond.net.au> <447D95DE.1080903@sw.ru>	 <447DBD44.5040602@in.ibm.com> <447E9A1D.9040109@openvz.org>	 <447EA694.8060407@in.ibm.com> <1149187413.13336.24.camel@linuxchandra>	 <447FD2E1.7060605@bigpond.net.au>	 <1149237992.9446.133.camel@Homer.TheSimpsons.net>	 <44803ABA.6050001@bigpond.net.au> <1149259639.8661.22.camel@Homer.TheSimpsons.net>
In-Reply-To: <1149259639.8661.22.camel@Homer.TheSimpsons.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 3 Jun 2006 00:08:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Fri, 2006-06-02 at 23:18 +1000, Peter Williams wrote:
>> Mike Galbraith wrote:
>>> On Fri, 2006-06-02 at 15:55 +1000, Peter Williams wrote:
>>>> Chandra Seetharaman wrote:
>>>>> On Thu, 2006-06-01 at 14:04 +0530, Balbir Singh wrote:
>>>>>> Hi, Kirill,
>>>>>>
>>>>>> Kirill Korotaev wrote:
>>>>>>>> Do you have any documented requirements for container resource 
>>>>>>>> management?
>>>>>>>> Is there a minimum list of features and nice to have features for 
>>>>>>>> containers
>>>>>>>> as far as resource management is concerned?
>>>>>>> Sure! You can check OpenVZ project (http://openvz.org) for example of 
>>>>>>> required resource management. BTW, I must agree with other people here 
>>>>>>> who noticed that per-process resource management is really useless and 
>>>>>>> hard to use :(
>>>>> I totally agree.
>>>> "nice" seems to be doing quite nicely :-)
>>>>
>>>> To me this capping functionality is a similar functionality to that 
>>>> provided by "nice" and all that's needed to make it useful is a command 
>>>> (similar to "nice") that runs tasks with caps applied.
>>> Similar in that they are both inherited.  Very dissimilar in that the
>>> effect of nice is not altered by fork whereas the effect of a cap is.
>>>
>>> Consider make.  A cap on make itself isn't meaningful, and _any_ per
>>> task cap you put on it with the intent of managing the aggregate, is
>>> defeated by the argument -j.  Per task caps require omniscience to be
>>> effective in managing processes.  That's a pretty severe limitation.
>> These caps aren't trying to control aggregates but with suitable 
>> software they can be used to control aggregates.
> 
> How?  How would you deal with the make example with per task caps.

I'd build a resource management tool that uses task statistics, nice and 
caps to manage CPU resource allocation.  This could be a plug in kernel 
module or a user space daemon.  It doesn't need to be in the scheduler.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
