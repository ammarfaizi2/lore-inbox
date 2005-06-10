Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262533AbVFJJvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262533AbVFJJvM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 05:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbVFJJvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 05:51:12 -0400
Received: from mail1003.centrum.cz ([213.29.7.172]:44161 "EHLO
	mail1003.centrum.cz") by vger.kernel.org with ESMTP id S262533AbVFJJvD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 05:51:03 -0400
Date: Fri, 10 Jun 2005 11:50:59 +0200
From: "Milan Svoboda" <milan.svoboda@centrum.cz>
To: <xschmi00@stud.feec.vutbr.cz>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
X-Mailer: Centrum Mail 1.0
MIME-Version: 1.0
X-Priority: 3
Message-ID: <200506101150.6364@centrum.cz>
Subject: Re: bug in Real-Time Preemption
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Milan Svoboda wrote:
> > under non RT preempt:
> > (these results are expected)
> > > ./a.out
> > Flag: 0, Dif:11714
> > ./a.out
> > Flag: 0, Dif:11678
> > > under full RT preempt:
> > ./a.out
> > Flag: 1, Dif:582536
> > ./a.out
> > Flag: 1, Dif:579791
> > > This shows that thread with bigger priority was
> > blocked by the thread with lower priority!
> 
> Can you retry with RT-V0.7.48-05 and this patch applied?
> 
> Michal
> 

I didn't help. Results are the same.

./a.out
Flag: 1, Dif: 598910

uname -a
Linux 2.6.12-rc6-RT-V0.7.48-05 #4 Fri Jun 10 11:26:38 CEST 2005 i686 i686 i386 GNU/Linux


BTW: I cannot compile this version with RT disabled:

-rc6-RT-V0.7.48-05

  CC      lib/radix-tree.o
  CC      lib/rbtree.o
  CC      lib/rwsem.o
lib/rwsem.c: In function `__rwsem_do_wake':
lib/rwsem.c:57: warning: implicit declaration of function `rwsem_atomic_update'
lib/rwsem.c:57: error: `RWSEM_ACTIVE_BIAS' undeclared (first use in this function)
lib/rwsem.c:57: error: (Each undeclared identifier is reported only once
lib/rwsem.c:57: error: for each function it appears in.)
lib/rwsem.c:59: error: `RWSEM_ACTIVE_MASK' undeclared (first use in this function)
lib/rwsem.c:62: error: structure has no member named `wait_list'
lib/rwsem.c:85: error: structure has no member named `wait_list'
lib/rwsem.c:99: error: structure has no member named `wait_list'
lib/rwsem.c:108: error: `RWSEM_WAITING_BIAS' undeclared (first use in this function)
lib/rwsem.c:113: warning: implicit declaration of function `rwsem_atomic_add'
lib/rwsem.c:115: error: structure has no member named `wait_list'
lib/rwsem.c:126: error: structure has no member named `wait_list'
lib/rwsem.c:127: error: structure has no member named `wait_list'
lib/rwsem.c: In function `rwsem_down_failed_common':
lib/rwsem.c:153: error: structure has no member named `wait_lock'
lib/rwsem.c:153: warning: type defaults to `int' in declaration of `type name'
lib/rwsem.c:153: error: structure has no member named `wait_lock'
lib/rwsem.c:153: error: structure has no member named `wait_lock'
lib/rwsem.c:153: warning: type defaults to `int' in declaration of `type name'
lib/rwsem.c:153: error: structure has no member named `wait_lock'
lib/rwsem.c:157: error: structure has no member named `wait_list'
lib/rwsem.c:163: error: `RWSEM_ACTIVE_MASK' undeclared (first use in this function)
lib/rwsem.c:166: error: structure has no member named `wait_lock'
lib/rwsem.c:166: warning: type defaults to `int' in declaration of `type name'
lib/rwsem.c:166: error: structure has no member named `wait_lock'
lib/rwsem.c:166: error: structure has no member named `wait_lock'
lib/rwsem.c:166: warning: type defaults to `int' in declaration of `type name'
lib/rwsem.c:166: error: structure has no member named `wait_lock'
lib/rwsem.c: In function `rwsem_down_read_failed':
lib/rwsem.c:193: error: `RWSEM_WAITING_BIAS' undeclared (first use in this function)
lib/rwsem.c:193: error: `RWSEM_ACTIVE_BIAS' undeclared (first use in this function)
lib/rwsem.c: In function `rwsem_down_write_failed':
lib/rwsem.c:210: error: `RWSEM_ACTIVE_BIAS' undeclared (first use in this function)
lib/rwsem.c: In function `rwsem_wake':
lib/rwsem.c:226: error: structure has no member named `wait_lock'
lib/rwsem.c:226: warning: type defaults to `int' in declaration of `type name'
lib/rwsem.c:226: error: structure has no member named `wait_lock'
lib/rwsem.c:226: error: structure has no member named `wait_lock'
lib/rwsem.c:226: warning: type defaults to `int' in declaration of `type name'
lib/rwsem.c:226: error: structure has no member named `wait_lock'
lib/rwsem.c:229: error: structure has no member named `wait_list'
lib/rwsem.c:232: error: structure has no member named `wait_lock'
lib/rwsem.c:232: warning: type defaults to `int' in declaration of `type name'
lib/rwsem.c:232: error: structure has no member named `wait_lock'
lib/rwsem.c:232: error: structure has no member named `wait_lock'
lib/rwsem.c:232: warning: type defaults to `int' in declaration of `type name'
lib/rwsem.c:232: error: structure has no member named `wait_lock'
lib/rwsem.c: In function `rwsem_downgrade_wake':
lib/rwsem.c:250: error: structure has no member named `wait_lock'
lib/rwsem.c:250: warning: type defaults to `int' in declaration of `type name'
lib/rwsem.c:250: error: structure has no member named `wait_lock'
lib/rwsem.c:250: error: structure has no member named `wait_lock'
lib/rwsem.c:250: warning: type defaults to `int' in declaration of `type name'
lib/rwsem.c:250: error: structure has no member named `wait_lock'
lib/rwsem.c:253: error: structure has no member named `wait_list'
lib/rwsem.c:256: error: structure has no member named `wait_lock'
lib/rwsem.c:256: warning: type defaults to `int' in declaration of `type name'
lib/rwsem.c:256: error: structure has no member named `wait_lock'
lib/rwsem.c:256: error: structure has no member named `wait_lock'
lib/rwsem.c:256: warning: type defaults to `int' in declaration of `type name'
lib/rwsem.c:256: error: structure has no member named `wait_lock'
make[1]: *** [lib/rwsem.o] Error 1

Relevant .config:

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_SMP is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT_DESKTOP is not set
# CONFIG_PREEMPT_RT is not set
# CONFIG_PREEMPT_SOFTIRQS is not set
# CONFIG_PREEMPT_HARDIRQS is not set
# CONFIG_PREEMPT_BKL is not set
CONFIG_ASM_SEMAPHORES=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=m

