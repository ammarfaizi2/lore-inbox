Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269294AbUI3Ou4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269294AbUI3Ou4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 10:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269076AbUI3Ou4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 10:50:56 -0400
Received: from server14.totalchoicehosting.com ([69.72.226.50]:54757 "EHLO
	server14.totalchoicehosting.com") by vger.kernel.org with ESMTP
	id S269294AbUI3Ouh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 10:50:37 -0400
From: "Leonid Petrov" <nouser@lpetrov.net>
To: linux-kernel@vger.kernel.org
CC: user@lpetrov.net
Subject: Out of Memory: Killed process while 1 Gb is free
X-Mailer: NeoMail 1.26
X-IPAddress: 128.183.107.130
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Message-Id: <E1CD2GS-0006EF-7b@server14.totalchoicehosting.com>
Date: Thu, 30 Sep 2004 10:50:36 -0400
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server14.totalchoicehosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [584 585] / [47 12]
X-AntiAbuse: Sender Address Domain - server14.totalchoicehosting.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: 
    "Out of Memory: Killed process" when more than 1 Gb of free memory
     is available.

Description:
  My Linux-server after 2-10 days starts killing processes claiming
  that it is "Out of memory". Top does not show any processess which
  occupy more than several percent of memory. It always occur when 
  the amount of available memory (1Gb) is about half of the total 
  memory (2Gb). Killing a process does not help and the kernel 
  continue mass murder till the state then it becomes non-operational. 
  During agony vmstat showed that the occupied 1Gb of memory was used 
  mainly by cache and buffers. Analazing kernel log I found 245 events 
  for last 3 weeks. All events occured when anount of Normal memory 
  was in the range [0,2052]Kb (and about 1Gb of free high memory). 
  It did not occur before upgrade to 2.6.8.1. Out of memory events 
  occured in both Hyperthreading enabled and Hyperthreading disabled 
  mode.

Keywords:
  Virtual memory managment

Leonid
------------------------------- Attachment 1 

Sep 30 08:53:22 lacerta kernel: 
Sep 30 08:53:22 lacerta kernel: Free pages:      979224kB (975808kB HighMem)
Sep 30 08:53:22 lacerta kernel: Active:18681 inactive:29707 dirty:0
writeback:0 unstable:0 free:244806 slab:2967 mapped:17333 pagetables:418
Sep 30 08:53:22 lacerta kernel: DMA free:1904kB min:16kB low:32kB
high:48kB active:112kB inactive:0kB present:16384kB
Sep 30 08:53:22 lacerta kernel: protections[]: 8 476 732
Sep 30 08:53:22 lacerta kernel: Normal free:1512kB min:936kB low:1872kB
high:2808kB active:216kB inactive:436kB present:901120kB
Sep 30 08:53:22 lacerta kernel: protections[]: 0 468 724
Sep 30 08:53:22 lacerta kernel: HighMem free:975808kB min:512kB
low:1024kB high:1536kB active:74396kB inactive:118392kB present:1179584kB
Sep 30 08:53:22 lacerta kernel: protections[]: 0 0 256
Sep 30 08:53:22 lacerta kernel: DMA: 26*4kB 9*8kB 6*16kB 1*32kB 3*64kB
3*128kB 2*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1904kB
Sep 30 08:53:22 lacerta kernel: Normal: 52*4kB 19*8kB 8*16kB 4*32kB
0*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1512kB
Sep 30 08:53:22 lacerta kernel: HighMem: 64*4kB 0*8kB 704*16kB 3364*32kB
2707*64kB 1925*128kB 1007*256kB 276*512kB 33*1024kB 2*2048kB 0*4096kB =
975808kB
Sep 30 08:53:23 lacerta kernel: Swap cache: add 6659, delete 6233, find
1982/2342, race 0+0
Sep 30 08:53:23 lacerta kernel: Out of Memory: Killed process 23332 (xterm).
Sep 30 08:53:23 lacerta kernel: oom-killer: gfp_mask=0xd0
Sep 30 08:53:23 lacerta kernel: DMA per-cpu:
Sep 30 08:53:23 lacerta kernel: cpu 0 hot: low 2, high 6, batch 1
Sep 30 08:53:23 lacerta kernel: cpu 0 cold: low 0, high 2, batch 1
Sep 30 08:53:23 lacerta kernel: Normal per-cpu:
Sep 30 08:53:23 lacerta kernel: cpu 0 hot: low 32, high 96, batch 16
Sep 30 08:53:23 lacerta kernel: cpu 0 cold: low 0, high 32, batch 16
Sep 30 08:53:23 lacerta kernel: HighMem per-cpu:
Sep 30 08:53:23 lacerta kernel: cpu 0 hot: low 32, high 96, batch 16
Sep 30 08:53:23 lacerta kernel: cpu 0 cold: low 0, high 32, batch 16

------------------------------- Attachment 2 
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 3
model name	: Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping	: 3
cpu MHz		: 3499.459
cache size	: 1024 KB
physical id	: 0
siblings	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pni monitor
ds_cpl cid
bogomips	: 6914.04

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 3
model name	: Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping	: 3
cpu MHz		: 3499.459
cache size	: 1024 KB
physical id	: 0
siblings	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pni monitor
ds_cpl cid
bogomips	: 6979.58

------------------------------- Attachment 3 
MemTotal:      2075880 kB
MemFree:       1625564 kB
Buffers:         17048 kB
Cached:         293236 kB
SwapCached:          0 kB
Active:         203636 kB
Inactive:       209388 kB
HighTotal:     1179584 kB
HighFree:       772608 kB
LowTotal:       896296 kB
LowFree:        852956 kB
SwapTotal:     4192956 kB
SwapFree:      4192956 kB
Dirty:           53584 kB
Writeback:           0 kB
Mapped:         117024 kB
Slab:            19160 kB
Committed_AS:   126872 kB
PageTables:       1624 kB
VmallocTotal:   114680 kB
VmallocUsed:     26824 kB
VmallocChunk:    83600 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB
------------------------------- Attachment 4 
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
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_SCHED_SMT=y
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
------------------------------- Attachment 5
/tmp> cat /proc/version
Linux version 2.6.8.1 (root@lacerta) (gcc version 3.3.3) #1 SMP Mon Aug
30 18:38:21 EDT 2004

