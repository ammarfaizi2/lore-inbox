Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262795AbSJWDPB>; Tue, 22 Oct 2002 23:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262799AbSJWDPB>; Tue, 22 Oct 2002 23:15:01 -0400
Received: from ma-northadams1b-3.bur.adelphia.net ([24.52.166.3]:2947 "EHLO
	ma-northadams1b-3.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S262795AbSJWDO7>; Tue, 22 Oct 2002 23:14:59 -0400
Date: Tue, 22 Oct 2002 23:21:04 -0400
From: Eric Buddington <eric@ma-northadams1b-3.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.44-ac1 link failure
Message-ID: <20021022232104.D333@ma-northadams1b-3.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the end of output from "make bzImage" with almost everything
configured as modules. Athlon UP system, gcc 3.2, .config available if
needed.

This may be useful since it complained of smp_* symbols below.

bash-2.04$ grep SMP .config
# CONFIG_SMP is not set
CONFIG_X86_FIND_SMP_CONFIG=y

-Eric

-----------------------------
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-voyager/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
arch/i386/kernel/built-in.o: In function `vic_sys_interrupt':
arch/i386/kernel/built-in.o(.text+0x2d65): undefined reference to `smp_vic_sys_interrupt'
arch/i386/kernel/built-in.o: In function `vic_cmn_interrupt':
arch/i386/kernel/built-in.o(.text+0x2d89): undefined reference to `smp_vic_cmn_interrupt'
arch/i386/kernel/built-in.o: In function `vic_cpi_interrupt':
arch/i386/kernel/built-in.o(.text+0x2dad): undefined reference to `smp_vic_cpi_interrupt'
arch/i386/kernel/built-in.o: In function `qic_timer_interrupt':
arch/i386/kernel/built-in.o(.text+0x2dd1): undefined reference to `smp_qic_timer_interrupt'
arch/i386/kernel/built-in.o: In function `qic_invalidate_interrupt':
arch/i386/kernel/built-in.o(.text+0x2df5): undefined reference to `smp_qic_invalidate_interrupt'
arch/i386/kernel/built-in.o: In function `qic_reschedule_interrupt':
arch/i386/kernel/built-in.o(.text+0x2e19): undefined reference to `smp_qic_reschedule_interrupt'
arch/i386/kernel/built-in.o: In function `qic_enable_irq_interrupt':
arch/i386/kernel/built-in.o(.text+0x2e3d): undefined reference to `smp_qic_enable_irq_interrupt'
arch/i386/kernel/built-in.o: In function `qic_call_function_interrupt':
arch/i386/kernel/built-in.o(.text+0x2e61): undefined reference to `smp_qic_call_function_interrupt'
arch/i386/kernel/built-in.o: In function `setup_memory':
arch/i386/kernel/built-in.o(.init.text+0x1160): undefined reference to `find_smp_config'
arch/i386/kernel/built-in.o(__ksymtab+0x10): undefined reference to `machine_real_restart'
arch/i386/mach-voyager/built-in.o: In function `voyager_power_off':
arch/i386/mach-voyager/built-in.o(.text+0x1cd): undefined reference to `voyager_cat_power_off'
arch/i386/mach-voyager/built-in.o: In function `check_from_kernel':
arch/i386/mach-voyager/built-in.o(.text+0x436): undefined reference to `voyager_status'
arch/i386/mach-voyager/built-in.o: In function `check_continuing_condition':
arch/i386/mach-voyager/built-in.o(.text+0x475): undefined reference to `voyager_status'
arch/i386/mach-voyager/built-in.o(.text+0x498): undefined reference to `voyager_cat_psi'
arch/i386/mach-voyager/built-in.o: In function `thread':
arch/i386/mach-voyager/built-in.o(.text+0x592): undefined reference to `voyager_status'
arch/i386/mach-voyager/built-in.o(.text+0x5d6): undefined reference to `voyager_status'
fs/built-in.o: In function `keyed_hash':
fs/built-in.o(.text+0x7d971): undefined reference to `BUG'
fs/built-in.o(.text+0x7da17): undefined reference to `BUG'
fs/built-in.o(.text+0x7da96): undefined reference to `BUG'
net/built-in.o: In function `p8022_request':
net/built-in.o(.text+0x12f26): undefined reference to `llc_build_and_send_ui_pkt'
net/built-in.o: In function `register_8022_client':
net/built-in.o(.text+0x12f7d): undefined reference to `llc_sap_open'
net/built-in.o: In function `unregister_8022_client':
net/built-in.o(.text+0x12fc2): undefined reference to `llc_sap_close'
net/built-in.o: In function `snap_request':
net/built-in.o(.text+0x1314f): undefined reference to `llc_build_and_send_ui_pkt'
net/built-in.o: In function `snap_init':
net/built-in.o(.init.text+0x713): undefined reference to `llc_sap_open'
make: *** [.tmp_vmlinux1] Error 1
