Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288582AbSAHXka>; Tue, 8 Jan 2002 18:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288584AbSAHXk0>; Tue, 8 Jan 2002 18:40:26 -0500
Received: from zero.tech9.net ([209.61.188.187]:5897 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288582AbSAHXkM>;
	Tue, 8 Jan 2002 18:40:12 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Ken Brownfield <brownfld@irridia.com>
Cc: Luigi Genoni <kernel@Expansa.sns.it>, linux-kernel@vger.kernel.org
In-Reply-To: <20020108173254.B9318@asooo.flowerfire.com>
In-Reply-To: <E16Nyaf-0000A5-00@starship.berlin>
	<Pine.LNX.4.33.0201082351020.1185-100000@Expansa.sns.it> 
	<20020108173254.B9318@asooo.flowerfire.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 08 Jan 2002 18:42:19 -0500
Message-Id: <1010533340.3229.200.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-08 at 18:32, Ken Brownfield wrote:
> On Wed, Jan 09, 2002 at 12:02:48AM +0100, Luigi Genoni wrote:
> | Probably sometimes they are not making a good business. In the reality
> | preempt is good in many scenarios, as I said, and I agree that for
> | desktops, and dedicated servers where just one application runs, and
> | probably the CPU is idle the most of the time, indeed users have a speed
> | feeling. Please consider that on eavilly loaded servers, with 40 and more
> | users, some are running gcc, others g77, others g++ compilations, someone
> | runs pine or mutt or kmail, and netscape, and mozilla, and emacs (someone
> | form xterm kde or gnome), and and
> | and... You can have also 4/8 CPU butthey are not infinite ;) (but I talk
> | mainly thinking of dualAthlon systems).
> | there is a lot of memory and disk I/O.
> | This is not a strange scenary on the interactive servers used at SNS.
> | Here preempt has a too high price
> 
> MacOS 9 is the OS for you.
> 
> Essentially what the low-latency patches are is cooperative
> multitasking.  Which has less overhead in some cases than preemptive as
> long as everyone is equally nice and calls WaitNextEvent() within the
> right inner loops.  In the absence of preemptive, Andrew's patch is the
> next best thing.  But Bad Things happen without preemptive.  Just try
> using Mac OS 9. ;)
> 
> Preemptive gives better interactivity under load, which is the whole
> point of multitasking (think about it).  If you don't want the overhead
> (which also exists without preemptive) run #processes == #processors.
> 
> Whether or not preemptive is applied, having a large number of processes
> active is a performance hit from context switches, cache thrashing, etc.
> Preemptive punishes (and rewards) everyone equally, thus better latency.
> 
> I'm really surprised that people are still actually arguing _against_
> preemptive multitasking in this day and age.  This is a no-brainer in
> the long run, where current corner cases aren't holding us back.

Amen.

Of course, the counter argument is that we, as kernel programmers, can
design everything to behave kindly cooperatively.  I reply "now that the
kernel is SMP safe it is trivial to become preemptible" but some still
don't take the patch.  I'll keep trucking along.

	Robert Love



