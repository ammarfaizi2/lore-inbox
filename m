Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266959AbTBCSYe>; Mon, 3 Feb 2003 13:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266961AbTBCSYe>; Mon, 3 Feb 2003 13:24:34 -0500
Received: from air-2.osdl.org ([65.172.181.6]:16329 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266959AbTBCSYS>;
	Mon, 3 Feb 2003 13:24:18 -0500
Subject: Re: 2.5.59-mjb3 (scalability / NUMA patchset)
From: Mark Haverkamp <markh@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <125620000.1044238081@[10.10.2.4]>
References: <19270000.1038270642@flay><134580000.1039414279@titus>
	 <32230000.1039502522@titus><568990000.1040112629@titus>
	 <21380000.1040717475@titus> <821470000.1041579423@titus>
	 <214500000.1041821919@titus> <676880000.1042101078@titus>
	 <922170000.1042183282@titus> <437220000.1042531505@titus>
	 <190030000.1042787514@titus> <19610000.1043137151@titus>
	 <20200000.1043806571@flay>  <125620000.1044238081@[10.10.2.4]>
Content-Type: multipart/mixed; boundary="=-jV79QG3zaJvCQB7TsG1b"
Organization: 
Message-Id: <1044297228.29537.5.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 03 Feb 2003 10:33:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jV79QG3zaJvCQB7TsG1b
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2003-02-02 at 18:08, Martin J. Bligh wrote:
> The patchset contains mainly scalability and NUMA stuff, and anything 
> else that stops things from irritating me. It's meant to be pretty stable, 
> not so much a testing ground for new stuff.
> 
> I'd be very interested in feedback from anyone willing to test on any 
> platform, however large or small.
> 
> http://www.aracnet.com/~fletch/linux/2.5.59/patch-2.5.59-mjb3.bz2
> 

I tried 2.5.59-mjb3 today on our 16 processor numaq and got a boot
hang.  I had been running 2.5.59-mjb2 previously.  I have included the
console output and my config file.   


-- 
Mark Haverkamp <markh@osdl.org>

--=-jV79QG3zaJvCQB7TsG1b
Content-Disposition: attachment; filename=dev16-mjb3.log
Content-Type: text/plain; name=dev16-mjb3.log; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Loading l-2.5.59-mjb3.....................
Linux version 2.5.59-mjb3 (markh@markh1.pdx.osdl.net) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 SMP Mon Feb 3 09:32:21 PST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 0000000000100000 - 00000000f8000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec09000 (reserved)
 BIOS-e820: 00000000ffe80000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000400000000 (usable)
Reserving 10752 pages of KVA for lmem_map of node 1
Shrinking node 1 from 2097152 pages to 2086400 pages
Reserving 10752 pages of KVA for lmem_map of node 2
Shrinking node 2 from 3145728 pages to 3134976 pages
Reserving 10752 pages of KVA for lmem_map of node 3
Shrinking node 3 from 4194304 pages to 4183552 pages
Reserving total of 32256 pages for numa KVA remap
15488MB HIGHMEM available.
770MB LOWMEM available.
min_low_pfn = 968, max_low_pfn = 197120, highstart_pfn = 229376
Low memory ends at vaddr f0200000
node 0 will remap to vaddr f8000000 - f8000000
node 1 will remap to vaddr f5600000 - f8000000
node 2 will remap to vaddr f2c00000 - f5600000
node 3 will remap to vaddr f0200000 - f2c00000
High memory starts at vaddr f8000000
found SMP MP-table at 000f6040
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 1048576
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 193024 pages, LIFO batch:16
  HighMem zone: 851456 pages, LIFO batch:16
BUG: wrong zone alignment, it will crash
On node 1 totalpages: 1037824
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 1037824 pages, LIFO batch:16
On node 2 totalpages: 1037824
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 1037824 pages, LIFO batch:16
On node 3 totalpages: 1037824
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 1037824 pages, LIFO batch:16
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: IBM NUMA Product ID: SBB          Found an OEM MPC table at   6009b0 - parsing it ... 
Translation: record 0, type 1, quad 0, global 3, local 3
Translation: record 1, type 1, quad 0, global 1, local 1
Translation: record 2, type 1, quad 0, global 1, local 1
Translation: record 3, type 1, quad 0, global 1, local 1
Translation: record 4, type 1, quad 1, global 1, local 3
Translation: record 5, type 1, quad 1, global 1, local 1
Translation: record 6, type 1, quad 1, global 1, local 1
Translation: record 7, type 1, quad 1, global 1, local 1
Translation: record 8, type 1, quad 2, global 1, local 3
Translation: record 9, type 1, quad 2, global 1, local 1
Translation: record 10, type 1, quad 2, global 1, local 1
Translation: record 11, type 1, quad 2, global 1, local 1
Translation: record 12, type 1, quad 3, global 1, local 3
Translation: record 13, type 1, quad 3, global 1, local 1
Translation: record 14, type 1, quad 3, global 1, local 1
Translation: record 15, type 1, quad 3, global 1, local 1
Translation: record 16, type 3, quad 0, global 0, local 0
Translation: record 17, type 3, quad 0, global 1, local 1
Translation: record 18, type 4, quad 0, global 8, local 18
Translation: record 19, type 3, quad 1, global 2, local 0
Translation: record 20, type 3, quad 1, global 3, local 1
Translation: record 21, type 4, quad 1, global 9, local 18
Translation: record 22, type 3, quad 2, global 4, local 0
Translation: record 23, type 3, quad 2, global 5, local 1
Translation: record 24, type 4, quad 2, global 10, local 18
Translation: record 25, type 3, quad 3, global 6, local 0
Translation: record 26, type 3, quad 3, global 7, local 1
Translation: record 27, type 4, quad 3, global 11, local 18
Translation: record 28, type 2, quad 0, global 13, local 14
Translation: record 29, type 2, quad 0, global 14, local 13
Translation: record 30, type 2, quad 1, global 15, local 14
Translation: record 31, type 2, quad 1, global 16, local 13
Translation: record 32, type 2, quad 2, global 17, local 14
Translation: record 33, type 2, quad 2, global 18, local 13
Translation: record 34, type 2, quad 3, global 19, local 14
Translation: record 35, type 2, quad 3, global 20, local 13
APIC at: 0xFEC08000
Processor #0 6:7 APIC version 17 (quad 0, apic 1)
Processor #4 6:7 APIC version 17 (quad 0, apic 8)
Processor #1 6:7 APIC version 17 (quad 0, apic 2)
Processor #2 6:7 APIC version 17 (quad 0, apic 4)
Processor #0 6:7 APIC version 17 (quad 1, apic 17)
Processor #4 6:7 APIC version 17 (quad 1, apic 24)
Processor #1 6:7 APIC version 17 (quad 1, apic 18)
Processor #2 6:7 APIC version 17 (quad 1, apic 20)
Processor #0 6:7 APIC version 17 (quad 2, apic 33)
Processor #4 6:7 APIC version 17 (quad 2, apic 40)
Processor #1 6:7 APIC version 17 (quad 2, apic 34)
Processor #2 6:7 APIC version 17 (quad 2, apic 36)
Processor #0 6:7 APIC version 17 (quad 3, apic 49)
Processor #4 6:7 APIC version 17 (quad 3, apic 56)
Processor #1 6:7 APIC version 17 (quad 3, apic 50)
Processor #2 6:7 APIC version 17 (quad 3, apic 52)
Bus #0 is PCI    (node 0)
Bus #1 is PCI    (node 0)
Bus #8 is EISA   (node 0)
Bus #2 is PCI    (node 1)
Bus #3 is PCI    (node 1)
Bus #9 is EISA   (node 1)
Bus #4 is PCI    (node 2)
Bus #5 is PCI    (node 2)
Bus #10 is EISA   (node 2)
Bus #6 is PCI    (node 3)
Bus #7 is PCI    (node 3)
Bus #11 is EISA   (node 3)
I/O APIC #13 Version 17 at 0xFE800000.
I/O APIC #14 Version 17 at 0xFE801000.
I/O APIC #15 Version 17 at 0xFE840000.
I/O APIC #16 Version 17 at 0xFE841000.
I/O APIC #17 Version 17 at 0xFE880000.
I/O APIC #18 Version 17 at 0xFE881000.
I/O APIC #19 Version 17 at 0xFE8C0000.
I/O APIC #20 Version 17 at 0xFE8C1000.
Enabling APIC mode:  NUMA-Q.  Using 8 I/O APICs
Processors: 16
Building zonelist for node : 0
Building zonelist for node : 1
Building zonelist for node : 2
Building zonelist for node : 3
Kernel command line: BOOT_IMAGE=l-2.5.59-mjb3 ro root=802 BOOT_FILE=/boot/vmlinuz-2.5.59-mjb3 console=ttyS0,38400 console=tty1
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 495.202 MHz processor.
Console: colour VGA+ 80x25

Warning! Detected 1660695 micro-second gap between interrupts.
  Compensating for 1659 lost ticks.
Call Trace:
 [<c010bb38>] handle_IRQ_event+0x38/0x60
 [<c010bd3e>] do_IRQ+0x9e/0x110
 [<c0105000>] rest_init+0x0/0x60
 [<c010a30e>] common_interrupt+0x42/0x58

Calibrating delay loop... 974.84 BogoMIPS
Initializing highpages for node 0
Initializing highpages for node 1
Initializing highpages for node 2
Initializing highpages for node 3
Memory: 16469460k/16777216k available (1596k kernel code, 45388k reserved, 606k data, 288k init, 15728640k highmem)
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Katmai) stepping 03
per-CPU timeslice cutoff: 1461.65 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
Leaving ESR disabled.
Mapping cpu 0 to node 0
Remapping cross-quad port I/O for 4 quads
xquad_portio vaddr 0xf8800000, len 00100000
Booting processor 1/2 eip 2000
Storing NMI vector
Initializing CPU#1
masked ExtINT on CPU#1
Leaving ESR disabled.
Mapping cpu 1 to node 0
Calibrating delay loop... 987.13 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU1: Intel Pentium III (Katmai) stepping 03
Booting processor 2/4 eip 2000
Storing NMI vector
Initializing CPU#2
masked ExtINT on CPU#2
Leaving ESR disabled.
Mapping cpu 2 to node 0
Calibrating delay loop... 987.13 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU2: Intel Pentium III (Katmai) stepping 03
Booting processor 3/8 eip 2000
Storing NMI vector
Initializing CPU#3
masked ExtINT on CPU#3
Leaving ESR disabled.
Mapping cpu 3 to node 0
Calibrating delay loop... 989.18 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU3: Intel Pentium III (Katmai) stepping 03
Booting processor 4/17 eip 2000
Storing NMI vector
Initializing CPU#4
masked ExtINT on CPU#4
Leaving ESR disabled.
Mapping cpu 4 to node 1
Calibrating delay loop... 985.08 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU4: Intel Pentium III (Katmai) stepping 03
Booting processor 5/18 eip 2000
Storing NMI vector
Initializing CPU#5
masked ExtINT on CPU#5
Leaving ESR disabled.
Mapping cpu 5 to node 1
Calibrating delay loop... 985.08 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU5: Intel Pentium III (Katmai) stepping 03
Booting processor 6/20 eip 2000
Storing NMI vector
Initializing CPU#6
masked ExtINT on CPU#6
Leaving ESR disabled.
Mapping cpu 6 to node 1
Calibrating delay loop... 985.08 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU6: Intel Pentium III (Katmai) stepping 03
Booting processor 7/24 eip 2000
Storing NMI vector
Initializing CPU#7
masked ExtINT on CPU#7
Leaving ESR disabled.
Mapping cpu 7 to node 1
Calibrating delay loop... 985.08 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU7: Intel Pentium III (Katmai) stepping 03
Booting processor 8/33 eip 2000
Storing NMI vector
Initializing CPU#8
masked ExtINT on CPU#8
Leaving ESR disabled.
Mapping cpu 8 to node 2
Calibrating delay loop... 985.08 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU8: Intel Pentium III (Katmai) stepping 03
Booting processor 9/34 eip 2000
Storing NMI vector
Initializing CPU#9
masked ExtINT on CPU#9
Leaving ESR disabled.
Mapping cpu 9 to node 2
Calibrating delay loop... 985.08 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU9: Intel Pentium III (Katmai) stepping 03
Booting processor 10/36 eip 2000
Storing NMI vector
Initializing CPU#10
masked ExtINT on CPU#10
Leaving ESR disabled.
Mapping cpu 10 to node 2
Calibrating delay loop... 985.08 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU10: Intel Pentium III (Katmai) stepping 03
Booting processor 11/40 eip 2000
Storing NMI vector
Initializing CPU#11
masked ExtINT on CPU#11
Leaving ESR disabled.
Mapping cpu 11 to node 2
Calibrating delay loop... 985.08 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU11: Intel Pentium III (Katmai) stepping 03
Booting processor 12/49 eip 2000
Storing NMI vector
Initializing CPU#12
masked ExtINT on CPU#12
Leaving ESR disabled.
Mapping cpu 12 to node 3
Calibrating delay loop... 985.08 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU12: Intel Pentium III (Katmai) stepping 03
Booting processor 13/50 eip 2000
Storing NMI vector
Initializing CPU#13
masked ExtINT on CPU#13
Leaving ESR disabled.
Mapping cpu 13 to node 3
Calibrating delay loop... 985.08 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU13: Intel Pentium III (Katmai) stepping 03
Booting processor 14/52 eip 2000
Storing NMI vector
Initializing CPU#14
masked ExtINT on CPU#14
Leaving ESR disabled.
Mapping cpu 14 to node 3
Calibrating delay loop... 985.08 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU14: Intel Pentium III (Katmai) stepping 03
Booting processor 15/56 eip 2000
Storing NMI vector
Initializing CPU#15
masked ExtINT on CPU#15
Leaving ESR disabled.
Mapping cpu 15 to node 3
Calibrating delay loop... 987.13 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU15: Intel Pentium III (Katmai) stepping 03
Total of 16 processors activated (15761.40 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ... failed.
...trying to set up timer as Virtual Wire IRQ...<4>
Warning! Detected 99069 micro-second gap between interrupts.
  Compensating for 98 lost ticks.
Call Trace:
 [<c010bb38>] handle_IRQ_event+0x38/0x60
 [<c010bd3e>] do_IRQ+0x9e/0x110
 [<c010a30e>] common_interrupt+0x42/0x58

 works.
testing the IO APIC.......................








.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 494.0860 MHz.
..... host bus clock speed is 89.0974 MHz.

Warning! Detected 130932 micro-second gap between interrupts.
  Compensating for 129 lost ticks.
Call Trace:
 [<c010bb38>] handle_IRQ_event+0x38/0x60
 [<c010bd3e>] do_IRQ+0x9e/0x110
 [<c010a30e>] common_interrupt+0x42/0x58

checking TSC synchronization across 16 CPUs: 

Warning! Detected 7720312 micro-second gap between interrupts.
  Compensating for 7719 lost ticks.
Call Trace:
 [<c010bb38>] handle_IRQ_event+0x38/0x60
 [<c010bd3e>] do_IRQ+0x9e/0x110
 [<c010a30e>] common_interrupt+0x42/0x58

BIOS BUG: CPU#0 improperly initialized, has -15606 usecs TSC skew! FIXED.
BIOS BUG: CPU#1 improperly initialized, has -15606 usecs TSC skew! FIXED.
BIOS BUG: CPU#2 improperly initialized, has -15606 usecs TSC skew! FIXED.
BIOS BUG: CPU#3 improperly initialized, has -15606 usecs TSC skew! FIXED.
BIOS BUG: CPU#4 improperly initialized, has -812 usecs TSC skew! FIXED.
BIOS BUG: CPU#5 improperly initialized, has -812 usecs TSC skew! FIXED.
BIOS BUG: CPU#6 improperly initialized, has -812 usecs TSC skew! FIXED.
BIOS BUG: CPU#7 improperly initialized, has -812 usecs TSC skew! FIXED.
BIOS BUG: CPU#8 improperly initialized, has 14807 usecs TSC skew! FIXED.
BIOS BUG: CPU#9 improperly initialized, has 14807 usecs TSC skew! FIXED.
BIOS BUG: CPU#10 improperly initialized, has 14807 usecs TSC skew! FIXED.
BIOS BUG: CPU#11 improperly initialized, has 14807 usecs TSC skew! FIXED.
BIOS BUG: CPU#12 improperly initialized, has 1611 usecs TSC skew! FIXED.
BIOS BUG: CPU#13 improperly initialized, has 1611 usecs TSC skew! FIXED.
BIOS BUG: CPU#14 improperly initialized, has 1611 usecs TSC skew! FIXED.
BIOS BUG: CPU#15 improperly initialized, has 1611 usecs TSC skew! FIXED.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1




--=-jV79QG3zaJvCQB7TsG1b
Content-Disposition: attachment; filename=.config
Content-Type: text/plain; name=.config; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_SWAP=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=16

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_X86_PC is not set
# CONFIG_X86_VOYAGER is not set
CONFIG_X86_NUMAQ=y
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PREFETCH=y
CONFIG_X86_CMOV=y
# CONFIG_HUGETLB_PAGE is not set
CONFIG_SMP=y
# CONFIG_PREEMPT is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_NR_CPUS=32
CONFIG_NUMA=y
CONFIG_DISCONTIGMEM=y
CONFIG_HAVE_ARCH_BOOTMEM_NODE=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
# CONFIG_05GB is not set
CONFIG_1GB=y
# CONFIG_2GB is not set
# CONFIG_3GB is not set
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
# CONFIG_HIGHPTE is not set
# CONFIG_4K_STACK is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_100HZ is not set
CONFIG_1000HZ=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI Support
#
# CONFIG_ACPI is not set
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_SCx200 is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_LBD=y

#
# ATA/ATAPI/MFM/RLL device support
#
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
# CONFIG_CHR_DEV_SG is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
CONFIG_SCSI_QLOGIC_ISP=y
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_XFRM_USER is not set
# CONFIG_IPV6 is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
CONFIG_ADAPTEC_STARFIRE=y
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
CONFIG_EEPRO100=y
# CONFIG_E100 is not set
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
# CONFIG_NET_POCKET is not set

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
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices (depends on LLC=y)
#
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
# CONFIG_SERIO is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

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
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# I2C Hardware Sensors Mainboard support
#

#
# I2C Hardware Sensors Chip support
#

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_INTEL_RNG=y
# CONFIG_AMD_RNG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_XATTR is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
# CONFIG_FAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_TMPFS is not set
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_XFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=y
# CONFIG_SUNRPC_GSS is not set
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
# CONFIG_CIFS is not set
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=y

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_X86_REMOTE_DEBUG is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_EARLY_PRINTK is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_KALLSYMS=y
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y

--=-jV79QG3zaJvCQB7TsG1b--

