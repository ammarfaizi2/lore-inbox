Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281456AbRKFEg4>; Mon, 5 Nov 2001 23:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281457AbRKFEgq>; Mon, 5 Nov 2001 23:36:46 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:17685 "EHLO
	c0mailgw08.prontomail.com") by vger.kernel.org with ESMTP
	id <S281456AbRKFEgg>; Mon, 5 Nov 2001 23:36:36 -0500
Message-ID: <3BE768C4.D6F5E9E3@starband.net>
Date: Mon, 05 Nov 2001 23:36:20 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.14 fails to link.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[1]: Leaving directory `/usr/src/linux-2.4.14/arch/i386/mm'
make CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.14/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 " -C  arch/i386/lib
make[1]: Entering directory `/usr/src/linux-2.4.14/arch/i386/lib'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.4.14/arch/i386/lib'
make[2]: Nothing to be done for `all_targets'.
make[2]: Leaving directory `/usr/src/linux-2.4.14/arch/i386/lib'
make[1]: Leaving directory `/usr/src/linux-2.4.14/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux-2.4.14/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o
drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o
drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o

drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o \
        net/network.o \
        /usr/src/linux-2.4.14/arch/i386/lib/lib.a
/usr/src/linux-2.4.14/lib/lib.a
/usr/src/linux-2.4.14/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/block/block.o: In function `lo_send':
drivers/block/block.o(.text+0x855f): undefined reference to
`deactivate_page'
drivers/block/block.o(.text+0x85c4): undefined reference to
`deactivate_page'
make: *** [vmlinux] Error 1
[root@war linux]#

System Info:

System Hardware:
    CPU Type: Pentium III
   CPU Speed: 868.665 MHz
         Ram: 1005 MB
        Swap: 2000 MB

System Software:
Distribution: Red Hat Linux release 7.2 (Enigma)
    autoconf: 2.52
     autogen: 5.2.11
    automake: 1.5
    binutils: 2.11.2
      esound: 0.2.23
         gcc: 2.95.3
     gettext: 0.10.40
       glibc: 2.2.4
        glib: 1.2.10
  gnome-libs: 1.2.13
         gtk: 1.2.10
       imlib: 1.9.11
     kdelibs: 2.2.1
      kernel: 2.4.13
     libtool: 1.4.2
     openssl: 0.9.6b
       orbit: 0.5.8
   orbit-idl: 0.6.8
        perl: 5.6.1
          qt: 3.0.0
         rpm: 4.0.3
         sdl: 1.2.2
     xfree86: 4.1.0
        xml2: 2.4.8
         xml: 1.8.16



