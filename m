Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310652AbSCLLsx>; Tue, 12 Mar 2002 06:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310632AbSCLLsf>; Tue, 12 Mar 2002 06:48:35 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:8636 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S310646AbSCLLsS>;
	Tue, 12 Mar 2002 06:48:18 -0500
Subject: [ANNOUNCE]  Journaled File System (JFS)  release 1.0.16
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF65E650C0.92890E51-ON86256B7A.004027F4@raleigh.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Tue, 12 Mar 2002 05:46:32 -0600
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.9a |January 7, 2002) at
 03/12/2002 06:47:57 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.0.16 of JFS was made available yesterday.

Drop 54 on March 11, 2002 (jfs-2.4-1.0.16.tar.gz
and jfsutils-1.0.16.tar.gz) includes fixes to the file
system and utilities. JFS has been incorporated into the
2.5.6 linux kernel, and the 2.4.X-ac kernels beginning
with 2.4.18-pre9-ac4.

Utilities changes
- make fsck.jfs exit codes conform to fsck (see updated fsck.jfs man page)
- display/log fsck.jfs exit code in debug exit msg
- fix xchkdmp to print logredo messages
- make xchkdmp print message text instead of message number
- use PBSIZE for physical block size instead of BLKSSZGET ioctl
  (eliminates MD error msg "used obsolete MD ioctl", fixes S/390 mkfs.jfs)
- remove libfs open/close wrappers (Christoph Hellwig)
- messaging code cleanup, general code cleanup (all)

File System changes

- Limit readdir offset to signed integer for NFSv2 (Christoph Hellwig)
- missing static in jfs_imap.c (Christoph Hellwig)
- Fix infinite loop in jfs_readdir
  weren't updating the directory index table completely (bug # 2591)
- Sync up 2.4 tree with 2.5 -- (Christoph Hellwig & Shaggy)
  move to completions, provide back-compact for pre-2.4.7
  remove dead code
  add kdev_t conversion, that should have been in 2.4 anyway
  move one-time inode initialization into slab constructor
- Remove non-core files from CVS

For more details about JFS, please see the patchinstructions or
changelog.jfs files.

Steve
JFS for Linux http://oss.software.ibm.com/jfs

