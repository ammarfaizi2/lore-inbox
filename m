Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129346AbRDWEOC>; Mon, 23 Apr 2001 00:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129359AbRDWENw>; Mon, 23 Apr 2001 00:13:52 -0400
Received: from mx5.sac.fedex.com ([199.81.194.37]:22028 "EHLO
	mx5.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S129346AbRDWENr>; Mon, 23 Apr 2001 00:13:47 -0400
Date: Mon, 23 Apr 2001 12:14:16 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Chua <jchua@fedex.com>
Subject: rwsem.o undefined reference to __builtin_expect
Message-ID: <Pine.LNX.4.33.0104231211530.519-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


cannot compile 2.4.4-pre6. This may have been reported, but I
haven't seen it.

Thanks,
Jeff.


ld -m elf_i386 -T /u2/src/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o  drivers/char/drm/drm.o
drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o
drivers/md/mddev.o \
        net/network.o \
        /u2/src/linux/arch/i386/lib/lib.a /u2/src/linux/lib/lib.a
/u2/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
/u2/src/linux/lib/lib.a(rwsem.o): In function `__rwsem_do_wake':
rwsem.o(.text+0x30): undefined reference to `__builtin_expect'
rwsem.o(.text+0x73): undefined reference to `__builtin_expect'
make: *** [vmlinux] Error 1



