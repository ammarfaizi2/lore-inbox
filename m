Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317497AbSHCKXg>; Sat, 3 Aug 2002 06:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317498AbSHCKXg>; Sat, 3 Aug 2002 06:23:36 -0400
Received: from linux.kappa.ro ([194.102.255.131]:20927 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S317497AbSHCKXg>;
	Sat, 3 Aug 2002 06:23:36 -0400
Date: Sat, 3 Aug 2002 13:28:54 +0300
From: Teodor Iacob <Teodor.Iacob@astral.kappa.ro>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.19
Message-ID: <20020803102854.GA23440@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to compile 2.4.19 with Sis driver suport in drm and I get this:

ld -m elf_i386 -T /usr/src/linux-2.4.19/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o \
        net/network.o \
        /usr/src/linux-2.4.19/arch/i386/lib/lib.a /usr/src/linux-2.4.19/lib/lib.a /usr/src/linux-2.4.19/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/char/drm/drm.o: In function `sis_fb_alloc':
drivers/char/drm/drm.o(.text+0x6a46): undefined reference to `sis_malloc'
drivers/char/drm/drm.o(.text+0x6a8d): undefined reference to `sis_free'
drivers/char/drm/drm.o: In function `sis_fb_free':
drivers/char/drm/drm.o(.text+0x6bd2): undefined reference to `sis_free'
drivers/char/drm/drm.o: In function `sis_final_context':
drivers/char/drm/drm.o(.text+0x7086): undefined reference to `sis_free'
make: *** [vmlinux] Error 1


Teo
