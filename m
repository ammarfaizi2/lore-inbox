Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269476AbUJSP6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269476AbUJSP6Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 11:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269479AbUJSP4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 11:56:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:32705 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269476AbUJSP4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 11:56:01 -0400
Date: Tue, 19 Oct 2004 17:57:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
Message-ID: <20041019155722.GA9711@elte.hu>
References: <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019144642.GA6512@elte.hu> <28172.195.245.190.93.1098199429.squirrel@195.245.190.93> <1098200660.12223.923.camel@thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098200660.12223.923.camel@thomas>
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


* Thomas Gleixner <tglx@linutronix.de> wrote:

> > Sorry that I can't show any trace dumps; only a hard-screenshot (with
> > digital camera?) would be possible but rather incomplete. The serial
> > console hack is not an option--these "modern" laptops doesn't come with
> > serial ports anymore, and netconsole is a no-op at a so early point of the
> > boot process. Or so I believe.
> > 
> > OK. After some incremental configurations, I've isolated that those
> > oops(es) only occurs if PREEMPT_TIMING and/or LATENCY_TRACE areset (Y). My
> > first suspect was that newest RWSEM_DEADLOCK_DETECT, but it wasn't the
> > case.
> 
> Same here on al DELL P4/UP. 

any chance for serial logging on that box?

and does this bootup crash go away if you unset PREEMPT_TIMING or
LATENCY_TRACE, as suggested by Rui?

	Ingo
