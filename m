Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262644AbSIPP5Y>; Mon, 16 Sep 2002 11:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262645AbSIPP5Y>; Mon, 16 Sep 2002 11:57:24 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:43403 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262644AbSIPP5X>;
	Mon, 16 Sep 2002 11:57:23 -0400
Subject: [ANNOUNCE]  Journaled File System (JFS)  release 1.0.22
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF1DB2874A.3A92B29E-ON85256C36.00576261@pok.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Mon, 16 Sep 2002 11:02:14 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 09/16/2002 12:02:16 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Release 1.0.22 of JFS was made available today.

Drop 60 on September 16, 2002 (jfs-2.4-1.0.22.tar.gz
and jfsutils-1.0.22.tar.gz) includes fixes to the file
system and utilities.

There are two patches available to support ACLs, the first is
JFS extended attributes (jfs-2.4-1.0.22-xattr.patch)
the second is JFS ACLs (jfs-2.4-1.0.22-acl.patch).

Utilities changes

- add jfs_tune utility (see jfs_tune man page for details)
  jfs_tune allows users to:
    attach a JFS external journal to a JFS file system
    set/change volume label, UUID of JFS file system and external log
    devices
    view superblock information of JFS file system and external log
    devices
- add option '-J journal_device' to mkfs.jfs to create an external journal
   only   and optionally set its volume label (see mkfs.jfs man page)
- add option '-J device=' to mkfs.jfs to attach an existing JFS external
   journal to the JFS file system that will be created
   (see mkfs.jfs man page)
- fix mkfs.jfs to store 16 character volume labels properly
- code cleaup
- add extend support to JFS FSIM for EVMS
    see http://sourceforge.net/projects/evms/


File System changes

- Use strtoul instead of strtoull
- Add write_super_lockfs & unlock_fs used for snapshot
- rework extent invalidation
- cosmetic changes to reduce the diff to the bitkeeper tree
- backport lmLogWait from 2.5
- Remove unused jfs_extendfs.h
- use buffer_heads to access the superblock
- ifdef out unused functions related to partial blocks
- sync the block device on umount or r/o remount
- remove superfluous includes


For more details about JFS, please see the patch instructions
or changelog.jfs files.


Steve
JFS for Linux http://oss.software.ibm.com/jfs


