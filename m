Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbSKYTkM>; Mon, 25 Nov 2002 14:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbSKYTkM>; Mon, 25 Nov 2002 14:40:12 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:64156 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S265567AbSKYTkL>; Mon, 25 Nov 2002 14:40:11 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Eric Altendorf <EricAltendorf@orst.edu>
Reply-To: EricAltendorf@orst.edu
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: In 2.5.49: Can't compile w/ ACPI suspend states
Date: Mon, 25 Nov 2002 11:29:59 -0800
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211251129.59466.EricAltendorf@orst.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, past few versions (at least 48 and 49 IIRC) won't compile w/ 
ACPI suspend states enabled.  Is this a known problem?  

ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
arch/i386/kernel/built-in.o: In function `do_suspend_lowlevel':
arch/i386/kernel/built-in.o(.data+0x1154): undefined reference to `save_processor_state'
arch/i386/kernel/built-in.o(.data+0x115a): undefined reference to `saved_context_esp'
arch/i386/kernel/built-in.o(.data+0x115f): undefined reference to `saved_context_eax'
arch/i386/kernel/built-in.o(.data+0x1165): undefined reference to `saved_context_ebx'
arch/i386/kernel/built-in.o(.data+0x116b): undefined reference to `saved_context_ecx'
arch/i386/kernel/built-in.o(.data+0x1171): undefined reference to `saved_context_edx'
arch/i386/kernel/built-in.o(.data+0x1177): undefined reference to `saved_context_ebp'
arch/i386/kernel/built-in.o(.data+0x117d): undefined reference to `saved_context_esi'
arch/i386/kernel/built-in.o(.data+0x1183): undefined reference to `saved_context_edi'
arch/i386/kernel/built-in.o(.data+0x118a): undefined reference to `saved_context_eflags'
arch/i386/kernel/built-in.o(.data+0x11ca): undefined reference to `saved_context_esp'
arch/i386/kernel/built-in.o(.data+0x11d0): undefined reference to `saved_context_ebp'
arch/i386/kernel/built-in.o(.data+0x11d5): undefined reference to `saved_context_eax'
arch/i386/kernel/built-in.o(.data+0x11db): undefined reference to `saved_context_ebx'
arch/i386/kernel/built-in.o(.data+0x11e1): undefined reference to `saved_context_ecx'
arch/i386/kernel/built-in.o(.data+0x11e7): undefined reference to `saved_context_edx'
arch/i386/kernel/built-in.o(.data+0x11ed): undefined reference to `saved_context_esi'
arch/i386/kernel/built-in.o(.data+0x11f3): undefined reference to `saved_context_edi'
arch/i386/kernel/built-in.o(.data+0x11f8): undefined reference to `restore_processor_state'
arch/i386/kernel/built-in.o(.data+0x11fe): undefined reference to `saved_context_eflags'
make: *** [.tmp_vmlinux1] Error 1

I run a crusoe machine and tried compiling for both crusoe and 
PII/Celeron procs, same problem.  I'm not using modules, FWIW.
More machine info & .config info available upon request...

Help!  I have a laptop and need to suspend (to ram or swsusp)!

Thanks, :-)

Eric
-- 
"First they ignore you.  Then they laugh at you.
 Then they fight you.  And then you win."             -Gandhi
