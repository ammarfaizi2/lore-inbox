Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130155AbQLWPpj>; Sat, 23 Dec 2000 10:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130300AbQLWPp3>; Sat, 23 Dec 2000 10:45:29 -0500
Received: from s340-modem2372.dial.xs4all.nl ([194.109.169.68]:9860 "EHLO
	sjoerd.sjoerdnet") by vger.kernel.org with ESMTP id <S130155AbQLWPpJ>;
	Sat, 23 Dec 2000 10:45:09 -0500
Date: Sat, 23 Dec 2000 16:12:40 +0100 (CET)
From: Arjan Filius <iafilius@xs4all.nl>
Reply-To: Arjan Filius <iafilius@xs4all.nl>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: "undefined reference" atm_lane_init & atm_mpoa_init with test13-pre4
In-Reply-To: <Pine.LNX.4.10.10012211726060.968-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0012231600450.17383-100000@sjoerd.sjoerdnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

With 2.4.0-test13-pre4 i noticed

 "Networking options"
  <M>   LAN Emulation (LANE) support
  <M>   Multi-Protocol Over ATM (MPOA) support

results with 'make bzImage' in:

make[1]: Leaving directory `/usr/src/linux-2.4.0-test13-4/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	drivers/block/block.o drivers/char/char.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o  drivers/char/drm/drm.o drivers/net/fc/fc.o drivers/net/appletalk/appletalk.o drivers/net/tokenring/tr.a drivers/net/wan/wan.o drivers/atm/atm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o drivers/net/hamradio/hamradio.o drivers/md/mddev.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
net/network.o: In function `atm_ioctl':
net/network.o(.text+0x3ff92): undefined reference to `atm_lane_init'
net/network.o(.text+0x40039): undefined reference to `atm_mpoa_init'
make: *** [vmlinux] Error 1
sjoerd:/usr/src/linux #

Unsetting these options "fixed" this for me.

Greatings,

-- 
Arjan Filius
mailto:iafilius@xs4all.nl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
