Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262081AbRETQpJ>; Sun, 20 May 2001 12:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262082AbRETQpA>; Sun, 20 May 2001 12:45:00 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:15123 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262081AbRETQon>; Sun, 20 May 2001 12:44:43 -0400
Date: Sun, 20 May 2001 18:44:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010520184411.K18119@athlon.random>
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru> <20010519155502.A16482@athlon.random> <20010519231131.A2840@jurassic.park.msu.ru>, <20010519231131.A2840@jurassic.park.msu.ru>; <20010520044013.A18119@athlon.random> <3B07AF49.5A85205F@uow.edu.au> <20010520154958.E18119@athlon.random>, <20010520154958.E18119@athlon.random>; <20010520181803.I18119@athlon.random> <3B07EEFE.43DDBA5C@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B07EEFE.43DDBA5C@uow.edu.au>; from andrewm@uow.edu.au on Mon, May 21, 2001 at 02:21:18AM +1000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 02:21:18AM +1000, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> Would it not be sufficient to define a machine-specific
> macro which queries it for error?  On x86 it would be:
> 
> #define BUS_ADDR_IS_ERR(addr)	((addr) == 0)

that would be more flexible at least, however not mixing the error with
a potential bus address still looks cleaner to me.

> I can't find *any* pci_map_single() in the 2.4.4-ac9 tree
> which can fail, BTW.

I assume you mean that no one single caller of pci_map_single is
checking if it failed or not (because all pci_map_single can fail).

Andrea
