Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314345AbSDRNNO>; Thu, 18 Apr 2002 09:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314346AbSDRNNN>; Thu, 18 Apr 2002 09:13:13 -0400
Received: from buster.altus.de ([213.61.61.5]:53161 "EHLO buster.altus.de")
	by vger.kernel.org with ESMTP id <S314345AbSDRNNL>;
	Thu, 18 Apr 2002 09:13:11 -0400
Message-ID: <3CBEC663.2040705@altus.de>
Date: Thu, 18 Apr 2002 15:13:07 +0200
From: Juri Haberland <haberland@altus.de>
Organization: ALTUS Media AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020407
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre7: undefined reference to `ahc_acquire_seeprom'
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
When compiling 2.4.19-pre7 I am getting undefined reference to
`ahc_acquire_seeprom' and `ahc_release_seeprom' errors on linking vmlinux:

make[2]: Leaving directory `/var/tmp/linux/arch/i386/lib'
make[1]: Leaving directory `/var/tmp/linux/arch/i386/lib'
ld -m elf_i386 -T /var/tmp/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/scsi/scsidrv.o
drivers/cdrom/driver.o drivers/pnp/pnp.o drivers/video/video.o \
        net/network.o \
        /var/tmp/linux/arch/i386/lib/lib.a /var/tmp/linux/lib/lib.a
/var/tmp/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/scsi/scsidrv.o: In function `ahc_proc_write_seeprom':
drivers/scsi/scsidrv.o(.text+0xf21e): undefined reference to
`ahc_acquire_seeprom'
drivers/scsi/scsidrv.o(.text+0xf265): undefined reference to
`ahc_release_seeprom'
drivers/scsi/scsidrv.o: In function `ahc_linux_proc_info':
drivers/scsi/scsidrv.o(.text+0xf3e3): undefined reference to
`ahc_acquire_seeprom'
drivers/scsi/scsidrv.o(.text+0xf4a6): undefined reference to
`ahc_release_seeprom'
make: *** [vmlinux] Error 1


This is a kernel for a 486 _without_ PCI. If I enable PCI support it
compiles fine.

Any hints?

Juri

-- 
  If each of us have one object, and we exchange them,
     then each of us still has one object.
  If each of us have one idea,   and we exchange them,
     then each of us now has two ideas.

