Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312256AbSD2OBh>; Mon, 29 Apr 2002 10:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312261AbSD2OBg>; Mon, 29 Apr 2002 10:01:36 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:8910 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S312256AbSD2OBf>;
	Mon, 29 Apr 2002 10:01:35 -0400
Date: Mon, 29 Apr 2002 10:01:34 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.11 busy inodes after unmount
In-Reply-To: <200204291358.PAA21654@harpo.it.uu.se>
Message-ID: <Pine.GSO.4.21.0204291000100.2918-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Apr 2002, Mikael Pettersson wrote:

> With the 2.5.11 kernel I always get the "VFS: Busy inodes
> after unmount. Self-destruct in 5 seconds.  Have a nice day..."
> message from fs/super.c when shutting down. Rebooting with my
> rescue floppy, fsck complains a lot about "Deleted inode with
> zero dtime", "Block bitmap differences", "Free blocks count wrong",
> "Inode bitmap differences", "Free inodes count wrong", and
> "Directories count wrong". Luckily no files seemed to get trashed.
> 
> Very plain but solid box: x86, Intel chipset, IDE, ext2.


Yes.  Massive dentry leak from fastwalk patch.  I see what's going on;
fix will be posted in an hour or so.

