Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964770AbWJBPQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770AbWJBPQP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 11:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWJBPQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 11:16:15 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:21916 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932521AbWJBPQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 11:16:14 -0400
To: torvalds@osdl.org
Subject: [git pull] jfs update
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-Id: <20061002151612.6AB5A83A2B@kleikamp.austin.ibm.com>
Date: Mon,  2 Oct 2006 10:16:12 -0500 (CDT)
From: shaggy@austin.ibm.com (Dave Kleikamp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git for-linus

This will update the following files:

 fs/jfs/acl.c            |    8 -
 fs/jfs/endian24.h       |    2 
 fs/jfs/file.c           |    8 -
 fs/jfs/inode.c          |    8 -
 fs/jfs/jfs_acl.h        |    8 -
 fs/jfs/jfs_btree.h      |    6 -
 fs/jfs/jfs_debug.c      |    6 -
 fs/jfs/jfs_dinode.h     |    8 -
 fs/jfs/jfs_dmap.c       |  180 +++++++++++++++---------------
 fs/jfs/jfs_dmap.h       |   28 ++--
 fs/jfs/jfs_dtree.c      |   18 +--
 fs/jfs/jfs_dtree.h      |   10 -
 fs/jfs/jfs_extent.c     |   42 +++----
 fs/jfs/jfs_extent.h     |    8 -
 fs/jfs/jfs_filsys.h     |   24 ++--
 fs/jfs/jfs_imap.c       |  222 +++++++++++++++++++-------------------
 fs/jfs/jfs_imap.h       |   14 +-
 fs/jfs/jfs_incore.h     |    8 -
 fs/jfs/jfs_inode.c      |   15 +-
 fs/jfs/jfs_inode.h      |    6 -
 fs/jfs/jfs_lock.h       |   10 -
 fs/jfs/jfs_logmgr.c     |   38 +++---
 fs/jfs/jfs_logmgr.h     |   76 ++++++-------
 fs/jfs/jfs_metapage.c   |   12 +-
 fs/jfs/jfs_metapage.h   |    8 -
 fs/jfs/jfs_mount.c      |   34 ++---
 fs/jfs/jfs_superblock.h |   22 +--
 fs/jfs/jfs_txnmgr.c     |    8 -
 fs/jfs/jfs_txnmgr.h     |   12 +-
 fs/jfs/jfs_umount.c     |   24 ++--
 fs/jfs/jfs_unicode.c    |   12 +-
 fs/jfs/jfs_unicode.h    |   10 -
 fs/jfs/jfs_uniupr.c     |    8 -
 fs/jfs/jfs_xattr.h      |    2 
 fs/jfs/jfs_xtree.c      |   12 +-
 fs/jfs/jfs_xtree.h      |    8 -
 fs/jfs/namei.c          |   67 +++++------
 fs/jfs/resize.c         |    6 -
 fs/jfs/super.c          |   12 +-
 fs/jfs/symlink.c        |    6 -
 fs/jfs/xattr.c          |   38 +++---
 41 files changed, 525 insertions(+), 529 deletions(-)

through these ChangeSets:

Commit: 63f83c9fcf40ab61b75edf5d2f2c1ae6bf876482 
Author: Dave Kleikamp <shaggy@austin.ibm.com> Mon, 02 Oct 2006 09:55:27 -0500 

    JFS: White space cleanup
    
    Removed trailing spaces & tabs, and spaces preceding tabs.
    Also a couple very minor comment cleanups.
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>
    (cherry picked from f74156539964d7b3d5164fdf8848e6a682f75b97 commit)

Commit: 087387f90f577f5a0ab68d33ef326c9bb6d80dda 
Author: Akinobu Mita <mita@miraclelinux.com> Thu, 14 Sep 2006 09:22:38 -0500 

    [PATCH] JFS: return correct error when i-node allocation failed
    
    I have seen confusing behavior on JFS when I injected many intentional
    slab allocation errors. The cp command failed with no disk space error
    with enough disk space.
    
    This patch makes:
    
    - change the return value in case slab allocation failures happen
      from -ENOSPC to -ENOMEM
    
    - ialloc() return error code so that the caller can know the reason
      of failures
    
    Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>
    (cherry picked from 2b46f77976f798f3fe800809a1d0ed38763c71c8 commit)

Commit: 2a6968a9784551c216f9379a728d4104dbad98a8 
Author: Tony Breeds <tony@bakeyournoodle.com> Mon, 11 Sep 2006 08:19:19 -0500 

    JFS: Remove shadow variable from fs/jfs/jfs_txnmgr.c:xtLog()
    
    Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>
    (cherry picked from bdc3d9e5af7d9c105be734dd7b5c3f1d9425a15a commit)

