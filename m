Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSFGUuv>; Fri, 7 Jun 2002 16:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317344AbSFGUuu>; Fri, 7 Jun 2002 16:50:50 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:55684 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S313087AbSFGUut>; Fri, 7 Jun 2002 16:50:49 -0400
Message-ID: <3D011C64.45AC84E5@us.ibm.com>
Date: Fri, 07 Jun 2002 15:49:40 -0500
From: Steve Best <sfbest@us.ibm.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Journaled File System (JFS) release 1.0.19
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.0.19 of JFS was made available today.

Drop 57 on June 7, 2002 (jfs-2.4-1.0.19.tar.gz
and jfsutils-1.0.19.tar.gz) includes fixes to the file
system and utilities.


Utilities changes

- Fix jfsutils packaging/build error from 1.0.18

File System changes

- Fix powerpc64 compiler warnings
- Fix structure alignment
   xdlistlock_t must be the same size as maplock_t, whether pointers are
   32 bits or 64 bits.
   fix for bugzilla #583, assert(blkno + nblocks <= bmp->db_mapsize) jfs_dmap.
   c:464!
- Add Christoph's copyright to files he has significantly contributed to.
- sanitize->clear_inode, remove ->put_inode (Christoph Hellwig)
   Rename the JFS->clear_inode from diClearExtension to the more descriptive
   jfs_clear_inode, move it ti inode.c and clean it up a bit.
   Remove jfs_put_inode as in 2.5

For more details about JFS, please see the patch instructions or changelog.
jfs files.


Steve Best
Linux Technology Center
JFS for Linux http://oss.software.ibm.com/jfs
