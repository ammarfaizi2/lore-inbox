Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132806AbRDIRh2>; Mon, 9 Apr 2001 13:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132807AbRDIRhS>; Mon, 9 Apr 2001 13:37:18 -0400
Received: from c526559-a.rchdsn1.tx.home.com ([24.0.107.130]:63104 "EHLO
	ledzep.dyndns.org") by vger.kernel.org with ESMTP
	id <S132806AbRDIRhP>; Mon, 9 Apr 2001 13:37:15 -0400
Message-ID: <3AD1F347.8140B08B@home.com>
Date: Mon, 09 Apr 2001 12:37:11 -0500
From: Jordan <ledzep37@home.com>
Organization: University of Texas at Dallas - Student
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-ac3-preempt-reiserfs-3.6.25 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: vmlinuz won't build with cmd64X.C 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I went in to my .config and disabled 640 and 640 enhanced in favor of
trying the 64x ide support.  I especially liked the fact that from the
code it look to have a /proc table similar the the via driver for my
onboard controller.  Then during compile I can not get the 64x to
correctly build itself into the kernel.  Actually it build into the
kernel but during the final steps the whole build fails becuase of these
errors:

make[2]: Leaving directory `/usr/src/linux/arch/i386/lib'
make[1]: Leaving directory `/usr/src/linux/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o  drivers/parport/driver.o
drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o
drivers/scsi/scsidrv.o drivers/cdrom/driver.o
drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/pnp/pnp.o
drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o
drivers/acpi/acpi.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/ide/idedriver.o: In function `ide_setup':
drivers/ide/idedriver.o(.text.init+0x712): undefined reference to
`cmd640_vlb'
drivers/ide/idedriver.o: In function `probe_for_hwifs':
drivers/ide/idedriver.o(.text.init+0x918): undefined reference to
`ide_probe_for_cmd640x'
drivers/ide/idedriver.o: In function `pci_init_cmd64x':
drivers/ide/idedriver.o(.text.init+0xb2a): undefined reference to
`cmd64x_display_info'
make: *** [vmlinux] Error 1

I am running 2.4.3-ac3.  Thanks for any help, I would really like to be
able to try 64x as opposed to 640.

Jordan
