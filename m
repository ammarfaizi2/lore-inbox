Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161031AbWI1GSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161031AbWI1GSv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 02:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161034AbWI1GSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 02:18:51 -0400
Received: from www.osadl.org ([213.239.205.134]:62687 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161031AbWI1GSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 02:18:50 -0400
Date: Thu, 28 Sep 2006 08:18:47 +0200
From: Jan Altenberg <tb10alj@tglx.de>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove trailing whitespaces in 2.6.18-rt4
Message-ID: <20060928061847.GB5091@tb10alj3.homag.com>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recognized some trailing whitespaces in lines inserted by the -rt
patch:

- Remove trailing whitespaces from 2.6.18-rt4


Signed-off-by: Jan Altenberg <tb10alj@tglx.de>

----------------------

diff -uprN -X linux-2.6.18-rt4/Documentation/dontdiff linux-2.6.18-rt4/arch/arm/mach-ixp4xx/common.c linux-2.6.18-rt4-whitespace-fixes/arch/arm/mach-ixp4xx/common.c
--- linux-2.6.18-rt4/arch/arm/mach-ixp4xx/common.c	2006-09-28 07:29:10.000000000 +0200
+++ linux-2.6.18-rt4-whitespace-fixes/arch/arm/mach-ixp4xx/common.c	2006-09-28 07:13:23.000000000 +0200
@@ -396,7 +396,7 @@ device_initcall(ixp4xx_clocksource_init)
 #ifdef CONFIG_HIGH_RES_TIMERS
 static u32 clockevent_mode = 0;
 
-static void ixp4xx_set_next_event(unsigned long evt, 
+static void ixp4xx_set_next_event(unsigned long evt,
 				  struct clock_event *unused)
 {
 	u32 oneshot = (clockevent_mode == CLOCK_EVT_ONESHOT) ?
@@ -413,7 +413,7 @@ static void ixp4xx_set_mode(int mode, st
 
 static struct clock_event clockevent_ixp4xx = {
 	.name		= "ixp4xx timer1",
-	.capabilities	= CLOCK_CAP_NEXTEVT | CLOCK_CAP_TICK | 
+	.capabilities	= CLOCK_CAP_NEXTEVT | CLOCK_CAP_TICK |
 			  CLOCK_CAP_UPDATE | CLOCK_CAP_PROFILE,
 	.shift		= 32,
 	.set_mode	= ixp4xx_set_mode,
diff -uprN -X linux-2.6.18-rt4/Documentation/dontdiff linux-2.6.18-rt4/arch/ia64/kernel/entry.S linux-2.6.18-rt4-whitespace-fixes/arch/ia64/kernel/entry.S
--- linux-2.6.18-rt4/arch/ia64/kernel/entry.S	2006-09-28 07:29:11.000000000 +0200
+++ linux-2.6.18-rt4-whitespace-fixes/arch/ia64/kernel/entry.S	2006-09-28 07:15:09.000000000 +0200
@@ -1113,7 +1113,7 @@ skip_rbs_switch:
 	ssm psr.i		// enable interrupts
 	br.call.spnt.many rp=schedule
 .ret9a:	rsm psr.i		// disable interrupts
-	;; 
+	;;
 	br.cond.sptk.many .endpreemptdep
 .fromkernel:
 	br.call.spnt.many rp=preempt_schedule_irq
diff -uprN -X linux-2.6.18-rt4/Documentation/dontdiff linux-2.6.18-rt4/arch/ia64/kernel/fsys.S linux-2.6.18-rt4-whitespace-fixes/arch/ia64/kernel/fsys.S
--- linux-2.6.18-rt4/arch/ia64/kernel/fsys.S	2006-09-28 07:29:11.000000000 +0200
+++ linux-2.6.18-rt4-whitespace-fixes/arch/ia64/kernel/fsys.S	2006-09-28 07:17:05.000000000 +0200
@@ -219,7 +219,7 @@ ENTRY(fsys_gettimeofday)
 (p6)    br.cond.spnt.few .fail_einval	// deferred branch
 	;;
 	ld8 r30 = [r10]		// clocksource->mmio_ptr
-	movl r19 = itc_lastcycle 
+	movl r19 = itc_lastcycle
 	add r23 = IA64_CLOCKSOURCE_SHIFT_OFFSET,r20
 	cmp.ne p6, p0 = 0, r2	// Fallback if work is scheduled
 (p6)    br.cond.spnt.many fsys_fallback_syscall
diff -uprN -X linux-2.6.18-rt4/Documentation/dontdiff linux-2.6.18-rt4/arch/mips/kernel/time.c linux-2.6.18-rt4-whitespace-fixes/arch/mips/kernel/time.c
--- linux-2.6.18-rt4/arch/mips/kernel/time.c	2006-09-28 07:29:11.000000000 +0200
+++ linux-2.6.18-rt4-whitespace-fixes/arch/mips/kernel/time.c	2006-09-28 07:19:15.000000000 +0200
@@ -12,9 +12,9 @@
  * option) any later version.
  *
  * This implementation of High Res Timers uses two timers. One is the system
- * timer. The second is used for the high res timers. The high res timers 
+ * timer. The second is used for the high res timers. The high res timers
  * require the CPU to have count/compare registers. The mips_set_next_event()
- * function schedules the next high res timer interrupt. 
+ * function schedules the next high res timer interrupt.
  */
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -754,7 +754,7 @@ void __init time_init(void)
 
 #ifdef CONFIG_HIGH_RES_TIMERS
 		hrt_cycles_per_jiffy = ( (CONFIG_CPU_SPEED * 1000000) + HZ / 2) / HZ;
-#else 
+#else
 		hrt_cycles_per_jiffy = cycles_per_jiffy;
 #endif
 
@@ -921,7 +921,7 @@ static void sync_c0_count_slave(void *in
 	unsigned long flags;
 	u32 diff_count; /* CPU count registers are 32-bit */
 	local_irq_save(flags);
-        
+
 	for(loop = 0; loop <= LOOPS; loop++) {
 		/* Sync with the Master processor */
 		sync_cpus_slave(cpus++);
diff -uprN -X linux-2.6.18-rt4/Documentation/dontdiff linux-2.6.18-rt4/include/asm-mips/atomic.h linux-2.6.18-rt4-whitespace-fixes/include/asm-mips/atomic.h
--- linux-2.6.18-rt4/include/asm-mips/atomic.h	2006-09-28 07:29:11.000000000 +0200
+++ linux-2.6.18-rt4-whitespace-fixes/include/asm-mips/atomic.h	2006-09-28 07:21:09.000000000 +0200
@@ -657,7 +657,7 @@ static __inline__ long atomic64_sub_if_p
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
-	} 
+	}
 #if !defined(CONFIG_NO_SPINLOCK) && !defined(CONFIG_PREEMPT_RT)
 	else {
 		unsigned long flags;
diff -uprN -X linux-2.6.18-rt4/Documentation/dontdiff linux-2.6.18-rt4/kernel/timer.c linux-2.6.18-rt4-whitespace-fixes/kernel/timer.c
--- linux-2.6.18-rt4/kernel/timer.c	2006-09-28 07:29:11.000000000 +0200
+++ linux-2.6.18-rt4-whitespace-fixes/kernel/timer.c	2006-09-28 07:23:03.000000000 +0200
@@ -690,9 +690,9 @@ unsigned long next_timer_interrupt(void)
 
 /******************************************************************/
 
-/* 
- * The current time 
- * wall_to_monotonic is what we need to add to xtime (or xtime corrected 
+/*
+ * The current time
+ * wall_to_monotonic is what we need to add to xtime (or xtime corrected
  * for sub jiffie times) to get to monotonic time.  Monotonic is pegged
  * at zero at system boot time, so wall_to_monotonic will be negative,
  * however, we will ALWAYS keep the tv_nsec part positive so we can use
