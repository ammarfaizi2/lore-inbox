Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132123AbQLQDOo>; Sat, 16 Dec 2000 22:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132163AbQLQDOe>; Sat, 16 Dec 2000 22:14:34 -0500
Received: from mail.inconnect.com ([209.140.64.7]:32489 "HELO
	mail.inconnect.com") by vger.kernel.org with SMTP
	id <S132123AbQLQDOY>; Sat, 16 Dec 2000 22:14:24 -0500
Date: Sat, 16 Dec 2000 19:43:57 -0700 (MST)
From: Dax Kelson <dax@gurulabs.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: test13pre2 - ieee1394 compile failure
In-Reply-To: <Pine.LNX.4.10.10012160946450.21362-100000@penguin.transmeta.com>
Message-ID: <Pine.SOL.4.30.0012161932320.16016-100000@ultra1.inconnect.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds said once upon a time (Sat, 16 Dec 2000):

> Can anybody else find build irregularities with the new Makefiles? Please
> holler..

I've been having problems building Firewire support since test12-pre3, I'm
still having problems with test13-pre2 (although different problems).

You can read about my test12-pre3+ problems here:

http://lists.insecure.org/linux-kernel/2000/Dec/0186.html

My current test13-pre2 problems:

ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
	drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o  drivers/char/agp/agp.o
drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o
drivers/ieee1394/ieee1394.a drivers/cdrom/driver.o
drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/pnp/pnp.o
drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o
drivers/i2c/i2c.o \
	net/network.o \
	/usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/linux/arch/i386/lib/lib.a \
	--end-group \
	-o vmlinux
ld: cannot open drivers/ieee1394/ieee1394.a: No such file or directory

>From my .config:

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=y
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=y
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_RAWIO=m
# CONFIG_IEEE1394_VERBOSEDEBUG is not set


Dax Kelson

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
