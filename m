Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262300AbREUBHi>; Sun, 20 May 2001 21:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262301AbREUBH2>; Sun, 20 May 2001 21:07:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63389 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262300AbREUBHV>;
	Sun, 20 May 2001 21:07:21 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15112.27206.4123.40450@pizda.ninka.net>
Date: Sun, 20 May 2001 18:07:17 -0700 (PDT)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <20010520191206.A30738@athlon.random>
In-Reply-To: <20010519231131.A2840@jurassic.park.msu.ru>
	<20010520044013.A18119@athlon.random>
	<3B07AF49.5A85205F@uow.edu.au>
	<20010520154958.E18119@athlon.random>
	<20010520181803.I18119@athlon.random>
	<3B07EEFE.43DDBA5C@uow.edu.au>
	<20010520184411.K18119@athlon.random>
	<3B07F6B8.4EAB0142@uow.edu.au>
	<20010520191206.A30738@athlon.random>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli writes:
 > > [..]  Even sparc64's fancy
 > > iommu-based pci_map_single() always succeeds.
 > 
 > Whatever sparc64 does to hide the driver bugs you can break it if you
 > pci_map 4G+1 bytes of phyical memory.

Which is an utterly stupid thing to do.

Please construct a plausable situation where this would occur legally
and not be a driver bug, given the maximum number of PCI busses and
slots found on sparc64 and the maximum _concurrent_ usage of PCI dma
space for any given driver (which isn't doing something stupid).

Later,
David S. Miller
davem@redhat.com
