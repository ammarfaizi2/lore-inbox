Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276151AbRI1Q0G>; Fri, 28 Sep 2001 12:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276153AbRI1QZ5>; Fri, 28 Sep 2001 12:25:57 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:20867 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S276151AbRI1QZs>; Fri, 28 Sep 2001 12:25:48 -0400
Subject: [ANNOUNCEMENT]  Journaled File System (JFS)  release 1.0.6 
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF642081A9.EA7BF10D-ON85256AD5.0059728C@raleigh.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Fri, 28 Sep 2001 11:26:04 -0500
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.8 |June 18, 2001) at
 09/28/2001 12:26:04 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.0.6 of JFS was made available today.

Drop 44 on September 28, 2001 (jfs-2.4-1.0.6-patch.tar.gz
and jfsutils-1.0.6.tar.gz) includes fixes to the file system
and utilities.

Function and Fixes in release 1.0.6

- If fsck rebuilds root directory, reset di_next_index to 2
- fsck needs to process, validate inodes with size=0
- Create jfs_incore.h which merges linux/jfs_fs.h, linux/jfs_fs_i.h
  , and jfs_fs_sb.h (Thanks Christoph Hellwig)
- Create a configuration option to handle JFS_DEBUG define (Thanks
  Christoph Hellwig)
- Fixed a few cases where positive error codes were returned to
  the VFS (Thanks Christoph Hellwig).
- Replace jfs_dir_read by generic_read_dir (Thanks Christoph Hellwig).
- jfs_fsync_inode is only called by jfs_fsync_file, merge the two
  and rename to jfs_fsync (Thanks Christoph Hellwig).
- Add a bunch of missing externs (Thanks Christoph Hellwig).
- jfs_rwlock_lock is unused, nuke it (Thanks Christoph Hellwig).
- Always use atomic set/test_bit operations to protect
  jfs_ip->cflag (Thanks Christoph Hellwig)
- Combine jfs_ip->flag with jfs_ip->cflag (Thanks Christoph Hellwig).
- Fixed minor format errors reported by fsck
- cflags should be long so bitops always works correctly (Thanks
  Christoph Hellwig)
- Use GFP_NOFS for runtime memory allocations (Thanks Christoph Hellwig)
- Support  VM changes in 2.4.10 of the kernel
- Remove ifdefs supporting older 2.4 kernels. JFS now requires
  at least 2.4.3 or 2.4.2-ac2
- Simplify and remove one use of IWRITE_TRYLOCK
- jfs_truncate was not passing tid to xtTruncate
- removed obsolete extent_page workaround
- correct recovery from failed diAlloc call (disk full)
- In write_metapage, don't call commit_write if prepare_write failed

For more details about JFS, please see the README or changelog.jfs.

Steve
JFS for Linux http://oss.software.ibm.com/jfs



