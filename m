Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266116AbSKVX6O>; Fri, 22 Nov 2002 18:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266236AbSKVX6O>; Fri, 22 Nov 2002 18:58:14 -0500
Received: from [66.62.77.7] ([66.62.77.7]:53940 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id <S266116AbSKVX6H>;
	Fri, 22 Nov 2002 18:58:07 -0500
Subject: 2.5.49 ACPI and Software Suspend compile failure
From: Dax Kelson <dax@gurulabs.com>
To: andrew.grover@intel.com, pavel@suse.cz
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Nov 2002 17:05:30 -0700
Message-Id: <1038009931.1623.7.camel@mentor>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  Generating include/linux/compile.h (updated)
  gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=pentium4 -Iarch/i386/mach-generic -nostdinc -iwithprefix
include    -DKBUILD_BASENAME=version -DKBUILD_MODNAME=version   -c -o
init/version.o init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o
init/do_mounts.o init/initramfs.o
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s
arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o
--start-group  usr/built-in.o  arch/i386/kernel/built-in.o 
arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o 
kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o 
security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a 
drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o 
net/built-in.o --end-group  -o .tmp_vmlinux1
arch/i386/kernel/built-in.o: In function `do_suspend_lowlevel':
arch/i386/kernel/built-in.o(.data+0x1304): undefined reference to
`save_processor_state'
arch/i386/kernel/built-in.o(.data+0x130a): undefined reference to
`saved_context_esp'
arch/i386/kernel/built-in.o(.data+0x130f): undefined reference to
`saved_context_eax'
arch/i386/kernel/built-in.o(.data+0x1315): undefined reference to
`saved_context_ebx'
arch/i386/kernel/built-in.o(.data+0x131b): undefined reference to
`saved_context_ecx'
arch/i386/kernel/built-in.o(.data+0x1321): undefined reference to
`saved_context_edx'
arch/i386/kernel/built-in.o(.data+0x1327): undefined reference to
`saved_context_ebp'
arch/i386/kernel/built-in.o(.data+0x132d): undefined reference to
`saved_context_esi'
arch/i386/kernel/built-in.o(.data+0x1333): undefined reference to
`saved_context_edi'
arch/i386/kernel/built-in.o(.data+0x133a): undefined reference to
`saved_context_eflags'
arch/i386/kernel/built-in.o(.data+0x137a): undefined reference to
`saved_context_esp'
arch/i386/kernel/built-in.o(.data+0x1380): undefined reference to
`saved_context_ebp'
arch/i386/kernel/built-in.o(.data+0x1385): undefined reference to
`saved_context_eax'
arch/i386/kernel/built-in.o(.data+0x138b): undefined reference to
`saved_context_ebx'
arch/i386/kernel/built-in.o(.data+0x1391): undefined reference to
`saved_context_ecx'
arch/i386/kernel/built-in.o(.data+0x1397): undefined reference to
`saved_context_edx'
arch/i386/kernel/built-in.o(.data+0x139d): undefined reference to
`saved_context_esi'
arch/i386/kernel/built-in.o(.data+0x13a3): undefined reference to
`saved_context_edi'
arch/i386/kernel/built-in.o(.data+0x13a8): undefined reference to
`restore_processor_state'
arch/i386/kernel/built-in.o(.data+0x13ae): undefined reference to
`saved_context_eflags'


