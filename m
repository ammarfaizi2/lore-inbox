Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289301AbSAVNnp>; Tue, 22 Jan 2002 08:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289302AbSAVNnh>; Tue, 22 Jan 2002 08:43:37 -0500
Received: from axor.zcu.cz ([147.228.57.20]:13490 "EHLO axor.zcu.cz")
	by vger.kernel.org with ESMTP id <S289301AbSAVNnU>;
	Tue, 22 Jan 2002 08:43:20 -0500
Date: Tue, 22 Jan 2002 14:43:16 +0100 (CET)
From: Jan Pospisil <honik@civ.zcu.cz>
X-X-Sender: <honik@aither.zcu.cz>
To: <linux-kernel@vger.kernel.org>
cc: <bug-binutils@gnu.org>
Subject: undefined references when compiling kernel with binutils-2.11.92.0.12.3
Message-ID: <Pine.LNX.4.33.0201221421050.20914-100000@aither.zcu.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, it has been posted so many times, and according to Richard Gooch it
should be fixed in 2.4.18-pre3, however I am still having the problem

undefined reference to `local symbols in discarded section .text.exit'

particullary with the CONFIG_VIDEO_BT848=y (as a module it works fine).

I have Athlon 850, Debian 3.0 (latest Sid), binutils-2.11.92.0.12.3-5,
gcc-3.0.3 and I tried both 2.4.17 and 2.4.18-pre4 with the same result.

Could someone help?

Thanks.
J.P.

Some listings follow:

...
ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/parport/driver.o drivers/char/char.o
drivers/block/block.o drivers/misc/misc.o drivers/net/net.o
drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o
drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o
drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/video/video.o
drivers/usb/usbdrv.o drivers/i2c/i2c.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux drivers/media/media.o:

In function `bttv_probe':
drivers/media/media.o(.text.init+0x1745): undefined reference to `local
symbols in discarded section .text.exit'

make: *** [vmlinux] Error 1

...
Linux aither 2.4.17 #1 Fri Jan 18 16:30:51 CET 2002 i686 unknown

Gnu C                  3.0.3
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.12
e2fsprogs              1.25
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         openafs

...

           \|/
          (*.*)
=======oOO=(-)=OOo====================================================
  Ing. Jan Pospisil                       University of West Bohemia
  tel:    + 420 (19) 7491-426    West-Bohemian Supercomputing Centre
  fax:    + 420 (19) 7421-419                         Univerzitni 20
  e-mail: Jan.Pospisil@civ.zcu.cz       306 14 Plzen, Czech Republic
======================================================================

