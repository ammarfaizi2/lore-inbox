Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263236AbUJ2LCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263236AbUJ2LCG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 07:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263238AbUJ2LCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 07:02:06 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:1721 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S263236AbUJ2LCD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 07:02:03 -0400
Message-Id: <200410291101.i9TB1uhp002490@localhost.localdomain>
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4] 
In-reply-to: Your message of "Fri, 29 Oct 2004 11:09:57 +0200."
             <20041029090957.GA1460@elte.hu> 
Date: Fri, 29 Oct 2004 07:01:56 -0400
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [141.151.88.122] at Fri, 29 Oct 2004 06:01:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>but now it should be possible to prove that Jackd itself doesnt
>introduce latencies, via the userspace-atomicity mode feature in -V0.5.5
>:-) If that proves that the latencies dont occur in Jackd (and if it's
>not another, even higher prio thread that causes the delay) then we can
>pass the ball back to the kernel.

this is something i haven't mentioned. when running in RT mode, jackd
also runs a higher prio RT thread called the watchdog. it wakes every
5 seconds to check that the "main" thread is not stalled (i.e. a
client that is stuck in a loop) and kills everything if it
is. however, this thread's loop is incredibly simple (it checks and
resets a single int variable and goes back to sleep) that causing a
700usec delay would itself seem to me to be indicative of a
problem. do you agree?

--p
