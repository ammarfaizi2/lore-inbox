Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262364AbSKBMjO>; Sat, 2 Nov 2002 07:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265950AbSKBMjO>; Sat, 2 Nov 2002 07:39:14 -0500
Received: from technicolor.pl ([62.21.19.63]:27155 "EHLO wilnet.info")
	by vger.kernel.org with ESMTP id <S262364AbSKBMjO>;
	Sat, 2 Nov 2002 07:39:14 -0500
Date: Sat, 2 Nov 2002 13:45:40 +0100 (CET)
From: Pawel Bernadowski <pbern@wilnet.info>
To: linux-kernel@vger.kernel.org
Subject: 2.5.45-mcp2 Build error
Message-ID: <Pine.LNX.4.44L.0211021345060.27334-100000@farma.wilnet.info>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=version   -c -o init/version.o init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o 
init/do_mounts.o
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o 
--start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  
arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  
fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  
lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  
arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
init/built-in.o: In function `rd_load_image':
init/built-in.o(.init.text+0x12ac): undefined reference to `change_floppy'


Pawel Bernadowski
GG 3377

