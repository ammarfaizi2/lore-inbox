Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310132AbSCACta>; Thu, 28 Feb 2002 21:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293094AbSCACrf>; Thu, 28 Feb 2002 21:47:35 -0500
Received: from chinook.Stanford.EDU ([171.64.93.186]:59582 "EHLO
	chinook.stanford.edu") by vger.kernel.org with ESMTP
	id <S293366AbSCACpZ>; Thu, 28 Feb 2002 21:45:25 -0500
Date: Thu, 28 Feb 2002 18:45:24 -0800
To: linux-kernel@vger.kernel.org
Subject: Problem compiling 2.5.6-pre2 w/ OSS support
Message-ID: <20020301024524.GA24167@chinook.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Mailer: Mutt http://www.mutt.org/
From: Max Kamenetsky <maxk@chinook.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm having a problem complining 2.5.6-pre2 with OSS support.  If it
matters, I'm compiling support for a Turtle Beach Fiji card as a
module.  The compilation bombs out during "make bzImage" at this point:


ld -m elf_i386 -T /usr/src/linux-2.5.6-pre2/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
        /usr/src/linux-2.5.6-pre2/arch/i386/lib/lib.a /usr/src/linux-2.5.6-pre2/lib/lib.a /usr/src/linux-2.5.6-pre2/arch/i386/lib/lib.a \
         drivers/base/base.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o sound/sound.o drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o drivers/usb/usbdrv.o drivers/input/serio/seriodrv.o \
        net/network.o \
        --end-group \
        -o vmlinux
sound/sound.o: In function `sound_alloc_dmap':
sound/sound.o(.text+0x36d9): undefined reference to `virt_to_bus_not_defined_use_pci_map'
make: *** [vmlinux] Error 1


The same problem was exhibited by 2.5.5.  I have been unable to figure
out why this is happening, so any help would be greatly appreciated.

Thanks,
    Max
