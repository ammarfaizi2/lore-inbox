Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318563AbSGZUOp>; Fri, 26 Jul 2002 16:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318565AbSGZUNG>; Fri, 26 Jul 2002 16:13:06 -0400
Received: from holomorphy.com ([66.224.33.161]:13216 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318559AbSGZUM2>;
	Fri, 26 Jul 2002 16:12:28 -0400
Date: Fri, 26 Jul 2002 13:15:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@tech9.net>
Cc: Andrew Morton <akpm@zip.com.au>, Ravikiran G Thirumalai <kiran@in.ibm.com>,
       linux-kernel@vger.kernel.org, lse <lse-tech@lists.sourceforge.net>,
       riel@conectiva.com.br, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Lse-tech] Re: [RFC] Scalable statistics counters using kmalloc_percpu
Message-ID: <20020726201526.GZ2907@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Love <rml@tech9.net>, Andrew Morton <akpm@zip.com.au>,
	Ravikiran G Thirumalai <kiran@in.ibm.com>,
	linux-kernel@vger.kernel.org, lse <lse-tech@lists.sourceforge.net>,
	riel@conectiva.com.br, Rusty Russell <rusty@rustcorp.com.au>
References: <20020726204033.D18570@in.ibm.com> <3D41990A.EDC1A530@zip.com.au> <20020726194643.GX2907@holomorphy.com> <1027713012.2443.49.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027713012.2443.49.camel@sinai>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 11:46:34AM -0700, Andrew Morton wrote:
>>> Oh dear.  Most people only have two CPUs.
>>> Rusty, can we *please* fix this?  Really soon?

On Fri, 2002-07-26 at 12:46, William Lee Irwin III wrote:
>> I'll post the panic triggered by lowering NR_CPUS shortly. There's
>> an ugly showstopping i386 arch code issue here.

