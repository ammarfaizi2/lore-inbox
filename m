Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282843AbRLWK2S>; Sun, 23 Dec 2001 05:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286864AbRLWK2J>; Sun, 23 Dec 2001 05:28:09 -0500
Received: from tonib-gw-old.customer.0rbitel.net ([195.24.39.218]:43017 "HELO
	mail.ludost.net") by vger.kernel.org with SMTP id <S286862AbRLWK1w>;
	Sun, 23 Dec 2001 05:27:52 -0500
Date: Sun, 23 Dec 2001 12:27:50 +0200 (EET)
From: Vasil Kolev <lnxkrnl@mail.ludost.net>
X-X-Sender: <lnxkrnl@doom.bastun.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17] net/network.o(.text.lock+0x1a88): undefined reference
 to `local symbols...
Message-ID: <Pine.LNX.4.33.0112231226260.1032-100000@doom.bastun.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[1]: Leaving directory `/usr/src/linux/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o
drivers/net/wan/wan.o drivers/ide/idedriver.o drivers/cdrom/driver.o
drivers/sound/sounddrivers.o drivers/pci/driver.o
drivers/net/wireless/wireless_net.o drivers/pnp/pnp.o
drivers/video/video.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/net/net.o(.data+0x514): undefined reference to `local symbols in
discarded section .text.exit'
make: *** [vmlinux] Error 1


# ./reference_discarded.pl
Finding objects, 538 objects, ignoring 0 module(s)
Finding conglomerates, ignoring 48 conglomerate(s)
Scanning objects
Error: ./drivers/net/dmfe.o .data refers to 00000514 R_386_32
.text.exit
Done


