Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262009AbTCHNDW>; Sat, 8 Mar 2003 08:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262010AbTCHNDW>; Sat, 8 Mar 2003 08:03:22 -0500
Received: from thunk.org ([140.239.227.29]:36785 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262009AbTCHNDV>;
	Sat, 8 Mar 2003 08:03:21 -0500
To: linux-kernel@vger.kernel.org
Subject: Updated 2.4 htree patches available for 2.4.21rc5
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E18re9F-00086y-00@think.thunk.org>
Date: Sat, 08 Mar 2003 08:13:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've backported all of the bugfixes to the 2.5 dxdir/htree patches to
2.4, and have created a new set of patches for Linux 2.4.21rc5.  At this
point it *looks* like we've fixed all of the htree bugs that people have
reported, including the brelse bug, the memory leak bugs, and the NFS
compatibility problems.

I've done *very* light testing, and things seem to work, but I'm now
looking for some brave souls/guinea pigs to give this some more strenous
testing.  Please don't use this on production systems just yet, until
some people report success.  In particular, I'm looking for people who
had trouble with NFS to confirm whether or not this patch fixes their
problems or not.  If you do try out the patch, please let me know how
well (or how poorly) it works.

The patches can be found at:

	http://thunk.org/tytso/linux/extfs-2.4-update/extfs-update-2.4.21rc5

Also available are the patches broken out into separate diffs, here:

	http://thunk.org/tytso/linux/extfs-2.4-update/broken-out-2.4.21rc5/

In the broken out directory, only the first patch is the htree patch.
The rest are some other 2.5 features which I've backported to 2.4,
including forward compatibility for upcoming future extfs upgrades
including dynamic filesystem resizing and expanded inodes for things
like subsecond timestamps.  The patches also add support for setting
default mount options via tune2fs, and the improved Orlov block
allocator.

So if you're feeling adventurour, please backup your systems (you should
*always* backup your systems, even when you're not trying out new kernel
patches :-), and give these patches a whirl, and let me know how it
goes.  Thanks!

						- Ted
