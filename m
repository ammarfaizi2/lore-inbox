Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274233AbRI3Wbu>; Sun, 30 Sep 2001 18:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274237AbRI3Wbk>; Sun, 30 Sep 2001 18:31:40 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:9876 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274233AbRI3Wb3>;
	Sun, 30 Sep 2001 18:31:29 -0400
Date: Sun, 30 Sep 2001 18:31:55 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
Subject: [CFT][PATCH] cleanup of partition code
Message-ID: <Pine.GSO.4.21.0109301819220.12896-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Folks, _please_ help to test this one.  It switches most of
the fs/partitions/* to use of pagecache, cleans it up and fixes quite
a few holes in that area.

	It should work in all cases when vanilla tree does.  Please,
try it on different partitioning schemes.

	Things to look for:

* Odd IDE disks - victims of EZ-Disk, OnCrack, etc.
* Minix, Solaris, Unixware partitions.  Changes were completely
  straightforward, but it needs testing.
* BSD disklabels.  Should work, but more testing is needed.
* non-x86 variants - Sun disklables, SGI, etc.  Need testing.

	One thing that doesn't work yet is support of Acorn partitions -
I'm switching it to pagecache right now.

	If there's no bug reports it will go into the tree, so _please_
test it now, not after it's in 2.4.11

	Patch is on ftp.math.psu.edu/pub/viro/partition-a-S11-pre1.  It's
against 2.4.11-pre1.  Again, any help with testing is very welcome.

