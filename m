Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267010AbSK2LGs>; Fri, 29 Nov 2002 06:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267011AbSK2LGs>; Fri, 29 Nov 2002 06:06:48 -0500
Received: from murphys.services.quay.plus.net ([212.159.14.225]:45031 "HELO
	murphys.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S267010AbSK2LGr>; Fri, 29 Nov 2002 06:06:47 -0500
Date: Fri, 29 Nov 2002 11:13:57 +0000
From: Stig Brautaset <stig@brautaset.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.50: build error with allnoconfig
Message-ID: <20021129111357.GA9498@arwen.brautaset.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Location: London, UK
X-URL: http://brautaset.org
X-KeyServer: wwwkeys.nl.pgp.net
X-PGP/GnuPG-Key: 9336ADC1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make -f scripts/Makefile.build obj=arch/i386/lib
echo '  Generating build number'
  Generating build number
. scripts/mkversion > .tmp_version
mv -f .tmp_version .version
make -f scripts/Makefile.build obj=init
  Generating include/linux/compile.h (updated)
  gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=version -DKBUILD_MODNAME=version   -c -o init/version.o init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/do_mounts.o init/initramfs.o
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  net/built-in.o --end-group  -o vmlinux
net/built-in.o: In function `sock_ioctl':
net/built-in.o(.text+0x976): undefined reference to `dev_ioctl'
net/built-in.o: In function `__kfree_skb':
net/built-in.o(.text+0x31dc): undefined reference to `__secpath_destroy'
make: *** [vmlinux] Error 1


Stig
-- 
brautaset.org
