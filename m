Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbUJ3U3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbUJ3U3V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 16:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbUJ3U3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 16:29:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:22695 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261310AbUJ3U3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 16:29:18 -0400
X-Authenticated: #4399952
Date: Sat, 30 Oct 2004 22:29:15 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041030222915.2ed03b30@mango.fruits.de>
In-Reply-To: <1099166715.1434.1.camel@krustophenia.net>
References: <20041029172243.GA19630@elte.hu>
	<20041029203619.37b54cba@mango.fruits.de>
	<20041029204220.GA6727@elte.hu>
	<20041029233117.6d29c383@mango.fruits.de>
	<20041029212545.GA13199@elte.hu>
	<1099086166.1468.4.camel@krustophenia.net>
	<20041029214602.GA15605@elte.hu>
	<1099091566.1461.8.camel@krustophenia.net>
	<20041030115808.GA29692@elte.hu>
	<1099158570.1972.5.camel@krustophenia.net>
	<20041030191725.GA29747@elte.hu>
	<20041030214738.1918ea1d@mango.fruits.de>
	<1099166715.1434.1.camel@krustophenia.net>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Oct 2004 16:05:14 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> So maybe the bug is not related to scheduling of SCHED_FIFO threads, but
> that we are missing IRQs.  I think this would explain the choppy
> playback with mplayer (it uses the RTC and does not run SCHED_FIFO).

I wonder about what X11 is doing. Is it maybe doing some locking which is
"out of line" for RP or something? I mean the RP patches touch everything
that accesses hw directly with the exception of X11, right? [/me never
grokked how X fits into linux' driver model anyways]

flo
