Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136025AbRDVKpt>; Sun, 22 Apr 2001 06:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136026AbRDVKpf>; Sun, 22 Apr 2001 06:45:35 -0400
Received: from [213.166.15.20] ([213.166.15.20]:7442 "EHLO
	mailth4.byworkwise.com") by vger.kernel.org with ESMTP
	id <S136025AbRDVKp2>; Sun, 22 Apr 2001 06:45:28 -0400
Message-ID: <3AE2B634.51F4BB2E@FreeNet.co.uk>
Date: Sun, 22 Apr 2001 11:45:08 +0100
From: Sid Boyce <sidb@FreeNet.co.uk>
Reply-To: sidb@FreeNet.co.uk
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 2.4.4-pre7 and 2.4.3-ac12 compile failure
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	In the same area for both, I think both failures were the same. I tried
pre7 and now ac12 with the following results.

make[1]: Leaving directory `/usr/src/linux/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
drivers
/net/net.o drivers/media/media.o  drivers/char/agp/agp.o
drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o
drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o
drivers/pcmcia/pcmcia.o drivers/net/pcmcia/pcmcia_net.o
drivers/pnp/pnp.o drivers/video/video.o drivers/usb/usbdrv.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
/usr/src/linux/lib/lib.a(rwsem.o): In function `rwsem_down_read_failed':
rwsem.o(.text+0x8d): undefined reference to `__builtin_expect'
/usr/src/linux/lib/lib.a(rwsem.o): In function
`rwsem_down_write_failed':
rwsem.o(.text+0x1f5): undefined reference to `__builtin_expect'
/usr/src/linux/lib/lib.a(rwsem.o): In function `rwsem_up_read_wake':
rwsem.o(.text+0x314): undefined reference to `__builtin_expect'
/usr/src/linux/lib/lib.a(rwsem.o): In function `rwsem_up_write_wake':
rwsem.o(.text+0x3fb): undefined reference to `__builtin_expect'
make: *** [vmlinux] Error 1

Regards
-- 
Sid Boyce ... hamradio G3VBV ... Cessna/Warrior Pilot
Linux only shop.. Tel. 44-121 422 0375
