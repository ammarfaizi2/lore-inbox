Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263146AbUJ2I3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbUJ2I3U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 04:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbUJ2I3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 04:29:20 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:14503
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S263146AbUJ2I3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 04:29:16 -0400
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>
In-Reply-To: <20041029080247.GC30400@elte.hu>
References: <1099008264.4199.4.camel@krustophenia.net>
	 <200410290057.i9T0v5I8011561@localhost.localdomain>
	 <20041029080247.GC30400@elte.hu>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 29 Oct 2004 10:21:03 +0200
Message-Id: <1099038063.22387.534.camel@thomas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 10:02 +0200, Ingo Molnar wrote:
> there are multiple possibilities of how this ~700 usecs delay occured:
> 
>  - the kernel still has a wakeup bug. But this should be detected by the
>    tracer which measures the time between when the task hits the
>    runqueue and the task gets to execute on the CPU. Also, if there is a
>    critical section in the kernel that is 700 usecs long it would be
>    detected by _another_, independent timing/tracing mechanism that
>    measures critical sections. The likelyhood of both the scheduler
>    _and_ two independent kernel-tracers being buggy in the same way is
>    quite significantly low. (not to mention the user-space amlat tool
>    which seems to agree with the kernel instrumentation.)
> 

The sound subsystem uses a lot of sleep_on() variants. We know that they
are racy. Might this be related ?

tglx


