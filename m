Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbSJUWin>; Mon, 21 Oct 2002 18:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261743AbSJUWin>; Mon, 21 Oct 2002 18:38:43 -0400
Received: from air-2.osdl.org ([65.172.181.6]:5868 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261742AbSJUWim>;
	Mon, 21 Oct 2002 18:38:42 -0400
Subject: Re: [RFC][PATCH] linux-2.5.34_vsyscall_A0
From: Stephen Hemminger <shemminger@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
       Michael Hohnbaum <hbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       george anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1034915132.1681.144.camel@cog>
References: <1034915132.1681.144.camel@cog>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 15:44:43 -0700
Message-Id: <1035240284.1209.41.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch doesn't work if kernel is compiled with kernel symbols
enabled.
-------------------------------------------------------------------
 ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  arch/i386/oprofile/built-in.o  net/built-in.o --end-group .tmp_kallsyms1.o -o .tmp_vmlinux2
ld: section .vsyscall_0 [c0328000 -> c03280e1] overlaps section __kallsyms [c0327e60 -> c03afe8f]
ld: section .vxtime_sequence [c0328100 -> c0328107] overlaps section __kallsyms
[c0327e60 -> c03afe8f]
ld: section .last_tsc_low [c0328108 -> c032810b] overlaps section __kallsyms [c0327e60 -> c03afe8f]
ld: section .delay_at_last_interrupt [c032810c -> c032810f] overlaps section __kallsyms [c0327e60 -> c03afe8f]
ld: section .fast_gettimeoffset_quotient [c0328110 -> c0328113] overlaps section __kallsyms [c0327e60 -> c03afe8f]
ld: section .wall_jiffies [c0328114 -> c0328117] overlaps section __kallsyms [c0327e60 -> c03afe8f]
ld: section .sys_tz [c0328118 -> c032811f] overlaps section __kallsyms [c0327e60 -> c03afe8f]
ld: section .jiffies [c0328120 -> c0328123] overlaps section __kallsyms [c0327e60 -> c03afe8f]
ld: section .xtime [c0328130 -> c0328137] overlaps section __kallsyms [c0327e60
-> c03afe8f]
ld: section .vsyscall_1 [c0328400 -> c0328436] overlaps section __kallsyms [c0327e60 -> c03afe8f]

