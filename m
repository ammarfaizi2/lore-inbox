Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266870AbRGKW40>; Wed, 11 Jul 2001 18:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266864AbRGKW4R>; Wed, 11 Jul 2001 18:56:17 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:61382 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S266870AbRGKW4C>;
	Wed, 11 Jul 2001 18:56:02 -0400
Date: Wed, 11 Jul 2001 18:55:59 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: torvalds@transmeta.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [PATCH] ext2 cleanups
In-Reply-To: <200107112229.f6BMT5ls009821@webber.adilger.int>
Message-ID: <Pine.GSO.4.21.0107111848570.11424-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 11 Jul 2001, Andreas Dilger wrote:

> This patch cleans up the ext2 code in various places.  It is mostly cosmetic
> changes to comments, avoiding lines > 80 columns, removing redundant #ifdef
> lines, etc.  It also adds the new COMPAT flags from the current e2fsprogs
> into include/linux/ext2_fs.h.
> 
> It removes the "not_used_1" field from struct ext2_inode_info, which is
> an in-memory only struct, so there is no need to keep this for "compatibility
> reasons", unlike unused fields in the on-disk data structs.
> 
> It removes the inclusion of <linux/ext2_fs.h> and <linux/minix.h> from
> ksyms.c, because these filesystems do not export any symbols, and they
> can do it themselves now anyways.

	Andreas, could you take a look at ext2 patchkit? It's on
ftp.math.psu.edu/pub/viro/ext2 and I'm going to start feeding that
stuff as soon as 2.5 opens. Patches there (the largest being ~7Kb,
most much smaller) are what I've cut into reasonable pieces; since
there's already 27 chunks in the set the rest is not too high on
my immediate list...

	BTW, folks, since minixfs patch got no complaints during the
last week... Alan, Linus - do you want it in your trees? It switches
the thing to page cache (pretty similar to sysvfs rewrite) and cleans
the things up a bit.

