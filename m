Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154075AbQAXUXs>; Mon, 24 Jan 2000 15:23:48 -0500
Received: by vger.rutgers.edu id <S153925AbQAXUF3>; Mon, 24 Jan 2000 15:05:29 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:3050 "EHLO smtp1.cern.ch") by vger.rutgers.edu with ESMTP id <S154138AbQAXTwl>; Mon, 24 Jan 2000 14:52:41 -0500
Date: Tue, 25 Jan 2000 00:56:45 +0100
From: Jamie Lokier <lkd@tantalophile.demon.co.uk>
To: dg50@daimlerchrysler.com
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: SMP Theory (was: Re: Interesting analysis of linux kernel threading by IBM)
Message-ID: <20000125005645.A5940@pcep-jamie.cern.ch>
References: <OFC8E00C6C.FBE80B06-ON85256870.007B8178@notes.chrysler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <OFC8E00C6C.FBE80B06-ON85256870.007B8178@notes.chrysler.com>; from dg50@daimlerchrysler.com on Mon, Jan 24, 2000 at 05:46:55PM -0500
Sender: owner-linux-kernel@vger.rutgers.edu

dg50@daimlerchrysler.com wrote:
> If this is indeed the case (please correct any misconceptions I have) then
> it strikes me that perhaps the hardware design of SMP is broken. That
> instead of sharing main memory, each processor should have it's own main
> memory. You connect the various main memory chunks to the "primary" CPU via
> some sort of very wide, very fast memory bus, and then when you spawn a
> thread, you instead do something more like a fork - copy the relevent
> process and data to the child cpu's private main memory (perhaps via some
> sort of blitter) over this bus, and then let that CPU go play in its own
> sandbox for a while.

I think you just reinvented NUMA -- Non-Uniform Memory Access.  Every
CPU can access the others' memory, but you really want them to
concentrate on their own.  SGI does some boxes like that.

Linux even has a memory allocator which is moving in the direction of
supporting those things.

> Which really is more like the "array of uni-processor boxen joined by a
> network" model than it is current SMP - just with a REALLY fast&wide
> network pipe that just happens to be in the same physical box.

It's been proposed to have multiple instances of the OS running too,
instead of one OS running on all CPUs.

-- Jamie

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
