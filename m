Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315588AbSECH4c>; Fri, 3 May 2002 03:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315589AbSECH4b>; Fri, 3 May 2002 03:56:31 -0400
Received: from brussels-smtp.planetinternet.be ([195.95.34.12]:34320 "EHLO
	firebird.planetinternet.be") by vger.kernel.org with ESMTP
	id <S315588AbSECH4b> convert rfc822-to-8bit; Fri, 3 May 2002 03:56:31 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Treeve Jelbert <treeve01@pi.be>
Organization: Knowhow sc
To: linux-kernel@vger.kernel.org
Subject: BUG - linux-2.5.13/arch/i386/kernel - bluesmoke.c
Date: Fri, 3 May 2002 09:59:52 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200205030959.52486.treeve01@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux-2.5.13/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=athlon    
-DKBUILD_BASENAME=bluesmoke  -c -o bluesmoke.o bluesmoke.c
bluesmoke.c: In function `intel_thermal_interrupt':
bluesmoke.c:36: warning: implicit declaration of function `ack_APIC_irq'
bluesmoke.c: In function `intel_init_thermal':
bluesmoke.c:92: warning: implicit declaration of function `apic_read'
bluesmoke.c:104: warning: implicit declaration of function `apic_write_around'


-----

make[1]: Leaving directory `/usr/src/linux-2.5.13/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux-2.5.13/arch/i386/vmlinux.lds -e stext 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o 
fs/fs.o ipc/ipc.o \
        /usr/src/linux-2.5.13/arch/i386/lib/lib.a 
/usr/src/linux-2.5.13/lib/lib.a /usr/src/linux-2.5.13/arch/i386/lib/lib.a \
         drivers/acpi/acpi.o drivers/base/base.o drivers/char/char.o 
drivers/block/block.o drivers/misc/misc.o drivers/net/net.o 
drivers/media/media.o drivers/char/drm/drm.o drivers/ide/idedriver.o 
drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o 
drivers/pnp/pnp.o drivers/video/video.o drivers/input/inputdrv.o \
        net/network.o \
        --end-group \
        -o vmlinux
arch/i386/kernel/kernel.o: In function `intel_thermal_interrupt':
arch/i386/kernel/kernel.o(.text+0x7801): undefined reference to `ack_APIC_irq'
arch/i386/kernel/kernel.o: In function `intel_init_thermal':
arch/i386/kernel/kernel.o(.text.init+0x2e41): undefined reference to 
`apic_read'
arch/i386/kernel/kernel.o(.text.init+0x2e83): undefined reference to 
`apic_write_around'
arch/i386/kernel/kernel.o(.text.init+0x2ea3): undefined reference to 
`apic_read'
arch/i386/kernel/kernel.o(.text.init+0x2eb3): undefined reference to 
`apic_write_around'
make: *** [vmlinux] Error 1


-- 
Regards,  Treeve
