Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281446AbRKFDhf>; Mon, 5 Nov 2001 22:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281448AbRKFDh0>; Mon, 5 Nov 2001 22:37:26 -0500
Received: from skynet.das.ucdavis.edu ([169.237.54.109]:43272 "EHLO
	www.mtc.dhs.org") by vger.kernel.org with ESMTP id <S281446AbRKFDhI>;
	Mon, 5 Nov 2001 22:37:08 -0500
Date: Mon, 5 Nov 2001 19:39:29 -0800 (PST)
From: Terminator <jimmy@mtc.dhs.org>
To: <linux-kernel@vger.kernel.org>
Subject: kernel 2.4.14 compiling fail for loop device
Message-ID: <Pine.LNX.4.33.0111051936090.18663-100000@www.mtc.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to compile 2.4.14 with loop back device as kernel module, and
got the following error. It seems it's removed from

ld -m elf_i386 -T /usr/src/linux-2.4.14/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o \
        net/network.o \
        /usr/src/linux-2.4.14/arch/i386/lib/lib.a /usr/src/linux-2.4.14/lib/lib.a /usr/src/linux-2.4.14/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/block/block.o: In function `lo_send':
drivers/block/block.o(.text+0x86bf): undefined reference to `deactivate_page'
drivers/block/block.o(.text+0x8709): undefined reference to `deactivate_page'


