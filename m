Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbTLAB2I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 20:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbTLAB2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 20:28:08 -0500
Received: from relay01.uchicago.edu ([128.135.12.136]:731 "EHLO
	relay01.uchicago.edu") by vger.kernel.org with ESMTP
	id S262784AbTLAB2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 20:28:05 -0500
Date: Sun, 30 Nov 2003 19:28:03 -0600 (CST)
From: Ryan Reich <ryanr@uchicago.edu>
Reply-To: Ryan Reich <ryanr@uchicago.edu>
To: linux-kernel@vger.kernel.org
Subject: [2.4.22] Error: fs/fs.o: undefined reference to `atomic_dec_and_lock'
Message-ID: <Pine.LNX.4.58.0311301925180.31444@ryanr.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm building a kernel with everything compiled in to serve as a boot image to
install Mandrake on my laptop, and I get the following error:

gcc -E -C -P -I/usr/src/structural/system/linux-2.4.22/include -imacros
/usr/src/structural/system/linux-2.4.22/include/linux/config.h -imacros
/usr/src/structural/system/linux-2.4.22/include/asm-i386/segment.h -imacros
/usr/src/structural/system/linux-2.4.22/include/asm-i386/page_offset.h -Ui386
arch/i386/vmlinux.lds.S >arch/i386/vmlinux.lds
ld -m elf_i386 -T /usr/src/structural/system/linux-2.4.22/arch/i386/vmlinux.lds
-e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/char/agp/agp.o drivers/char/drm/drm.o
drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o
drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/pcmcia/pcmcia.o
drivers/video/video.o drivers/usb/usbdrv.o drivers/media/media.o
drivers/hotplug/vmlinux-obj.o \
        net/network.o \
        grsecurity/grsec.o \
        /usr/src/structural/system/linux-2.4.22/arch/i386/lib/lib.a
/usr/src/structural/system/linux-2.4.22/lib/lib.a
/usr/src/structural/system/linux-2.4.22/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
fs/fs.o: In function `dput':
fs/fs.o(.text+0x15f1c): undefined reference to `atomic_dec_and_lock'
make: *** [vmlinux] Error 1

Ryan Reich
