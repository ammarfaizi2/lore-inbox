Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbULNVSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbULNVSo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 16:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbULNVSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 16:18:44 -0500
Received: from mx2.elte.hu ([157.181.151.9]:56509 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261662AbULNVSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 16:18:42 -0500
Date: Tue, 14 Dec 2004 22:18:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lee Revell <rlrevell@joe-job.com>, LKML <linux-kernel@vger.kernel.org>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       George Anzinger <george@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
Message-ID: <20041214211828.GA17216@elte.hu>
References: <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu> <1103052853.3582.46.camel@localhost.localdomain> <1103054908.14699.20.camel@krustophenia.net> <1103057144.3582.51.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103057144.3582.51.camel@localhost.localdomain>
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

> > > [RFC]
> > > 
> > > Ingo,
> > > 
> > > Any thought about adding a one shot timer for the system? 
> > > 
> > 
> > Isn't this what George Anzinger is working on?
> > 
> > http://sourceforge.net/projects/high-res-timers/
> > 
> > Lee
> > 
> 
> A quick look at this looks like this is what I was looking for. I'd
> need to review the code in a more detailed aspect but first glance,
> Yes, this is what I want.
> 
> Now, since High Res-timers and RT seem to go together, what are the
> plans for merging these?  If this is indeed what I need, then I'll be
> doing it to myself, [...]

i've been thinking about it on and off. If you would/could try it that
would certainly help. RT for Linux is a dance of many small steps.

the two projects are obviously complementary and i have no intention to
reinvent the wheel in any way. Best would be to bring hires timers up to
upstream-mergable state (independently of the -RT patch) and ask Andrew
to include it in -mm, then i'd port -RT to it automatically.

	Ingo
