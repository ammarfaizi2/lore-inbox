Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264000AbTEPEI3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 00:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264041AbTEPEI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 00:08:29 -0400
Received: from pan.togami.com ([66.139.75.105]:55435 "EHLO pan.mplug.org")
	by vger.kernel.org with ESMTP id S264000AbTEPEI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 00:08:27 -0400
Subject: 2.5.59-bk10 compile failure
From: Warren Togami <warren@togami.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1053058876.15567.72.camel@laptop>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (1.3.3-2) (Preview Release)
Date: 15 May 2003 18:21:16 -1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compilation fails here for 2.5.59-bk9 and bk10.  Last I tried was bk3
which compiled successfully.  Please let me know if you need any more
information, or my .config file.

(Please CC me if you reply, I am not subscribed to the list.  Thanks.)

Warren Togami
warren@togami.com

make -f scripts/Makefile.build obj=arch/i386/lib
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon
-Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=version
-DKBUILD_MODNAME=version -c -o init/.tmp_version.o init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o
init/mounts.o init/initramfs.o
        ld -m elf_i386  -T arch/i386/vmlinux.lds.s
arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o
--start-group  usr/built-in.o  arch/i386/kernel/built-in.o 
arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o 
kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o 
security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a 
drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o 
net/built-in.o --end-group -o .tmp_vmlinux1
arch/i386/kernel/built-in.o(.data+0x169a): In function
`do_suspend_lowlevel':
: undefined reference to `saved_context_esp'
arch/i386/kernel/built-in.o(.data+0x169f): In function
`do_suspend_lowlevel':
: undefined reference to `saved_context_eax'
arch/i386/kernel/built-in.o(.data+0x16a5): In function
`do_suspend_lowlevel':
: undefined reference to `saved_context_ebx'
arch/i386/kernel/built-in.o(.data+0x16ab): In function
`do_suspend_lowlevel':
: undefined reference to `saved_context_ecx'
arch/i386/kernel/built-in.o(.data+0x16b1): In function
`do_suspend_lowlevel':
: undefined reference to `saved_context_edx'
arch/i386/kernel/built-in.o(.data+0x16b7): In function
`do_suspend_lowlevel':
: undefined reference to `saved_context_ebp'
arch/i386/kernel/built-in.o(.data+0x16bd): In function
`do_suspend_lowlevel':
: undefined reference to `saved_context_esi'
arch/i386/kernel/built-in.o(.data+0x16c3): In function
`do_suspend_lowlevel':
: undefined reference to `saved_context_edi'
arch/i386/kernel/built-in.o(.data+0x16ca): In function
`do_suspend_lowlevel':
: undefined reference to `saved_context_eflags'
arch/i386/kernel/built-in.o(.data+0x170a): In function `ret_point':
: undefined reference to `saved_context_esp'
arch/i386/kernel/built-in.o(.data+0x1710): In function `ret_point':
: undefined reference to `saved_context_ebp'
arch/i386/kernel/built-in.o(.data+0x1715): In function `ret_point':
: undefined reference to `saved_context_eax'
arch/i386/kernel/built-in.o(.data+0x171b): In function `ret_point':
: undefined reference to `saved_context_ebx'
arch/i386/kernel/built-in.o(.data+0x1721): In function `ret_point':
: undefined reference to `saved_context_ecx'
arch/i386/kernel/built-in.o(.data+0x1727): In function `ret_point':
: undefined reference to `saved_context_edx'
arch/i386/kernel/built-in.o(.data+0x172d): In function `ret_point':
: undefined reference to `saved_context_esi'
arch/i386/kernel/built-in.o(.data+0x1733): In function `ret_point':
: undefined reference to `saved_context_edi'
arch/i386/kernel/built-in.o(.data+0x173e): In function `ret_point':
: undefined reference to `saved_context_eflags'
arch/i386/kernel/built-in.o(.data+0x1752): In function
`do_suspend_lowlevel_s4bios':
: undefined reference to `saved_context_esp'
arch/i386/kernel/built-in.o(.data+0x1757): In function
`do_suspend_lowlevel_s4bios':
: undefined reference to `saved_context_eax'
arch/i386/kernel/built-in.o(.data+0x175d): In function
`do_suspend_lowlevel_s4bios':
: undefined reference to `saved_context_ebx'
arch/i386/kernel/built-in.o(.data+0x1763): In function
`do_suspend_lowlevel_s4bios':
: undefined reference to `saved_context_ecx'
arch/i386/kernel/built-in.o(.data+0x1769): In function
`do_suspend_lowlevel_s4bios':
: undefined reference to `saved_context_edx'
arch/i386/kernel/built-in.o(.data+0x176f): In function
`do_suspend_lowlevel_s4bios':
: undefined reference to `saved_context_ebp'
arch/i386/kernel/built-in.o(.data+0x1775): In function
`do_suspend_lowlevel_s4bios':
: undefined reference to `saved_context_esi'
arch/i386/kernel/built-in.o(.data+0x177b): In function
`do_suspend_lowlevel_s4bios':
: undefined reference to `saved_context_edi'
arch/i386/kernel/built-in.o(.data+0x1782): In function
`do_suspend_lowlevel_s4bios':
: undefined reference to `saved_context_eflags'
make: *** [.tmp_vmlinux1] Error 1


