Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262296AbREUBEI>; Sun, 20 May 2001 21:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262293AbREUBD6>; Sun, 20 May 2001 21:03:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59037 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262292AbREUBDr>;
	Sun, 20 May 2001 21:03:47 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15112.26992.591864.905111@pizda.ninka.net>
Date: Sun, 20 May 2001 18:03:44 -0700 (PDT)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <20010520181803.I18119@athlon.random>
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru>
	<20010519155502.A16482@athlon.random>
	<20010519231131.A2840@jurassic.park.msu.ru>
	<20010520044013.A18119@athlon.random>
	<3B07AF49.5A85205F@uow.edu.au>
	<20010520154958.E18119@athlon.random>
	<20010520181803.I18119@athlon.random>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli writes:
 > On Sun, May 20, 2001 at 03:49:58PM +0200, Andrea Arcangeli wrote:
 > > they returned zero. You either have to drop the skb or to try again later
 > > if they returns zero.
 > 
 > BTW, pci_map_single is not a nice interface, it cannot return bus
 > address 0, so once we start the fixage it is probably better to change
 > the interface as well to get either the error or the bus address via a
 > pointer passed to the function.

No, pci_map_single is a fine interface.  What is lacking is a
"INVALID_DMA_ADDR" define for each platform, and I've known about
this for some time.

But for the time being, everyone assumes address zero is not valid and
it shouldn't be too painful to reserve the first page of DMA space
until we fix this issue.

Later,
David S. Miller
davem@redhat.com
