Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265289AbTLGA45 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 19:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265291AbTLGA45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 19:56:57 -0500
Received: from relay01.uchicago.edu ([128.135.12.136]:40424 "EHLO
	relay01.uchicago.edu") by vger.kernel.org with ESMTP
	id S265289AbTLGA4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 19:56:55 -0500
Date: Sat, 6 Dec 2003 18:56:54 -0600 (CST)
From: Ryan Reich <ryanr@uchicago.edu>
Reply-To: Ryan Reich <ryanr@uchicago.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.23-ck1 w/grsec patch build fails
Message-ID: <Pine.LNX.4.58.0312061854450.9348@ryanr.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following linking error when I build this:

ld -m elf_i386 -T /usr/src/structural/system/linux-2.4.23/arch/i386/vmlinux.lds
-e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o \
         drivers/acpi/acpi.o drivers/char/char.o drivers/block/block.o
drivers/misc/misc.o drivers/net/net.o drivers/char/drm/drm.o
drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/ieee1394/ieee1394drv.o
drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o
drivers/video/video.o drivers/usb/usbdrv.o drivers/media/media.o crypto/crypto.o
\
        net/network.o \
        grsecurity/grsec.o \
        /usr/src/structural/system/linux-2.4.23/arch/i386/lib/lib.a
/usr/src/structural/system/linux-2.4.23/lib/lib.a
/usr/src/structural/system/linux-2.4.23/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
grsecurity/grsec.o: In function `gr_acl_handle_psacct':
grsecurity/grsec.o(.text+0xfc80): undefined reference to `__udivdi3'
make: *** [vmlinux] Error 1

I have the grsec-fix patch also, not that it should matter since it only changes
one line in the chroot module.  Compiler is gcc-3.2.1.

Ryan Reich
