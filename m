Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261944AbRETNuy>; Sun, 20 May 2001 09:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261949AbRETNuo>; Sun, 20 May 2001 09:50:44 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:28538 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261944AbRETNue>; Sun, 20 May 2001 09:50:34 -0400
Date: Sun, 20 May 2001 15:49:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010520154958.E18119@athlon.random>
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru> <20010519155502.A16482@athlon.random> <20010519231131.A2840@jurassic.park.msu.ru>, <20010519231131.A2840@jurassic.park.msu.ru>; <20010520044013.A18119@athlon.random> <3B07AF49.5A85205F@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B07AF49.5A85205F@uow.edu.au>; from andrewm@uow.edu.au on Sun, May 20, 2001 at 09:49:29PM +1000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ cc'ed to l-k ]

> DMA-mapping.txt assumes that it cannot fail.

DMA-mapping.txt is wrong. Both pci_map_sg and pci_map_single failed if
they returned zero. You either have to drop the skb or to try again later
if they returns zero.

Andrea
