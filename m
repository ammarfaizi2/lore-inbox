Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132825AbRDPBnT>; Sun, 15 Apr 2001 21:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132826AbRDPBnL>; Sun, 15 Apr 2001 21:43:11 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:60665 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S132825AbRDPBmx>; Sun, 15 Apr 2001 21:42:53 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104160142.f3G1g6vx018717@webber.adilger.int>
Subject: Re: Ext2 Directory Index - File Structure
In-Reply-To: <20010415195233Z92259-21887+33@humbolt.nl.linux.org>
 "from Daniel Phillips at Apr 15, 2001 09:52:33 pm"
To: Daniel Phillips <phillips@nl.linux.org>
Date: Sun, 15 Apr 2001 19:42:05 -0600 (MDT)
CC: adilger@turbolinux.com, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel, you write:
> Andreas, you wrote:
> > We should go with "EXT2_FEATURE_COMPAT_DIR_INDEX 0x0008"
> > because the on-disk layout is 100% compatible with older kernels, so
> > no reason to force read-only for those systems.  I'm guessing Ted had
> > put RO_COMPAT_BTREE_DIR in there in anticipation, but it was never used.
> 
> By the way, did you mean:
> 
> 	#define EXT2_FEATURE_COMPAT_DIR_INDEX 0x0002
> 
> since there is only one other COMPAT feature currently defined?

Quick note - you need to use 0x0008 or higher (Ted is the authority on
this).  The kernel ext2_fs.h is out of date compared to the one in e2fsprogs.
The EXT3_FEATURE_COMPAT_HAS_JOURNAL and EXT2_FEATURE_COMPAT_IMAGIC_INODES
is missing from the kernel header.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
