Return-Path: <linux-kernel-owner+willy=40w.ods.org-S280502AbUKBDSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S280502AbUKBDSn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 22:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbUKBDMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 22:12:47 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:55044 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S287685AbUKAW73
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 17:59:29 -0500
Date: Mon, 1 Nov 2004 14:59:06 -0800
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Bill Huey <bhuey@lnxw.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041101225906.GA19276@nietzsche.lynx.com>
References: <20041031165913.2d0ad21e@mango.fruits.de> <20041031200621.212ee044@mango.fruits.de> <20041101134235.GA18009@elte.hu> <20041101135358.GA19718@elte.hu> <20041101140630.GA20448@elte.hu> <1099324040.3337.32.camel@thomas> <20041101184615.GB32009@elte.hu> <20041101233037.314337c8@mango.fruits.de> <20041101224047.GA19186@nietzsche.lynx.com> <20041101235125.2ae638a4@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041101235125.2ae638a4@mango.fruits.de>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 11:51:25PM +0100, Florian Schmidt wrote:
[...lock debugging...]
> ack. understood. i was just asking since i don't have a second machine and
> thus am not really able to help with the deadlock debugging. so i figured i
> could at least do some timing. btw: even with deadlock detection, the
> results for 0.6.5 looked pretty good [in 10 minutes uptime ca.3-4% max
> jitter [30something usecs].  until the deadlock that is [i head three finds
> plus kernel compile at nice -10 running]..

The lock chains aren't that deep in Linux so the algorithmic complexity
is not going to hit some crazy polynomial time unless there's some seriously
nasty contention at a certain point in the kernel (billions of readers for
example against a write aquire). But when we start to see things like that
under pressure is when we need to start shortening the need for that/those
lock(s) for that/those critical section(s) in question.

bill

