Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277533AbRKNUzu>; Wed, 14 Nov 2001 15:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277541AbRKNUzl>; Wed, 14 Nov 2001 15:55:41 -0500
Received: from lol1122.lss.emc.com ([168.159.27.122]:52352 "EHLO
	lol1122.lss.emc.com") by vger.kernel.org with ESMTP
	id <S277533AbRKNUzb>; Wed, 14 Nov 2001 15:55:31 -0500
Date: Wed, 14 Nov 2001 15:55:26 -0500
Message-Id: <200111142055.fAEKtQY30336@lol1122.lss.emc.com>
To: linux-kernel@vger.kernel.org
From: Preston Crow <pc-lkml141101@crowcastle.net>
Subject: Compile failed on fs.o for 2.4.15-pre4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After making the patch to setup.c so that it would compile, I ran into a
linking error.  I have a fairly standard uniprocessor PIII system.  I can
make my config file available to anyone that thinks it will help.


make[1]: Leaving directory `/usr/src/linux/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/net/fc/fc.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
fs/fs.o: In function `dput':
fs/fs.o(.text+0x10fb8): undefined reference to `atomic_dec_and_lock'
make: *** [vmlinux] Error 1

[Please CC responses to me]

--PC
