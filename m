Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262074AbRETQSy>; Sun, 20 May 2001 12:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262075AbRETQSp>; Sun, 20 May 2001 12:18:45 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:49681 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262074AbRETQSi>; Sun, 20 May 2001 12:18:38 -0400
Date: Sun, 20 May 2001 18:18:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010520181803.I18119@athlon.random>
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru> <20010519155502.A16482@athlon.random> <20010519231131.A2840@jurassic.park.msu.ru>, <20010519231131.A2840@jurassic.park.msu.ru>; <20010520044013.A18119@athlon.random> <3B07AF49.5A85205F@uow.edu.au> <20010520154958.E18119@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010520154958.E18119@athlon.random>; from andrea@suse.de on Sun, May 20, 2001 at 03:49:58PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2001 at 03:49:58PM +0200, Andrea Arcangeli wrote:
> they returned zero. You either have to drop the skb or to try again later
> if they returns zero.

BTW, pci_map_single is not a nice interface, it cannot return bus
address 0, so once we start the fixage it is probably better to change
the interface as well to get either the error or the bus address via a
pointer passed to the function.

Andrea
