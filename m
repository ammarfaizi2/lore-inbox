Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270135AbRHWTNf>; Thu, 23 Aug 2001 15:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270131AbRHWTNZ>; Thu, 23 Aug 2001 15:13:25 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:40100 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S270102AbRHWTNP>; Thu, 23 Aug 2001 15:13:15 -0400
Date: Thu, 23 Aug 2001 13:06:06 -0600
Message-Id: <200108231906.f7NJ66M14854@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v190 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 190 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

REMINDER: this patch and earlier patches include support for >2000
SCSI discs. Complete ChangeLog against 2.4.9 is appended.

This is against 2.4.9. Highlights of this release:

- Updated README from master HTML file

- Replaced BKL with global rwsem to protect symlink data (quick and
  dirty hack)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
===============================================================================
- Fixed bug in <devfs_setup> which could hang boot process

- Support large numbers of SCSI discs (~2080)

- Documentation typo fix for fs/devfs/util.c

- Added DEVFSD_NOTIFY_DELETE event

- Removed #include <asm/segment.h> from fs/devfs/base.c

- Made <block_semaphore> and <char_semaphore> in fs/devfs/util.c
  private

- Fixed inode table races by removing it and using inode->u.generic_ip
  instead

- Moved <devfs_read_inode> into <get_vfs_inode>

- Moved <devfs_write_inode> into <devfs_notify_change>

- Fixed race in <devfs_do_symlink> for uni-processor

- Fixed drivers/char/stallion.c for devfs

- Fixed drivers/char/rocket.c for devfs

- Fixed bug in <devfs_alloc_unique_number>: limited to 128 numbers

- Updated major masks in fs/devfs/util.c up to Linus' "no new majors"
  proclamation. Block: were 126 now 122 free, char: were 26 now 19 free

- Removed remnant of multi-mount support in <devfs_mknod>

- Removed unused DEVFS_FL_SHOW_UNREG flag

- Removed nlink field from struct devfs_inode

- Removed auto-ownership for /dev/pty/* (BSD ptys) and used
  DEVFS_FL_CURRENT_OWNER|DEVFS_FL_NO_PERSISTENCE for /dev/pty/s* (just
  like Unix98 pty slaves) and made /dev/pty/m* rw-rw-rw- access

- Updated README from master HTML file

- Replaced BKL with global rwsem to protect symlink data (quick and
  dirty hack)
