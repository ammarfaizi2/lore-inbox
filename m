Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262470AbREULAX>; Mon, 21 May 2001 07:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262471AbREULAN>; Mon, 21 May 2001 07:00:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10625 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262470AbREULAB>;
	Mon, 21 May 2001 07:00:01 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15112.62766.368436.236478@pizda.ninka.net>
Date: Mon, 21 May 2001 03:59:58 -0700 (PDT)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <20010521125032.K30738@athlon.random>
In-Reply-To: <20010520154958.E18119@athlon.random>
	<3B07CF20.2ABB5468@uow.edu.au>
	<20010520163323.G18119@athlon.random>
	<15112.26868.5999.368209@pizda.ninka.net>
	<20010521034726.G30738@athlon.random>
	<15112.48708.639090.348990@pizda.ninka.net>
	<20010521105944.H30738@athlon.random>
	<15112.55709.565823.676709@pizda.ninka.net>
	<20010521115631.I30738@athlon.random>
	<15112.59880.127047.315855@pizda.ninka.net>
	<20010521125032.K30738@athlon.random>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli writes:
 > On Mon, May 21, 2001 at 03:11:52AM -0700, David S. Miller wrote:
 > > I think such designs which gobble up a gig or so of DMA mappings on
 > 
 > they maps something like 200mbyte I think. I also seen other cards doing
 > the same kind of stuff again for the distributed computing.

Ok, 200MB, let's see what this gives us as an example.

200MB multiplied by 6 PCI slots, which uses up about 1.2GB IOMMU
space.

This still leaves around 800MB IOMMU space free on that sparc64 PCI
controller.

It wouldn't run out of space, and this is assuming that Sun ever made
a sparc64 system with 6 physical PCI card slots (I don't think they
ever did honestly, I think 4 physical card slots was the maximum).

Later,
David S. Miller
davem@redhat.com
