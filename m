Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130890AbQKJM73>; Fri, 10 Nov 2000 07:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131064AbQKJM7J>; Fri, 10 Nov 2000 07:59:09 -0500
Received: from node121b3.a2000.nl ([24.132.33.179]:14341 "EHLO
	node121b3.a2000.nl") by vger.kernel.org with ESMTP
	id <S130890AbQKJM7B>; Fri, 10 Nov 2000 07:59:01 -0500
Message-ID: <3A0BF10D.47E72B91@reviewboard.com>
Date: Fri, 10 Nov 2000 13:58:53 +0100
From: Chris Chabot <chabotc@reviewboard.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-kernel@kernel.org
Subject: Error Compiling linux-2.4.0-test11pre2 on rh7 (kgcc) system
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this error below, while trying to do my standard kernel compile. i
changed the makefile to use kgcc, and every compile upto 2.4.0-test10 &
2.4.0-test11 pre 1 worked fine (same .config).. The system is a clean
redhat 7.0 (amd 1ghz, adaptec scsi, nvidia geforce2, sblive, ibm 10k rpm
hd,asus mb, 256mb pc133 ram)... pls cc me in any replies since im not
subscribed to linux-kernel.

ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/parport/parport.a
drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/scsi/scsidrv.o
drivers/cdrom/cdrom.a drivers/pci/pci.a drivers/video/video.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
arch/i386/mm/mm.o: In function `do_page_fault':
arch/i386/mm/mm.o(.text+0x7b1): undefined reference to `bust_spinlocks'
make: *** [vmlinux] Error 1


    -- Chris Chabot

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
