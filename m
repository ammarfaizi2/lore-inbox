Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287425AbSAaKcG>; Thu, 31 Jan 2002 05:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288020AbSAaKb5>; Thu, 31 Jan 2002 05:31:57 -0500
Received: from Backfire.WH8.TU-Dresden.De ([141.30.225.118]:61093 "EHLO
	backfire.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S287425AbSAaKbq>; Thu, 31 Jan 2002 05:31:46 -0500
Message-Id: <200201311031.g0VAVjGC025915@backfire.WH8.TU-Dresden.De>
Content-Type: text/plain; charset=US-ASCII
From: Gregor Jasny <gjasny@wh8.tu-dresden.de>
Organization: Networkadministrator WH8/DD/Germany
To: linux-kernel@vger.kernel.org
Subject: 2.5.3 link problem in zisofs
Date: Thu, 31 Jan 2002 11:31:44 +0100
X-Mailer: KMail [version 1.3.2]
X-PGP-fingerprint: 5A65 E2CC EB06 F110 4F45  AB34 DE58 C135 1361 35BD
X-PGP-public-key: finger gjasny@hell.wh8.tu-dresden.de
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm usin debian sid with  binutils 2.11.92.0.12.3-5.

make[2]: Leaving directory `/usr/src/linux-2.5.3/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux-2.5.3/arch/i386/vmlinux.lds -e stext 
arch/i386/kernel/head.o arch/i386/
kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o 
fs/fs.o ipc/ipc.o \
        /usr/src/linux-2.5.3/arch/i386/lib/lib.a 
/usr/src/linux-2.5.3/lib/lib.a /usr/src/linux-2.5.3/arc
h/i386/lib/lib.a \
         drivers/acpi/acpi.o drivers/base/base.o drivers/char/char.o 
drivers/block/block.o drivers/misc/
misc.o drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o 
drivers/char/drm/drm.o drivers/ide
/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o 
drivers/pci/driver.o drivers/video/video.o dr
ivers/usb/usbdrv.o \
        net/network.o \
        --end-group \
        -o vmlinux
fs/fs.o: In function `init_iso9660_fs':
fs/fs.o(.text.init+0xcd1): undefined reference to `zisofs_cleanup'
drivers/char/char.o(.data+0x46b4): undefined reference to `local symbols in 
discarded section .text.exit
'
drivers/net/net.o(.data+0xd4): undefined reference to `local symbols in 
discarded section .text.exit'
make[1]: *** [vmlinux] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.3'
make: *** [stamp-build] Error 2
