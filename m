Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130466AbRDPKmB>; Mon, 16 Apr 2001 06:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130471AbRDPKlv>; Mon, 16 Apr 2001 06:41:51 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:18208 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S130466AbRDPKlg>; Mon, 16 Apr 2001 06:41:36 -0400
From: Daniel Phillips <phillips@nl.linux.org>
To: adilger@turbolinux.com, phillips@nl.linux.org
Subject: Re: Ext2 Directory Index - File Structure
Cc: linux-kernel@vger.kernel.org
Message-Id: <20010416104132Z92204-29165+6@humbolt.nl.linux.org>
Date: Mon, 16 Apr 2001 12:41:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas, you wrote:
> Daniel, you write:
> > Andreas, you wrote:
> > > We should go with "EXT2_FEATURE_COMPAT_DIR_INDEX 0x0008"
> > > because the on-disk layout is 100% compatible with older kernels, so
> > > no reason to force read-only for those systems.  I'm guessing Ted had
> > > put RO_COMPAT_BTREE_DIR in there in anticipation, but it was never used.
> > 
> > By the way, did you mean:
> > 
> > 	#define EXT2_FEATURE_COMPAT_DIR_INDEX 0x0002
> > 
> > since there is only one other COMPAT feature currently defined?
> 
> Quick note - you need to use 0x0008 or higher (Ted is the authority on
> this).  The kernel ext2_fs.h is out of date compared to the one in e2fsprogs.
> The EXT3_FEATURE_COMPAT_HAS_JOURNAL and EXT2_FEATURE_COMPAT_IMAGIC_INODES
> is missing from the kernel header.

Since this could mess up somebody's superblock, albiet in a minor way, I
uploaded the correction right away without changing the patch name.

--
Daniel

