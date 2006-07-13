Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbWGMIxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbWGMIxG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 04:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWGMIxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 04:53:06 -0400
Received: from mkedef2.rockwellautomation.com ([63.161.86.254]:4519 "EHLO
	ramilwsmtp01.ra.rockwell.com") by vger.kernel.org with ESMTP
	id S1751506AbWGMIxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 04:53:04 -0400
Message-ID: <44B62624.30908@ra.rockwell.com>
Date: Thu, 13 Jul 2006 10:53:24 +0000
From: Milan Svoboda <msvoboda@ra.rockwell.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de
Subject: [PATCH] 2.6.17-rt add clockevent to ixp4xx
X-MIMETrack: Itemize by SMTP Server on RAMilwSMTP01/Milwaukee/RA/Rockwell(Release
 6.5.4FP1|June 19, 2005) at 07/13/2006 03:53:47 AM,
	Serialize by Router on RAMilwSMTP01/Milwaukee/RA/Rockwell(Release 6.5.4FP1|June
 19, 2005) at 07/13/2006 03:53:52 AM,
	Serialize complete at 07/13/2006 03:53:52 AM
Content-Type: multipart/mixed;
 boundary="------------030407090006040206030206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030407090006040206030206
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

Hello,

there are patches that enable clock event on ixp4xx platform. This should
enable high resolution timers... Option for hrtimers in menuconfig is 
also enabled.

I tested it on nanosleep test program (included in attachments) and obtained
this results:

requested: 899000 us, got: 899159 us, diff: -159 us
requested: 897000 us, got: 897209 us, diff: -209 us
requested: 895000 us, got: 899803 us, diff: -4803 us
requested: 893000 us, got: 899425 us, diff: -6425 us
requested: 891000 us, got: 899806 us, diff: -8806 us
requested: 889000 us, got: 890142 us, diff: -1142 us
requested: 887000 us, got: 889873 us, diff: -2873 us
requested: 885000 us, got: 888096 us, diff: -3096 us
requested: 883000 us, got: 883323 us, diff: -323 us
requested: 881000 us, got: 883395 us, diff: -2395 us
requested: 879000 us, got: 883026 us, diff: -4026 us
requested: 877000 us, got: 877838 us, diff: -838 us
requested: 875000 us, got: 876975 us, diff: -1975 us
requested: 873000 us, got: 873585 us, diff: -585 us
requested: 871000 us, got: 871699 us, diff: -699 us
requested: 869000 us, got: 869747 us, diff: -747 us
requested: 867000 us, got: 869771 us, diff: -2771 us
requested: 865000 us, got: 869777 us, diff: -4777 us
requested: 863000 us, got: 869774 us, diff: -6774 us
requested: 861000 us, got: 869744 us, diff: -8744 us
requested: 859000 us, got: 861180 us, diff: -2180 us
requested: 857000 us, got: 857108 us, diff: -108 us
requested: 855000 us, got: 860986 us, diff: -5986 us
requested: 853000 us, got: 858383 us, diff: -5383 us
requested: 851000 us, got: 855234 us, diff: -4234 us
requested: 849000 us, got: 850261 us, diff: -1261 us
requested: 847000 us, got: 848729 us, diff: -1729 us
requested: 845000 us, got: 845926 us, diff: -926 us
requested: 843000 us, got: 844059 us, diff: -1059 us
requested: 841000 us, got: 841498 us, diff: -498 us
requested: 839000 us, got: 839758 us, diff: -758 us
requested: 837000 us, got: 839748 us, diff: -2748 us
requested: 835000 us, got: 839727 us, diff: -4727 us
requested: 833000 us, got: 834417 us, diff: -1417 us
requested: 831000 us, got: 834710 us, diff: -3710 us
requested: 829000 us, got: 834696 us, diff: -5696 us
requested: 827000 us, got: 830714 us, diff: -3714 us
requested: 825000 us, got: 830543 us, diff: -5543 us
requested: 823000 us, got: 830812 us, diff: -7812 us
requested: 821000 us, got: 828395 us, diff: -7395 us
requested: 819000 us, got: 819855 us, diff: -855 us
requested: 817000 us, got: 818855 us, diff: -1855 us
requested: 815000 us, got: 817711 us, diff: -2711 us
requested: 813000 us, got: 813312 us, diff: -312 us
requested: 811000 us, got: 811901 us, diff: -901 us
requested: 809000 us, got: 809804 us, diff: -804 us
requested: 807000 us, got: 809790 us, diff: -2790 us
requested: 805000 us, got: 809798 us, diff: -4798 us
requested: 803000 us, got: 809243 us, diff: -6243 us
requested: 801000 us, got: 801482 us, diff: -482 us
requested: 799000 us, got: 799772 us, diff: -772 us
requested: 797000 us, got: 801161 us, diff: -4161 us
requested: 795000 us, got: 798107 us, diff: -3107 us
requested: 793000 us, got: 795470 us, diff: -2470 us
requested: 791000 us, got: 793550 us, diff: -2550 us
requested: 789000 us, got: 789249 us, diff: -249 us
requested: 787000 us, got: 789163 us, diff: -2163 us
requested: 785000 us, got: 785329 us, diff: -329 us
requested: 783000 us, got: 783539 us, diff: -539 us
requested: 781000 us, got: 781949 us, diff: -949 us
requested: 779000 us, got: 779836 us, diff: -836 us
requested: 777000 us, got: 779785 us, diff: -2785 us
requested: 775000 us, got: 779804 us, diff: -4804 us
requested: 773000 us, got: 779805 us, diff: -6805 us
requested: 771000 us, got: 779811 us, diff: -8811 us
requested: 769000 us, got: 769796 us, diff: -796 us
requested: 767000 us, got: 769803 us, diff: -2803 us
requested: 765000 us, got: 769030 us, diff: -4030 us
requested: 763000 us, got: 771035 us, diff: -8035 us
requested: 761000 us, got: 761268 us, diff: -268 us
requested: 759000 us, got: 759746 us, diff: -746 us
requested: 757000 us, got: 757719 us, diff: -719 us
requested: 755000 us, got: 757442 us, diff: -2442 us
requested: 753000 us, got: 754198 us, diff: -1198 us
requested: 751000 us, got: 751350 us, diff: -350 us
requested: 749000 us, got: 749765 us, diff: -765 us
requested: 747000 us, got: 749758 us, diff: -2758 us

Results are far better than on standart kernel, but...

My question is: are these numbers expected? I hoped that with
hrtimers get better numbers, something about hundrets of us, instead
of thoushands...

The CONFIG_HIGH_RES_RESOLUTION is 100000 but
numbers were roughly the same with the default 1000. Numbers are
the same also when nanosleep and kernel threads are boosted to use
rt round-robin priority...

The system is running only this program.

Patch is against 2.6.17-rt7.

Feedback and comments are highly appreciated.

Signed-off-by: Milan Svoboda <msvoboda@ra.rockwell.com>
---


--------------030407090006040206030206
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="arm_add_hrtimer_option.patch"
Content-Disposition: inline;
 filename="arm_add_hrtimer_option.patch"

diff -uprN -X rt/Documentation/dontdiff rt/arch/arm/Kconfig rt_new/arch/arm/Kconfig
--- rt/arch/arm/Kconfig	2006-07-12 11:35:52.000000000 +0000
+++ rt_new/arch/arm/Kconfig	2006-07-10 10:45:53.000000000 +0000
@@ -474,6 +474,8 @@ config HZ
 	default OMAP_32K_TIMER_HZ if ARCH_OMAP && OMAP_32K_TIMER
 	default 100
 
+source "kernel/time/Kconfig"
+
 config AEABI
 	bool "Use the ARM EABI to compile the kernel"
 	help

--------------030407090006040206030206
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="hrtimer_add_clockevent_hz2mult.patch"
Content-Disposition: inline;
 filename="hrtimer_add_clockevent_hz2mult.patch"

diff -uprN -X rt/Documentation/dontdiff rt/include/linux/clockchips.h rt_new/include/linux/clockchips.h
--- rt/include/linux/clockchips.h	2006-07-12 11:35:52.000000000 +0000
+++ rt_new/include/linux/clockchips.h	2006-07-12 14:39:14.000000000 +0000
@@ -90,7 +90,19 @@ struct clock_event {
 	void *priv;
 };
 
+static inline u32 clockevent_hz2mult(u32 hz, u32 shift)
+{
+	u64 tmp = (u64) hz << shift;
+	do_div(tmp, 1000000000);
+	return (u32) tmp;
+}
 
+static inline u32 clockevent_khz2mult(u32 khz, u32 shift)
+{
+	u64 tmp = (u64) khz << shift;
+	do_div(tmp, 1000000);
+	return (u32) tmp;
+}
 
 /*
  * Calculate a multiplication factor with shift=32

--------------030407090006040206030206
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="ixp4xx_add_clock_event.patch"
Content-Disposition: inline;
 filename="ixp4xx_add_clock_event.patch"

diff -uprN -X rt/Documentation/dontdiff rt/arch/arm/mach-ixp4xx/common.c rt_new/arch/arm/mach-ixp4xx/common.c
--- rt/arch/arm/mach-ixp4xx/common.c	2006-07-12 11:35:52.000000000 +0000
+++ rt_new/arch/arm/mach-ixp4xx/common.c	2006-07-13 10:26:06.000000000 +0000
@@ -28,6 +28,7 @@
 #include <linux/time.h>
 #include <linux/timex.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 
 #include <asm/hardware.h>
 #include <asm/uaccess.h>
@@ -255,15 +256,32 @@ void __init ixp4xx_init_irq(void)
 
 static unsigned volatile last_jiffy_time;
 
-#define CLOCK_TICKS_PER_USEC	((CLOCK_TICK_RATE + USEC_PER_SEC/2) / USEC_PER_SEC)
+#ifdef CONFIG_HIGH_RES_TIMERS
+static void ixp4xx_set_next_event(unsigned long evt, void *priv)
+{
+	*IXP4XX_OSRT1 = (evt & ~IXP4XX_OST_RELOAD_MASK) | IXP4XX_OST_ENABLE;
+}
+
+static struct clock_event clockevent_ixp4xx = {
+	.name		= "OSTS clock event interface",
+	.capabilities	= CLOCK_CAP_NEXTEVT | CLOCK_CAP_TICK |
+				 CLOCK_HAS_IRQHANDLER,
+	.shift		= 32,
+	.set_next_event	= ixp4xx_set_next_event,
+};
+#endif
 
 static irqreturn_t ixp4xx_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	write_seqlock(&xtime_lock);
-
 	/* Clear Pending Interrupt by writing '1' to it */
 	*IXP4XX_OSST = IXP4XX_OSST_TIMER_1_PEND;
 
+#ifdef CONFIG_HIGH_RES_TIMERS
+	if (clockevent_ixp4xx.event_handler)
+		clockevent_ixp4xx.event_handler(regs, NULL);
+#endif
+	write_seqlock(&xtime_lock);
+
 	/*
 	 * Catch up with the real idea of time
 	 */
@@ -379,5 +397,20 @@ static int __init ixp4xx_clocksource_ini
 
 	return 0;
 }
