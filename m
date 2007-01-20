Return-Path: <linux-kernel-owner+w=401wt.eu-S965369AbXATUlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965369AbXATUlI (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 15:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965379AbXATUlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 15:41:08 -0500
Received: from stephens.ittc.ku.edu ([129.237.125.220]:47230 "EHLO
	stephens.ittc.ku.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965369AbXATUlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 15:41:06 -0500
From: Noah Watkins <nwatkins@ittc.ku.edu>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, Noah Watkins <nwatkins@ittc.ku.edu>
Subject: [PATCH -rt] whitespace cleanup for 2.6.20-rc5-rt7
Date: Sat, 20 Jan 2007 14:40:38 -0600
Message-Id: <11693256381932-git-send-email-nwatkins@ittc.ku.edu>
X-Mailer: git-send-email 1.4.4.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (stephens.ittc.ku.edu [129.237.125.220]); Sat, 20 Jan 2007 14:40:46 -0600 (CST)
X-VirusScan: Clean
X-MailScanner-From: nwatkins@ittc.ku.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fixes trailing whitespace and spaces before tab indents in 2.6.20-rc5-rt7 as
reported with: git-apply --whitespace=error-all

---

 arch/arm/mach-omap1/time.c        |    2 +-
 arch/i386/kernel/entry.S          |    2 +-
 arch/i386/kernel/reboot.c         |    2 +-
 arch/ia64/Kconfig                 |    4 ++--
 arch/ia64/kernel/fsys.S           |    2 +-
 arch/ia64/kernel/time.c           |    4 ++--
 arch/x86_64/kernel/entry.S        |    2 +-
 arch/x86_64/kernel/hpet.c         |    2 +-
 arch/x86_64/kernel/reboot.c       |    2 +-
 arch/x86_64/kernel/smpboot.c      |    8 ++++----
 arch/x86_64/kernel/tsc.c          |    8 ++++----
 arch/x86_64/kernel/vsyscall.c     |    2 +-
 drivers/char/lpptest.c            |    2 +-
 include/asm-arm/atomic.h          |    2 +-
 include/asm-generic/vmlinux.lds.h |    4 ++--
 include/linux/irq.h               |    6 +++---
 include/linux/mutex.h             |    2 +-
 kernel/fork.c                     |    6 +++---
 kernel/futex.c                    |    4 ++--
 kernel/hrtimer.c                  |    2 +-
 kernel/latency_trace.c            |    6 +++---
 kernel/spinlock.c                 |    2 +-
 kernel/workqueue.c                |    2 +-
 mm/migrate.c                      |    2 +-
 mm/slab.c                         |   14 +++++++-------
 25 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index 7baf0df..85f9f5e 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -105,7 +105,7 @@ static inline unsigned long omap_mpu_tim
 
 static inline void omap_mpu_set_autoreset(int nr)
 {
- 	volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
+	volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
 
 	timer->cntl = timer->cntl | MPU_TIMER_AR;
 }
diff --git a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
index ce8a092..33d6b80 100644
--- a/arch/i386/kernel/entry.S
+++ b/arch/i386/kernel/entry.S
@@ -272,7 +272,7 @@ need_resched:
 	jz restore_nocheck
 	testl $IF_MASK,PT_EFLAGS(%esp)	# interrupts off (exception path) ?
 	jz restore_nocheck
- 	DISABLE_INTERRUPTS(CLBR_ANY)
+	DISABLE_INTERRUPTS(CLBR_ANY)
 
 	call preempt_schedule_irq
 	jmp need_resched
diff --git a/arch/i386/kernel/reboot.c b/arch/i386/kernel/reboot.c
index 5f81e80..a3e7410 100644
--- a/arch/i386/kernel/reboot.c
+++ b/arch/i386/kernel/reboot.c
@@ -327,7 +327,7 @@ void machine_emergency_restart(void)
 		asm volatile (
 			"1: .byte 0x0f, 0x01, 0xc4	\n" /* vmxoff */
 			"2:				\n"
- 			".section __ex_table,\"a\"	\n"
+			".section __ex_table,\"a\"	\n"
 			"   .align 4			\n"
 			"   .long 	1b,2b		\n"
 			".previous			\n"
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 333049c..a1a6bc3 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -300,7 +300,7 @@ config HIGH_RES_RESOLUTION
 choice
 	prompt "Clock source"
 	depends on HIGH_RES_TIMERS
- 	default HIGH_RES_TIMER_ITC
+	default HIGH_RES_TIMER_ITC
 	help
 	  This option allows you to choose the hardware source in charge
 	  of generating high precision interruptions on your system.
@@ -308,7 +308,7 @@ choice
 
 	  <timer>				<resolution>
 	  ITC Interval Time Counter		1/CPU clock
-  	  HPET High Precision Event Timer	~ (XXX:have to check the spec)
+	  HPET High Precision Event Timer	~ (XXX:have to check the spec)
 
 	  The ITC timer is available on all the ia64 computers because
 	  it is integrated directly into the processor. However it may not
diff --git a/arch/ia64/kernel/fsys.S b/arch/ia64/kernel/fsys.S
index 7b94c34..2abf920 100644
--- a/arch/ia64/kernel/fsys.S
+++ b/arch/ia64/kernel/fsys.S
@@ -219,7 +219,7 @@ ENTRY(fsys_gettimeofday)
 (p6)    br.cond.spnt.few .fail_einval	// deferred branch
 	;;
 	ld8 r30 = [r10]		// clocksource->mmio_ptr
-	movl r19 = itc_lastcycle 
+	movl r19 = itc_lastcycle
 	add r23 = IA64_CLOCKSOURCE_SHIFT_OFFSET,r20
 	cmp.ne p6, p0 = 0, r2	// Fallback if work is scheduled
 (p6)    br.cond.spnt.many fsys_fallback_syscall
diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index 983ef26..4fc3670 100644
--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -262,10 +262,10 @@ ia64_init_itm (void)
 	ia64_cpu_local_tick();
 
 	if (!clocksource_itc_p) {
-        	/* Sort out mult/shift values: */
+		/* Sort out mult/shift values: */
 		clocksource_itc.mult = clocksource_hz2mult(local_cpu_data->itc_freq,
 						   clocksource_itc.shift);
-        	clocksource_register(&clocksource_itc);
+		clocksource_register(&clocksource_itc);
 		clocksource_itc_p = &clocksource_itc;
 	}
 }
diff --git a/arch/x86_64/kernel/entry.S b/arch/x86_64/kernel/entry.S
index fb0dace..75f2626 100644
--- a/arch/x86_64/kernel/entry.S
+++ b/arch/x86_64/kernel/entry.S
@@ -361,7 +361,7 @@ tracesys:
 	movq %r10,%rcx	/* fixup for C */
 	TRACE_SYS_CALL
 	call *sys_call_table(,%rax,8)
- 	TRACE_SYS_RET
+	TRACE_SYS_RET
 1:	movq %rax,RAX-ARGOFFSET(%rsp)
 	/* Use IRET because user could have changed frame */
 		
diff --git a/arch/x86_64/kernel/hpet.c b/arch/x86_64/kernel/hpet.c
index 9edc2e4..8ae86ff 100644
--- a/arch/x86_64/kernel/hpet.c
+++ b/arch/x86_64/kernel/hpet.c
@@ -63,7 +63,7 @@ static __init int late_hpet_init(void)
 	unsigned int 		ntimer;
 
 	if (!hpet_address)
-        	return 0;
+		return 0;
 
 	memset(&hd, 0, sizeof (hd));
 
diff --git a/arch/x86_64/kernel/reboot.c b/arch/x86_64/kernel/reboot.c
index dda0b88..36bad04 100644
--- a/arch/x86_64/kernel/reboot.c
+++ b/arch/x86_64/kernel/reboot.c
@@ -124,7 +124,7 @@ void machine_emergency_restart(void)
 		asm volatile (
 			"1: .byte 0x0f, 0x01, 0xc4	\n" /* vmxoff */
 			"2:				\n"
- 			".section __ex_table,\"a\"	\n"
+			".section __ex_table,\"a\"	\n"
 			"   .align 8			\n"
 			"   .quad 	1b,2b		\n"
 			".previous			\n"
diff --git a/arch/x86_64/kernel/smpboot.c b/arch/x86_64/kernel/smpboot.c
index f2c0475..8551845 100644
--- a/arch/x86_64/kernel/smpboot.c
+++ b/arch/x86_64/kernel/smpboot.c
@@ -335,8 +335,8 @@ void __cpuinit notrace start_secondary(v
 	barrier();
 
 	/*
-  	 * Check TSC sync first:
- 	 */
+	 * Check TSC sync first:
+	 */
 	check_tsc_sync_target();
 
 	Dprintk("cpu %d: setting up apic clock\n", smp_processor_id()); 	
@@ -954,8 +954,8 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	Dprintk("waiting for cpu %d\n", cpu);
 
 	/*
-  	 * Make sure and check TSC sync:
- 	 */
+	 * Make sure and check TSC sync:
+	 */
 	check_tsc_sync_source(cpu);
 
 	while (!cpu_isset(cpu, cpu_online_map))
diff --git a/arch/x86_64/kernel/tsc.c b/arch/x86_64/kernel/tsc.c
index ef2ec93..655d170 100644
--- a/arch/x86_64/kernel/tsc.c
+++ b/arch/x86_64/kernel/tsc.c
@@ -157,17 +157,17 @@ __cpuinit int unsynchronized_tsc(void)
 #endif
 	/* Most intel systems have synchronized TSCs except for
 	   multi node systems */
- 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
 #ifdef CONFIG_ACPI
 		/* But TSC doesn't tick in C3 so don't use it there */
 		if (acpi_fadt.length > 0 && acpi_fadt.plvl3_lat < 100)
 			return 1;
 #endif
- 		return 0;
+		return 0;
 	}
 
- 	/* Assume multi socket systems are not synchronized */
- 	return num_present_cpus() > 1;
+	/* Assume multi socket systems are not synchronized */
+	return num_present_cpus() > 1;
 }
 
 int __init notsc_setup(char *s)
diff --git a/arch/x86_64/kernel/vsyscall.c b/arch/x86_64/kernel/vsyscall.c
index b681eee..ed7c882 100644
--- a/arch/x86_64/kernel/vsyscall.c
+++ b/arch/x86_64/kernel/vsyscall.c
@@ -73,7 +73,7 @@ void update_vsyscall(struct timespec* wa
 	vsyscall_gtod_data.wall_time_tv.tv_usec = wall_time->tv_nsec/1000;
 	vsyscall_gtod_data.sys_tz = sys_tz;
 
- 	if (cpu_has(&boot_cpu_data, X86_FEATURE_RDTSCP))
+	if (cpu_has(&boot_cpu_data, X86_FEATURE_RDTSCP))
 		vsyscall_gtod_data.vgetcpu_mode = VGETCPU_RDTSCP;
 	else
 		vsyscall_gtod_data.vgetcpu_mode = VGETCPU_LSL;
diff --git a/drivers/char/lpptest.c b/drivers/char/lpptest.c
index 02765fe..0c9116b 100644
--- a/drivers/char/lpptest.c
+++ b/drivers/char/lpptest.c
@@ -78,7 +78,7 @@ static cycles_t test_response(void)
 	outb(0x08, 0x378);
 	now = get_cycles();
 	while(1) {
-    		if (inb(0x379) != in)
+		if (inb(0x379) != in)
 			break;
 		if (timeout++ > 1000000) {
 			outb(0x00, 0x378);
diff --git a/include/asm-arm/atomic.h b/include/asm-arm/atomic.h
index e21494d..9846347 100644
--- a/include/asm-arm/atomic.h
+++ b/include/asm-arm/atomic.h
@@ -242,7 +242,7 @@ static inline unsigned long __cmpxchg(vo
      __typeof__(*(ptr)) _o_ = (o);					\
      __typeof__(*(ptr)) _n_ = (n);					\
      (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,		\
-			   	 (unsigned long)_n_, sizeof(*(ptr)));	\
+				(unsigned long)_n_, sizeof(*(ptr)));	\
 })
 
 #endif
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 4c595cb..8ebba62 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -167,7 +167,7 @@
 #define EH_FRAME							\
 		/* Unwind data binary search table */			\
 		. = ALIGN(8);						\
-        	.eh_frame_hdr : AT(ADDR(.eh_frame_hdr) - LOAD_OFFSET) {	\
+		.eh_frame_hdr : AT(ADDR(.eh_frame_hdr) - LOAD_OFFSET) {	\
 			VMLINUX_SYMBOL(__start_unwind_hdr) = .;		\
 			*(.eh_frame_hdr)				\
 			VMLINUX_SYMBOL(__end_unwind_hdr) = .;		\
@@ -176,7 +176,7 @@
 		. = ALIGN(8);						\
 		.eh_frame : AT(ADDR(.eh_frame) - LOAD_OFFSET) {		\
 			VMLINUX_SYMBOL(__start_unwind) = .;		\
-		  	*(.eh_frame)					\
+			*(.eh_frame)					\
 			VMLINUX_SYMBOL(__end_unwind) = .;		\
 		}
 #else
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 28f049a..0f3bc01 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -161,9 +161,9 @@ struct irq_desc {
 	unsigned int		wake_depth;	/* nested wake enables */
 	unsigned int		irq_count;	/* For detecting broken IRQs */
 	unsigned int		irqs_unhandled;
- 	struct task_struct	*thread;
- 	wait_queue_head_t	wait_for_handler;
- 	cycles_t		timestamp;
+	struct task_struct	*thread;
+	wait_queue_head_t	wait_for_handler;
+	cycles_t		timestamp;
 	raw_spinlock_t		lock;
 #ifdef CONFIG_SMP
 	cpumask_t		affinity;
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 7a5d1fe..25d9df8 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -30,7 +30,7 @@ struct mutex {
 };
 
 #define DEFINE_MUTEX(mutexname) 					\
- 	struct mutex mutexname = { 					\
+	struct mutex mutexname = { 					\
 		.lock = __RT_MUTEX_INITIALIZER(mutexname.lock) 		\
 	}
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 075067e..1630673 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1876,9 +1876,9 @@ static int __devinit cpu_callback(struct
 			printk("desched_thread for %i failed\n", hotcpu);
 			return NOTIFY_BAD;
 		}
-  		per_cpu(desched_task, hotcpu) = p;
+		per_cpu(desched_task, hotcpu) = p;
 		kthread_bind(p, hotcpu);
- 		break;
+		break;
 	case CPU_ONLINE:
 
 		wake_up_process(per_cpu(desched_task, hotcpu));
@@ -1896,7 +1896,7 @@ static int __devinit cpu_callback(struct
 		takeover_tasklets(hotcpu);
 		break;
 #endif /* CONFIG_HOTPLUG_CPU */
- 	}
+	}
 	return NOTIFY_OK;
 }
 
diff --git a/kernel/futex.c b/kernel/futex.c
index b7ca553..9507575 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1358,7 +1358,7 @@ static int fixup_pi_state_owner(u32 __us
 		curval = futex_atomic_cmpxchg_inatomic(uaddr,
 						       uval, newval);
 		if (curval == -EFAULT)
- 			ret = -EFAULT;
+			ret = -EFAULT;
 		if (curval == uval)
 			break;
 		uval = curval;
@@ -2380,7 +2380,7 @@ static int fixup_pi_state_owner64(u64 __
 		curval = futex_atomic_cmpxchg_inatomic64(uaddr,
 							 uval, newval);
 		if (curval == -EFAULT)
- 			ret = -EFAULT;
+			ret = -EFAULT;
 		if (curval == uval)
 			break;
 		uval = curval;
diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index fb7731f..dfa9d0f 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -767,7 +767,7 @@ static enum hrtimer_restart hrtimer_sche
 {
 	struct hrtimer_cpu_base *cpu_base =
 		container_of(timer, struct hrtimer_cpu_base, sched_timer);
- 	struct pt_regs *regs = get_irq_regs();
+	struct pt_regs *regs = get_irq_regs();
 	ktime_t now = ktime_get();
 
 	/* Check, if the jiffies need an update */
diff --git a/kernel/latency_trace.c b/kernel/latency_trace.c
index 936238a..7f6c304 100644
--- a/kernel/latency_trace.c
+++ b/kernel/latency_trace.c
@@ -546,7 +546,7 @@ static void notrace early_print_entry(st
 		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
 		(entry->flags & TRACE_FLAG_IRQS_HARD_OFF) ? 'D' : '.',
 		(entry->flags & TRACE_FLAG_NEED_RESCHED_DELAYED) ? 'n' :
- 		((entry->flags & TRACE_FLAG_NEED_RESCHED) ? 'N' : '.'));
+		((entry->flags & TRACE_FLAG_NEED_RESCHED) ? 'N' : '.'));
 
 	hardirq = entry->flags & TRACE_FLAG_HARDIRQ;
 	softirq = entry->flags & TRACE_FLAG_SOFTIRQ;
@@ -1321,7 +1321,7 @@ print_generic(struct seq_file *m, struct
 		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
 		(entry->flags & TRACE_FLAG_IRQS_HARD_OFF) ? 'D' : '.',
 		(entry->flags & TRACE_FLAG_NEED_RESCHED_DELAYED) ? 'n' :
- 		((entry->flags & TRACE_FLAG_NEED_RESCHED) ? 'N' : '.'));
+		((entry->flags & TRACE_FLAG_NEED_RESCHED) ? 'N' : '.'));
 
 	hardirq = entry->flags & TRACE_FLAG_HARDIRQ;
 	softirq = entry->flags & TRACE_FLAG_SOFTIRQ;
@@ -2483,7 +2483,7 @@ static void print_entry(struct trace_ent
 		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
 		(entry->flags & TRACE_FLAG_IRQS_HARD_OFF) ? 'D' : '.',
 		(entry->flags & TRACE_FLAG_NEED_RESCHED_DELAYED) ? 'n' :
- 		((entry->flags & TRACE_FLAG_NEED_RESCHED) ? 'N' : '.'));
+		((entry->flags & TRACE_FLAG_NEED_RESCHED) ? 'N' : '.'));
 
 	hardirq = entry->flags & TRACE_FLAG_HARDIRQ;
 	softirq = entry->flags & TRACE_FLAG_SOFTIRQ;
diff --git a/kernel/spinlock.c b/kernel/spinlock.c
index 95a4b60..2b0b792 100644
--- a/kernel/spinlock.c
+++ b/kernel/spinlock.c
@@ -252,7 +252,7 @@ void __lockfunc __##op##_lock(locktype##
 		if (!(lock)->break_lock)				\
 			(lock)->break_lock = 1;				\
 		while (!__raw_##op##_can_lock(&(lock)->raw_lock) &&	\
-			       		(lock)->break_lock)		\
+					(lock)->break_lock)		\
 			__raw_##op##_relax(&lock->raw_lock);		\
 	}								\
 	(lock)->break_lock = 0;						\
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b532f38..e685d6d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -309,7 +309,7 @@ static void leak_check(void *func)
 	printk(KERN_ERR "BUG: workqueue leaked lock or atomic: "
 				"%s/0x%08x/%d\n",
 				current->comm, preempt_count(),
-			       	current->pid);
+				current->pid);
 	printk(KERN_ERR "    last function: ");
 	print_symbol("%s\n", (unsigned long)func);
 	debug_show_held_locks(current);
diff --git a/mm/migrate.c b/mm/migrate.c
index e35e95e..7bf090c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -329,7 +329,7 @@ static int migrate_page_move_mapping(str
 
 	radix_tree_replace_slot(pslot, newpage);
 	page->mapping = NULL;
-  	write_unlock_irq(&mapping->tree_lock);
+	write_unlock_irq(&mapping->tree_lock);
 	end_page_no_new_refs(page);
 
 	/*
diff --git a/mm/slab.c b/mm/slab.c
index 038812c..bec4763 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -143,13 +143,13 @@
 # define slab_irq_disable_rt(flags)	do { (void)(flags); } while (0)
 # define slab_irq_enable_rt(flags)	do { (void)(flags); } while (0)
 # define slab_spin_lock_irq(lock, cpu) \
- 	do { spin_lock_irq(lock); (cpu) = smp_processor_id(); } while (0)
+	do { spin_lock_irq(lock); (cpu) = smp_processor_id(); } while (0)
 # define slab_spin_unlock_irq(lock, cpu) \
-				 	spin_unlock_irq(lock)
+					spin_unlock_irq(lock)
 # define slab_spin_lock_irqsave(lock, flags, cpu) \
- 	do { spin_lock_irqsave(lock, flags); (cpu) = smp_processor_id(); } while (0)
+	do { spin_lock_irqsave(lock, flags); (cpu) = smp_processor_id(); } while (0)
 # define slab_spin_unlock_irqrestore(lock, flags, cpu) \
- 	do { spin_unlock_irqrestore(lock, flags); } while (0)
+	do { spin_unlock_irqrestore(lock, flags); } while (0)
 #else
 DEFINE_PER_CPU_LOCKED(int, slab_irq_locks) = { 0, };
 # define slab_irq_disable(cpu)		(void)get_cpu_var_locked(slab_irq_locks, &(cpu))
@@ -167,9 +167,9 @@ DEFINE_PER_CPU_LOCKED(int, slab_irq_lock
 # define slab_spin_unlock_irq(lock, cpu) \
 		do { spin_unlock(lock); slab_irq_enable(cpu); } while (0)
 # define slab_spin_lock_irqsave(lock, flags, cpu) \
- 	do { slab_irq_disable(cpu); spin_lock_irqsave(lock, flags); } while (0)
+	do { slab_irq_disable(cpu); spin_lock_irqsave(lock, flags); } while (0)
 # define slab_spin_unlock_irqrestore(lock, flags, cpu) \
- 	do { spin_unlock_irqrestore(lock, flags); slab_irq_enable(cpu); } while (0)
+	do { spin_unlock_irqrestore(lock, flags); slab_irq_enable(cpu); } while (0)
 #endif
 
 /*
@@ -3335,7 +3335,7 @@ static __always_inline void *__cache_all
 	 * ____cache_alloc_node() knows how to locate memory on other nodes
 	 */
  	if (NUMA_BUILD && !objp)
- 		objp = ____cache_alloc_node(cachep, flags, cpu_to_node(this_cpu), &this_cpu);
+		objp = ____cache_alloc_node(cachep, flags, cpu_to_node(this_cpu), &this_cpu);
 	slab_irq_restore(irqflags, this_cpu);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
 					    caller);
-- 
1.4.4.1

