Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283496AbRLCXqV>; Mon, 3 Dec 2001 18:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281856AbRLCXgy>; Mon, 3 Dec 2001 18:36:54 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:38790 "EHLO
	lazy.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S285303AbRLCWoA>; Mon, 3 Dec 2001 17:44:00 -0500
Date: Mon, 3 Dec 2001 16:29:35 -0600 (CST)
From: Manoj Iyer <manjo@austin.ibm.com>
X-X-Sender: <manjo@lazy>
To: kernelmailinglist <linux-kernel@vger.kernel.org>
Subject: PPC 2.4.17.pre2 kernel build breaks!!
Message-ID: <Pine.LNX.4.33.0112031626450.2127-100000@lazy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I get the following build break compiling kernel 2.4.17.pre2 on PPC-32.
Any suggestions??

Thank
Manoj Iyer

ld  -r -o x.o start.o xmon.o ppc-dis.o ppc-opc.o subr_prf.o setjmp.o
make[2]: Leaving directory `/usr/src/linux/arch/ppc/xmon'
make[1]: Leaving directory `/usr/src/linux/arch/ppc/xmon'
ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic arch/ppc/kernel/head.o init/main.o init/version.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/ppc/xmon/x.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/net/wireless/wireless_net.o drivers/macintosh/macintosh.o drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o \
        net/network.o \
        /usr/src/linux/lib/lib.a \
        --end-group \
        -o vmlinux
arch/ppc/kernel/kernel.o: In function `getpacket':
arch/ppc/kernel/kernel.o(.text+0x9f48): undefined reference to `getDebugChar'
arch/ppc/kernel/kernel.o(.text+0x9f48): relocation truncated to fit: R_PPC_REL24 getDebugChar
arch/ppc/kernel/kernel.o(.text+0x9f7c): undefined reference to `getDebugChar'
arch/ppc/kernel/kernel.o(.text+0x9f7c): relocation truncated to fit: R_PPC_REL24 getDebugChar
arch/ppc/kernel/kernel.o(.text+0x9f98): undefined reference to `getDebugChar'
arch/ppc/kernel/kernel.o(.text+0x9f98): relocation truncated to fit: R_PPC_REL24 getDebugChar
arch/ppc/kernel/kernel.o(.text+0x9fa8): undefined reference to `getDebugChar'
arch/ppc/kernel/kernel.o(.text+0x9fa8): relocation truncated to fit: R_PPC_REL24 getDebugChar
arch/ppc/kernel/kernel.o(.text+0x9fc8): undefined reference to `putDebugChar'
arch/ppc/kernel/kernel.o(.text+0x9fc8): relocation truncated to fit: R_PPC_REL24 putDebugChar
arch/ppc/kernel/kernel.o(.text+0x9fd4): undefined reference to `putDebugChar'
arch/ppc/kernel/kernel.o(.text+0x9fd4): relocation truncated to fit: R_PPC_REL24 putDebugChar
arch/ppc/kernel/kernel.o(.text+0x9fec): undefined reference to `putDebugChar'
arch/ppc/kernel/kernel.o(.text+0x9fec): relocation truncated to fit: R_PPC_REL24 putDebugChar
arch/ppc/kernel/kernel.o(.text+0x9ff8): undefined reference to `putDebugChar'
arch/ppc/kernel/kernel.o(.text+0x9ff8): relocation truncated to fit: R_PPC_REL24 putDebugChar
arch/ppc/kernel/kernel.o: In function `putpacket':
arch/ppc/kernel/kernel.o(.text+0xa068): undefined reference to `putDebugChar'
arch/ppc/kernel/kernel.o(.text+0xa068): relocation truncated to fit: R_PPC_REL24 putDebugChar
arch/ppc/kernel/kernel.o(.text+0xa084): more undefined references to `putDebugChar' follow
arch/ppc/kernel/kernel.o: In function `putpacket':
arch/ppc/kernel/kernel.o(.text+0xa084): relocation truncated to fit: R_PPC_REL24 putDebugChar
arch/ppc/kernel/kernel.o(.text+0xa0a4): relocation truncated to fit: R_PPC_REL24 putDebugChar
arch/ppc/kernel/kernel.o(.text+0xa0b4): relocation truncated to fit: R_PPC_REL24 putDebugChar
arch/ppc/kernel/kernel.o(.text+0xa0c4): relocation truncated to fit: R_PPC_REL24 putDebugChar
arch/ppc/kernel/kernel.o(.text+0xa0c8): undefined reference to `getDebugChar'
arch/ppc/kernel/kernel.o(.text+0xa0c8): relocation truncated to fit: R_PPC_REL24 getDebugChar
arch/ppc/kernel/kernel.o: In function `handle_exception':
arch/ppc/kernel/kernel.o(.text+0xa344): undefined reference to `kgdb_interruptible'
arch/ppc/kernel/kernel.o(.text+0xa344): relocation truncated to fit: R_PPC_REL24 kgdb_interruptible
arch/ppc/kernel/kernel.o(.text+0xa8f4): undefined reference to `kgdb_interruptible'
arch/ppc/kernel/kernel.o(.text+0xa8f4): relocation truncated to fit: R_PPC_REL24 kgdb_interruptible
arch/ppc/kernel/kernel.o: In function `pmac_setup_arch':
arch/ppc/kernel/kernel.o(.text.init+0x28c0): undefined reference to `zs_kgdb_hook'
arch/ppc/kernel/kernel.o(.text.init+0x28c0): relocation truncated to fit: R_PPC_REL24 zs_kgdb_hook
make: *** [vmlinux] Error 1




*******************************************************************************
		The greatest risk is not taking one.
*******************************************************************************