-
 device_initcall(ixp4xx_clocksource_init);
+
+#ifdef CONFIG_HIGH_RES_TIMERS
+static int __init ixp4xx_clockevent_init(void)
+{
+	clockevent_ixp4xx.mult =
+		clockevent_hz2mult(FREQ, clockevent_ixp4xx.shift);
+	clockevent_ixp4xx.max_delta_ns =
+		clockevent_delta2ns(0xfffffffe, &clockevent_ixp4xx);
+	clockevent_ixp4xx.min_delta_ns =
+		clockevent_delta2ns(0xf, &clockevent_ixp4xx);
+	setup_local_clockevent(&clockevent_ixp4xx, CPU_MASK_NONE);
+
+	return 0;
+}
+device_initcall(ixp4xx_clockevent_init);
+#endif

--------------030407090006040206030206
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="ixp4xx_make_clock_accurate.patch"
Content-Disposition: inline;
 filename="ixp4xx_make_clock_accurate.patch"

diff -uprN -X rt/Documentation/dontdiff rt/arch/arm/mach-ixp4xx/common.c rt_new/arch/arm/mach-ixp4xx/common.c
--- rt/arch/arm/mach-ixp4xx/common.c	2006-07-12 11:35:52.000000000 +0000
+++ rt_new/arch/arm/mach-ixp4xx/common.c	2006-07-12 11:37:27.000000000 +0000
@@ -364,7 +364,7 @@ static struct clocksource clocksource_ix
 	.rating		= 200,
 	.read		= ixp4xx_get_cycles,
 	.mask		= 0xFFFFFFFF,
