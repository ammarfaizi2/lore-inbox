Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312588AbSDOMRs>; Mon, 15 Apr 2002 08:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312601AbSDOMRr>; Mon, 15 Apr 2002 08:17:47 -0400
Received: from relay.planetinternet.be ([194.119.232.24]:22029 "EHLO
	relay.planetinternet.be") by vger.kernel.org with ESMTP
	id <S312588AbSDOMRq> convert rfc822-to-8bit; Mon, 15 Apr 2002 08:17:46 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Treeve Jelbert <treeve01@pi.be>
Organization: Knowhow sc
To: linux-kernel@vger.kernel.org
Subject: PROBLEM linux-2.5.8 undefined reference to `setup_per_cpu_areas'
Date: Mon, 15 Apr 2002 14:20:53 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200204151420.53495.treeve01@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ld -m elf_i386 -T /usr/src/linux-2.5.8/arch/i386/vmlinux.lds -e stext 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o 
fs/fs.o ipc/ipc.o \
        /usr/src/linux-2.5.8/arch/i386/lib/lib.a 
/usr/src/linux-2.5.8/lib/lib.a /usr/src/linux-2.5.8/arch/i386/lib/lib.a \
         drivers/acpi/acpi.o drivers/base/base.o drivers/char/char.o 
drivers/block/block.o drivers/misc/misc.o drivers/net/net.o 
drivers/media/media.o drivers/char/drm/drm.o drivers/ide/idedriver.o 
drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o 
drivers/pnp/pnp.o drivers/video/video.o drivers/input/inputdrv.o \
        net/network.o \
        --end-group \
        -o vmlinux
init/main.o: In function `start_kernel':
init/main.o(.text.init+0x621): undefined reference to `setup_per_cpu_areas'
 ! Problem Detected !
make: *** [vmlinux] Error 1



Regards,  Treeve
