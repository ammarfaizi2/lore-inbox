Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263212AbUJ2CTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbUJ2CTu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 22:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbUJ2CNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 22:13:23 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:26497 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263284AbUJ2CK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 22:10:57 -0400
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: Lee Revell <rlrevell@joe-job.com>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>
In-Reply-To: <200410290057.i9T0v5I8011561@localhost.localdomain>
References: <200410290057.i9T0v5I8011561@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 28 Oct 2004 22:10:53 -0400
Message-Id: <1099015853.4529.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-28 at 20:57 -0400, Paul Davis wrote:
> >>   XRUN Rate . . . . . . . . . . .     424         8         4    /hour
> >>   Delay Rate (>spare time)  . . .     496         0         0    /hour
> >>   Delay Rate (>1000 usecs)  . . .     940         8         4    /hour
> >>   Maximum Delay . . . . . . . . .    6904       921       721    usecs
> >>   Maximum Process Cycle . . . . .    1449      1469      1590    usecs
> >>   Average DSP CPU Load  . . . . .      38        39        40    %
> >>   Average Context-Switch Rate . .    7480      8929      9726    /sec
> >
> >looks pretty good, doesnt it?
> 
> yes and no. its troubling that we're using an extra 100usecs of time
> for the max process cycle, if the statistics make that number
> meaningful. and why a 30% increase in the context switch rate? is that
> an artifact or a real behavioural change? the xrun rate is not bad,
> although i'd need to know the period size. 4 clicks per hour would
> actually be unacceptable to most professionals, but this may have been
> with significant loading outside of JACK - i don't know.

I would not take these results too seriously yet, they are comparing one
highly experimental kernel to another.  Neither of these setups claims
to be ready for professional use yet - we are definitely going for zero
xruns, period, this seems to be achievable with most hardware.  I just
left this in to give you some context.

Lee

