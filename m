Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbUJYLIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbUJYLIH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 07:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbUJYLIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 07:08:07 -0400
Received: from relay02.pair.com ([209.68.5.16]:8975 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S261756AbUJYLIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 07:08:01 -0400
X-pair-Authenticated: 66.190.53.4
Message-ID: <417CDE90.6040201@cybsft.com>
Date: Mon, 25 Oct 2004 06:08:00 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
References: <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu>
In-Reply-To: <20041025104023.GA1960@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> [ NOTE: there's one known bug in this release: selinux on one of my
> testsystems broke, it hangs during bootup. With CONFIG_SECURITY disabled
> it works fine. I'm working on the fix. So please keep CONFIG_SECURITY
> disabled for the time being. ]
>
Does this include all models of security or just the selinux stuff?


> other changes in -V0:
> 
>  - build fixes: more driver fixes from Thomas Gleixner
> 
>  - crash fix: fixed a bug found by Thomas Gleixner: rwsem runtime
>    initialization was racy.
> 
>  - deadlock fix: fixed lockup bug caused by __schedule clearing
>    PREEMPT_ACTIVE. The need_resched loop is now outside of __schedule(). 
>    This might solve lockups/slowdowns reported by some people.
> 
>  - latency fix: made keventd SCHED_FIFO - this could fix the mouse
>    related delays reported by a number of people.
> 
>  - latency fix: fixed SMP lock-break mechanism of mutexes.
> 
>  - usability feature: hard-interrupts get decreasing SCHED_FIFO priority
>    starting at prio 49 and stopping at prio 25. This should give a good
>    default.
> 
>  - debug feature: implemented SysRq-D to show the list of tasks with
>    locks blocked on, if RW_SEM_DEADLOCK_DETECTION is enabled.
> 
> to create a -V0 tree from scratch, the patching order is:
> 
>    http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
>  + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9-mm1/2.6.9-mm1.bz2
>  + http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-mm1-V0
> 
> 	Ingo
> 


