Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQKNRhR>; Tue, 14 Nov 2000 12:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129170AbQKNRhJ>; Tue, 14 Nov 2000 12:37:09 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:34874 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129097AbQKNRgr>; Tue, 14 Nov 2000 12:36:47 -0500
Date: Tue, 14 Nov 2000 18:06:02 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: Josue.Amaro@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: Advanced Linux Kernel/Enterprise Linux Kernel
Message-ID: <20001114180602.A777@athlon.random>
In-Reply-To: <200011141459.IAA413471@tomcat.admin.navo.hpc.mil> <3A117311.8DC02909@holly-springs.nc.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A117311.8DC02909@holly-springs.nc.us>; from rothwell@holly-springs.nc.us on Tue, Nov 14, 2000 at 12:14:57PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2000 at 12:14:57PM -0500, Michael Rothwell wrote:
> Ext2 + bdflush + kupdated? Not likely.  To quote the Be Filesystems
> book, Ext2 throws safety to the wind to achieve speed. This also ties

What safety problems bdflush/kupdated have? (if something they lacks in
performance since they works on a global dirty list while it should be per
queue dirty list to take the I/O pipeline full on all disks)

> [..] And the ability to grow filesystems online, [..]

This is provided in linux for ages by LVM+reiserfs also in 2.2.x.

Any filesystem with inode map and not dependent on disk offsets to find
stuff (exept the superblock of course) can do the grow almost trivially
and online, the shrink is some more complicated instead.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