-	.shift 		= 10,
+	.shift 		= 20,
 	.is_continuous 	= 1,
 };
 

--------------030407090006040206030206
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="nanosleep.c"
Content-Disposition: inline;
 filename="nanosleep.c"

#include <time.h>
#include <sys/time.h>

int main(int argc, char **argv)
{
	int i, r;
	unsigned long delta;
	struct timeval beg, end;
	struct timespec ts;
	struct timespec rest;
	
	ts.tv_sec  = 0;
	ts.tv_nsec = 900000000;
	
	// > 1 msec
	//
	while (ts.tv_nsec > 1000000)
	{
		r = gettimeofday(&beg, NULL);
		if (r < 0)
			break;
	
		r = nanosleep(&ts, &rest);
		if (r < 0)
			break;

		r = gettimeofday(&end, NULL);
		if (r < 0)
			break;
	
		delta = (end.tv_sec - beg.tv_sec) * 1000 * 1000;
		delta = delta + (end.tv_usec - beg.tv_usec);
		
		printf("requested: %lu us, got: %lu us, diff: %li us\n",
			(ts.tv_nsec / 1000),
			delta,
			delta - (ts.tv_nsec / 1000));
			
		// 1 msec
		//
		ts.tv_nsec -= 1000000;
	}

	printf("ts.tv_nsec: %lu\n", ts.tv_nsec);	

	return 0;
}

