Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbTDYC6F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 22:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbTDYC6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 22:58:02 -0400
Received: from customer-148-223-196-18.uninet.net.mx ([148.223.196.18]:44418
	"EHLO soltisns.soltis.cc") by vger.kernel.org with ESMTP
	id S262792AbTDYC6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 22:58:01 -0400
From: "jds" <jds@soltis.cc>
To: linux-kernel@vger.kernel.org
Subject: busy_loop in compile kernel 2.5.68-mm2  
Date: Thu, 24 Apr 2003 20:28:12 -0600
Message-Id: <20030425022510.M26474@soltis.cc>
X-Mailer: Open WebMail 1.90 20030212
X-OriginatingIP: 200.78.6.117 (jds)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  Hi:

    I have problems when compile kernel 2.5.68-mm2 the message is:

    make -f scripts/Makefile.build obj=net/unix
make -f scripts/Makefile.build obj=net/xfrm
make -f scripts/Makefile.build obj=lib
make -f scripts/Makefile.build obj=arch/i386/lib
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=pentium3 -Iinclude/asm-i386/mach-default
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=version
-DKBUILD_MODNAME=version -c -o init/version.o init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o
init/mounts.o init/initramfs.o
        ld -m elf_i386  -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o
arch/i386/kernel/init_task.o   init/built-in.o --start-group  usr/built-in.o 
arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o 
arch/i386/mach-default/built-in.o  kernel/built-in.o  mm/built-in.o 
fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o 
lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o 
arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
drivers/built-in.o(.text+0x9d70b): In function `busy_loop':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0x9d710): In function `busy_loop':
: undefined reference to `sti'
drivers/built-in.o(.text+0x9d72d): In function `busy_loop':
: undefined reference to `restore_flags'
make: *** [.tmp_vmlinux1] Error 1


  Help me please

  Regards

