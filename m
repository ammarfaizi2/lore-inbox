Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265640AbTIESwd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 14:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265642AbTIESwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 14:52:32 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:27351 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265640AbTIESwb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 14:52:31 -0400
Subject: [ANNOUNCE] JFS 1.1.2
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1062787938.9648.15.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 05 Sep 2003 13:52:18 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.1.3 of JFS was made available today.

It is important that you update the JFS utilities if you are using the
2.6.0 kernel.  A recent change in the kernel changed the behavior of
the O_EXCL flag in an open call to a block device.  Older versions of
fsck.jfs may fail to replay the journal when a file system is mounted
read-only.  (This will be the case if the root file system is JFS.)

Drop 66 on September 5, 2003 includes fixes to the file system and
utilities.

Utilities changes

- jfs_fsck can now find external journal on evms release 2 volumes
- code cleanup: fsck messaging is much cleaner
- Don't right-justify when printing volume label
- jfs_fsck should return zero when replaying the journal is successful
- jfs_fsck should not require that the device is opened with O_EXCL

File System changes

- Fix compat.h so that compile does not break on unlikely and dump_stack
- jfs_lookup should check for bad inode returned by iget
- Prevent rare deadlock
- Fix compile problem with recent Redhat kernels
- Code cleanup suggested by static analysis tool
- Peformance improvement
- Use block device inode/mapping instead of direct_inode/direct_mapping
- Support for kernels older than 2.4.18 has been removed
- Fix resize errors
- Fix possible trap/data loss when fixing directory index table
- If unicode conversion fails, operation should fail
- Code cleanup: make error return codes negative
- add nointegrity mount option
- Merge xattr code.  This has been in the official kernel since 2.4.20
- jfs_write_super_lockfs should mark superblock clean

Note: The 2.4.23 and 2.6 kernel.org development kernels are kept up to 
date with the latest JFS code.  The file system updates available on 
the web site are only needed for maintaining earlier 2.4 kernels.

For more details about JFS, please see our website:
http://oss.software.ibm.com/jfs
-- 
David Kleikamp
IBM Linux Technology Center