--------------030407090006040206030206
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name=".config"
Content-Disposition: inline;
 filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.17-rt7
# Thu Jul 13 10:09:57 2006
#
CONFIG_ARM=y
CONFIG_MMU=y
CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_VECTORS_BASE=0xffff0000

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
# CONFIG_SWAP is not set
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
# CONFIG_IKCONFIG is not set
# CONFIG_RELAY is not set
CONFIG_INITRAMFS_SOURCE=""
CONFIG_UID16=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_RT_MUTEXES=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set
CONFIG_OBSOLETE_INTERMODULE=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_KMOD is not set

#
# Block layer
#
# CONFIG_BLK_DEV_IO_TRACE is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# System Type
#
# CONFIG_ARCH_CLPS7500 is not set
# CONFIG_ARCH_CLPS711X is not set
# CONFIG_ARCH_CO285 is not set
# CONFIG_ARCH_EBSA110 is not set
# CONFIG_ARCH_EP93XX is not set
# CONFIG_ARCH_FOOTBRIDGE is not set
# CONFIG_ARCH_INTEGRATOR is not set
# CONFIG_ARCH_IOP3XX is not set
CONFIG_ARCH_IXP4XX=y
# CONFIG_ARCH_IXP2000 is not set
# CONFIG_ARCH_IXP23XX is not set
# CONFIG_ARCH_L7200 is not set
# CONFIG_ARCH_PXA is not set
# CONFIG_ARCH_RPC is not set
# CONFIG_ARCH_SA1100 is not set
# CONFIG_ARCH_S3C2410 is not set
# CONFIG_ARCH_SHARK is not set
# CONFIG_ARCH_LH7A40X is not set
# CONFIG_ARCH_OMAP is not set
# CONFIG_ARCH_VERSATILE is not set
# CONFIG_ARCH_REALVIEW is not set
# CONFIG_ARCH_IMX is not set
# CONFIG_ARCH_H720X is not set
# CONFIG_ARCH_AAEC2000 is not set
# CONFIG_ARCH_AT91RM9200 is not set
CONFIG_ARCH_SUPPORTS_BIG_ENDIAN=y

#
# Intel IXP4xx Implementation Options
#

#
# IXP4xx Platforms
#
# CONFIG_MACH_NSLU2 is not set
# CONFIG_ARCH_AVILA is not set
# CONFIG_ARCH_ADI_COYOTE is not set
# CONFIG_ARCH_IXDP425 is not set
# CONFIG_MACH_IXDPG425 is not set
CONFIG_MACH_IXDP465=y
# CONFIG_ARCH_PRPMC1100 is not set
# CONFIG_MACH_NAS100D is not set
CONFIG_ARCH_IXDP4XX=y
CONFIG_CPU_IXP46X=y
# CONFIG_MACH_GTWX5715 is not set

#
# IXP4xx Options
#
CONFIG_DMABOUNCE=y
# CONFIG_IXP4XX_INDIRECT_PCI is not set

#
# Processor Type
#
CONFIG_CPU_32=y
CONFIG_CPU_XSCALE=y
CONFIG_CPU_32v5=y
CONFIG_CPU_ABRT_EV5T=y
CONFIG_CPU_CACHE_VIVT=y
CONFIG_CPU_TLB_V4WBI=y

#
# Processor Features
#
# CONFIG_ARM_THUMB is not set
CONFIG_CPU_BIG_ENDIAN=y
CONFIG_XSCALE_PMU=y

#
# Bus support
#
CONFIG_PCI=y
# CONFIG_PCI_DEBUG is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# Kernel Features
#
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT_DESKTOP is not set
CONFIG_PREEMPT_RT=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_SOFTIRQS=y
CONFIG_PREEMPT_HARDIRQS=y
CONFIG_PREEMPT_BKL=y
# CONFIG_CLASSIC_RCU is not set
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_STATS is not set
# CONFIG_NO_IDLE_HZ is not set
CONFIG_HZ=100
CONFIG_HIGH_RES_TIMERS=y
CONFIG_HIGH_RES_RESOLUTION=100000
# CONFIG_AEABI is not set
# CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_SPLIT_PTLOCK_CPUS=4096
CONFIG_ALIGNMENT_TRAP=y

