Return-Path: <linux-kernel-owner+willy=40w.ods.org-S285206AbUKBFBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S285206AbUKBFBN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 00:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S284109AbUKBFBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 00:01:12 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:30468 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S285206AbUKAWl3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 17:41:29 -0500
Date: Mon, 1 Nov 2004 14:40:47 -0800
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041101224047.GA19186@nietzsche.lynx.com>
References: <20041031134016.GA24645@elte.hu> <20041031162059.1a3dd9eb@mango.fruits.de> <20041031165913.2d0ad21e@mango.fruits.de> <20041031200621.212ee044@mango.fruits.de> <20041101134235.GA18009@elte.hu> <20041101135358.GA19718@elte.hu> <20041101140630.GA20448@elte.hu> <1099324040.3337.32.camel@thomas> <20041101184615.GB32009@elte.hu> <20041101233037.314337c8@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041101233037.314337c8@mango.fruits.de>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 11:30:37PM +0100, Florian Schmidt wrote:
> took jackit-devel off cc, since it bounced anyways [too many recipients]
> On Mon, 1 Nov 2004 19:46:15 +0100
> Ingo Molnar <mingo@elte.hu> wrote:
... 
> > 
> > also, there are no "arbitrary load" latency guarantees with
> > DEADLOCK_DETECTION turned on, since we search the list of all held locks
> > during task-exit time - this can generate pretty bad latencies e.g.
> > during hackbench.

> btw: i see the same build failure as Rui with lock debugging disabled. Since
> the lock debugging can screw timings, will this be fixed in [one of] the next
> version[s]?

Unlikely, it's got to lock the entire kernel to make sure that things aren't
changing under it. Getting measurements is useful at this stage, but don't expect
it to be a finished product any time soon and please keep that in mind. Stability
should be, if it's not already, the single most important things in this project
at this phase. Getting numbers now for a specific single application is going to
be of limit use until the system is stable enough for general characterization.

Keep doing it, but keep in mind that anything you're going to get at this time
is going to be very coarse. Don't put too much weight on it.

That's my take.

bill

