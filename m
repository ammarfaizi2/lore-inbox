Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279922AbRKRQya>; Sun, 18 Nov 2001 11:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279912AbRKRQyV>; Sun, 18 Nov 2001 11:54:21 -0500
Received: from [212.221.184.215] ([212.221.184.215]:47881 "EHLO post.gaia.de")
	by vger.kernel.org with ESMTP id <S279903AbRKRQyC>;
	Sun, 18 Nov 2001 11:54:02 -0500
From: a_vogt@gaia.de (Andreas Vogt)
X-ZC-POST: Andreas Vogt;72076 Tuebingen
X-ZC-TELEFON: V+49-7071-67651
X-Mailer: CrossPoint/OpenXP v3.40RC3@1809011916 R/A8212
Message-ID: <8D6bPntFarB@a_vogt.gaia.de>
X-Gateway: ZCONNECT UU gaia.de [DUUCP BETA vom 25.09.2000]
Subject: Compilation problem 2.4.14
Date: 18 Nov 2001 00:00:00 GMT
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I can't compile actual kernel
2.4.14
with gcc 2.95.3 and ld 2.11.90.0.29 (GNU)

Compilation ends with follwing messages:

make dep clean
works fine.

Next step
make bzImage

outputs the following:



. scripts/mkversion > .tmpversion
gcc -D__KERNEL__ -I/usr/src/linux-2.4.14/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -DUTS_MACHINE='"i386"' -c -o init/version.o init/version.c
make CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.14/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 " -C  kernel
...
...
make all_targets
make[2]: Entering directory `/usr/src/linux-2.4.14/arch/i386/lib'
make[2]: Nothing to be done for `all_targets'.
make[2]: Leaving directory `/usr/src/linux-2.4.14/arch/i386/lib'
make[1]: Leaving directory `/usr/src/linux-2.4.14/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux-2.4.14/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	 drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/drm/drm.o drivers/net/fc/fc.o drivers/net/appletalk/appletalk.o drivers/net/wan/wan.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/net/pcmcia/pcmcia_net.o drivers/video/video.o drivers/md/mddev.o \
	net/network.o \
	/usr/src/linux-2.4.14/arch/i386/lib/lib.a /usr/src/linux-2.4.14/lib/lib.a /usr/src/linux-2.4.14/arch/i386/lib/lib.a \
	--end-group \
	-o vmlinux
drivers/block/block.o: In function `lo_send':
drivers/block/block.o(.text+0xa2ef): undefined reference to `deactivate_page'
drivers/block/block.o(.text+0xa339): undefined reference to `deactivate_page'
make: *** [vmlinux] Error 1


So what's wrong?
I didn't patch the kernel. It's original from ftp.kernel.org, downloaded  
yesterday.
What can I do? Do you need more information about .config?

I also noticed a problem with kernel 2.4.12 concerning ieee1284_ops.c
(IEEE1284_PH_DIR_UNKNOWN should be IEEE1284_PH_ECP_DIR_UNKNOWN)
This seems to be fixed now (2.4.14).

There was also a warning about not to use 2.4.11

Aren't there enough people to test new kernels? Are you releasing too  
often?

Thank's for any helping answers.

Bye
Andreas Vogt




