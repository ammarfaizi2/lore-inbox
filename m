Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbTDZRIy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 13:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbTDZRIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 13:08:54 -0400
Received: from f49.law8.hotmail.com ([216.33.241.49]:13575 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S262134AbTDZRIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 13:08:53 -0400
X-Originating-IP: [67.86.246.131]
X-Originating-Email: [seandarcy@hotmail.com]
From: "sean darcy" <seandarcy@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: initrd bk6 & 7 builds -  undefined initrd_load & real_root_dev
Date: Sat, 26 Apr 2003 13:21:00 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law8-F49snvUFcxT5nw0000056c@hotmail.com>
X-OriginalArrivalTime: 26 Apr 2003 17:21:00.0860 (UTC) FILETIME=[353F5FC0:01C30C18]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If initrd is compiled in, both 2.5.68-bk6 and bk7 give the same errors when 
building;


.........
  gcc -E -Wp,-MD,arch/i386/.vmlinux.lds.s.d -D__ASSEMBLY__ -D__KERNEL__ 
-Iinclude -Iinclude/asm-i386/mach-default
-nostdinc -iwithprefix include   -P -C -Ui386   -o arch/i386/vmlinux.lds.s 
arch/i386/vmlinux.lds.S
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=athlon 
-Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix 
include    -DKBUILD_BASENAME=version -DKBUILD_MODNAME=version -c -o 
init/version.o init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o 
init/mounts.o init/initramfs.o
        ld -m elf_i386  -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o 
arch/i386/kernel/init_task.o   init/built-in.o --start-group  usr/built-in.o 
  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  
arch/i386/mach-default/built-in.o  kernel/built-in.o  mm/built-in.o  
fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  
lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  
arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
init/built-in.o(.init.text+0xf39): In function `prepare_namespace':
: undefined reference to `initrd_load'
kernel/built-in.o(.data+0x860): undefined reference to `real_root_dev'
make: *** [vmlinux] Error 1






_________________________________________________________________
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail

