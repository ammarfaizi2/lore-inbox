Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270889AbSISJoB>; Thu, 19 Sep 2002 05:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270937AbSISJoB>; Thu, 19 Sep 2002 05:44:01 -0400
Received: from cc15467-a.groni1.gr.home.nl ([217.120.147.78]:28009 "HELO
	cc15467-a.groni1.gr.nl.home.com") by vger.kernel.org with SMTP
	id <S270889AbSISJoA>; Thu, 19 Sep 2002 05:44:00 -0400
Date: Thu, 19 Sep 2002 11:51:07 +0200
From: Han Boetes <han@boetes.org>
To: linux-kernel@vger.kernel.org
Subject: Linux-2.4.20-pre7ac1 and ac2
Message-ID: <20020919095107.GA2471@han.myip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On linux mandrake cooker, with gcc3.2, athlon XP

ld -m elf_i386 -T
/home/han/src/Kernel/linux-2.4.19/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
	mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
	 drivers/net/net.o drivers/media/media.o
	 drivers/char/drm-4.0/drm.o drivers/ide/idedriver.o
	 drivers/cdrom/driver.o drivers/pci/driver.o drivers/pnp/pnp.o
	 drivers/video/video.o arch/i386/math-emu/math.o \
        net/network.o \
        /home/han/src/Kernel/linux-2.4.19/arch/i386/lib/lib.a
	/home/han/src/Kernel/linux-2.4.19/lib/lib.a
	/home/han/src/Kernel/linux-2.4.19/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
fs/fs.o: In function `jfs_lazycommit':
fs/fs.o(.text+0x88713): undefined reference to `cond_resched'
fs/fs.o: In function `txQuiesce':
fs/fs.o(.text+0x8891f): undefined reference to `cond_resched'
fs/fs.o: In function `jfs_sync':
fs/fs.o(.text+0x88b93): undefined reference to `cond_resched'
make: *** [vmlinux] Error 1



//Han

