Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261924AbSJEDKY>; Fri, 4 Oct 2002 23:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261973AbSJEDKY>; Fri, 4 Oct 2002 23:10:24 -0400
Received: from f139.law8.hotmail.com ([216.33.241.139]:7184 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S261924AbSJEDKX>;
	Fri, 4 Oct 2002 23:10:23 -0400
X-Originating-IP: [24.44.249.150]
From: "sean darcy" <seandarcy@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40 compile fails: undef ref in drivers/builtin.o
Date: Fri, 04 Oct 2002 23:15:52 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F139LiemHEBX9Bh57850000f9ad@hotmail.com>
X-OriginalArrivalTime: 05 Oct 2002 03:15:53.0195 (UTC) FILETIME=[83447BB0:01C26C1D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I almost got there. Trying to build 2.5.40 on athlon, then:

  Generating build number
make[1]: Entering directory `/opt/kernel/2.5/linux-2.5.40/init'
  Generating /opt/kernel/2.5/linux-2.5.40/include/linux/compile.h (updated)
  gcc -Wp,-MD,./.version.o.d -D__KERNEL__ 
-I/opt/kernel/2.5/linux-2.5.40/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=athlon  
-I/opt/kernel/2.5/linux-2.5.40/arch/i386/mach-generic -nostdinc -iwithprefix 
include    -DKBUILD_BASENAME=version   -c -o version.o version.c
   ld -m elf_i386  -r -o built-in.o main.o version.o do_mounts.o
make[1]: Leaving directory `/opt/kernel/2.5/linux-2.5.40/init'
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o 
--start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  
arch/i386/mach-generic/built-in.o kernel/built-in.o mm/built-in.o 
fs/built-in.o ipc/built-in.o security/built-in.o  lib/lib.a  
arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  
arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
drivers/built-in.o(.data+0x2e174): undefined reference to `local symbols in 
discarded section .text.exit'
make: *** [vmlinux] Error 1


jay


_________________________________________________________________
Join the world’s largest e-mail service with MSN Hotmail. 
http://www.hotmail.com

