Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267024AbSKWMwF>; Sat, 23 Nov 2002 07:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267025AbSKWMwF>; Sat, 23 Nov 2002 07:52:05 -0500
Received: from marstons.services.quay.plus.net ([212.159.14.223]:13482 "HELO
	marstons.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S267024AbSKWMwE>; Sat, 23 Nov 2002 07:52:04 -0500
Date: Sat, 23 Nov 2002 12:29:47 +0000
To: linux-kernel@vger.kernel.org
Subject: 2.5.49: compile problem with allnoconfig (actually show error this time)
Message-ID: <20021123122947.GA13747@arwen.brautaset.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Location: London, UK
X-URL: http://brautaset.org
X-KeyServer: wwwkeys.nl.pgp.net
X-PGP/GnuPG-Key: 9336ADC1
From: Stig Brautaset <stig@brautaset.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
make -f scripts/Makefile.build obj=init
  Generating include/linux/compile.h (unchanged)
make -f scripts/Makefile.build obj=usr
make -f scripts/Makefile.build obj=arch/i386/kernel
make -f scripts/Makefile.build obj=arch/i386/kernel/cpu
make -f scripts/Makefile.build obj=arch/i386/kernel/timers
make -f scripts/Makefile.build obj=arch/i386/mm
make -f scripts/Makefile.build obj=arch/i386/mach-generic
make -f scripts/Makefile.build obj=kernel
make -f scripts/Makefile.build obj=mm
make -f scripts/Makefile.build obj=fs
make -f scripts/Makefile.build obj=fs/devpts
make -f scripts/Makefile.build obj=fs/partitions
make -f scripts/Makefile.build obj=fs/ramfs
make -f scripts/Makefile.build obj=fs/sysfs
make -f scripts/Makefile.build obj=ipc
make -f scripts/Makefile.build obj=security
make -f scripts/Makefile.build obj=crypto
make -f scripts/Makefile.build obj=drivers
make -f scripts/Makefile.build obj=drivers/base
make -f scripts/Makefile.build obj=drivers/base/fs
make -f scripts/Makefile.build obj=drivers/block
make -f scripts/Makefile.build obj=drivers/cdrom
make -f scripts/Makefile.build obj=drivers/char
make -f scripts/Makefile.build obj=drivers/media
make -f scripts/Makefile.build obj=drivers/media/dvb
make -f scripts/Makefile.build obj=drivers/media/dvb/av7110
make -f scripts/Makefile.build obj=drivers/media/dvb/dvb-core
make -f scripts/Makefile.build obj=drivers/media/dvb/frontends
make -f scripts/Makefile.build obj=drivers/media/radio
make -f scripts/Makefile.build obj=drivers/media/video
make -f scripts/Makefile.build obj=drivers/misc
make -f scripts/Makefile.build obj=drivers/net
make -f scripts/Makefile.build obj=drivers/serial
make -f scripts/Makefile.build obj=sound
make -f scripts/Makefile.build obj=net
make -f scripts/Makefile.build obj=net/core
make -f scripts/Makefile.build obj=lib
make -f scripts/Makefile.build obj=arch/i386/lib
echo '  Generating build number'
  Generating build number
. scripts/mkversion > .tmp_version
mv -f .tmp_version .version
make -f scripts/Makefile.build obj=init
  Generating include/linux/compile.h (updated)
  gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=version -DKBUILD_MODNAME=version   -c -o init/version.o init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/do_mounts.o init/initramfs.o
  	ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  net/built-in.o --end-group  -o vmlinux
net/built-in.o: In function `sock_ioctl':
net/built-in.o(.text+0x976): undefined reference to `dev_ioctl'
net/built-in.o: In function `__kfree_skb':
net/built-in.o(.text+0x31cc): undefined reference to `__secpath_destroy'
make: *** [vmlinux] Error 1
