Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264632AbTFQIAX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 04:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264634AbTFQIAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 04:00:23 -0400
Received: from speedy.tutby.com ([195.209.41.194]:43960 "EHLO tut.by")
	by vger.kernel.org with ESMTP id S264632AbTFQIAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 04:00:21 -0400
Date: Tue, 17 Jun 2003 11:15:02 +0300
From: Igor Krasnoselski <iek@tut.by>
X-Mailer: The Bat! (v1.36) S/N F29DEE5D / Educational
Reply-To: Igor Krasnoselski <iek@tut.by>
X-Priority: 3 (Normal)
Message-ID: <10468.030617@tut.by>
To: linux-kernel@vger.kernel.org
Subject: Can't mount an ext3 partition - why?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

maybe it's so easy... but I stuck on it:

I have a 2.4.18-3 pre-compiled kernel coming with an RH7.3
distribution. Running a system under it I create an ext-3 partition on
a secondary HDD (/dev/hdc1). All was fine, but now I have to recompile
my kernel with some new modules, and new kernel can't mount this! It
mounts my /dev/hda partitions (/, /boot and swap) without any
question, but /dev/hdc1 makes it stuck! fsck says, it has something
wrong on it... But old kernel mounts hdc1 silently, and I have no reason
to run fsck (I think).

Please tell me what I miss in the kernel config? Here's related part
of it:

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_UMSDOS_FS=y
CONFIG_VFAT_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_JFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=y
# CONFIG_UDF_RW is not set
CONFIG_UFS_FS=y
# CONFIG_UFS_FS_WRITE is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y                   *
CONFIG_SOLARIS_X86_PARTITION=y                *
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y                        *
CONFIG_SMB_NLS=y
CONFIG_NLS=y

* is a result of my 'experiments' with different partition types...

PC is Intel Pentium II 233, hda is 4GB Fujitsy, hdc is 80GB Maxtor
(BIOS can't detect it, so in BIOS table I choose "none").

Any comments?

-- 
Best regards,
 Igor                            mailto:iek@tut.by


