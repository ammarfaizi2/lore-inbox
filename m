Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262472AbREULDn>; Mon, 21 May 2001 07:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262473AbREULDd>; Mon, 21 May 2001 07:03:33 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:42364 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262472AbREULDS>; Mon, 21 May 2001 07:03:18 -0400
Date: Mon, 21 May 2001 13:00:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010521130034.L30738@athlon.random>
In-Reply-To: <3B07CF20.2ABB5468@uow.edu.au> <20010520163323.G18119@athlon.random> <15112.26868.5999.368209@pizda.ninka.net> <20010521034726.G30738@athlon.random> <15112.48708.639090.348990@pizda.ninka.net> <20010521105944.H30738@athlon.random> <15112.55709.565823.676709@pizda.ninka.net> <20010521115631.I30738@athlon.random> <15112.59880.127047.315855@pizda.ninka.net> <15112.60362.447922.780857@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15112.60362.447922.780857@pizda.ninka.net>; from davem@redhat.com on Mon, May 21, 2001 at 03:19:54AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 03:19:54AM -0700, David S. Miller wrote:
> max bytes per bttv: max_gbuffers * max_gbufsize
> 		    64           * 0x208000      == 133.12MB
> 
> 133.12MB * 8 PCI slots == ~1.06 GB
> 
> Which is still only half of the total IOMMU space available per
> controller.

and it is the double of the iommu space that I am going to reserve for
pci dynamic mappings on the tsunami (right now it is 128Mbyte... and I'll
change to 512mbyte) also bttv is not doing that a large dma and by
default it only uses 2 buffers in the ring. bttv is not a good example
of what can really overflow the pci virtual address space in real life
(when I mentioned it it was only to point out it still uses
virt_to_bus), filling a pci bus with bttv cards sounds quite silly
anyways ;)

Andrea
