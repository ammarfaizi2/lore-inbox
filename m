Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbUJ3Roi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUJ3Roi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 13:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbUJ3Roi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 13:44:38 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:10660 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261204AbUJ3Roh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 13:44:37 -0400
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20041030111640.GA23493@elte.hu>
References: <20041029193303.7d3990b4@mango.fruits.de>
	 <20041029172151.GB16276@elte.hu> <20041029172243.GA19630@elte.hu>
	 <20041029203619.37b54cba@mango.fruits.de> <20041029204220.GA6727@elte.hu>
	 <20041029233117.6d29c383@mango.fruits.de> <20041029212545.GA13199@elte.hu>
	 <20041030003122.03bcf01b@mango.fruits.de>
	 <1099107364.1551.7.camel@krustophenia.net>
	 <1099108122.1551.12.camel@krustophenia.net>
	 <20041030111640.GA23493@elte.hu>
Content-Type: text/plain
Date: Sat, 30 Oct 2004 13:44:34 -0400
Message-Id: <1099158275.1972.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-30 at 13:16 +0200, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> >   835 80000000 0.473ms (+0.000ms): finish_task_switch (__schedule)
> >   835 80000000 0.474ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
> >   835 80000000 0.474ms (+0.849ms): (835) ((49))
> >   835 80000000 1.324ms (+0.000ms): do_IRQ (finish_task_switch)
> >   835 80000000 1.324ms (+0.001ms): do_IRQ ((0))
> >   835 80000000 1.325ms (+0.002ms): mask_and_ack_8259A (__do_IRQ)
> 
> this seems to be very similar to the DMA problems Mark H Johnson had. It
> is almost certainly not caused by the kernel. It could in theory be some
> SMM overhead, but the bigger likelyhood is disk DMA.
> 

I find this hard to believe - I _never_ saw that problem on this system
before.  And it works _perfectly_ with T3 - I can run hundreds of
millions of process cycles without a single xrun.

Lee

