Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288596AbSAHXxT>; Tue, 8 Jan 2002 18:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288601AbSAHXxK>; Tue, 8 Jan 2002 18:53:10 -0500
Received: from Expansa.sns.it ([192.167.206.189]:26635 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S288596AbSAHXwu>;
	Tue, 8 Jan 2002 18:52:50 -0500
Date: Wed, 9 Jan 2002 00:52:46 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Ken Brownfield <brownfld@irridia.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020108173254.B9318@asooo.flowerfire.com>
Message-ID: <Pine.LNX.4.33.0201090040030.1185-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Jan 2002, Ken Brownfield wrote:

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
> using Mac OS 9 :)
Not exaclty what I was thinking about.
I listened some horror story from MAC sysadmin at SNS
>
> Preemptive gives better interactivity under load, which is the whole
> point of multitasking (think about it).  If you don't want the overhead
> (which also exists without preemptive) run #processes == #processors.
>
> Whether or not preemptive is applied, having a large number of processes
> active is a performance hit from context switches, cache thrashing, etc.
> Preemptive punishes (and rewards) everyone equally, thus better latency.
you are supposing that I want them to be punished equally. But there are
cases when that is not what you want ;). Thing if one users runs a
montecarlo code for test in the server I was describing. This job could
run, let's say, a couple of hour, and also under nice 20 it can suck a
lot.
>
> I'm really surprised that people are still actually arguing _against_
> preemptive multitasking in this day and age.  This is a no-brainer in
> the long run, where current corner cases aren't holding us back.
>
> At least IMVHO.
What I am talking about is some test I did some week ago. The initial post
of this thread, I think, was very clear about that. On the long run, with
a very well tested implementation. Actually it is not a good idea to
insert preempt nside of the 2.4 stable tree,
because there is a lot of work to do
to get a very WELL TESTED implementation.

