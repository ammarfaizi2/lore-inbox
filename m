Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266292AbSLCMCF>; Tue, 3 Dec 2002 07:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266295AbSLCMCF>; Tue, 3 Dec 2002 07:02:05 -0500
Received: from pc3-stoc3-4-cust114.midd.cable.ntl.com ([80.6.255.114]:51977
	"EHLO buzz.ichilton.co.uk") by vger.kernel.org with ESMTP
	id <S266292AbSLCMCD>; Tue, 3 Dec 2002 07:02:03 -0500
Date: Tue, 3 Dec 2002 12:09:29 +0000
From: Ian Chilton <ian@ichilton.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 Compile Failure
Message-ID: <20021203120928.GC8351@buzz.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm not on linux-kernel at the moment so please cc any replies directly.

I get the following error when compiling
2.4.20-fairsched-kpreempt-skas3.

If I remove this..:
--- DRM 4.1 drivers
<*>   SiS
...it works fine.


Here is the error:

ld -m elf_i386 -T /usr/src/linux-2.4.20/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/acpi/acpi.o drivers/parport/driver.o
drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o
drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o
drivers/cdrom/driver.o drivers/pci/driver.o drivers/pnp/pnp.o
drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o \
        net/network.o \
        /usr/src/linux-2.4.20/arch/i386/lib/lib.a
/usr/src/linux-2.4.20/lib/lib.a
/usr/src/linux-2.4.20/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/char/drm/drm.o: In function `sis_fb_alloc':
drivers/char/drm/drm.o(.text+0x73d8): undefined reference to
`sis_malloc'
drivers/char/drm/drm.o(.text+0x7486): undefined reference to `sis_free'
drivers/char/drm/drm.o: In function `sis_fb_free':
drivers/char/drm/drm.o(.text+0x74f9): undefined reference to `sis_free'
drivers/char/drm/drm.o: In function `sis_final_context':
drivers/char/drm/drm.o(.text+0x791f): undefined reference to `sis_free'
make: *** [vmlinux] Error 1


[root@jester linux]# gcc -v
Reading specs from /usr/lib/gcc-lib/i686-pc-linux-gnu/3.2/specs
Configured with: ../gcc-3.2/configure --prefix=/usr --enable-shared
--enable-languages=c,c++ --enable-threads=posix --with-slibdir=/lib
Thread model: posix
gcc version 3.2
[root@jester linux]#


Bye for Now,

Ian
