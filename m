Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283048AbRLMCeB>; Wed, 12 Dec 2001 21:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283045AbRLMCdw>; Wed, 12 Dec 2001 21:33:52 -0500
Received: from nr9-216-68-182-146.fuse.net ([216.68.182.146]:51603 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S283048AbRLMCdp>;
	Wed, 12 Dec 2001 21:33:45 -0500
Date: Wed, 12 Dec 2001 21:33:44 -0500 (EST)
From: Rob Hensley <zoid@zoid.staticky.com>
X-X-Sender: <zoid@localhost>
To: <linux-kernel@vger.kernel.org>
Subject: debian unstable and 2.4.16-pre8...
Message-ID: <Pine.LNX.4.33.0112122124480.21682-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's what I've got installed:

binutils	2.11.92.0.12.3-3
gcc		2:2.95.4-9
gcc-3.0		1:3.0.3-0pre011209
libc6		2.2.4-7

And here are the steps I took to compiling my kernel:

1.) Got the 2.4.16 source and the pre8 patch and put them both in /usr/src
2.) tar zxvf linux-2.4.16.tar.gz
3.) gzip -cd patch-2.4.17-pre8.gz | patch -p0
4.) I then copied my old kernel .config to /usr/src/linux and ran
    make oldconfig
5.) Everything went fine with make oldconfig, so I went ahead and did
    make dep
6.) After make dep, everything still went fine, so I did make bzImage
7.) During make bzImage I got the following error:

    ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/acpi/acpi.o drivers/char/char.o drivers/block/block.o
drivers/misc/misc.o drivers/net/net.o drivers/media/media.o
drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o
drivers/ieee1394/ieee1394drv.o drivers/cdrom/driver.o
drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/pcmcia/pcmcia.o
drivers/net/pcmcia/pcmcia_net.o drivers/net/wireless/wireless_net.o
drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/pcmcia/pcmcia.o(.data+0x1294): undefined reference to `local
symbols in discarded section .text.exit'
make: *** [vmlinux] Error 1

If anyone has any clue how I can go about fixing this, or you need more
information about my installation, or somethin' else, please feel free to
ask, any help would be greatly appreciated. Thanks in advance.

--------------------------------------------------------------------------------

Rob Hensley
E-email:      zoid@staticky.com
Text Message: 5135186731@airtouch.net

