Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267310AbTBFOZ0>; Thu, 6 Feb 2003 09:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267312AbTBFOZ0>; Thu, 6 Feb 2003 09:25:26 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:10738 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267310AbTBFOZZ>;
	Thu, 6 Feb 2003 09:25:25 -0500
Subject: Compile failure in last night's automated test
From: Paul Larson <plars@linuxtestproject.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 06 Feb 2003 08:30:28 -0600
Message-Id: <1044541829.10047.145.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last night's automated bk pull/ltp run got a compile failure:




        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s
arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o
--start-group  usr/built-in.o  arch/i386/kernel/built-in.o 
arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o 
kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o 
security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a 
drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o 
net/built-in.o --end-group  -o .tmp_vmlinux1
drivers/built-in.o: In function `acpi_processor_apply_limit':
drivers/built-in.o(.text+0x34df2): undefined reference to
`cpufreq_get_policy'
drivers/built-in.o(.text+0x34e32): undefined reference to
`cpufreq_set_policy'
make: *** [.tmp_vmlinux1] Error 1

