Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283586AbRLIQXZ>; Sun, 9 Dec 2001 11:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283588AbRLIQXQ>; Sun, 9 Dec 2001 11:23:16 -0500
Received: from tahallah.demon.co.uk ([158.152.175.193]:34313 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S283594AbRLIQXD>; Sun, 9 Dec 2001 11:23:03 -0500
Date: Sun, 9 Dec 2001 16:19:31 +0000 (GMT)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [sparc32, 2.4.17-pre6] Wrong use of 'disable_irq' when linking kernel
Message-ID: <Pine.LNX.4.33.0112091614001.21084-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been looking into a problem for someone who apparently can't compile
a working kernel for his Sun PCI based Javastation, and here's the error I
get when I build and link the kernel using his .config:

make[1]: Entering directory
`/home/alex/src/kernel/chilton-linux/arch/sparc/boot'
ld -m elf32_sparc -r
/home/alex/src/kernel/chilton-linux/arch/sparc/kernel/head.o \
/home/alex/src/kernel/chilton-linux/arch/sparc/kernel/init_task.o \
/home/alex/src/kernel/chilton-linux/init/main.o /home/alex/src/kernel/chilton-linux/init/version.o \
        --start-group \
/home/alex/src/kernel/chilton-linux/arch/sparc/kernel/kernel.o \
/home/alex/src/kernel/chilton-linux/arch/sparc/mm/mm.o \
/home/alex/src/kernel/chilton-linux/kernel/kernel.o \
/home/alex/src/kernel/chilton-linux/mm/mm.o \
/home/alex/src/kernel/chilton-linux/fs/fs.o \
/home/alex/src/kernel/chilton-linux/ipc/ipc.o \
/home/alex/src/kernel/chilton-linux/arch/sparc/math-emu/math-emu.o \
/home/alex/src/kernel/chilton-linux/drivers/char/char.o \
/home/alex/src/kernel/chilton-linux/drivers/block/block.o \
/home/alex/src/kernel/chilton-linux/drivers/misc/misc.o \
/home/alex/src/kernel/chilton-linux/drivers/net/net.o \
/home/alex/src/kernel/chilton-linux/drivers/media/media.o \
/home/alex/src/kernel/chilton-linux/drivers/pci/driver.o \
/home/alex/src/kernel/chilton-linux/drivers/sbus/sbus_all.o \
/home/alex/src/kernel/chilton-linux/drivers/video/video.o \
/home/alex/src/kernel/chilton-linux/net/network.o \
        /home/alex/src/kernel/chilton-linux/lib/lib.a \
/home/alex/src/kernel/chilton-linux/lib/lib.a \
/home/alex/src/kernel/chilton-linux/arch/sparc/prom/promlib.a \
/home/alex/src/kernel/chilton-linux/arch/sparc/lib/lib.a \
        --end-group -o vmlinux.o
objdump -x vmlinux.o | ./btfixupprep > btfix.s
Wrong use of 'disable_irq' in '.text.exit' section. It can be only used in .text, .text.init, .fixup and __ksymtab
make[1]: *** [btfix.s] Error 1
make[1]: Leaving directory
`/home/alex/src/kernel/chilton-linux/arch/sparc/boot'
make: *** [_dir_arch/sparc/boot] Error 2

Any ideas what could be causing this problem? Further details available on
request.

-- 
The best things in life are free.

http://www.tahallah.demon.co.uk

