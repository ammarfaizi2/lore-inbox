Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280944AbRKLT4p>; Mon, 12 Nov 2001 14:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280954AbRKLT4h>; Mon, 12 Nov 2001 14:56:37 -0500
Received: from a79150.upc-a.chello.nl ([62.163.79.150]:9732 "EHLO
	achilles.dreef.net") by vger.kernel.org with ESMTP
	id <S280922AbRKLT4V>; Mon, 12 Nov 2001 14:56:21 -0500
Date: Mon, 12 Nov 2001 20:56:16 +0100 (CET)
From: Erik Verhulp <tip@achilles.dnsalias.com>
X-X-Sender: <tip@achilles.dreef.net>
To: <linux-kernel@vger.kernel.org>
Subject: error compiling 2.4.14
Message-ID: <Pine.LNX.4.33.0111122053270.25006-100000@achilles.dreef.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While compiling my new 2.4.14 kernel, i received a couple of warnings
regarding the function lo_send (this was relatively early in the compiling
process). After a while the compiler exited with the following error
message:

make[2]: Leaving directory `/usr/src/linux-2.4.14/arch/i386/lib'
make[1]: Leaving directory `/usr/src/linux-2.4.14/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux-2.4.14/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o
drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o
drivers/video/video.o \
        net/network.o \
        /usr/src/linux-2.4.14/arch/i386/lib/lib.a
/usr/src/linux-2.4.14/lib/lib.a /usr/src/linux-2.4.14/arch/i386/lib/lib.a
\
        --end-group \
        -o vmlinux
drivers/block/block.o: In function `lo_send':
drivers/block/block.o(.text+0x889d): undefined reference to
`deactivate_page'
drivers/block/block.o(.text+0x88e9): undefined reference to
`deactivate_page'
make: *** [vmlinux] Error 1


I never had an error like this before, and i also don't know what to do
about it. Thought maybe someone can make some sense out of it.

Regards,
Erik Verhulp


P.S. i dont know what information could be relevant while finding the
solution, if someone has any questions, please mail me.





