Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbSKTRKz>; Wed, 20 Nov 2002 12:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261627AbSKTRKz>; Wed, 20 Nov 2002 12:10:55 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:28129 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261624AbSKTRKy>;
	Wed, 20 Nov 2002 12:10:54 -0500
Subject: [ANNOUNCE]  Journaled File System (JFS)  release 1.1.0
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF0A870FDA.DB5EE301-ON85256C77.005EBF18@pok.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Wed, 20 Nov 2002 11:17:45 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 11/20/2002 12:17:53 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.1.0 of JFS was made available today.

Drop 63 on November 20, 2002 (jfs-2.4-1.1.0.tar.gz
and jfsutils-1.1.0.tar.gz) includes fixes to the file
system and utilities. Extended attributes and ACLs patches
have been updated also.

Utilities changes

- rename jfs utilities as follows:
    fsck.jfs -> jfs_fsck, is hard linked to fsck.jfs upon install
    mkfs.jfs -> jfs_mkfs, is hard linked to mkfs.jfs upon install
    jfs_tune remains the same
    logdump -> jfs_logdump
    xchklog, xchkdmp combined -> jfs_fscklog
    xpeek -> jfs_debugfs
    logredo removed, function added to jfs_fsck via
    --replay_journal_only option
- update man pages appropriately for name changes
- change jfs_fsck option -o to --omit_journal_replay
- fix log replay errors
- fix off-by-one error, minor formatting error in jfs_fsck
- keep jfs_fsck from complaining during specific tree restructuring
- fix jfs_debugfs to recognize all inode types
- code cleanup

File System changes

- Fix off-by-one error when symbolic link length == 256 (bug 1513)
- jfs_clear_inode should skip bad inodes instead of choking on them
  (bug 1445)
- Make txForce actually force the metadata to disk
- Fix hang on umount after stress test(#21357) ACL problem
- Fix byte-swapping problem in getting ealist->size (bug 21085) EA
  problem

For more details about JFS, please see the patch instructions or
readme files.


Steve
JFS for Linux http://oss.software.ibm.com/jfs




