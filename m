Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263484AbUJ2VUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbUJ2VUG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 17:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263575AbUJ2VS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 17:18:56 -0400
Received: from pop.gmx.de ([213.165.64.20]:18870 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263484AbUJ2VOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:14:11 -0400
X-Authenticated: #4399952
Date: Fri, 29 Oct 2004 23:31:17 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
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
Message-ID: <20041029233117.6d29c383@mango.fruits.de>
In-Reply-To: <20041029204220.GA6727@elte.hu>
References: <20041029183256.564897b2@mango.fruits.de>
	<20041029162316.GA7743@elte.hu>
	<20041029163155.GA9005@elte.hu>
	<20041029191652.1e480e2d@mango.fruits.de>
	<20041029170237.GA12374@elte.hu>
	<20041029170948.GA13727@elte.hu>
	<20041029193303.7d3990b4@mango.fruits.de>
	<20041029172151.GB16276@elte.hu>
	<20041029172243.GA19630@elte.hu>
	<20041029203619.37b54cba@mango.fruits.de>
	<20041029204220.GA6727@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004 22:42:20 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> > compiles and boots fine. no observable change in xrun behaviour
> > though. 
> 
> do you compile jackd from sources? If yes then could you try the patch
> below? With this added, the kernel will produce a stackdump whenever
> jackd does an 'illegal' sleep.
> 
> Also, could you do a small modification to kernel/sched.c and remove
> this line:
> 
> 		send_sig(SIGUSR1, current, 1);
> 
> just to make it easier to get Jack up and running. (by default an
> atomicity violation triggers a signal to make it easier to debug it in
> userspace, but i suspect there will be alot of such violations so jackd
> would stop all the time.)

[snip]

will do so. btw: i think i'm a bit confused right now. What debugging
features should i have enabled for this test?

flo
