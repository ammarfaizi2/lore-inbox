Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263618AbUJ2VxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbUJ2VxD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 17:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263615AbUJ2VuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 17:50:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:18663 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263524AbUJ2VpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:45:04 -0400
Date: Fri, 29 Oct 2004 23:46:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
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
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041029214602.GA15605@elte.hu>
References: <20041029170237.GA12374@elte.hu> <20041029170948.GA13727@elte.hu> <20041029193303.7d3990b4@mango.fruits.de> <20041029172151.GB16276@elte.hu> <20041029172243.GA19630@elte.hu> <20041029203619.37b54cba@mango.fruits.de> <20041029204220.GA6727@elte.hu> <20041029233117.6d29c383@mango.fruits.de> <20041029212545.GA13199@elte.hu> <1099086166.1468.4.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099086166.1468.4.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Fri, 2004-10-29 at 23:25 +0200, Ingo Molnar wrote:
> > > will do so. btw: i think i'm a bit confused right now. What debugging
> > > features should i have enabled for this test?
> > 
> > this particular one (atomicity-checking) is always-enabled if you have
> > the -RT patch applied (it's a really cheap check).
> 
> One more question, what do you recommend the priorities of the IRQ
> threads be set to?  AIUI for xrun-free operation with JACK, all that
> is needed is to set the RT priorities of the soundcard IRQ thread
> highest, followed by the JACK threads, then the other IRQ threads.  Is
> this correct?

correct. softirqs are not used by the sound subsystem so there's no
ksoftirqd dependency.

	Ingo
