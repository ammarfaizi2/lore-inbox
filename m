Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280365AbRKSRcO>; Mon, 19 Nov 2001 12:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280388AbRKSRcG>; Mon, 19 Nov 2001 12:32:06 -0500
Received: from zok.SGI.COM ([204.94.215.101]:12747 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S280365AbRKSRb6>;
	Mon, 19 Nov 2001 12:31:58 -0500
Subject: [ANNOUNCE] XFS 1.0.2 for Linux Released
From: Eric Sandeen <sandeen@sgi.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 19 Nov 2001 11:29:24 -0600
Message-Id: <1006190964.29797.13.camel@stout.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SGI is pleased to announce the 1.0.2 release of XFS for Linux.

This release includes kernels for both ia64 and x86 architectures, 
including x86 RPMs based on kernels from Red Hat Linux 7.1 and 7.2.
This release also includes a system installer for Red Hat Linux 7.2.

For more information, please see
http://oss.sgi.com/projects/xfs/102_release.html
and the changelog at the end of this message.

Downloads are available at
ftp://oss.sgi.com/projects/xfs/download/Release-1.0.2/

This download URL contains the following directories:

kernel_rpms/i386/linux-2.4.14/

These 2.4.14 kernel RPMS are based on vanilla 2.4.14 kernels 
(Linus' tree) with XFS and kdb added.


kernel_rpms/i386/2.4.9-12-RH7.1/
kernel_rpms/i386/2.4.9-13-RH7.2/

These 2.4.9 kernel RPMS are based on Red Hat's 7.1/7.2 2.4.9 kernel
version - 
only the XFS bits have been changed.  These RPMS are intended
for anyone using XFS on RH 7.1/7.2 in an environment where they 
need Red Hat's kernel improvements, and they do not wish
to jump kernel versions to get XFS improvements.


kernel_rpms/ia64/2.4.9/

These are xfs-enabled kernel RPMs based on "vanilla" 2.4.9 linux,
built for the IA64 platform.


kernel_patches/i386/2.4.14/

The patches provided are for linux-2.4.14.
kdb patches are also provided for debugging.


kernel_patches/ia64/2.4.9/

This patch is against the vanilla 2.4.9 kernel, for ia64 architectures.

See the README file in the patches/ directories for patching
instructions.


cmd_tars/
cmd_rpms/

Userspace tools are provided both as source tarballs and
as RPMs, for both ia64 and i386 platforms.


installer/i386/

The installer/i386/ directory contains a modified Red Hat 7.2
installer that will allow you to install a Red Hat 7.2 system
on XFS.  If you already used the XFS 1.0 or 1.0.1 system installer, 
you can use this to upgrade your system.

Note that an ia64 system installer is not available at this time.


CHANGES since 1.0.1:
====================

Kernel
------
Fixed direct I/O read beyond eof.
Removed BLKBSZSET ioctl from kernel.
O_SYNC write path error checking.
Low memory improvements.
Fixed busy inode after xfsdump problem.
Worked around gcc bug in xfs_growfs.
Added MODULE_LICENSE("GPL") to XFS modules.
Changed dmapi to use /proc instead of /dev/dmapi.
Fixed nfs related bug with sparse file size.
Merged in bugfixes from Irix.
DMAPI can now monitor memory mapped files.

ACL
---
* Added -r (recursive) option to chacl.
* Fixed a bug in acl_check ACL validity check code.

xfsdump
-------
* xfsdump/xfsrestore available from root filesystem.
* xfsdump/xfsrestore now handle DMAPI filesystems.
* Fixed xfsrestore handling of device major numbers.
* Allowed xfsrestore to run on non-xfs filesystem.
* Merged xfsdump fsr bug fixes from IRIX.
* Merged xfsdump phase 3 performance fixup from IRIX.
* Merged xfsdump code to specify maximum file size, specify media file
  size, & request single media file.
* FHS compliance for xfsdump inventory directory (/var/lib/xfsdump).

xfs_db
------
* Fixed endianness bug in xfs_db write command.
* Fixed frag command in xfs_db.

xfsprogs
---------
* Fixed xfs_growfs bug when parsing mount options.
* Fixed too-small-final-AG bug in mkfs.xfs.
* Fixed xfs_repair bug in handling a corrupt root directory inode with
  multiple "lost+found" entries.
* Prevented xfs_repair from zeroing a dirty log.
* Added mkfs.xfs heuristics to prevent inode numbers > 32 bits on >1TB
  filesystems.
* Implemented the -f (file) option to xfs_logprint.
* Changed mkfs.xfs to call lvdisplay instead of linking against liblvm.

misc
----
* Changed libdm (dmapi), libhandle, libacl, libattr libraries to LGPL
  license.
* Updated documentation.

----

Many thanks to mkp@linuxcare, msw@redhat, and arjan@redhat
for their help in preparing this release.

-- 
Eric Sandeen      XFS for Linux     http://oss.sgi.com/projects/xfs
sandeen@sgi.com   SGI, Inc.

