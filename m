Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265262AbSLQTLD>; Tue, 17 Dec 2002 14:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265541AbSLQTLD>; Tue, 17 Dec 2002 14:11:03 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:40092 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265262AbSLQTLC>;
	Tue, 17 Dec 2002 14:11:02 -0500
Subject: [ANNOUNCE]  Journaled File System (JFS)  release 1.1.1
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF2E26C923.FCC2F94E-ON85256C92.0069F495@pok.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Tue, 17 Dec 2002 13:18:49 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 12/17/2002 02:18:55 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Release 1.1.1 of JFS was made available today.

Drop 64 on December 17, 2002 (jfs-2.4-1.1.1.tar.gz
and jfsutils-1.1.1.tar.gz) includes fixes to the file
system and utilities.

Utilities changes

- fix segmentation fault in mkfs.jfs when given bad block device
- fix jfs_debugfs to display directory index with directory entries


File System changes

- calling brelse() with wrong bh during writing out of secondary
  superblock while resizing the FS
- Remove COMMIT_Holdlock
- jfs_clear_inode was assuming that active_ag should never be set
  coming into this routine. Since it's possible for a file to be
  extended after the file descriptor has been closed, we need to allow
  the possibility. (Dirty pages of memory mapped files can be written
  after the file has been closed.)
- Avoid writing partial log pages for lazy transactions.
- Move index table out of directory inode's address space.
- jfs_truncate needs to call block_truncate_page


For more details about JFS, please see the patch instructions or
readme files.


Steve
JFS for Linux http://oss.software.ibm.com/jfs


