Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbRCWGC1>; Fri, 23 Mar 2001 01:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129638AbRCWGCS>; Fri, 23 Mar 2001 01:02:18 -0500
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:64495 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S129595AbRCWGCG>; Fri, 23 Mar 2001 01:02:06 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103230600.f2N60CU07723@webber.adilger.int>
Subject: Re: [RFC] sane access to per-fs metadata (was Re: [PATCH] Documentation/ioctl-number.txt)
In-Reply-To: <Pine.GSO.4.21.0103221720250.5619-100000@weyl.math.psu.edu> from
 Alexander Viro at "Mar 22, 2001 06:07:44 pm"
To: Alexander Viro <viro@math.psu.edu>
Date: Thu, 22 Mar 2001 23:00:12 -0700 (MST)
CC: Dave Kleikamp <shaggy@austin.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al, you write:
> 	* You can get rid of any need to register ioctls, etc.
> 	* You can add debugging/whatever at any moment with no need to
> 	  update any utilities - everything is available from plain shell
> 	* You can conveniently view whatever metadata you want - no need to
> 	  shove everything into ioctls on one object.
> 	* You can use normal permissions control - just set appropriate
> 	  permission bits for objects on jfsmeta
> 
> IOW, you can get normal filesystem view (meaning that you have all usual
> UNIX toolkit available) for per-fs control stuff. And keep the ability to
> do proper locking - it's the same driver that handles the main fs and you
> have access to superblock. No need to change the API - everything is already
> there...
> 	I'll post an example patch for ext2 (safe access to superblock,
> group descriptors, inode table and bitmaps on a live fs) after this weekend
> (== when misc shit will somewhat settle down).

I look forward to seeing the ext2 code.  I was just in the process of
adding ioctls to ext3 to do online resizing within transactions.  Maybe
I'll rather use this interface if it looks good.  Will it work on 2.2,
or does it depend too much on new VFS?

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
