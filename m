Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317603AbSGUAZI>; Sat, 20 Jul 2002 20:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317604AbSGUAZI>; Sat, 20 Jul 2002 20:25:08 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:61700 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S317603AbSGUAZH>; Sat, 20 Jul 2002 20:25:07 -0400
Subject: 2.5.27 -- memory.c:50:22: asm/rmap.h: No such file or directory
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1027211240.1864.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 20 Jul 2002 20:27:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  gcc -Wp,-MD,./.memory.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=memory   -c -o memory.o memory.c
memory.c:50:22: asm/rmap.h: No such file or directory
memory.c: In function `free_one_pmd':
memory.c:95: warning: implicit declaration of function `pgtable_remove_rmap'
memory.c: In function `pte_alloc_map':
memory.c:156: warning: implicit declaration of function `pgtable_add_rmap'
make[2]: *** [memory.o] Error 1

I ran "make mrproper", copied in my .config and then ran:

    make oldconfig dep all install modules modules_install

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y

CONFIG_MODULES=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_MPENTIUM4=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_SMP=y
CONFIG_TOSHIBA=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

# ACPI Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_TOSHIBA=y
CONFIG_ACPI_DEBUG=y
CONFIG_PM=y

# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y

Let me know if you need more information.

	Miles

