Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263738AbUJ3A16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263738AbUJ3A16 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 20:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbUJ3ASV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 20:18:21 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:63914 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261637AbUJ3APl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 20:15:41 -0400
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
In-Reply-To: <20041029214602.GA15605@elte.hu>
References: <20041029170237.GA12374@elte.hu>
	 <20041029170948.GA13727@elte.hu> <20041029193303.7d3990b4@mango.fruits.de>
	 <20041029172151.GB16276@elte.hu> <20041029172243.GA19630@elte.hu>
	 <20041029203619.37b54cba@mango.fruits.de> <20041029204220.GA6727@elte.hu>
	 <20041029233117.6d29c383@mango.fruits.de> <20041029212545.GA13199@elte.hu>
	 <1099086166.1468.4.camel@krustophenia.net> <20041029214602.GA15605@elte.hu>
Content-Type: text/plain
Date: Fri, 29 Oct 2004 20:15:39 -0400
Message-Id: <1099095339.1579.3.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 23:46 +0200, Ingo Molnar wrote: 
> > One more question, what do you recommend the priorities of the IRQ
> > threads be set to?  AIUI for xrun-free operation with JACK, all that
> > is needed is to set the RT priorities of the soundcard IRQ thread
> > highest, followed by the JACK threads, then the other IRQ threads.  Is
> > this correct?
> 
> correct. softirqs are not used by the sound subsystem so there's no
> ksoftirqd dependency.
> 

I don't see much point in latency testing this one yet; I have had to go
for the reset button twice in the past hour.  Web surfing and a kernel
compile kill it pretty quickly.

Lockups aside, it's not necessary to use JACK to demonstrate the
problem, playing AVIs with mplayer will skip.

As a final test I am recompiling with all debug options disabled.

Lee

