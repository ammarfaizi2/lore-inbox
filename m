Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281161AbRKOXMO>; Thu, 15 Nov 2001 18:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281162AbRKOXMC>; Thu, 15 Nov 2001 18:12:02 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:56412 "EHLO
	lazy.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S281161AbRKOXLv>; Thu, 15 Nov 2001 18:11:51 -0500
Date: Thu, 15 Nov 2001 17:01:20 -0600 (CST)
From: Manoj Iyer <manjo@austin.ibm.com>
X-X-Sender: <manjo@lazy>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.15.pre4 compile breaks on ppc
Message-ID: <Pine.LNX.4.33.0111151656460.21602-100000@lazy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am building Linux power pc kernel 2.4.15.pre4 and I see the following
error...

ld  -r -o x.o start.o xmon.o ppc-dis.o ppc-opc.o subr_prf.o setjmp.o
make[2]: Leaving directory `/usr/src/linux.2.4.15.pre4/arch/ppc/xmon'
make[1]: Leaving directory `/usr/src/linux.2.4.15.pre4/arch/ppc/xmon'
ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic
arch/ppc/kernel/head.o init/main.o init/version.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/ppc/xmon/x.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/net/fc/fc.o
drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o
drivers/pci/driver.o drivers/net/wireless/wireless_net.o
drivers/macintosh/macintosh.o drivers/video/video.o drivers/usb/usbdrv.o
drivers/input/inputdrv.o drivers/md/mddev.o \
        net/network.o \
        /usr/src/linux.2.4.15.pre4/lib/lib.a \
        --end-group \
        -o vmlinux
fs/fs.o: In function `cpuinfo_open':
fs/fs.o(.text+0x2b06e): undefined reference to `cpuinfo_op'
fs/fs.o(.text+0x2b072): undefined reference to `cpuinfo_op'
make: *** [vmlinux] Error 1
root@acura:/usr/src/linux.2.4.15.pre4 >

Kindly copy manjo@austin.rr.com to your reply, I dont subscribe to this
list.

I really appreciate any help.

Thanks
Manoj Iyer

