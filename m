Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbQKALw7>; Wed, 1 Nov 2000 06:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129118AbQKALwt>; Wed, 1 Nov 2000 06:52:49 -0500
Received: from TRAMPOLINE.THUNK.ORG ([216.175.175.172]:26886 "EHLO
	trampoline.thunk.org") by vger.kernel.org with ESMTP
	id <S129026AbQKALwi>; Wed, 1 Nov 2000 06:52:38 -0500
From: tytso@trampoline.thunk.org
Date: Wed, 1 Nov 2000 06:52:21 -0500
To: Andreas Dilger <adilger@turbolinux.com>
Cc: blizbor@ima.pl, linux-kernel@vger.kernel.org
Subject: Re: ext2fs disaster - how to recover some files ?
Message-ID: <20001101065221.B14084@trampoline.thunk.org>
In-Reply-To: <39F76E9A.E78826B2@ima.pl> <200010260041.e9Q0fvY29910@webber.adilger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200010260041.e9Q0fvY29910@webber.adilger.net>; from adilger@turbolinux.com on Wed, Oct 25, 2000 at 06:41:57PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2000 at 06:41:57PM -0600, Andreas Dilger wrote:
> Since you have a filesystem > 500MB it will default to having 4kB blocks,
> and the backup superblocks will be aligned on 32768 block boundaries.
> Try "e2fsck -B 4096 -b 32768" (or 98304, 163840, 229376, 81920) to see
> if that works.  I think I will submit a patch to Ted which offers more
> suggestions than 8193 for backup blocks, since not too many people know
> where the backups are located on more recent filesystems since they
> will normally have 4kB blocks these days.

This is a known bug; it's fixed (incorrectly) in 1.19, and will be
fixed in 1.20.

You don't have to specify -B 4096.  "e2fsck -b 32768" is sufficient,
as e2fsck will automatically figure out the proper blocksize.

							- Ted


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
