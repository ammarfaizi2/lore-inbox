Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135991AbREGEPI>; Mon, 7 May 2001 00:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135992AbREGEO6>; Mon, 7 May 2001 00:14:58 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:37360 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S135991AbREGEOw>; Mon, 7 May 2001 00:14:52 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105070408.f4748seA026331@webber.adilger.int>
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <E14wVc1-0002aj-00@the-village.bc.nu> "from Alan Cox at May 6, 2001
 09:58:38 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sun, 6 May 2001 22:08:54 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>,
        Alexander Viro <viro@math.psu.edu>, Chris Wedgwood <cw@f00f.org>,
        Andrea Arcangeli <andrea@suse.de>, Jens Axboe <axboe@suse.de>,
        Rogier Wolff <R.E.Wolff@bitwizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>, volodya@mindspring.com,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan writes:
> > Actually, the EVMS project does exactly this.  All I/O is done on a full
> > disk basis, and essentially does block remapping for each partition.  This
> > also solves the problem of cache inconsistency if accessing the parent
> > device vs. accessing the partition.
> 
> Interesting. Can EVMS handle the partition labels used by the LVM layer - ie
> could it replace it as well ?

Yes, they already support all current LVM volumes (including snapshots).
However, the user-space tools to set up new LVM volumes and manage existing
ones is not ready yet.  The last I talked with the IBM folks (a week ago),
they said they were starting to work on the user-space tools.

Because the whole partition/volume code is modular in EVMS, they will be able
to handle AIX LVM, HP/UX LVM, etc. volumes in addition to the normal DOS or
other partitions.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
