Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265002AbSLBUme>; Mon, 2 Dec 2002 15:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265012AbSLBUme>; Mon, 2 Dec 2002 15:42:34 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:45065 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S265002AbSLBUmd>;
	Mon, 2 Dec 2002 15:42:33 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [2.5.50, ACPI] link error
Message-Id: <E18Ix71-0003ik-00@gswi1164.jochen.org>
From: Jochen Hein <jochen@delphi.lan-ks.de>
Date: Mon, 02 Dec 2002 21:24:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When compiling 2.5.50 with CONFIG_ACPI_SLEEP=y
I get:

   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/do_mounts.o init/initramfs.o
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
arch/i386/kernel/built-in.o(.data+0x1304): In function `do_suspend_lowlevel':
: undefined reference to `save_processor_state'
arch/i386/kernel/built-in.o(.data+0x130a): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_esp'
arch/i386/kernel/built-in.o(.data+0x130f): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_eax'
arch/i386/kernel/built-in.o(.data+0x1315): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_ebx'
arch/i386/kernel/built-in.o(.data+0x131b): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_ecx'
arch/i386/kernel/built-in.o(.data+0x1321): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_edx'
arch/i386/kernel/built-in.o(.data+0x1327): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_ebp'
arch/i386/kernel/built-in.o(.data+0x132d): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_esi'
arch/i386/kernel/built-in.o(.data+0x1333): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_edi'
arch/i386/kernel/built-in.o(.data+0x133a): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_eflags'
arch/i386/kernel/built-in.o(.data+0x137a): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_esp'
arch/i386/kernel/built-in.o(.data+0x1380): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_ebp'
arch/i386/kernel/built-in.o(.data+0x1385): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_eax'
arch/i386/kernel/built-in.o(.data+0x138b): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_ebx'
arch/i386/kernel/built-in.o(.data+0x1391): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_ecx'
arch/i386/kernel/built-in.o(.data+0x1397): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_edx'
arch/i386/kernel/built-in.o(.data+0x139d): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_esi'
arch/i386/kernel/built-in.o(.data+0x13a3): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_edi'
arch/i386/kernel/built-in.o(.data+0x13a8): In function `do_suspend_lowlevel':
: undefined reference to `restore_processor_state'
arch/i386/kernel/built-in.o(.data+0x13ae): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_eflags'
make: *** [vmlinux] Fehler 1

