Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317278AbSHLSvJ>; Mon, 12 Aug 2002 14:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318088AbSHLSvJ>; Mon, 12 Aug 2002 14:51:09 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:6327 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317278AbSHLSvI>;
	Mon, 12 Aug 2002 14:51:08 -0400
Subject: [ANNOUNCE]  Journaled File System (JFS)  release 1.0.21
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFF333C1AE.64DEBA14-ON85256C13.0066C972@pok.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Mon, 12 Aug 2002 13:45:23 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.10 SPR# MIAS5B3GZN |June
 28, 2002) at 08/12/2002 02:54:51 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Release 1.0.21 of JFS was made available today.

Drop 59 on August 12, 2002 (jfs-2.4-1.0.21.tar.gz
and jfsutils-1.0.21.tar.gz) includes fixes to the file
system and utilities.

The new feature in this release is the capability to resize
the file system.

Utilities changes

- add external log support to xpeek
- fix fsck.jfs to update log device number in superblock after
  logredo with external log.
- fix typo in mkfs.jfs Emergency help. (Bas)
- do not build currently unused defrag, extendfs utilities
- eliminate uuid redefinition compiler warnings
- add logsuper functions to libfs
- fix printf format specifiers.  (Christoph Hellwig)
- code cleanup (all)
- update JFS FSIM for EVMS - see http://sourceforge.net/projects/evms/

File System changes

- define sb_bread for kernels older than 2.4.18
- C99-style initializers (Christoph Hellwig)
- Add resize function to JFS
   This is invoked by mount -oremount,resize=<blocks>
   See Documentation/filesystems/jfs.txt for more information.
- Remove d_delete calls from jfs_rmdir & jfs_unlink
- Dynamically allocate metapage structures
   Use slab cache and pool of reserved structures to manage the metapage
   structures. This is set up similar to the mempool routines in the
   2.5 kernel. Previously a fixed number of these structures were
   preallocated. This did not scale well.
- Rework JFS's inode locking


For more details about JFS, please see the patch instructions or
changelog.jfs files.

Steve
JFS for Linux http://oss.software.ibm.com/jfs


