Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbULMW0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbULMW0p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 17:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbULMWYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 17:24:47 -0500
Received: from mx2.elte.hu ([157.181.151.9]:51161 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261231AbULMWVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 17:21:24 -0500
Date: Mon, 13 Dec 2004 23:20:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Bill Huey <bhuey@lnxw.com>, Esben Nielsen <simlo@phys.au.dk>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, LKML <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
Message-ID: <20041213222058.GA6470@elte.hu>
References: <Pine.OSF.4.05.10412112027540.6963-100000@da410.ifa.au.dk> <1102804480.3691.32.camel@localhost.localdomain> <20041213215549.GB29432@nietzsche.lynx.com> <1102976100.3582.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102976100.3582.7.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > One thing that I noticed in this thread is that even though you were talking
> > about the mechanisms to support these features, it really needs some
> > consideration as to how it's going to effect the stock kernel since you're
> > really introduction a first-class threading object/concept into the system.
> > That means changes to the scheduler, how QoS fits into this, etc...
> > IMO, it's ultimately about QoS and that alone is a hot button since it's
> > so invasive throughout the kernel.
> 
> Is there any talk about Ingo's patch getting into the mainstream
> kernel?

a good number of generic bits (generic irq subsystem, preemption
fixes/enhancements, lock initializer cleanups, and tons of fixes found
in -RT) are upstream or in -mm already, but the core PREEMPT_RT stuff is
still under development and thus not ready for upstream. I'm constantly
sending independent bits (fixes or orthogonal improvements) that show up
in -RT towards upstream as well. [-RT would be a 1MB unmaintainable
patch otherwise.]

	Ingo
