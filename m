Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262887AbSLCR4f>; Tue, 3 Dec 2002 12:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262913AbSLCR4f>; Tue, 3 Dec 2002 12:56:35 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:48888 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S262887AbSLCR4U>; Tue, 3 Dec 2002 12:56:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: Eric Altendorf <EricAltendorf@orst.edu>
Reply-To: EricAltendorf@orst.edu
To: Jochen Hein <jochen@delphi.lan-ks.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.5.50, ACPI] link error
Date: Tue, 3 Dec 2002 10:07:01 -0800
User-Agent: KMail/1.4.1
References: <E18Ix71-0003ik-00@gswi1164.jochen.org>
In-Reply-To: <E18Ix71-0003ik-00@gswi1164.jochen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212031007.01782.EricAltendorf@orst.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Try turning on software suspend in the kernel hacking section.  I had 
to clean and recompile a couple times after doing that but that 
eventually got it to compile.  Of course, once I got it compiled it 
oops'ed on boot, so that may not get you anywhere, but.... :-)

eric

On Monday 02 December 2002 12:24, Jochen Hein wrote:
> When compiling 2.5.50 with CONFIG_ACPI_SLEEP=y
> I get:
>
>    ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o
> init/do_mounts.o init/initramfs.o ld -m elf_i386 -e stext -T
> arch/i386/vmlinux.lds.s arch/i386/kernel/head.o
> arch/i386/kernel/init_task.o  init/built-in.o --start-group 
> usr/built-in.o  arch/i386/kernel/built-in.o 
> arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o 
> kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o 
> security/built-in.o  crypto/built-in.o  lib/lib.a 
> arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o 
> arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
>
> arch/i386/kernel/built-in.o(.data+0x1304): In function 
`do_suspend_lowlevel':
> : undefined reference to `save_processor_state'
>
> arch/i386/kernel/built-in.o(.data+0x130a): In function 
`do_suspend_lowlevel':
> : undefined reference to `saved_context_esp'
>
> arch/i386/kernel/built-in.o(.data+0x130f): In function 
`do_suspend_lowlevel':
> : undefined reference to `saved_context_eax'
>
> arch/i386/kernel/built-in.o(.data+0x1315): In function 
`do_suspend_lowlevel':
> : undefined reference to `saved_context_ebx'
>
> arch/i386/kernel/built-in.o(.data+0x131b): In function 
`do_suspend_lowlevel':
> : undefined reference to `saved_context_ecx'
>
> arch/i386/kernel/built-in.o(.data+0x1321): In function 
`do_suspend_lowlevel':
> : undefined reference to `saved_context_edx'
>
> arch/i386/kernel/built-in.o(.data+0x1327): In function 
`do_suspend_lowlevel':
> : undefined reference to `saved_context_ebp'
>
> arch/i386/kernel/built-in.o(.data+0x132d): In function 
`do_suspend_lowlevel':
> : undefined reference to `saved_context_esi'
>
> arch/i386/kernel/built-in.o(.data+0x1333): In function 
`do_suspend_lowlevel':
> : undefined reference to `saved_context_edi'
>
> arch/i386/kernel/built-in.o(.data+0x133a): In function 
`do_suspend_lowlevel':
> : undefined reference to `saved_context_eflags'
>
> arch/i386/kernel/built-in.o(.data+0x137a): In function 
`do_suspend_lowlevel':
> : undefined reference to `saved_context_esp'
>
> arch/i386/kernel/built-in.o(.data+0x1380): In function 
`do_suspend_lowlevel':
> : undefined reference to `saved_context_ebp'
>
> arch/i386/kernel/built-in.o(.data+0x1385): In function 
`do_suspend_lowlevel':
> : undefined reference to `saved_context_eax'
>
> arch/i386/kernel/built-in.o(.data+0x138b): In function 
`do_suspend_lowlevel':
> : undefined reference to `saved_context_ebx'
>
> arch/i386/kernel/built-in.o(.data+0x1391): In function 
`do_suspend_lowlevel':
> : undefined reference to `saved_context_ecx'
>
> arch/i386/kernel/built-in.o(.data+0x1397): In function 
`do_suspend_lowlevel':
> : undefined reference to `saved_context_edx'
>
> arch/i386/kernel/built-in.o(.data+0x139d): In function 
`do_suspend_lowlevel':
> : undefined reference to `saved_context_esi'
>
> arch/i386/kernel/built-in.o(.data+0x13a3): In function 
`do_suspend_lowlevel':
> : undefined reference to `saved_context_edi'
>
> arch/i386/kernel/built-in.o(.data+0x13a8): In function 
`do_suspend_lowlevel':
> : undefined reference to `restore_processor_state'
>
> arch/i386/kernel/built-in.o(.data+0x13ae): In function 
`do_suspend_lowlevel':
> : undefined reference to `saved_context_eflags'
>
> make: *** [vmlinux] Fehler 1
>
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
"First they ignore you.  Then they laugh at you.
 Then they fight you.  And then you win."             -Gandhi
