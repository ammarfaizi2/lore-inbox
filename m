Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281680AbRKQB7e>; Fri, 16 Nov 2001 20:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281681AbRKQB7Y>; Fri, 16 Nov 2001 20:59:24 -0500
Received: from flounder.jimking.net ([209.205.176.18]:60680 "EHLO
	flounder.jimking.net") by vger.kernel.org with ESMTP
	id <S281680AbRKQB7F>; Fri, 16 Nov 2001 20:59:05 -0500
To: linux-kernel@vger.kernel.org
Subject: It's me again ...
From: Tony Reed <Tony@TRLJC.COM>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.1 (i586-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20011117015851.531B415B4A@kubrick.trljc.com>
Date: Fri, 16 Nov 2001 20:58:51 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been building kernels since 2.2.15 or something, and I've never
had problems before, so bear with me.

Where is "deacivate_page" defined?  Because, right at the end, I'm
getting:

ld -m elf_i386 -T /usr/src/linux-2.4.14/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/video/video.o arch/i386/math-emu/math.o \
        net/network.o \
        /usr/src/linux-2.4.14/linux/arch/i386/lib/lib.a /usr/src/linux-2.4.14/linux/lib/lib.a /usr/src/linux-2.4.14/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/block/block.o: In function `lo_send':
drivers/block/block.o(.text+0xa8ad): undefined reference to `deactivate_page'
drivers/block/block.o(.text+0xa8f9): undefined reference to `deactivate_page'
make: *** [vmlinux] Error 1


So I'm kinda stuck.  
-- 
   Tony Reed 
<Tony@TRLJC.COM>
My "vendor"?. If I wanna _buy_ an OS, I'll buy an Mac.
