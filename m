Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278000AbRJIVsD>; Tue, 9 Oct 2001 17:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277999AbRJIVrx>; Tue, 9 Oct 2001 17:47:53 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:53000 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S277993AbRJIVrp>; Tue, 9 Oct 2001 17:47:45 -0400
Subject: 2.4.10-ac10 -- Unresolved symbol __io_virt_debug in sk98lin.o,
	skfp.o, aha152x_cs.o, fdomain_cs.o abd msnd_classic.o.
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99 (Preview Release)
Date: 09 Oct 2001 14:39:41 -0700
Message-Id: <1002663582.3218.7.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I searched the LKML and didn't find this mentioned.

find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.10-ac10; fi
depmod: *** Unresolved symbols in /lib/modules/2.4.10-ac10/kernel/drivers/net/sk98lin/sk98lin.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.10-ac10/kernel/drivers/net/skfp/skfp.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.10-ac10/kernel/drivers/scsi/pcmcia/aha152x_cs.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.10-ac10/kernel/drivers/scsi/pcmcia/fdomain_cs.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.10-ac10/kernel/drivers/sound/msnd_classic.o
depmod: 	__io_virt_debug

Not sure if it is related, but I have #define DEBUG in my arch/i386/kernel/pci-i386.h.

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_TOSHIBA=m
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
CONFIG_MATH_EMULATION=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_BUGVERBOSE=y



