Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265315AbUGVNIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265315AbUGVNIY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 09:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265317AbUGVNIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 09:08:24 -0400
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:48631 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S265315AbUGVNIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 09:08:05 -0400
Message-ID: <313680C9A886D511A06000204840E1CF08F43056@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Cc: crossgcc <crossgcc@sources.redhat.com>
Subject: 2.6.7 ppc 8260 (cross compile in Cygwin) - lots of undefined refe
	rences to `jiffies' and other symbols in built-in.o - anybody ?
Date: Thu, 22 Jul 2004 09:07:23 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
powerpc-linux-ld: section __ftr_fixup [000005c4 -> 00000783] overlaps
section .text.1 [00000000 -> 000037df]
powerpc-linux-ld: section .rodata [00000874 -> 0000eeff] overlaps section
.text.1 [00000000 -> 000037df]
powerpc-linux-ld: section .rodata.str1.4 [0000ef00 -> 00022060] overlaps
section .init.text [00007620 -> 00015c67]
powerpc-linux-ld: section .init.ramfs [00022061 -> 000220e5] overlaps
section .text.10 [0002186c -> 0003b0cf]
powerpc-linux-ld: section __ex_table [000220e8 -> 000234df] overlaps section
.text.10 [0002186c -> 0003b0cf]
powerpc-linux-ld: section __bug_table [000234e0 -> 00026caf] overlaps
section .text.10 [0002186c -> 0003b0cf]
powerpc-linux-ld: section __param [00026cb0 -> 00026d3b] overlaps section
.text.10 [0002186c -> 0003b0cf]

**********Alex Povolotsky - what is meaning of above "overlaps" messages ?
**********************

init/built-in.o(.text+0x3e): In function `calibrate_delay':
: undefined reference to `jiffies'
init/built-in.o(.text+0x42): In function `calibrate_delay':
: undefined reference to `jiffies'
init/built-in.o(.text+0x46): In function `calibrate_delay':
: undefined reference to `jiffies'
init/built-in.o(.text+0x52): In function `calibrate_delay':
: undefined reference to `jiffies'
init/built-in.o(.text+0x5e): In function `calibrate_delay':
: undefined reference to `jiffies'
init/built-in.o(.text+0x96): more undefined references to `jiffies' follow
init/built-in.o(.init.text+0x52): In function `obsolete_checksetup':
: undefined reference to `__setup_start'
init/built-in.o(.init.text+0x56): In function `obsolete_checksetup':
: undefined reference to `__setup_end'
init/built-in.o(.init.text+0x66): In function `obsolete_checksetup':
: undefined reference to `__setup_start'
init/built-in.o(.init.text+0x6a): In function `obsolete_checksetup':
: undefined reference to `__setup_end'
init/built-in.o(.init.text+0x4aa): In function `do_initcalls':
: undefined reference to `__initcall_start'
init/built-in.o(.init.text+0x4b6): In function `do_initcalls':
: undefined reference to `__initcall_end'
init/built-in.o(.init.text+0x4ba): In function `do_initcalls':
: undefined reference to `__initcall_start'
init/built-in.o(.init.text+0x4be): In function `do_initcalls':
: undefined reference to `__initcall_end'
init/built-in.o(.init.text+0x552): In function `do_initcalls':
: undefined reference to `__initcall_end'
init/built-in.o(.init.text+0x30ee): In function `populate_rootfs':
: undefined reference to `__initramfs_start'
init/built-in.o(.init.text+0x30f2): In function `populate_rootfs':
: undefined reference to `__initramfs_end'
init/built-in.o(.init.text+0x30fa): In function `populate_rootfs':
: undefined reference to `__initramfs_start'
init/built-in.o(.init.text+0x30fe): In function `populate_rootfs':
: undefined reference to `__initramfs_end'
arch/ppc/kernel/built-in.o(.text+0x90): In function `sys_call_table':
arch/ppc/kernel/entry.S: relocation truncated to fit: R_PPC_REL14
power_save_6xx
_restore
arch/ppc/kernel/built-in.o(.text+0x94):arch/ppc/kernel/entry.S: relocation
trunc
ated to fit: R_PPC_REL14 power_save_6xx_restore
arch/ppc/kernel/built-in.o(.text+0xc2):arch/ppc/kernel/entry.S: undefined
refere
nce to `_end'
arch/ppc/kernel/built-in.o(.text+0xc6):arch/ppc/kernel/entry.S: undefined
refere
nce to `_end'
arch/ppc/kernel/built-in.o(.text+0x235a): In function `_switch':
arch/ppc/kernel/entry.S: undefined reference to `jiffies'
arch/ppc/kernel/built-in.o(.text+0x2362):arch/ppc/kernel/entry.S: undefined
refe
rence to `jiffies'
arch/ppc/kernel/built-in.o(.text+0x248e):arch/ppc/kernel/entry.S: undefined
refe
rence to `jiffies'
arch/ppc/kernel/built-in.o(.text+0x24de):arch/ppc/kernel/entry.S: undefined
refe
rence to `jiffies'
arch/ppc/kernel/built-in.o(.text+0x25e2):arch/ppc/kernel/entry.S: undefined
refe
rence to `jiffies'
arch/ppc/kernel/built-in.o(.text+0x25f2):arch/ppc/kernel/entry.S: more
undefined
 references to `jiffies' follow
