Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263480AbUJ2Unu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263480AbUJ2Unu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbUJ2UkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 16:40:14 -0400
Received: from mx2.elte.hu ([157.181.151.9]:10189 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263480AbUJ2UcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:32:18 -0400
Date: Fri, 29 Oct 2004 22:33:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041029203320.GC5186@elte.hu>
References: <20041029183256.564897b2@mango.fruits.de> <20041029162316.GA7743@elte.hu> <20041029163155.GA9005@elte.hu> <20041029191652.1e480e2d@mango.fruits.de> <20041029170237.GA12374@elte.hu> <20041029170948.GA13727@elte.hu> <20041029193303.7d3990b4@mango.fruits.de> <20041029172151.GB16276@elte.hu> <20041029172243.GA19630@elte.hu> <20041029203619.37b54cba@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029203619.37b54cba@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> > > > fs/ioctl.c: In function `sys_ioctl':
> > > > fs/ioctl.c:75: error: structure has no member named `ioctl_nobkl'
> > > > fs/ioctl.c:76: error: structure has no member named `ioctl_nobkl'
> > > 
> > > fs.h chunk went missing ... uploading -V0.5.14 in a minute.
> > 
> > done.
> 
> compiles and boots fine. no observable change in xrun behaviour though. 

ok, so there's something else going on as well - or i missed an ioctl. 
Even if it's not the BKL, the ioctl/BKL problem would come back later
and haunt us during stresstests anyway so it's not bad that we have a
solution for it.

	Ingo