On Fri, Jul 26, 2002 at 12:50:12PM -0700, Robert Love wrote:
> In current 2.5?  I thought Andrew and I fixed all those issues and
> pushed them to Linus...
> The `configurable NR_CPUS' patch works fine for me.  I always boot with
> NR_CPUS=2.

No idea who it works for, it sure doesn't work here. Behold:


Script started on Fri Jul 26 12:55:23 2002
Linux version 2.5.28-akpm-1 (wli@megeira) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Fri Jul 26 09:05:07 PDT 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 0000000000100000 - 00000000e0000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec09000 (reserved)
 BIOS-e820: 00000000ffe80000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000400000000 (usable)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 0000000000100000 - 00000000e0000000 (usable)
 user: 00000000fec00000 - 00000000fec09000 (reserved)
 user: 00000000ffe80000 - 0000000100000000 (reserved)
 user: 0000000100000000 - 0000000400000000 (usable)
15488MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f6040
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 4194304
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 3964928 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: IBM NUMA Product ID: SBB          APIC at: 0xFEC08000
Found an OEM MPC table at   7009c8 - parsing it ... 
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
Translation: record 18, type 3, quad 0, global 2, local 2
Translation: record 19, type 4, quad 0, global 12, local 18
Translation: record 20, type 3, quad 1, global 3, local 0
Translation: record 21, type 3, quad 1, global 4, local 1
Translation: record 22, type 3, quad 1, global 5, local 2
Translation: record 23, type 4, quad 1, global 13, local 18
Translation: record 24, type 3, quad 2, global 6, local 0
Translation: record 25, type 3, quad 2, global 7, local 1
Translation: record 26, type 3, quad 2, global 8, local 2
Translation: record 27, type 4, quad 2, global 14, local 18
Translation: record 28, type 3, quad 3, global 9, local 0
Translation: record 29, type 3, quad 3, global 10, local 1
Translation: record 30, type 3, quad 3, global 11, local 2
Translation: record 31, type 4, quad 3, global 15, local 18
Translation: record 32, type 2, quad 0, global 13, local 14
Translation: record 33, type 2, quad 0, global 14, local 13
Translation: record 34, type 2, quad 1, global 15, local 14
Translation: record 35, type 2, quad 1, global 16, local 13
Translation: record 36, type 2, quad 2, global 17, local 14
Translation: record 37, type 2, quad 2, global 18, local 13
Translation: record 38, type 2, quad 3, global 19, local 14
Translation: record 39, type 2, quad 3, global 20, local 13
Processor #0 6:10 APIC version 17 (quad 0, apic 1)
Processor #4 6:10 APIC version 17 (quad 0, apic 8)
Processor #1 6:10 APIC version 17 (quad 0, apic 2)
Processor #2 6:10 APIC version 17 (quad 0, apic 4)
Processor #0 6:10 APIC version 17 (quad 1, apic 17)
Processor #4 6:10 APIC version 17 (quad 1, apic 24)
Processor #1 6:10 APIC version 17 (quad 1, apic 18)
Processor #2 6:10 APIC version 17 (quad 1, apic 20)
Processor #0 6:10 APIC version 17 (quad 2, apic 33)
Processor #4 6:10 APIC version 17 (quad 2, apic 40)
Processor #1 6:10 APIC version 17 (quad 2, apic 34)
Processor #2 6:10 APIC version 17 (quad 2, apic 36)
Processor #0 6:10 APIC version 17 (quad 3, apic 49)
Processor #4 6:10 APIC version 17 (quad 3, apic 56)
Processor #1 6:10 APIC version 17 (quad 3, apic 50)
Processor #2 6:10 APIC version 17 (quad 3, apic 52)
Bus #0 is PCI    (node 0)
Bus #1 is PCI    (node 0)
Bus #2 is PCI    (node 0)
Bus #12 is EISA   (node 0)
Bus #3 is PCI    (node 1)
Bus #4 is PCI    (node 1)
Bus #5 is PCI    (node 1)
Bus #13 is EISA   (node 1)
Bus #6 is PCI    (node 2)
Bus #7 is PCI    (node 2)
Bus #8 is PCI    (node 2)
Bus #14 is EISA   (node 2)
Bus #9 is PCI    (node 3)
Bus #10 is PCI    (node 3)
Bus #11 is PCI    (node 3)
Bus #15 is EISA   (node 3)
I/O APIC #13 Version 17 at 0xFE800000.
I/O APIC #14 Version 17 at 0xFE801000.
I/O APIC #15 Version 17 at 0xFE840000.
I/O APIC #16 Version 17 at 0xFE841000.
I/O APIC #17 Version 17 at 0xFE880000.
I/O APIC #18 Version 17 at 0xFE881000.
I/O APIC #19 Version 17 at 0xFE8C0000.
I/O APIC #20 Version 17 at 0xFE8C1000.
Processors: 16
Kernel command line: root=/dev/sda2 console=ttyS0,38400n8 mem=16777216K
Initializing CPU#0
Loading GDT/IDT for CPU#0
Loaded per-cpu LDT/TSS for CPU#0
Cleaned up FPU and debug regs for CPU#0
Detected 700.274 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1380.35 BogoMIPS
Memory: 16069096k/16777216k available (1370k kernel code, 183444k reserved, 530k data, 260k init, 15335424k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Remapping cross-quad port I/O for 4 quads
xquad_portio vaddr 0x00000000, len 00200000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU0: Intel 00/0a stepping 04
per-CPU timeslice cutoff: 5846.34 usecs.
task migration cache decay timeout: 6 msecs.
enabled ExtINT on CPU#0
Leaving ESR disabled.
Booting processor 1/2 eip 2000
Initializing CPU#1
Loading GDT/IDT for CPU#1
Loaded per-cpu LDT/TSS for CPU#1
Cleaned up FPU and debug regs for CPU#1
masked ExtINT on CPU#1
Leaving ESR disabled.
Calibrating delay loop... 1396.73 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU1: Intel 00/0a stepping 04
Restoring NMI vector
Booting processor 2/4 eip 2000
Initializing CPU#2
Loading GDT/IDT for CPU#2
Loaded per-cpu LDT/TSS for CPU#2
Cleaned up FPU and debug regs for CPU#2
masked ExtINT on CPU#2
Leaving ESR disabled.
Calibrating delay loop... 1396.73 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU2: Intel 00/0a stepping 00
Restoring NMI vector
Booting processor 3/8 eip 2000
Initializing CPU#3
Loading GDT/IDT for CPU#3
Loaded per-cpu LDT/TSS for CPU#3
Cleaned up FPU and debug regs for CPU#3
masked ExtINT on CPU#3
Leaving ESR disabled.
Calibrating delay loop... 1396.73 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU3: Intel 00/0a stepping 04
Restoring NMI vector
Booting processor 4/17 eip 2000
Initializing CPU#4
Loading GDT/IDT for CPU#4
Loaded per-cpu LDT/TSS for CPU#4
Cleaned up FPU and debug regs for CPU#4
masked ExtINT on CPU#4
Leaving ESR disabled.
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU4: Intel 00/0a stepping 01
Restoring NMI vector
Booting processor 5/18 eip 2000
Initializing CPU#5
Loading GDT/IDT for CPU#5
Loaded per-cpu LDT/TSS for CPU#5
Cleaned up FPU and debug regs for CPU#5
masked ExtINT on CPU#5
Leaving ESR disabled.
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU5: Intel 00/0a stepping 01
Restoring NMI vector
Booting processor 6/20 eip 2000
Initializing CPU#6
Loading GDT/IDT for CPU#6
Loaded per-cpu LDT/TSS for CPU#6
Cleaned up FPU and debug regs for CPU#6
masked ExtINT on CPU#6
Leaving ESR disabled.
Calibrating delay loop... 1388.54 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU6: Intel 00/0a stepping 01
Restoring NMI vector
Booting processor 7/24 eip 2000
Initializing CPU#7
Loading GDT/IDT for CPU#7
Loaded per-cpu LDT/TSS for CPU#7
Cleaned up FPU and debug regs for CPU#7
masked ExtINT on CPU#7
Leaving ESR disabled.
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU7: Intel 00/0a stepping 01
Restoring NMI vector
Booting processor 8/33 eip 2000
Initializing CPU#8
Loading GDT/IDT for CPU#8
Loaded per-cpu LDT/TSS for CPU#8
Cleaned up FPU and debug regs for CPU#8
masked ExtINT on CPU#8
Leaving ESR disabled.
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU8: Intel 00/0a stepping 04
Restoring NMI vector
Booting processor 9/34 eip 2000
Initializing CPU#9
Loading GDT/IDT for CPU#9
Loaded per-cpu LDT/TSS for CPU#9
Cleaned up FPU and debug regs for CPU#9
masked ExtINT on CPU#9
Leaving ESR disabled.
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU9: Intel 00/0a stepping 04
Restoring NMI vector
Booting processor 10/36 eip 2000
Initializing CPU#10
Loading GDT/IDT for CPU#10
Loaded per-cpu LDT/TSS for CPU#10
Cleaned up FPU and debug regs for CPU#10
masked ExtINT on CPU#10
Leaving ESR disabled.
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU10: Intel 00/0a stepping 04
Restoring NMI vector
Booting processor 11/40 eip 2000
Initializing CPU#11
Loading GDT/IDT for CPU#11
Loaded per-cpu LDT/TSS for CPU#11
Cleaned up FPU and debug regs for CPU#11
masked ExtINT on CPU#11
Leaving ESR disabled.
Calibrating delay loop... 1388.54 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU11: Intel 00/0a stepping 04
Restoring NMI vector
Booting processor 12/49 eip 2000
Initializing CPU#12
Loading GDT/IDT for CPU#12
Loaded per-cpu LDT/TSS for CPU#12
Cleaned up FPU and debug regs for CPU#12
masked ExtINT on CPU#12
Leaving ESR disabled.
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU12: Intel 00/0a stepping 00
Restoring NMI vector
Booting processor 13/50 eip 2000
Initializing CPU#13
Loading GDT/IDT for CPU#13
Loaded per-cpu LDT/TSS for CPU#13
Cleaned up FPU and debug regs for CPU#13
masked ExtINT on CPU#13
Leaving ESR disabled.
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU13: Intel 00/0a stepping 04
Restoring NMI vector
Booting processor 14/52 eip 2000
Initializing CPU#14
Loading GDT/IDT for CPU#14
Loaded per-cpu LDT/TSS for CPU#14
Cleaned up FPU and debug regs for CPU#14
masked ExtINT on CPU#14
Leaving ESR disabled.
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU14: Intel 00/0a stepping 00
Restoring NMI vector
Booting processor 15/56 eip 2000
Initializing CPU#15
Loading GDT/IDT for CPU#15
Loaded per-cpu LDT/TSS for CPU#15
Cleaned up FPU and debug regs for CPU#15
masked ExtINT on CPU#15
Leaving ESR disabled.
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU15: Intel 00/0a stepping 00
Restoring NMI vector
Total of 16 processors activated (22274.04 BogoMIPS).
ENABLING IO-APIC IRQs
BIOS bug, IO-APIC#0 ID 0 is already used!...
... fixing up to 4. (tell your hw vendor)
...changing IO-APIC physical APIC ID to 4 ... ok.
BIOS bug, IO-APIC#1 ID 0 is already used!...
... fixing up to 5. (tell your hw vendor)
...changing IO-APIC physical APIC ID to 5 ... ok.
BIOS bug, IO-APIC#2 ID 0 is already used!...
... fixing up to 6. (tell your hw vendor)
...changing IO-APIC physical APIC ID to 6 ... ok.
BIOS bug, IO-APIC#3 ID 0 is already used!...
... fixing up to 7. (tell your hw vendor)
...changing IO-APIC physical APIC ID to 7 ... ok.
BIOS bug, IO-APIC#4 ID 0 is already used!...
... fixing up to 8. (tell your hw vendor)
...changing IO-APIC physical APIC ID to 8 ... ok.
BIOS bug, IO-APIC#5 ID 0 is already used!...
... fixing up to 9. (tell your hw vendor)
...changing IO-APIC physical APIC ID to 9 ... ok.
BIOS bug, IO-APIC#6 ID 0 is already used!...
... fixing up to 10. (tell your hw vendor)
...changing IO-APIC physical APIC ID to 10 ... ok.
BIOS bug, IO-APIC#7 ID 0 is already used!...
... fixing up to 11. (tell your hw vendor)
...changing IO-APIC physical APIC ID to 11 ... ok.
BIOS bug, IO-APIC#8 ID 0 is already used!...
... fixing up to 12. (tell your hw vendor)
...changing IO-APIC physical APIC ID to 12 ... ok.
BIOS bug, IO-APIC#9 ID 0 is already used!...
... fixing up to 13. (tell your hw vendor)
...changing IO-APIC physical APIC ID to 13 ... ok.
BIOS bug, IO-APIC#10 ID 0 is already used!...
... fixing up to 14. (tell your hw vendor)
...changing IO-APIC physical APIC ID to 14 ... ok.
BIOS bug, IO-APIC#11 ID 0 is already used!...
Kernel panic: Max APIC ID exceeded!

In idle task - not syncing

[detached]
$

Script done on Fri Jul 26 13:01:19 2002
