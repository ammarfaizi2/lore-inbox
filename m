Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272313AbTHIKMv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 06:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272314AbTHIKMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 06:12:51 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:54030 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S272313AbTHIKMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 06:12:49 -0400
Date: Sat, 9 Aug 2003 11:07:18 +0200
To: lkml@vger.kernel.org
Subject: 2.6.0-test3 cannot mount root fs
Message-ID: <20030809090718.GA10360@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi friends!

I am trying 2.6.0-test3 but cannot get the kernel to mount /dev/hdb1
which is the root fs.

I tells me all the usual stuff concerning that it finds the controllers
(VIA and HPT) and disks/cdroms, but than hangs with
	cannot mount rootfs "NULL" or hdb1
I have compile in (of course) the filesystems of my root fs (ext3) and
everything else I thought may be necessary, or at least what has been
necessary up to 2.4.22-rc2.

hardware: athlon, via686 ide + hpt366/370 ide, linux is un hdb

here my config options for ide:
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDISK_STROKE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_TASKFILE_IO=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y

for FS:
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_MINIX_FS=m
CONFIG_ROMFS_FS=m
CONFIG_ISO9660_FS=m
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_HFS_FS=m
CONFIG_CRAMFS=m

Unfortunately I cannot capture the output of the boot of 2.6.0, but I
would happily compare it to one's dmesg output. So if you have 2.6.0
running with via686 can you send me the dmesg after boot, so that I can
check what there should be or what I  am missing.

Thanks a lot

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
WIDDICOMBE (n.)
The sort of person who impersonates trim phones.
			--- Douglas Adams, The Meaning of Liff
