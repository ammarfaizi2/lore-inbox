Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291579AbSBHOVp>; Fri, 8 Feb 2002 09:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291585AbSBHOVf>; Fri, 8 Feb 2002 09:21:35 -0500
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:49346 "HELO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with SMTP
	id <S291579AbSBHOVU>; Fri, 8 Feb 2002 09:21:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>
Message-Id: <200202081520.29475@bilbo.math.uni-mannheim.de>
To: linux-kernel@vger.kernel.org
Subject: [2.5.4-pre3] link error in drivers/video/video.o
Date: Fri, 8 Feb 2002 15:22:00 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ld -m elf_i386 -T /mnt/kernel/linux-2.5.4-pre3/arch/i386/vmlinux.lds -e stext 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o 
fs/fs.o ipc/ipc.o \
        /mnt/kernel/linux-2.5.4-pre3/arch/i386/lib/lib.a 
/mnt/kernel/linux-2.5.4-pre3/lib/lib.a 
/mnt/kernel/linux-2.5.4-pre3/arch/i386/lib/lib.a \
         drivers/base/base.o drivers/char/char.o drivers/block/block.o 
drivers/misc/misc.o drivers/net/net.o drivers/media/media.o 
drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o 
drivers/video/video.o \
        net/network.o \
        --end-group \
        -o vmlinux
drivers/video/video.o: In function `vesafb_init':
drivers/video/video.o(.text.init+0x13f9): undefined reference to 
`bus_to_virt_not_defined_use_pci_map'
make: *** [vmlinux] Error 1

Eike
