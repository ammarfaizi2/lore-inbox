Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135296AbRDWPYN>; Mon, 23 Apr 2001 11:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135293AbRDWPYE>; Mon, 23 Apr 2001 11:24:04 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:49165 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S135310AbRDWPXu>; Mon, 23 Apr 2001 11:23:50 -0400
Date: Mon, 23 Apr 2001 17:23:48 +0200 (CEST)
From: axel <axel@rayfun.org>
To: linux-kernel@vger.kernel.org
Message-ID: <Pine.LNX.4.21.0104231718220.2691-100000@neon.rayfun.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

I just tried to compile latest kernel 2.4.4pre6 with following error
output. Unfortunately I don't have no idea what this wants to tell me.
Probably something about those rw_semaphores I have recently read about in
lkml.

Regards,
Axel Siebenwirth


make[1]: Entering directory `/usr/src/linux-2.4.4pre6/arch/i386/lib'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.4.4pre6/arch/i386/lib'
make[2]: Nothing to be done for `all_targets'.
make[2]: Leaving directory `/usr/src/linux-2.4.4pre6/arch/i386/lib'
make[1]: Leaving directory `/usr/src/linux-2.4.4pre6/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux-2.4.4pre6/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o  drivers/isdn/isdn.a
drivers/scsi/scsidrv.o drivers/scsi/aic7xxx/aic7xxx_drv.o
drivers/cdrom/driver.o drivers/pci/driver.o drivers/pnp/pnp.o
drivers/video/video.o \
        net/network.o \
        /usr/src/linux-2.4.4pre6/arch/i386/lib/lib.a
/usr/src/linux-2.4.4pre6/lib/lib.a
/usr/src/linux-2.4.4pre6/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
/usr/src/linux-2.4.4pre6/lib/lib.a(rwsem.o): In function
`__rwsem_do_wake':
rwsem.o(.text+0x30): undefined reference to `__builtin_expect'
rwsem.o(.text+0x73): undefined reference to `__builtin_expect'
make: *** [vmlinux] Error 1

