Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316408AbSGATcL>; Mon, 1 Jul 2002 15:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316430AbSGATcK>; Mon, 1 Jul 2002 15:32:10 -0400
Received: from balu.sch.bme.hu ([152.66.208.40]:14260 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S316408AbSGATcK>;
	Mon, 1 Jul 2002 15:32:10 -0400
Date: Mon, 1 Jul 2002 21:34:36 +0200 (MEST)
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-rc1 compile error
In-Reply-To: <Pine.GSO.4.30.0207012130060.8423-200000@balu>
Message-ID: <Pine.GSO.4.30.0207012134130.8423-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oops, sorry about the noise here, known bug.

On Mon, 1 Jul 2002, Pozsar Balazs wrote:

>
> I got the error below.
> .config attached.
>
> gcc -D__KERNEL__ -I/home/pozsy/DEV/kernel/test2/linux-2.4.19-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=do_mounts -c -o init/do_mounts.o init/do_mounts.c
> init/do_mounts.c: In function `rd_load_image':
> init/do_mounts.c:613: warning: implicit declaration of function `change_floppy'
>
> [...]
>
> ld -m elf_i386 -T /home/pozsy/DEV/kernel/test2/linux-2.4.19-rc1/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
> 	--start-group \
> 	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
> 	 drivers/acpi/acpi.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/drm/drm.o drivers/net/fc/fc.o drivers/net/tokenring/tr.o drivers/net/wan/wan.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/net/pcmcia/pcmcia_net.o drivers/net/wireless/wireless_net.o drivers/pnp/pnp.o drivers/video/video.o drivers/net/hamradio/hamradio.o drivers/md/mddev.o drivers/isdn/vmlinux-obj.o arch/i386/math-emu/math.o \
> 	net/network.o \
> 	/home/pozsy/DEV/kernel/test2/linux-2.4.19-rc1/arch/i386/lib/lib.a /home/pozsy/DEV/kernel/test2/linux-2.4.19-rc1/lib/lib.a /home/pozsy/DEV/kernel/test2/linux-2.4.19-rc1/arch/i386/lib/lib.a \
> 	--end-group \
> 	-o vmlinux
> init/do_mounts.o: In function `rd_load_image':
> init/do_mounts.o(.text.init+0x907): undefined reference to `change_floppy'
> init/do_mounts.o: In function `rd_load_disk':
> init/do_mounts.o(.text.init+0xa3b): undefined reference to `change_floppy'
> make: *** [vmlinux] Error 1
>
> --
> pozsy
>

-- 
pozsy

