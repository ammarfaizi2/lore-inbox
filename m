Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135818AbREFTtj>; Sun, 6 May 2001 15:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135819AbREFTta>; Sun, 6 May 2001 15:49:30 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:34032 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S135818AbREFTtS>; Sun, 6 May 2001 15:49:18 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105061946.f46JkkFr026005@webber.adilger.int>
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <E14wNwy-00022t-00@the-village.bc.nu> "from Alan Cox at May 6, 2001
 01:47:47 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sun, 6 May 2001 13:46:46 -0600 (MDT)
CC: Alexander Viro <viro@math.psu.edu>, Chris Wedgwood <cw@f00f.org>,
        Andrea Arcangeli <andrea@suse.de>, Jens Axboe <axboe@suse.de>,
        Rogier Wolff <R.E.Wolff@bitwizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>, volodya@mindspring.com,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan writes:
> > an interesting task when your root lives on /dev/sda1. Ditto for destroying
> > a single partition (not mounted/used by swap/etc.) while you have some
> > other partition in use. IWBNI we had a decent API for handling partition
> > tables...
> 
> Partitions are just very crude logical volumes, and ultimiately I believe
> should be handled exactly that way

Actually, the EVMS project does exactly this.  All I/O is done on a full
disk basis, and essentially does block remapping for each partition.  This
also solves the problem of cache inconsistency if accessing the parent
device vs. accessing the partition.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
