Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWFBNe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWFBNe0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 09:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWFBNe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 09:34:26 -0400
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:36580 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751425AbWFBNeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 09:34:25 -0400
Message-ID: <44803E5F.60806@bigpond.net.au>
Date: Fri, 02 Jun 2006 23:34:23 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Kirill Korotaev <dev@openvz.org>
CC: sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       Srivatsa <vatsa@in.ibm.com>, ckrm-tech@lists.sourceforge.net,
       balbir@in.ibm.com, Balbir Singh <bsingharora@gmail.com>,
       Mike Galbraith <efault@gmx.de>, Sam Vilain <sam@vilain.net>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ckrm-tech] [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>		<20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>		<661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com>		<44781167.6060700@bigpond.net.au> <447D95DE.1080903@sw.ru>		<447DBD44.5040602@in.ibm.com> <447E9A1D.9040109@openvz.org>		<447EA694.8060407@in.ibm.com>	<1149187413.13336.24.camel@linuxchandra> <447FD2E1.7060605@bigpond.net.au> <447FECFD.8000602@openvz.org>
In-Reply-To: <447FECFD.8000602@openvz.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 2 Jun 2006 13:34:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
>>>>> Sure! You can check OpenVZ project (http://openvz.org) for example 
>>>>> of required resource management. BTW, I must agree with other 
>>>>> people here who noticed that per-process resource management is 
>>>>> really useless and hard to use :(
>>>
>>>
>>> I totally agree.
>>
>>
>> "nice" seems to be doing quite nicely :-)
> I'm sorry, but nice never looked "nice" to me.
> Have you ever tried to "nice" apache server which spawns 500 
> processes/threads on a loaded machine?
> With nice you _can't_ impose limits or priority on the whole "apache".
> The more apaches you have the more useless their priorites and nices are...

Nevertheless "nice" is still useful.  I'd bet that just about every 
Linux system has at least one task with non normal nice at any time.

I think that these caps can be similarly useful.

They can be also used as the basic mechanism to implement the kind of 
thing you want from OUTSIDE of the scheduler.

> 
>> To me this capping functionality is a similar functionality to that 
>> provided by "nice" and all that's needed to make it useful is a 
>> command (similar to "nice") that runs tasks with caps applied.  To 
>> that end I've written a small script (attached) that does this.  As 
>> this is something that a user might like to combine with "nice" the 
>> command has an option for setting "nice" as well as caps.
>>
>> Usage:
>>         withcap [options] command [arguments ...]
>>         withcap -h
>> Options:
>>         [-c <CPU rate soft cap>]
>>         [-C <CPU rate hard cap>]
>>         [-n <nice value>]
>>
>>         -c Set CPU usage rate soft cap
>>         -C Set CPU usage rate hard cap
>>         -n Set nice value
>>         -h Display this help
> 
> the same for this. you can't limit a _user_, only his processes.
> Today I have 1 task and 20% limit is ok, tomorrow I have 10 tasks and 
> this 20% limits changes nothing in the system.

This still doesn't make it useless.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