arch/ppc/kernel/built-in.o(.text+0x2a82): In function `reloc_got2':
arch/ppc/kernel/entry.S: undefined reference to `__got2_start'
arch/ppc/kernel/built-in.o(.text+0x2a86):arch/ppc/kernel/entry.S: undefined
refe
rence to `__got2_start'
arch/ppc/kernel/built-in.o(.text+0x2a8a):arch/ppc/kernel/entry.S: undefined
refe
rence to `__got2_end'
arch/ppc/kernel/built-in.o(.text+0x2a8e):arch/ppc/kernel/entry.S: undefined
refe
rence to `__got2_end'
arch/ppc/kernel/built-in.o(.text+0x5eae): In function `execve':
arch/ppc/kernel/entry.S: undefined reference to `__bss_start'
arch/ppc/kernel/built-in.o(.text+0x5eb6):arch/ppc/kernel/entry.S: undefined
refe
rence to `__bss_start'
arch/ppc/kernel/built-in.o(.text+0x5eca):arch/ppc/kernel/entry.S: undefined
refe
rence to `__bss_start'
arch/ppc/kernel/built-in.o(.text+0x5ece):arch/ppc/kernel/entry.S: undefined
refe
rence to `__bss_start'
arch/ppc/kernel/built-in.o(.init.text+0x2da): In function `DoSyscall':
arch/ppc/kernel/entry.S: undefined reference to `_end'
arch/ppc/kernel/built-in.o(.init.text+0x2de):arch/ppc/kernel/entry.S:
undefined
reference to `__bss_start'
arch/ppc/kernel/built-in.o(.init.text+0x2e2):arch/ppc/kernel/entry.S:
undefined
reference to `_end'
arch/ppc/kernel/built-in.o(.init.text+0x2e6):arch/ppc/kernel/entry.S:
undefined
reference to `__bss_start'
arch/ppc/kernel/built-in.o(.init.text+0x536):arch/ppc/kernel/entry.S:
undefined
reference to `_etext'
arch/ppc/kernel/built-in.o(.init.text+0x53a):arch/ppc/kernel/entry.S:
undefined
reference to `_edata'
arch/ppc/kernel/built-in.o(.init.text+0x542):arch/ppc/kernel/entry.S:
undefined
reference to `_etext'
arch/ppc/kernel/built-in.o(.init.text+0x546):arch/ppc/kernel/entry.S:
undefined
reference to `_edata'
arch/ppc/mm/built-in.o(.text+0x6c2): In function `free_initmem':
: undefined reference to `__init_begin'
arch/ppc/mm/built-in.o(.text+0x6c6): In function `free_initmem':
: undefined reference to `__init_end'
arch/ppc/mm/built-in.o(.text+0x6ce): In function `free_initmem':
: undefined reference to `__init_begin'
arch/ppc/mm/built-in.o(.text+0x6d2): In function `free_initmem':
: undefined reference to `__init_end'
arch/ppc/mm/built-in.o(.text+0x6e2): In function `free_initmem':
: undefined reference to `__pmac_begin'
arch/ppc/mm/built-in.o(.text+0x6e6): In function `free_initmem':
: undefined reference to `__pmac_end'
arch/ppc/mm/built-in.o(.text+0x6ea): In function `free_initmem':
: undefined reference to `__pmac_begin'
arch/ppc/mm/built-in.o(.text+0x6ee): In function `free_initmem':
: undefined reference to `__pmac_end'
arch/ppc/mm/built-in.o(.text+0x6fe): In function `free_initmem':
: undefined reference to `__chrp_begin'
arch/ppc/mm/built-in.o(.text+0x702): In function `free_initmem':
: undefined reference to `__chrp_end'
arch/ppc/mm/built-in.o(.text+0x706): In function `free_initmem':
: undefined reference to `__chrp_begin'
arch/ppc/mm/built-in.o(.text+0x70a): In function `free_initmem':
: undefined reference to `__chrp_end'
arch/ppc/mm/built-in.o(.text+0x71a): In function `free_initmem':
: undefined reference to `__prep_begin'
arch/ppc/mm/built-in.o(.text+0x71e): In function `free_initmem':
: undefined reference to `__prep_end'
arch/ppc/mm/built-in.o(.text+0x722): In function `free_initmem':
: undefined reference to `__prep_begin'
arch/ppc/mm/built-in.o(.text+0x726): In function `free_initmem':
: undefined reference to `__prep_end'
arch/ppc/mm/built-in.o(.text+0x736): In function `free_initmem':
: undefined reference to `__openfirmware_begin'
arch/ppc/mm/built-in.o(.text+0x73a): In function `free_initmem':
: undefined reference to `__openfirmware_end'
arch/ppc/mm/built-in.o(.text+0x73e): In function `free_initmem':
: undefined reference to `__openfirmware_begin'
arch/ppc/mm/built-in.o(.text+0x742): In function `free_initmem':
: undefined reference to `__openfirmware_end'
arch/ppc/mm/built-in.o(.init.text+0x4c6): In function `mem_init':
: undefined reference to `etext'
arch/ppc/mm/built-in.o(.init.text+0x4ce): In function `mem_init':
: undefined reference to `etext'
arch/ppc/mm/built-in.o(.init.text+0x4d2): In function `mem_init':
: undefined reference to `__init_begin'
arch/ppc/mm/built-in.o(.init.text+0x4da): In function `mem_init':
: undefined reference to `__init_end'
arch/ppc/mm/built-in.o(.init.text+0x4e2): In function `mem_init':
: undefined reference to `__init_begin'
arch/ppc/mm/built-in.o(.init.text+0x4e6): In function `mem_init':
: undefined reference to `__init_end'
arch/ppc/mm/built-in.o(.init.text+0xbba): In function `mapin_ram':
: undefined reference to `etext'
arch/ppc/mm/built-in.o(.init.text+0xbc2): In function `mapin_ram':
: undefined reference to `etext'
arch/ppc/mm/built-in.o(.sdata+0x4): undefined reference to `_end'
kernel/built-in.o(.text+0xe7e): In function `scheduler_tick':
: undefined reference to `jiffies'
kernel/built-in.o(.text+0xe82): In function `scheduler_tick':
: undefined reference to `jiffies'
kernel/built-in.o(.text+0xed2): In function `scheduler_tick':
: undefined reference to `jiffies'
kernel/built-in.o(.text+0xed6): In function `scheduler_tick':
: undefined reference to `jiffies'
kernel/built-in.o(.text+0x2096): In function `in_sched_functions':
: undefined reference to `__sched_text_start'
kernel/built-in.o(.text+0x209e): In function `in_sched_functions':
: undefined reference to `__sched_text_start'
kernel/built-in.o(.text+0x20a2): In function `in_sched_functions':
: undefined reference to `__sched_text_end'
kernel/built-in.o(.text+0x20aa): In function `in_sched_functions':
: undefined reference to `__sched_text_end'
kernel/built-in.o(.text+0x4772): In function `zap_locks':
: undefined reference to `jiffies'
kernel/built-in.o(.text+0x477a): In function `zap_locks':
: undefined reference to `jiffies'
kernel/built-in.o(.text+0x4796): In function `zap_locks':
: undefined reference to `jiffies'
kernel/built-in.o(.text+0x47ae): In function `zap_locks':
: undefined reference to `jiffies'
kernel/built-in.o(.text+0x4eda): In function `__printk_ratelimit':
: undefined reference to `jiffies'
kernel/built-in.o(.text+0x4ee2): more undefined references to `jiffies'
follow
kernel/built-in.o(.text+0x15536): In function `kernel_text_address':
: undefined reference to `_sinittext'
kernel/built-in.o(.text+0x1553e): In function `kernel_text_address':
: undefined reference to `_sinittext'
kernel/built-in.o(.text+0x1554a): In function `kernel_text_address':
: undefined reference to `_etext'
kernel/built-in.o(.text+0x15552): In function `kernel_text_address':
: undefined reference to `_etext'
kernel/built-in.o(.text+0x1556a): In function `kernel_text_address':
: undefined reference to `_einittext'
kernel/built-in.o(.text+0x1556e): In function `kernel_text_address':
: undefined reference to `_einittext'
kernel/built-in.o(.text+0x1613e): In function `schedule_next_timer':
: undefined reference to `jiffies'
kernel/built-in.o(.text+0x16146): In function `schedule_next_timer':
: undefined reference to `jiffies'
kernel/built-in.o(.text+0x16916): In function `do_timer_gettime':
: undefined reference to `jiffies'
kernel/built-in.o(.text+0x1691a): In function `do_timer_gettime':
: undefined reference to `jiffies'
kernel/built-in.o(.text+0x16fca): In function `sys_timer_settime':
: undefined reference to `jiffies'
kernel/built-in.o(.text+0x16fd2): more undefined references to `jiffies'
follow
kernel/built-in.o(.text+0x1909e): In function `kallsyms_lookup':
: undefined reference to `_etext'
kernel/built-in.o(.text+0x190a2): In function `kallsyms_lookup':
: undefined reference to `_sinittext'
kernel/built-in.o(.text+0x190a6): In function `kallsyms_lookup':
: undefined reference to `_etext'
kernel/built-in.o(.text+0x190b2): In function `kallsyms_lookup':
: undefined reference to `_sinittext'
kernel/built-in.o(.text+0x190b6): In function `kallsyms_lookup':
: undefined reference to `_sinittext'
kernel/built-in.o(.text+0x190c2): In function `kallsyms_lookup':
: undefined reference to `_einittext'
kernel/built-in.o(.text+0x190c6): In function `kallsyms_lookup':
: undefined reference to `_einittext'
kernel/built-in.o(.text+0x19166): In function `kallsyms_lookup':
: undefined reference to `_sinittext'
kernel/built-in.o(.text+0x19172): In function `kallsyms_lookup':
: undefined reference to `_einittext'
kernel/built-in.o(.text+0x19176): In function `kallsyms_lookup':
: undefined reference to `_einittext'
kernel/built-in.o(.text+0x19182): In function `kallsyms_lookup':
: undefined reference to `_etext'
kernel/built-in.o(.text+0x19186): In function `kallsyms_lookup':
: undefined reference to `_etext'
kernel/built-in.o(.text+0x193ca): In function `get_ksymbol_core':
: undefined reference to `_sinittext'
kernel/built-in.o(.text+0x193d6): In function `get_ksymbol_core':
: undefined reference to `_sinittext'
kernel/built-in.o(.text+0x193da): In function `get_ksymbol_core':
: undefined reference to `_etext'
kernel/built-in.o(.text+0x193e2): In function `get_ksymbol_core':
: undefined reference to `_etext'
kernel/built-in.o(.text+0x193fe): In function `get_ksymbol_core':
: undefined reference to `_einittext'
kernel/built-in.o(.text+0x19402): In function `get_ksymbol_core':
: undefined reference to `_einittext'
kernel/built-in.o(.sched.text+0xa82): In function `schedule_timeout':
: undefined reference to `jiffies'
kernel/built-in.o(.sched.text+0xa9a): In function `schedule_timeout':
: undefined reference to `jiffies'
kernel/built-in.o(.sched.text+0xad6): In function `schedule_timeout':
: undefined reference to `jiffies'
kernel/built-in.o(.sched.text+0xb2e): In function `nanosleep_restart':
: undefined reference to `jiffies'
kernel/built-in.o(.sched.text+0xb3e): In function `nanosleep_restart':
: undefined reference to `jiffies'
kernel/built-in.o(.init.text+0x6aa): In function `profile_init':
: undefined reference to `_etext'
kernel/built-in.o(.init.text+0x6ba): In function `profile_init':
: undefined reference to `_etext'
mm/built-in.o(.text+0x3eea): In function `out_of_memory':
: undefined reference to `jiffies'
mm/built-in.o(.text+0x3eee): In function `out_of_memory':
: undefined reference to `jiffies'
mm/built-in.o(.text+0x6162): In function `wb_kupdate':
: undefined reference to `jiffies'
mm/built-in.o(.text+0x61be): In function `wb_kupdate':
: undefined reference to `jiffies'
mm/built-in.o(.text+0x61ca): In function `wb_kupdate':
: undefined reference to `jiffies'
mm/built-in.o(.text+0x622e): more undefined references to `jiffies' follow
drivers/built-in.o(.init.text+0x29a): In function `console_init':
: undefined reference to `__con_initcall_end'
drivers/built-in.o(.init.text+0x29e): In function `console_init':
: undefined reference to `__con_initcall_start'
drivers/built-in.o(.init.text+0x2a2): In function `console_init':
: undefined reference to `__con_initcall_end'
drivers/built-in.o(.init.text+0x2a6): In function `console_init':
: undefined reference to `__con_initcall_start'
drivers/built-in.o(.init.text+0xeb2): In function `con_init':
: undefined reference to `jiffies'
drivers/built-in.o(.init.text+0xeba): In function `con_init':
: undefined reference to `jiffies'
arch/ppc/8260_io/built-in.o(.text+0x656): In function `rs_8xx_interrupt':
: undefined reference to `jiffies'
arch/ppc/8260_io/built-in.o(.text+0x65e): In function `rs_8xx_interrupt':
: undefined reference to `jiffies'
arch/ppc/8260_io/built-in.o(.text+0x1cce): In function
`rs_8xx_wait_until_sent':

: undefined reference to `jiffies'
arch/ppc/8260_io/built-in.o(.text+0x1cd2): more undefined references to
`jiffies
' follow
make: *** [.tmp_vmlinux1] Error 1