#
# Boot options
#
CONFIG_ZBOOT_ROM_TEXT=0
CONFIG_ZBOOT_ROM_BSS=0
CONFIG_CMDLINE="console=ttyS0,115200 root=/dev/nfs ip=bootp mem=128M"
# CONFIG_XIP_KERNEL is not set

#
# Floating point emulation
#

#
# At least one emulation must be selected
#
# CONFIG_FPE_NWFPE is not set
# CONFIG_FPE_FASTFPE is not set

#
# Userspace binary formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set
# CONFIG_ARTHUR is not set

#
# Power management options
#
CONFIG_PM=y
# CONFIG_PM_LEGACY is not set
CONFIG_PM_DEBUG=y
# CONFIG_APM is not set

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set

#
# TIPC Configuration (EXPERIMENTAL)
#
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=y
# CONFIG_MTD_DEBUG is not set
# CONFIG_MTD_CONCAT is not set
CONFIG_MTD_PARTITIONS=y
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_AFS_PARTS is not set

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLOCK=y
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_CFI_INTELEXT=y
# CONFIG_MTD_CFI_AMDSTD is not set
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# CONFIG_MTD_OBSOLETE_CHIPS is not set

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_ARM_INTEGRATOR is not set
CONFIG_MTD_IXP4XX=y
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOC2000 is not set
# CONFIG_MTD_DOC2001 is not set
# CONFIG_MTD_DOC2001PLUS is not set

#
# NAND Flash Device Drivers
#
# CONFIG_MTD_NAND is not set

#
# OneNAND Flash Device Drivers
#
# CONFIG_MTD_ONENAND is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#

#
# Block devices
#
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=8192
CONFIG_BLK_DEV_INITRD=y
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
# CONFIG_PHYLIB is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_SMC91X is not set
# CONFIG_DM9000 is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=y
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_PCIPS2 is not set
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_NR_UARTS=2
CONFIG_SERIAL_8250_RUNTIME_UARTS=2
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_DRM is not set
# CONFIG_RAW_DRIVER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=y
# CONFIG_HWMON_VID is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#

#
# LED devices
#
# CONFIG_NEW_LEDS is not set

#
# LED drivers
#

#
# LED Triggers
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set
CONFIG_VIDEO_V4L2=y

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set

#
# Console display driver support
#
# CONFIG_VGA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
# CONFIG_USB is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# USB Gadget Support
#
CONFIG_USB_GADGET=m
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_SELECTED=y
# CONFIG_USB_GADGET_NET2280 is not set
CONFIG_USB_GADGET_PXA2XX=y
CONFIG_USB_PXA2XX=m
CONFIG_USB_PXA2XX_SMALL=y
# CONFIG_USB_GADGET_GOKU is not set
# CONFIG_USB_GADGET_LH7A40X is not set
# CONFIG_USB_GADGET_OMAP is not set
# CONFIG_USB_GADGET_AT91 is not set
# CONFIG_USB_GADGET_DUMMY_HCD is not set
# CONFIG_USB_GADGET_DUALSPEED is not set
CONFIG_USB_ZERO=m
# CONFIG_USB_ETH is not set
CONFIG_USB_GADGETFS=m
# CONFIG_USB_FILE_STORAGE is not set
# CONFIG_USB_G_SERIAL is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# Real Time Clock
#
CONFIG_RTC_LIB=y
# CONFIG_RTC_CLASS is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
# CONFIG_EXT3_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_NFSD is not set
CONFIG_ROOT_NFS=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
# CONFIG_NLS is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
# CONFIG_PRINTK_IGNORE_LOGLEVEL is not set
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_PI_LIST=y
CONFIG_RT_MUTEX_TESTER=y
# CONFIG_WAKEUP_TIMING is not set
CONFIG_PREEMPT_TRACE=y
# CONFIG_CRITICAL_PREEMPT_TIMING is not set
# CONFIG_CRITICAL_IRQSOFF_TIMING is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
CONFIG_FRAME_POINTER=y
CONFIG_UNWIND_INFO=y
CONFIG_FORCED_INLINING=y
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_DEBUG_USER is not set
CONFIG_DEBUG_WAITQ=y
CONFIG_DEBUG_ERRORS=y
# CONFIG_DEBUG_LL is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Hardware crypto devices
#

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_PLIST=y

--------------030407090006040206030206--
