Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272304AbRI0Ku3>; Thu, 27 Sep 2001 06:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272322AbRI0KuS>; Thu, 27 Sep 2001 06:50:18 -0400
Received: from web14503.mail.yahoo.com ([216.136.224.66]:13319 "HELO
	web14503.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S272304AbRI0Kt7>; Thu, 27 Sep 2001 06:49:59 -0400
Message-ID: <20010927105026.55277.qmail@web14503.mail.yahoo.com>
Date: Thu, 27 Sep 2001 03:50:26 -0700 (PDT)
From: Michael Goetze <mgoetze5@yahoo.com>
Subject: Linker errors (drivers/scsi/scsidrv.o) compiling 2.4.10 on SPARC
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running Debian GNU/Linux woody on my SPARCstation 5 and trying to
compile Linux 2.4.10. Making all_targets fails with the following
linker error:

*** Begin output ***

make[1]: Entering directory `/usr/src/linux/arch/sparc/boot'
ld -m elf32_sparc -r /usr/src/linux/arch/sparc/kernel/head.o
/usr/src/linux/arch/sparc/kernel/init_task.o /usr/src/linux/init/main.o
/usr/src/linux/init/version.o \
        --start-group \
        /usr/src/linux/arch/sparc/kernel/kernel.o
/usr/src/linux/arch/sparc/mm/mm.o /usr/src/linux/kernel/kernel.o
/usr/src/linux/mm/mm.o /usr/src/linux/fs/fs.o /usr/src/linux/ipc/ipc.o
/usr/src/linux/arch/sparc/math-emu/math-emu.o
/usr/src/linux/drivers/char/char.o /usr/src/linux/drivers/block/block.o
/usr/src/linux/drivers/misc/misc.o /usr/src/linux/drivers/net/net.o
/usr/src/linux/drivers/media/media.o
/usr/src/linux/drivers/scsi/scsidrv.o
/usr/src/linux/drivers/sbus/sbus_all.o
/usr/src/linux/drivers/video/video.o /usr/src/linux/net/network.o \
        /usr/src/linux/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/linux/arch/sparc/prom/promlib.a
/usr/src/linux/arch/sparc/lib/lib.a \
        --end-group -o vmlinux.o
objdump -x vmlinux.o | ./btfixupprep > btfix.s
gcc -c -o btfix.o btfix.s
make[1]: Leaving directory `/usr/src/linux/arch/sparc/boot'
	ld -m elf32_sparc -T arch/sparc/vmlinux.lds arch/sparc/kernel/head.o
arch/sparc/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/sparc/kernel/kernel.o arch/sparc/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o arch/sparc/math-emu/math-emu.o
arch/sparc/boot/btfix.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/scsi/scsidrv.o
drivers/sbus/sbus_all.o drivers/video/video.o \
        net/network.o \
        /usr/src/linux/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/linux/arch/sparc/prom/promlib.a
/usr/src/linux/arch/sparc/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/scsi/scsidrv.o: In function `sd_ioctl':
drivers/scsi/scsidrv.o(.text+0x101e8): undefined reference to
`__put_user_bad'
make: *** [vmlinux] Error 1
root@sparky (2) > gcc --version
2.95.2
root@sparky > ld --version
GNU ld 2.11.90.0.31
Copyright 2001 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms
of
the GNU General Public License.  This program has absolutely no
warranty.
  Supported emulations:
   elf32_sparc
   sparclinux
   elf64_sparc
   sun4

*** End output ***

If you require further diagnostic information, drop me a note. Please
CC me on all replies as I am not subscribed to the list.

Thank you,

Michael


__________________________________________________
Do You Yahoo!?
Listen to your Yahoo! Mail messages from any phone.
http://phone.yahoo.com
