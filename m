Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751515AbWFCF7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbWFCF7x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 01:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbWFCF7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 01:59:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:3553 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751195AbWFCF7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 01:59:52 -0400
X-Authenticated: #14349625
Subject: Re: [ckrm-tech] [RFC 3/5] sched: Add CPU rate hard caps
From: Mike Galbraith <efault@gmx.de>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: sekharan@us.ibm.com, balbir@in.ibm.com, dev@openvz.org,
       Andrew Morton <akpm@osdl.org>, Srivatsa <vatsa@in.ibm.com>,
       Sam Vilain <sam@vilain.net>, ckrm-tech@lists.sourceforge.net,
       Balbir Singh <bsingharora@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>
In-Reply-To: <4480D319.8040403@bigpond.net.au>
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
	 <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>
	 <661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com>
	 <44781167.6060700@bigpond.net.au> <447D95DE.1080903@sw.ru>
	 <447DBD44.5040602@in.ibm.com> <447E9A1D.9040109@openvz.org>
	 <447EA694.8060407@in.ibm.com> <1149187413.13336.24.camel@linuxchandra>
	 <447FD2E1.7060605@bigpond.net.au>
	 <1149237992.9446.133.camel@Homer.TheSimpsons.net>
	 <44803ABA.6050001@bigpond.net.au>
	 <1149259639.8661.22.camel@Homer.TheSimpsons.net>
	 <4480D319.8040403@bigpond.net.au>
Content-Type: text/plain
Date: Sat, 03 Jun 2006 08:02:12 +0200
Message-Id: <1149314532.7513.40.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-03 at 10:08 +1000, Peter Williams wrote:
> Mike Galbraith wrote:
> > How?  How would you deal with the make example with per task caps.
> 
> I'd build a resource management tool that uses task statistics, nice and 
> caps to manage CPU resource allocation.  This could be a plug in kernel 
> module or a user space daemon.  It doesn't need to be in the scheduler.

Ok, you _can_ gather statistics, and modify caps/nice on the fly... for
long running tasks.  How long does a task have to exist before you have
statistics for it so you can manage it?

Also, if you're going to need a separate resource manager to allocate,
monitor and modify in realtime, why not go whole hog, and allocate and
monitor instances of uml.  It'd be a heck of a lot easier. 

	-Mike

