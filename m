Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261369AbSJYLy5>; Fri, 25 Oct 2002 07:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbSJYLy5>; Fri, 25 Oct 2002 07:54:57 -0400
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:25810 "EHLO
	pc.kolivas.net") by vger.kernel.org with ESMTP id <S261369AbSJYLy4>;
	Fri, 25 Oct 2002 07:54:56 -0400
Message-ID: <1035547268.3db9328488960@kolivas.net>
Date: Fri, 25 Oct 2002 22:01:08 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.44-mm5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Compile failure (gcc3.2):

  gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic
-fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=version
  -c -o init/version.o init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/do_mounts.o
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s
arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o
--start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o 
arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o 
fs/built-in.o  ipc/built-in.o  security/built-in.o  lib/lib.a 
arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o 
arch/i386/pci/built-in.o  arch/i386/oprofile/built-in.o  net/built-in.o
--end-group  -o .tmp_vmlinux1
kernel/built-in.o: In function `sched_init':
kernel/built-in.o(.init.text+0xc4): undefined reference to `init_kstat'
make: *** [.tmp_vmlinux1] Error 1
