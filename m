Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262466AbREUK5X>; Mon, 21 May 2001 06:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262467AbREUK5D>; Mon, 21 May 2001 06:57:03 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:46714 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262466AbREUK5B>; Mon, 21 May 2001 06:57:01 -0400
Date: Mon, 21 May 2001 12:50:32 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010521125032.K30738@athlon.random>
In-Reply-To: <20010520154958.E18119@athlon.random> <3B07CF20.2ABB5468@uow.edu.au> <20010520163323.G18119@athlon.random> <15112.26868.5999.368209@pizda.ninka.net> <20010521034726.G30738@athlon.random> <15112.48708.639090.348990@pizda.ninka.net> <20010521105944.H30738@athlon.random> <15112.55709.565823.676709@pizda.ninka.net> <20010521115631.I30738@athlon.random> <15112.59880.127047.315855@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15112.59880.127047.315855@pizda.ninka.net>; from davem@redhat.com on Mon, May 21, 2001 at 03:11:52AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 03:11:52AM -0700, David S. Miller wrote:
> I think such designs which gobble up a gig or so of DMA mappings on

they maps something like 200mbyte I think. I also seen other cards doing
the same kind of stuff again for the distributed computing.

> to be using dual address cycles, ie. 64-bit PCI addressing.  It is
> the same response you would give to someone trying to obtain 3 or more
> gigabytes of user address space in a process on x86, right?  You might

I never seen those running on 64bit boxes even if they are supposed to
run there too.

Here it's a little different, 32bit virtual address space limitation
isn't always a showstopper for those kind of CPU intensive apps (they
don't need huge caches).

> respond to that person "What you really need is x86-64." for example
> :-)

for the 32bit virtual address space issues of course yes ;)

> To me, from this perspective, the Quadrics sounds instead like a very
> broken piece of hardware.  And in any event, is there even a Quadrics

they're not the only ones doing that, I seen others doing that kind of
stuff, it's just a matter of information memory fast across a cluster,
if you delegate that work to a separate engine (btw they runs a
sparc32bit cpu, also guess why they aren't pci64) you can spend much
more cpu cycles of the main CPU on the userspace computations.

> driver for sparc64? :-)  (I'm a free software old-fart, so please
> excuse my immediate association between "high end" and "proprietary"
> :-)

:)

Andrea
