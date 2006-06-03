Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932602AbWFCLD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbWFCLD7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 07:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbWFCLD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 07:03:59 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:30695 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932602AbWFCLD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 07:03:59 -0400
Message-ID: <44816C9B.9020708@bigpond.net.au>
Date: Sat, 03 Jun 2006 21:03:55 +1000
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
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	 <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>	 <661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com>	 <44781167.6060700@bigpond.net.au> <447D95DE.1080903@sw.ru>	 <447DBD44.5040602@in.ibm.com> <447E9A1D.9040109@openvz.org>	 <447EA694.8060407@in.ibm.com> <1149187413.13336.24.camel@linuxchandra>	 <447FD2E1.7060605@bigpond.net.au>	 <1149237992.9446.133.camel@Homer.TheSimpsons.net>	 <44803ABA.6050001@bigpond.net.au>	 <1149259639.8661.22.camel@Homer.TheSimpsons.net>	 <4480D319.8040403@bigpond.net.au> <1149314532.7513.40.camel@Homer.TheSimpsons.net>
In-Reply-To: <1149314532.7513.40.camel@Homer.TheSimpsons.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 3 Jun 2006 11:03:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Sat, 2006-06-03 at 10:08 +1000, Peter Williams wrote:
>> Mike Galbraith wrote:
>>> How?  How would you deal with the make example with per task caps.
>> I'd build a resource management tool that uses task statistics, nice and 
>> caps to manage CPU resource allocation.  This could be a plug in kernel 
>> module or a user space daemon.  It doesn't need to be in the scheduler.
> 
> Ok, you _can_ gather statistics, and modify caps/nice on the fly... for
> long running tasks.  How long does a task have to exist before you have
> statistics for it so you can manage it?

If the stats package is up to scratch it will provide stats for tasks 
that have exited so you will be able to charge their resource usage to 
the higher level entity and still manage that entity's usage properly 
via its other tasks.

> 
> Also, if you're going to need a separate resource manager to allocate,
> monitor and modify in realtime, why not go whole hog, and allocate and
> monitor instances of uml.  It'd be a heck of a lot easier. 

Or Xen.  Or Vmware.  That would be one solution and brings other 
functionality that may be desirable.  Of course, you can also do 
resource control within those instances as well :-).

"There's more than one way to skin a cat" as the old saying goes.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
