Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263378AbTC2Dgm>; Fri, 28 Mar 2003 22:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263379AbTC2Dgm>; Fri, 28 Mar 2003 22:36:42 -0500
Received: from franka.aracnet.com ([216.99.193.44]:19154 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263378AbTC2Dgl>; Fri, 28 Mar 2003 22:36:41 -0500
Date: Fri, 28 Mar 2003 19:47:54 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 517] New: Can't compile 2.5.66 w/i810fb support 
Message-ID: <51790000.1048909674@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=517

           Summary: Can't compile 2.5.66 w/i810fb support
    Kernel Version: 2.5.66
            Status: NEW
          Severity: blocking
             Owner: jsimmons@infradead.org
         Submitter: tmasoner_33@comcast.net


Distribution: Gentoo
Hardware Environment: P-III/Celeron
Software Environment: 
Problem Description: Kernel won't compile with i810 frame buffer support
enabled

Steps to reproduce: Enable Frame Buffer Support -> Intel i810/815 support

Results from make bzImage :

make -f scripts/Makefile.build obj=arch/i386/lib
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-
prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -
mpreferred-stack-boundary=2 -march=pentium3 -Iinclude/asm-i386/mach-default
- fomit-frame-pointer -nostdinc -iwithprefix include    -
DKBUILD_BASENAME=version -DKBUILD_MODNAME=version -c -o init/version.o 
init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o 
init/mounts.o init/initramfs.o
        ld -m elf_i386  -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o 
arch/i386/kernel/init_task.o   init/built-in.o --start-group
usr/built-in.o   arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o
arch/i386/mach- default/built-in.o  kernel/built-in.o  mm/built-in.o
fs/built-in.o  ipc/built- in.o  security/built-in.o  crypto/built-in.o
lib/lib.a  arch/i386/lib/lib.a   drivers/built-in.o  sound/built-in.o
arch/i386/pci/built-in.o  net/built-in.o - -end-group  -o vmlinux
drivers/built-in.o(.text+0x99032): In function `i810fb_imageblit':
: undefined reference to `__memcpy'
make: *** [vmlinux] Error 1

