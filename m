Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129860AbRAWV2I>; Tue, 23 Jan 2001 16:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129875AbRAWV16>; Tue, 23 Jan 2001 16:27:58 -0500
Received: from goalkeeper.d2.com ([198.211.88.26]:33056 "HELO
	goalkeeper.d2.com") by vger.kernel.org with SMTP id <S129860AbRAWV1r>;
	Tue, 23 Jan 2001 16:27:47 -0500
Date: Tue, 23 Jan 2001 13:22:30 -0800
From: Greg from Systems <chandler@d2.com>
To: linux-kernel@vger.kernel.org
Subject: Big Bada Boom...
Message-ID: <Pine.SGI.4.10.10101231316420.29904-100000@hell.d2.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.4.0 Kernel problem...
Alpha version only..

This seems to be purely a source problem...

attached is my .config, and here is the problem:

when using the attached .config and running a 'make dep ; make boot' I get
the following:

{previous stuff is all normal}

make[2]: Entering directory `/usr/src/linux/arch/alpha/math-emu'
make[2]: Nothing to be done for `all_targets'.
make[2]: Leaving directory `/usr/src/linux/arch/alpha/math-emu'
make[1]: Leaving directory `/usr/src/linux/arch/alpha/math-emu'
ld -static -T arch/alpha/vmlinux.lds -N  arch/alpha/kernel/head.o init/main.o init/version.o \
        --start-group \
        arch/alpha/kernel/kernel.o arch/alpha/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/alpha/math-emu/math-emu.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o  drivers/scsi/scsidrv.o
 drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o drivers/md/mddev.o \
        net/network.o \
        /usr/src/linux/arch/alpha/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/alpha/lib/lib.a \
        --end-group \
        -o vmlinux
arch/alpha/kernel/kernel.o: In function `pyxis_device_interrupt':
arch/alpha/kernel/kernel.o(.text+0xbb74): undefined reference to `isa_device_interrupt'
arch/alpha/kernel/kernel.o(.text+0xbb78): undefined reference to `isa_device_interrupt'
make: *** [vmlinux] Error 1


If I change the cpu type to 'generic' instead of 'rawhide' then it works..
No problems... I would really like to optimize it though....
Help please.
  Sir Ace

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
