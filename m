Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267824AbRGREOO>; Wed, 18 Jul 2001 00:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267828AbRGREOE>; Wed, 18 Jul 2001 00:14:04 -0400
Received: from cervantes.dabney.caltech.edu ([131.215.82.121]:4 "EHLO
	cervantes.dabney.caltech.edu") by vger.kernel.org with ESMTP
	id <S267824AbRGREN6>; Wed, 18 Jul 2001 00:13:58 -0400
Date: Tue, 17 Jul 2001 21:14:01 -0700
To: linux-kernel@vger.kernel.org
Subject: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <20010717211401.A322@caltech.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux/2.4.5 (i686)
X-Uptime: 21:12:03 up 9 min,  1 user,  load average: 0.07, 0.06, 0.04
From: Sam Thompson <samuelt@cervantes.dabney.caltech.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, please CC all replies to samuelt@caltech.edu, as I am not on the mailing list.


The other day a computer of mine lost power and the ext2 fs was severely damaged
. I decided to reinstall debian using reiserfs to prevent this. I had no problems with installation, (I've done this same install on other computers) but as I started to untar backup tarballs I had made, I started noticing problems with what I believe is the filesystem.

Tar/gzip will complain about crc errors in files: for example in a certain 40 mb file I can decompress fine on other computers. If I try to uncompress the same file immediately, it will fail at a different point, seemingly at random. Sometimes it works fine. Random debian packages I apt-get have the same problem. Sometimes they won't unpack properly, sometimes they will.

I tried reinstall gzip several times, but I don't think the problems are limited to compressed files, just very obvious in critical situations like that.

I can get complex software to run: xfree86 4.1, mozilla, etc, fine, although som
e files apparently go missing in some programs.

Just now I got the following error message when deleting a tarball:

vs-4080: reiserfs_free_block: free_block (0301:672040)[dev:blocknr]: bit already
 cleared


Next, I took the hard drive to my other, stable computer and ran reiserfsck --rebuild-tree on it, under the hopes that this would fix it. It did appear to fix it, but about 10 minutes later the symptoms came back. 

Here is 'debugreiserfs /dev/hda1' output:


Super block of format 3.5 found on the 0x3 in block 16
Block count 4233112
Blocksize 4096
Free blocks 3900694
Busy blocks (skipped 16, bitmaps - 130, journal blocks - 8193
1 super blocks, 324078 data blocks
Root block 8529
Journal block (first) 18
Journal dev 0
Journal orig size 8192
Filesystem state ERROR
Tree height 4
Hash function used to sort names: "tea"
Objectid map size 62, max 1004
Version 0


Here is my relevant hardware:

Motherboard: Asus A7V KT133 with 686A southbridge (NOT the 686B).
Harddrive: 30 gig ide maxtor/generic.

I installed 2.4.6 to try and fix the problem, it didn't seem to help, although I do not clearly remember the difference between 2.2.17-patched and 2.4.6 in terms of the symptoms.

I tried reinstalling once, but that did not help.

I'm at a loss as to how to proceed. Any ideas?

Thank you for your time,

Sam
---
samuelt@caltech.edu
