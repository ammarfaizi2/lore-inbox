Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292258AbSBOXQp>; Fri, 15 Feb 2002 18:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292260AbSBOXQf>; Fri, 15 Feb 2002 18:16:35 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:57764 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292258AbSBOXQU>; Fri, 15 Feb 2002 18:16:20 -0500
Subject: [ANNOUNCE]  Journaled File System (JFS)  release 1.0.15
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF0C618BC7.4B09003D-ON85256B61.007F85A4@raleigh.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Fri, 15 Feb 2002 17:15:23 -0600
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 02/15/2002 06:15:49 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.0.15 of JFS was made available today.

Drop 53 on February 15, 2002 (jfs-2.4-1.0.14-patch.tar.gz or
jfs-2.5.4-1.0.15-patch.gz and jfsutils-1.0.15.tar.gz)
includes fixes to the file system and utilities.

Utilities changes

- eliminate invalid fsck.jfs internal error 10
- update xpeek and fsck.jfs man pages
- better error message if device to be fsck.jfs'ed is not jfs
- add support for 4.4 BSD-style getmntinfo (Christoph Hellwig)
- include sys/types.h for BSD (Hiten Pandya)
- use defacto standard autoconf macro for large file support
  (Christoph Hellwig)
- general jfsutils code cleanup (all)

File System changes

- Fix trap when appending to very large file
- Moving jfs headers into fs/jfs at Linus' request
- Move up to linux-2.5.4
- Fix file size limit on 32-bit (Andi Kleen)
- make changelog more read-able and include only 1.0.0
  and above (Christoph Hellwig)
- Don't allocate metadata pages from high memory. JFS keeps
  them kmapped too long causing deadlock.
- Fix xtree corruption when creating file with >= 64 GB of physically
  contiguous dasd
- Replace semaphore with struct completion for thread startup/shutdown
  (Benedikt Spranger)
- cleanup Tx alloc/free (Christoph Hellwig)
- Move up to linux-2.5.3
- thread cleanups (Christoph Hellwig)
- First step toward making tblocks and tlocks dynamically allocated.
  Intro tid_t and lid_t to insulate the majority of the code from
  future changes. Also hide TxBlock and TxLock arrays by using macros
  to get from tids and lids to real structures.
- minor list-handling cleanup (Christoph Hellwig)
- Replace altnext and altprev with struct list_head


For more details about JFS, please see the README or changelog.jfs


Steve
JFS for Linux http://oss.software.ibm.com/jfs



