Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263257AbUJ2L1C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263257AbUJ2L1C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 07:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbUJ2L1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 07:27:02 -0400
Received: from out012pub.verizon.net ([206.46.170.137]:54667 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S263257AbUJ2L07
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 07:26:59 -0400
Message-Id: <200410291126.i9TBQuFu002731@localhost.localdomain>
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
In-reply-to: Your message of "Fri, 29 Oct 2004 13:14:08 +0200."
             <20041029111408.GA28259@elte.hu> 
Date: Fri, 29 Oct 2004 07:26:56 -0400
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [141.151.88.122] at Fri, 29 Oct 2004 06:26:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>my main suspicion is that either the main jackd thread itself calls the
>kernel where the kernel (unexpectedly for jackd) schedules away for
>whatever reason, or that the chain of wakeup in the audio path somehow
>gets violated (i.e. a kernel problem). There's one quick thing we could

the "max delay" measurement isn't a reflection of the runtime activity
of jackd. its simply a measurement of the delay between when jackd
expected to be next woken from poll and when it actually was.

as you noted, jackd generally goes back to sleep in poll typically a
long time before the next interrupt is expected. hence any delay in
the wakeup is between the interrupt handler and the scheduler getting
jackd's main thread back on the processor. i think.

