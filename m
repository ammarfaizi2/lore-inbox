Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267034AbTAFRG7>; Mon, 6 Jan 2003 12:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267033AbTAFRG7>; Mon, 6 Jan 2003 12:06:59 -0500
Received: from air-2.osdl.org ([65.172.181.6]:14033 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267057AbTAFRF2>;
	Mon, 6 Jan 2003 12:05:28 -0500
Subject: [STABILITY] Compile / STP metrics
From: John Cherry <cherry@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: linstab@osdl.org
Content-Type: text/plain
Organization: 
Message-Id: <1041873937.17802.23.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 06 Jan 2003 09:25:38 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile statistics have been for kernel releases from 2.5.46 to 2.5.54
at: www.osdl.org/archive/cherry/stability

This page also has the beginnings of STP (Scalable Test Platform)
results for a number of tests (aim9, LTP, unixbench, contest, bonnie++,
debench (quick), hackbench, iozone, dbt1 (1-tier), lmbench (short)) for
recent kernel releases.

These metrics are simply one way to measure how 2.5 is converging.  Many
of the compilation errors are being addressed by various kernel
developers, so in some ways, these statics are restating the obvious.

Reasonable convergence of compile time warnings/errors was happening
until 2.5.54 was released.  However, 2.5.54 took a step backwards.  The
latest results show...

                           2.5.53                       2.5.54
                       ------------------------ ------------------------
bzImage (defconfig)      16 warnings/0 errors     68 warnings/0 errors
bzImage (allmodconfig)   31 warnings/9 errors     40 warnings/11 errors
modules (allmodconfig) 1843 warnings/118 errors 3223 warnings/208 errors

The script that generated this data is also at
www.osdl.org/archive/cherry/stability.  Detailed information on warnings
and errors can be found by following the links in the table, but a
summary of the 2.5.54 run is shown here....

Kernel version: 2.5.54
Kernel build: 
   Making bzImage (defconfig): 68 warnings, 0 errors
   Making bzImage (allmodconfig): 40 warnings, 11 errors
   Making modules (allmodconfig): 3223 warnings, 208 errors

Building directories:
   Building fs/autofs: clean
   Building fs/autofs4: clean
   Building fs/befs: 0 warnings, 2 errors
   Building fs/bfs: clean
   Building fs/devfs: clean
   Building fs/devpts: clean
   Building fs/efs: clean
   Building fs/exportfs: clean
   Building fs/ext2: clean
   Building fs/ext3: clean
   Building fs/fat: clean
   Building fs/hfs: clean
   Building fs/hpfs: clean
   Building fs/hugetlbfs: clean
   Building fs/intermezzo: 2 warnings, 0 errors
   Building fs/isofs: clean
   Building fs/jbd: clean
   Building fs/jffs: clean
   Building fs/jffs2: clean
   Building fs/jfs: clean
   Building fs/lockd: 4 warnings, 0 errors
   Building fs/ncpfs: clean
   Building fs/nfs: clean
   Building fs/nfsd: 2 warnings, 0 errors
   Building fs/nls: clean
   Building fs/ntfs: 3 warnings, 0 errors
   Building fs/openpromfs: clean
   Building fs/partitions: clean
   Building fs/proc: clean
   Building fs/qnx4: clean
   Building fs/reiserfs: 1 warnings, 0 errors
   Building fs/romfs: 0 warnings, 2 errors
   Building fs/smbfs: 2 warnings, 0 errors
   Building fs/sysfs: clean
   Building fs/sysv: clean
   Building fs/udf: clean
   Building fs/ufs: clean
   Building fs/umsdos: clean
   Building fs/vfat: clean
   Building fs/xfs: 2 warnings, 0 errors
   Building drivers/acorn: clean
   Building drivers/cdrom: 34 warnings, 0 errors
   Building drivers/ide: 45 warnings, 2 errors
   Building drivers/mca: clean
   Building drivers/net: 626 warnings, 20 errors
   Building drivers/pcmcia: 13 warnings, 0 errors
   Building drivers/sgi: clean
   Building drivers/acpi: clean
   Building drivers/char: 374 warnings, 8 errors
   Building drivers/ieee1394: 17 warnings, 2 errors
   Building drivers/md: 18 warnings, 0 errors
   Building drivers/nubus: clean
   Building drivers/pnp: clean
   Building drivers/tc: clean
   Building river/atm: clean
   Building drivers/dio: clean
   Building drivers/input: 5 warnings, 0 errors
   Building drivers/media: 176 warnings, 31 errors
   Building drivers/oprofile: clean
   Building drivers/s390: clean
   Building drivers/telephony: 15 warnings, 2 errors
   Building drivers/base: clean
   Building drivers/fc4: clean
   Building drivers/isdn: 477 warnings, 18 errors
   Building drivers/message: 18 warnings, 2 errors
   Building drivers/parisc: clean
   Building drivers/sbus: clean
   Building drivers/usb: 34 warnings, 0 errors
   Building drivers/block: 10 warnings, 2 errors
   Building drivers/hotplug: 10 warnings, 0 errors
   Building drivers/misc: clean
   Building drivers/parport: 10 warnings, 0 errors
   Building drivers/scsi/aacraid: 3 warnings, 0 errors
   Building drivers/scsi/aic7xxx: 1 warnings, 0 errors
   Building drivers/scsi/dpt: clean
   Building drivers/scsi/pcmcia: 24 warnings, 3 errors
   Building drivers/scsi/sym53c8xx_2: 1 warnings, 0 errors
   Building drivers/video/aty: 0 warnings, 2 errors
   Building drivers/video/console: 2 warnings, 0 errors
   Building drivers/video/matrox: 106 warnings, 20 errors
   Building drivers/video/riva: clean
   Building drivers/video/sis: 37 warnings, 3 errors
   Building drivers/bluetooth: 15 warnings, 0 errors
   Building drivers/i2c: 3 warnings, 0 errors
   Building drivers/mtd: 30 warnings, 4 errors
   Building drivers/pci: clean
   Building drivers/serial: 1 warnings, 0 errors
   Building drivers/zorro: clean
   Building sound/core: 2 warnings, 0 errors
   Building sound/drivers: 1 warnings, 0 errors
   Building sound/i2c: clean
   Building sound/isa: 105 warnings, 34 errors
   Building sound/oss: 159 warnings, 13 errors
   Building sound/pci: 8 warnings, 0 errors
   Building sound/synth: clean
   Building sound/usb: clean
   Building arch/i386: clean
   Building crypto: clean
   Building ipc: clean
   Building lib: clean
   Building mm: clean
   Building net: 311 warnings, 0 errors
   Building security: 2 warnings, 0 errors
   Building sound: 123 warnings, 47 errors
   Building drivers/video: 297 warnings, 35 errors
   Building usr: clean


Failure Summary:

   drivers/block: 10 warnings, 2 errors
   drivers/char: 374 warnings, 8 errors
   drivers/ide: 45 warnings, 2 errors
   drivers/ieee1394: 17 warnings, 2 errors
   drivers/isdn: 477 warnings, 18 errors
   drivers/media: 176 warnings, 31 errors
   drivers/message: 18 warnings, 2 errors
   drivers/mtd: 30 warnings, 4 errors
   drivers/net: 626 warnings, 20 errors
   drivers/scsi/pcmcia: 24 warnings, 3 errors
   drivers/telephony: 15 warnings, 2 errors
   drivers/video: 297 warnings, 35 errors
   drivers/video/aty: 0 warnings, 2 errors
   drivers/video/matrox: 106 warnings, 20 errors
   drivers/video/sis: 37 warnings, 3 errors
   fs/befs: 0 warnings, 2 errors
   fs/romfs: 0 warnings, 2 errors
   sound: 123 warnings, 47 errors
   sound/isa: 105 warnings, 34 errors
   sound/oss: 159 warnings, 13 errors


Warning Summary:

   drivers/bluetooth: 15 warnings, 0 errors
   drivers/cdrom: 34 warnings, 0 errors
   drivers/hotplug: 10 warnings, 0 errors
   drivers/i2c: 3 warnings, 0 errors
   drivers/input: 5 warnings, 0 errors
   drivers/md: 18 warnings, 0 errors
   drivers/parport: 10 warnings, 0 errors
   drivers/pcmcia: 13 warnings, 0 errors
   drivers/scsi/aacraid: 3 warnings, 0 errors
   drivers/scsi/aic7xxx: 1 warnings, 0 errors
   drivers/scsi/sym53c8xx_2: 1 warnings, 0 errors
   drivers/serial: 1 warnings, 0 errors
   drivers/usb: 34 warnings, 0 errors
   drivers/video/console: 2 warnings, 0 errors
   fs/intermezzo: 2 warnings, 0 errors
   fs/lockd: 4 warnings, 0 errors
   fs/nfsd: 2 warnings, 0 errors
   fs/ntfs: 3 warnings, 0 errors
   fs/reiserfs: 1 warnings, 0 errors
   fs/smbfs: 2 warnings, 0 errors
   fs/xfs: 2 warnings, 0 errors
   net: 311 warnings, 0 errors
   security: 2 warnings, 0 errors
   sound/core: 2 warnings, 0 errors
   sound/drivers: 1 warnings, 0 errors
   sound/pci: 8 warnings, 0 errors

John Cherry
OSDL



