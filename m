Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbUKVIsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbUKVIsI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 03:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUKVIsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 03:48:08 -0500
Received: from apollo.nbase.co.il ([194.90.137.2]:29453 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP id S261986AbUKVIpy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 03:45:54 -0500
Message-ID: <41A1A6E6.5090807@mrv.com>
Date: Mon, 22 Nov 2004 10:44:22 +0200
From: emann@mrv.com (Eran Mann)
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
References: <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu>
In-Reply-To: <20041122005411.GA19363@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------000904090105030606020101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000904090105030606020101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Ingo Molnar wrote:
> i have released the -V0.7.30-2 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 
> 	http://redhat.com/~mingo/realtime-preempt/

Hi,
I´m seeing latencies of up to ~2000 microseconds. see attached traces
file for a small sample. I think I´m missing something obvious
config-wise but I don´t know what...
The ´load´ during the traces consisted of a kernel build in a
gnome-terminal, and 2 browser windows with a heavy site (Flash ads etc.)
in each. This load causes a >1 ms latency every 5 minutes on average.
After the kernel build ended the rate dropped dramatically to ~2 traces
an hour.
The traces were from V-0.7.29-5 but I´ve seen these latencies in all RT
kernels I tested (2.6.9-mm1-RT-V0.2 was the first). I´ll try V0.7.30-2 next.
The machine is a PIII 733 Mhz, 256MB RAM, IDE disks.
I attached the traces and a partial .config.
Relevant items in /proc/sys/kernel:

/proc/sys/kernel/kernel_preemption :
1
...
/proc/sys/kernel/osrelease :
2.6.10-rc2-mm2-V0.7.29-5
...
/proc/sys/kernel/panic :
0
/proc/sys/kernel/panic_on_oops :
0
/proc/sys/kernel/pid_max :
32768
/proc/sys/kernel/preempt_max_latency :
1737
/proc/sys/kernel/preempt_thresh :
1000
/proc/sys/kernel/preempt_wakeup_timing :
1
...
/proc/sys/kernel/real-root-dev :
0
/proc/sys/kernel/sem :
250     32000   32      128
/proc/sys/kernel/shmall :
2097152
/proc/sys/kernel/shmmax :
33554432
/proc/sys/kernel/shmmni :
4096
/proc/sys/kernel/sysrq :
1
/proc/sys/kernel/tainted :
0
/proc/sys/kernel/threads-max :
4095
/proc/sys/kernel/trace_enabled :
1
/proc/sys/kernel/trace_freerunning :
0
/proc/sys/kernel/trace_print_at_crash :
1
/proc/sys/kernel/trace_user_triggered :
0
/proc/sys/kernel/trace_verbose :
0
/proc/sys/kernel/unknown_nmi_panic :
0

Let me know if some more information is required.
Thank,
      Eran Mann


--------------000904090105030606020101
Content-Type: text/plain;
 name="config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config"

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
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
CONFIG_MPENTIUMIII=y
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
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT_DESKTOP is not set
CONFIG_PREEMPT_RT=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_SOFTIRQS=y
CONFIG_PREEMPT_HARDIRQS=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=y
......
CONFIG_HW_RANDOM=m
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_RTC_HISTOGRAM=m
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
......
#
# Profiling support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=m

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_PREEMPT is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
CONFIG_WAKEUP_TIMING=y
CONFIG_CRITICAL_PREEMPT_TIMING=y
CONFIG_CRITICAL_IRQSOFF_TIMING=y
CONFIG_CRITICAL_TIMING=y
CONFIG_LATENCY_TIMING=y
CONFIG_LATENCY_TRACE=y
CONFIG_MCOUNT=y
CONFIG_RT_DEADLOCK_DETECT=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
CONFIG_FRAME_POINTER=y
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
# CONFIG_KGDB is not set
.....
#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC32=m
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y


--------------000904090105030606020101
Content-Type: text/plain;
 name="traces"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="traces"

Nov 21 19:22:42 eran kernel: (multiload-apple/5506/CPU#0): 1694 us wakeup latency violates 1000 us threshold.
preemption latency trace v1.0.7 on 2.6.10-rc2-mm2-V0.7.29-5
-------------------------------------------------------
 latency: 1694 us, entries: 21 (21)   |   [VP:0 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: multiload-apple/5506, uid:500 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: try_to_wake_up+0x165/0x1d0 <c0117af5>
 => ended at:   finish_task_switch+0x4f/0xc0 <c0117fbf>
=======>
  131 88000006 0.000ms (+0.000ms): __trace_start_sched_wakeup (try_to_wake_up)
  131 88000005 0.000ms (+0.000ms): preempt_schedule (try_to_wake_up)
  131 88000005 0.000ms (+0.000ms): (115) ((116))
  131 88000005 0.000ms (+0.000ms): (5506) ((131))
  131 88000005 0.001ms (+0.000ms): try_to_wake_up (wake_up_process)
  131 88000005 0.001ms (+0.000ms): (0) ((1))
  131 88000004 0.001ms (+0.000ms): preempt_schedule (try_to_wake_up)
  131 88000004 0.001ms (+0.000ms): wake_up_process (__up_mutex)
  131 88000003 0.002ms (+0.000ms): preempt_schedule (__up_mutex)
  131 88000002 0.002ms (+0.000ms): preempt_schedule (__up_mutex)
  131 08000001 0.002ms (+0.000ms): preempt_schedule (__schedule)
  131 08000001 0.002ms (+0.000ms): sched_clock (__schedule)
  131 88000002 0.003ms (+0.000ms): deactivate_task (__schedule)
  131 88000002 0.003ms (+1.687ms): dequeue_task (deactivate_task)
 5506 80000002 1.691ms (+0.001ms): __switch_to (__schedule)
 5506 80000002 1.692ms (+0.000ms): (131) ((5506))
 5506 80000002 1.693ms (+0.000ms): (116) ((115))
 5506 80000002 1.693ms (+0.000ms): finish_task_switch (__schedule)
 5506 80000001 1.693ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
 5506 80000001 1.693ms (+0.005ms): (5506) ((115))
 5506 80000001 1.699ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
==================
Nov 21 19:30:58 eran kernel: (firefox-bin/14054/CPU#0): 1991 us wakeup latency violates 1000 us threshold.
preemption latency trace v1.0.7 on 2.6.10-rc2-mm2-V0.7.29-5
-------------------------------------------------------
 latency: 1991 us, entries: 21 (21)   |   [VP:0 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: firefox-bin/14054, uid:500 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: try_to_wake_up+0x165/0x1d0 <c0117af5>
 => ended at:   finish_task_switch+0x4f/0xc0 <c0117fbf>
=======>
  131 88000006 0.000ms (+0.000ms): __trace_start_sched_wakeup (try_to_wake_up)
  131 88000005 0.000ms (+0.000ms): preempt_schedule (try_to_wake_up)
  131 88000005 0.000ms (+0.000ms): (115) ((116))
  131 88000005 0.000ms (+0.000ms): <000036e6> ((131))
  131 88000005 0.000ms (+0.000ms): try_to_wake_up (wake_up_process)
  131 88000005 0.001ms (+0.000ms): (0) ((1))
  131 88000004 0.001ms (+0.000ms): preempt_schedule (try_to_wake_up)
  131 88000004 0.001ms (+0.000ms): wake_up_process (__up_mutex)
  131 88000003 0.001ms (+0.000ms): preempt_schedule (__up_mutex)
  131 88000002 0.002ms (+0.000ms): preempt_schedule (__up_mutex)
  131 08000001 0.002ms (+0.000ms): preempt_schedule (__schedule)
  131 08000001 0.002ms (+0.000ms): sched_clock (__schedule)
  131 88000002 0.003ms (+0.000ms): deactivate_task (__schedule)
  131 88000002 0.003ms (+1.986ms): dequeue_task (deactivate_task)
14054 80000002 1.989ms (+0.000ms): __switch_to (__schedule)
14054 80000002 1.989ms (+0.000ms): (131) (<000036e6>)
14054 80000002 1.989ms (+0.000ms): (116) ((115))
14054 80000002 1.990ms (+0.000ms): finish_task_switch (__schedule)
14054 80000001 1.990ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
14054 80000001 1.990ms (+0.006ms): <000036e6> ((115))
14054 80000001 1.996ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
==================
Nov 21 19:31:44 eran kernel: (IRQ 0/2/CPU#0): 1213 us wakeup latency violates 1000 us threshold.
preemption latency trace v1.0.7 on 2.6.10-rc2-mm2-V0.7.29-5
-------------------------------------------------------
 latency: 1213 us, entries: 23 (23)   |   [VP:0 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: IRQ 0/2, uid:0 nice:0 policy:1 rt_prio:49
    -----------------
 => started at: try_to_wake_up+0x165/0x1d0 <c0117af5>
 => ended at:   finish_task_switch+0x4f/0xc0 <c0117fbf>
=======>
    3 88010003 0.000ms (+0.000ms): __trace_start_sched_wakeup (try_to_wake_up)
    3 88010002 0.000ms (+0.000ms): preempt_schedule (try_to_wake_up)
    3 88010002 0.000ms (+0.000ms): (50) ((105))
    3 88010002 0.000ms (+0.000ms): (2) ((3))
    3 88010002 0.000ms (+0.000ms): try_to_wake_up (wake_up_process)
    3 88010002 0.001ms (+0.000ms): (0) ((1))
    3 88010001 0.001ms (+0.000ms): preempt_schedule (try_to_wake_up)
    3 88010001 0.001ms (+0.000ms): wake_up_process (redirect_hardirq)
    3 88010000 0.001ms (+0.000ms): preempt_schedule (__do_IRQ)
    3 88010000 0.002ms (+0.000ms): irq_exit (do_IRQ)
    3 88000001 0.002ms (+0.000ms): do_softirq (irq_exit)
    3 88000001 0.002ms (+0.000ms): __do_softirq (do_softirq)
    3 88000000 0.002ms (+0.000ms): preempt_schedule_irq (need_resched)
    3 98000000 0.003ms (+0.000ms): __schedule (preempt_schedule_irq)
    3 98000000 0.003ms (+0.000ms): profile_hit (__schedule)
    3 98000001 0.003ms (+0.000ms): sched_clock (__schedule)
    2 80000002 0.004ms (+1.207ms): __switch_to (__schedule)
    2 80000002 1.212ms (+0.000ms): (3) ((2))
    2 80000002 1.212ms (+0.000ms): (105) ((50))
    2 80000002 1.212ms (+0.000ms): finish_task_switch (__schedule)
    2 80000001 1.212ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
    2 80000001 1.212ms (+0.006ms): (2) ((50))
    2 80000001 1.219ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
==================
Nov 21 19:36:18 eran kernel: (firefox-bin/14054/CPU#0): 1881 us wakeup latency violates 1000 us threshold.
preemption latency trace v1.0.7 on 2.6.10-rc2-mm2-V0.7.29-5
-------------------------------------------------------
 latency: 1881 us, entries: 21 (21)   |   [VP:0 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: firefox-bin/14054, uid:500 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: try_to_wake_up+0x165/0x1d0 <c0117af5>
 => ended at:   finish_task_switch+0x4f/0xc0 <c0117fbf>
=======>
  131 88000006 0.000ms (+0.000ms): __trace_start_sched_wakeup (try_to_wake_up)
  131 88000005 0.000ms (+0.000ms): preempt_schedule (try_to_wake_up)
  131 88000005 0.000ms (+0.000ms): (115) ((116))
  131 88000005 0.000ms (+0.000ms): <000036e6> ((131))
  131 88000005 0.001ms (+0.000ms): try_to_wake_up (wake_up_process)
  131 88000005 0.001ms (+0.000ms): (0) ((1))
  131 88000004 0.001ms (+0.000ms): preempt_schedule (try_to_wake_up)
  131 88000004 0.001ms (+0.000ms): wake_up_process (__up_mutex)
  131 88000003 0.002ms (+0.000ms): preempt_schedule (__up_mutex)
  131 88000002 0.002ms (+0.000ms): preempt_schedule (__up_mutex)
  131 08000001 0.002ms (+0.000ms): preempt_schedule (__schedule)
  131 08000001 0.002ms (+0.000ms): sched_clock (__schedule)
  131 88000002 0.003ms (+0.000ms): deactivate_task (__schedule)
  131 88000002 0.003ms (+1.875ms): dequeue_task (deactivate_task)
14054 80000002 1.878ms (+0.001ms): __switch_to (__schedule)
14054 80000002 1.880ms (+0.000ms): (131) (<000036e6>)
14054 80000002 1.880ms (+0.000ms): (116) ((115))
14054 80000002 1.880ms (+0.000ms): finish_task_switch (__schedule)
14054 80000001 1.880ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
14054 80000001 1.881ms (+0.008ms): <000036e6> ((115))
14054 80000001 1.890ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
==================
Nov 21 19:37:18 eran kernel: (firefox-bin/14054/CPU#0): 1347 us wakeup latency violates 1000 us threshold.
preemption latency trace v1.0.7 on 2.6.10-rc2-mm2-V0.7.29-5
-------------------------------------------------------
 latency: 1347 us, entries: 21 (21)   |   [VP:0 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: firefox-bin/14054, uid:500 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: try_to_wake_up+0x165/0x1d0 <c0117af5>
 => ended at:   finish_task_switch+0x4f/0xc0 <c0117fbf>
=======>
  131 88000006 0.000ms (+0.000ms): __trace_start_sched_wakeup (try_to_wake_up)
  131 88000005 0.000ms (+0.000ms): preempt_schedule (try_to_wake_up)
  131 88000005 0.000ms (+0.000ms): (115) ((116))
  131 88000005 0.000ms (+0.000ms): <000036e6> ((131))
  131 88000005 0.000ms (+0.000ms): try_to_wake_up (wake_up_process)
  131 88000005 0.001ms (+0.000ms): (0) ((1))
  131 88000004 0.001ms (+0.000ms): preempt_schedule (try_to_wake_up)
  131 88000004 0.001ms (+0.000ms): wake_up_process (__up_mutex)
  131 88000003 0.001ms (+0.000ms): preempt_schedule (__up_mutex)
  131 88000002 0.002ms (+0.000ms): preempt_schedule (__up_mutex)
  131 08000001 0.002ms (+0.000ms): preempt_schedule (__schedule)
  131 08000001 0.002ms (+0.000ms): sched_clock (__schedule)
  131 88000002 0.003ms (+0.000ms): deactivate_task (__schedule)
  131 88000002 0.003ms (+0.000ms): dequeue_task (deactivate_task)
14054 80000002 0.003ms (+0.000ms): __switch_to (__schedule)
14054 80000002 0.004ms (+0.000ms): (131) (<000036e6>)
14054 80000002 0.004ms (+0.000ms): (116) ((115))
14054 80000002 0.004ms (+0.000ms): finish_task_switch (__schedule)
14054 80000001 0.005ms (+1.342ms): trace_stop_sched_switched (finish_task_switch)
14054 80000001 1.347ms (+0.103ms): <000036e6> ((115))
14054 80000001 1.450ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
==================
Nov 21 19:49:21 eran kernel: (gnome-terminal/5434/CPU#0): 1683 us wakeup latency violates 1000 us threshold.
preemption latency trace v1.0.7 on 2.6.10-rc2-mm2-V0.7.29-5
-------------------------------------------------------
 latency: 1683 us, entries: 21 (21)   |   [VP:0 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: gnome-terminal/5434, uid:500 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: try_to_wake_up+0x165/0x1d0 <c0117af5>
 => ended at:   finish_task_switch+0x4f/0xc0 <c0117fbf>
=======>
  131 88000006 0.000ms (+0.000ms): __trace_start_sched_wakeup (try_to_wake_up)
  131 88000005 0.000ms (+0.000ms): preempt_schedule (try_to_wake_up)
  131 88000005 0.000ms (+0.000ms): (115) ((116))
  131 88000005 0.001ms (+0.000ms): (5434) ((131))
  131 88000005 0.001ms (+0.000ms): try_to_wake_up (wake_up_process)
  131 88000005 0.001ms (+0.000ms): (0) ((1))
  131 88000004 0.001ms (+0.000ms): preempt_schedule (try_to_wake_up)
  131 88000004 0.001ms (+0.000ms): wake_up_process (__up_mutex)
  131 88000003 0.002ms (+0.000ms): preempt_schedule (__up_mutex)
  131 88000002 0.002ms (+0.000ms): preempt_schedule (__up_mutex)
  131 08000001 0.002ms (+0.000ms): preempt_schedule (__schedule)
  131 08000001 0.002ms (+0.000ms): sched_clock (__schedule)
  131 88000002 0.003ms (+0.000ms): deactivate_task (__schedule)
  131 88000002 0.003ms (+1.676ms): dequeue_task (deactivate_task)
 5434 80000002 1.680ms (+0.001ms): __switch_to (__schedule)
 5434 80000002 1.681ms (+0.000ms): (131) ((5434))
 5434 80000002 1.682ms (+0.000ms): (116) ((115))
 5434 80000002 1.682ms (+0.000ms): finish_task_switch (__schedule)
 5434 80000001 1.682ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
 5434 80000001 1.682ms (+0.006ms): (5434) ((115))
 5434 80000001 1.689ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
==================
Nov 21 19:52:18 eran kernel: (IRQ 0/2/CPU#0): 2009 us wakeup latency violates 1000 us threshold.
preemption latency trace v1.0.7 on 2.6.10-rc2-mm2-V0.7.29-5
-------------------------------------------------------
 latency: 2009 us, entries: 37 (37)   |   [VP:0 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: IRQ 0/2, uid:0 nice:0 policy:1 rt_prio:49
    -----------------
 => started at: try_to_wake_up+0x165/0x1d0 <c0117af5>
 => ended at:   finish_task_switch+0x4f/0xc0 <c0117fbf>
=======>
  783 88010003 0.000ms (+0.000ms): __trace_start_sched_wakeup (try_to_wake_up)
  783 88010002 0.000ms (+0.000ms): preempt_schedule (try_to_wake_up)
  783 88010002 0.000ms (+0.000ms): (50) ((54))
  783 88010002 0.000ms (+0.000ms): (2) ((783))
  783 88010002 0.000ms (+0.000ms): try_to_wake_up (wake_up_process)
  783 88010002 0.001ms (+0.000ms): (0) ((1))
  783 88010001 0.001ms (+0.000ms): preempt_schedule (try_to_wake_up)
  783 88010001 0.001ms (+0.000ms): wake_up_process (redirect_hardirq)
  783 88010000 0.001ms (+0.000ms): preempt_schedule (__do_IRQ)
  783 88010000 0.002ms (+0.000ms): irq_exit (do_IRQ)
  783 88000001 0.002ms (+0.000ms): do_softirq (irq_exit)
  783 88000001 0.002ms (+0.000ms): __do_softirq (do_softirq)
  783 88000001 0.003ms (+0.000ms): wake_up_process (do_softirq)
  783 88000001 0.003ms (+0.000ms): try_to_wake_up (wake_up_process)
  783 88000001 0.003ms (+0.000ms): task_rq_lock (try_to_wake_up)
  783 88000002 0.003ms (+0.000ms): activate_task (try_to_wake_up)
  783 88000002 0.004ms (+0.000ms): sched_clock (activate_task)
  783 88000002 0.004ms (+0.000ms): recalc_task_prio (activate_task)
  783 88000002 0.004ms (+0.000ms): effective_prio (recalc_task_prio)
  783 88000002 0.004ms (+0.000ms): enqueue_task (activate_task)
  783 88000002 0.005ms (+0.000ms): (105) ((54))
  783 88000002 0.005ms (+0.000ms): (3) ((783))
  783 88000002 0.005ms (+0.000ms): try_to_wake_up (wake_up_process)
  783 88000002 0.006ms (+1.999ms): (0) ((1))
  783 88000001 2.005ms (+0.000ms): preempt_schedule (try_to_wake_up)
  783 88000001 2.005ms (+0.000ms): wake_up_process (do_softirq)
  783 88000000 2.006ms (+0.000ms): preempt_schedule_irq (need_resched)
  783 98000000 2.006ms (+0.000ms): __schedule (preempt_schedule_irq)
  783 98000000 2.006ms (+0.000ms): profile_hit (__schedule)
  783 98000001 2.007ms (+0.000ms): sched_clock (__schedule)
    2 80000002 2.007ms (+0.000ms): __switch_to (__schedule)
    2 80000002 2.008ms (+0.000ms): (783) ((2))
    2 80000002 2.008ms (+0.000ms): (54) ((50))
    2 80000002 2.008ms (+0.000ms): finish_task_switch (__schedule)
    2 80000001 2.008ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
    2 80000001 2.009ms (+0.006ms): (2) ((50))
    2 80000001 2.015ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)


--------------000904090105030606020101--
