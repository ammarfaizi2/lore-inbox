Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267324AbRGPMZe>; Mon, 16 Jul 2001 08:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267327AbRGPMZY>; Mon, 16 Jul 2001 08:25:24 -0400
Received: from delta.Colorado.EDU ([128.138.139.9]:12554 "EHLO
	ibg.colorado.edu") by vger.kernel.org with ESMTP id <S267324AbRGPMZR>;
	Mon, 16 Jul 2001 08:25:17 -0400
Message-Id: <200107161225.GAA173748@ibg.colorado.edu>
To: linux-kernel@vger.kernel.org
Subject: Crash on bootup with 2.4.6-ac4
Organization: Institute for Behavioral Genetics
              University of Colorado
              Boulder, CO  80309-0447
X-Phone: +1 303 492 2843
X-FAX: +1 303 492 0852
X-URL: http://ibgwww.Colorado.EDU/~lessem/
X-Copyright: All original content is copyright 2001 Jeff Lessem.
X-Copyright: Quoted and non-original content may be copyright the
X-Copyright: original author or others.
Date: Mon, 16 Jul 2001 06:25:18 -0600
From: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying 2.4.6-ac4 on a Dell 8450 (8 processor Xeon PIII) with 8GB
of RAM.  The kernel has been compiled with 64GB support with gcc
2.95.4.

I am anxious to try the new AMI Megaraid driver and other
changes in -ac4, to see if they fix other problems I have been
having.  If there is any other information that would be relevant in
trouble shooting this problem, please let me know.

Attached below is the ksymoops log, and beneath that the boot log, up
until the crash.

Warning (multi_opt): you specified both -v and -V.  Using '-v linux/linux-ac/vmlinux'

ksymoops 2.4.1 on i686 2.4.6.  Options used
     -v linux/linux-ac/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.6-ac4/ (specified)
     -m /boot/System.map-2.4.6-ac4 (specified)

No modules in ksyms, skipping objects
7552MB HIGHMEM available.
cpu: 0, clocks: 1000150, slice: 111127
cpu: 7, clocks: 1000150, slice: 111127
cpu: 5, clocks: 1000150, slice: 111127
cpu: 1, clocks: 1000150, slice: 111127
cpu: 6, clocks: 1000150, slice: 111127
cpu: 3, clocks: 1000150, slice: 111127
cpu: 4, clocks: 1000150, slice: 111127
cpu: 2, clocks: 1000150, slice: 111127
Unable to handle kernel paging request at virtual address f8801000
c024fab6
*pde = 00000000
Oops: 0000
CPU:    7
EIP:    0010:[<c024fab6>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010203
eax: f8800000   ebx: f88000e9   ecx: 03ff810c   edx: 000006f0
esi: 00000f17   edi: c0203596   ebp: ecc3ff80   esp: c9cbbfbc
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c9cbb000)
Stack: c027f6ec c024bfc0 00000000 0008e000 51000000 03ff80e9 00000024 c024c884 
       c9cba000 c024c8c2 c0105075 00010f00 c024bfc0 c01054fc 00000000 00000078 
       00098700 
Call Trace: [<c0105075>] [<c01054fc>] 
Code: 8a 04 1e 00 44 24 13 46 39 ee 72 f4 80 7c 24 13 00 74 08 53 

>>EIP; c024fab6 <sbf_init+ee/198>   <=====
Trace; c0105075 <init+29/154>
Trace; c01054fc <kernel_thread+28/38>
Code;  c024fab6 <sbf_init+ee/198>
00000000 <_EIP>:
Code;  c024fab6 <sbf_init+ee/198>   <=====
   0:   8a 04 1e                  mov    (%esi,%ebx,1),%al   <=====
Code;  c024fab9 <sbf_init+f1/198>
   3:   00 44 24 13               add    %al,0x13(%esp,1)
Code;  c024fabd <sbf_init+f5/198>
   7:   46                        inc    %esi
Code;  c024fabe <sbf_init+f6/198>
   8:   39 ee                     cmp    %ebp,%esi
Code;  c024fac0 <sbf_init+f8/198>
   a:   72 f4                     jb     0 <_EIP>
Code;  c024fac2 <sbf_init+fa/198>
   c:   80 7c 24 13 00            cmpb   $0x0,0x13(%esp,1)
Code;  c024fac7 <sbf_init+ff/198>
  11:   74 08                     je     1b <_EIP+0x1b> c024fad1 <sbf_init+109/198>
Code;  c024fac9 <sbf_init+101/198>
  13:   53                        push   %ebx

 <0>Kernel panic: Attempted to kill init!

1 warning issued.  Results may not be reliable.


Linux version 2.4.6-ac4 (root@octopus) (gcc version 2.95.4 20010522 (Debian prerelease)) #2 SMP Mon Jul 16 12:06:23 BST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009d400 (usable)
 BIOS-e820: 000000000009d400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000003ff8000 (usable)
 BIOS-e820: 0000000003ff8000 - 0000000003fffc00 (ACPI data)
 BIOS-e820: 0000000003fffc00 - 0000000004000000 (ACPI NVS)
 BIOS-e820: 0000000004000000 - 00000000f0000000 (usable)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000210000000 (usable)
7552MB HIGHMEM available.
found SMP MP-table at 000f6570
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 2162688
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 1933312 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: OCPRF100     APIC at: 0xFEE00000
Processor #2 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
Processor #3 Pentium(tm) Pro APIC version 17
Processor #4 Pentium(tm) Pro APIC version 17
Processor #5 Pentium(tm) Pro APIC version 17
Processor #6 Pentium(tm) Pro APIC version 17
Processor #7 Pentium(tm) Pro APIC version 17
I/O APIC #8 Version 19 at 0xFEC00000.
Processors: 8
Kernel command line: root=/dev/sdb1 console=ttyS0,38400 mem=8650752K
Initializing CPU#0
Detected 700.101 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1395.91 BogoMIPS
Memory: 8504468k/8650752k available (1026k kernel code, 145896k reserved, 285k data, 208k init, 7733248k highmem)
Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 524288 (order: 9, 2097152 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#0.
CPU0: Intel Pentium III (Cascades) stepping 01
per-CPU timeslice cutoff: 2923.17 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Cascades) stepping 01
Booting processor 2/1 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#2.
CPU2: Intel Pentium III (Cascades) stepping 01
Booting processor 3/3 eip 2000
Initializing CPU#3
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#3.
CPU3: Intel Pentium III (Cascades) stepping 01
Booting processor 4/4 eip 2000
Initializing CPU#4
masked ExtINT on CPU#4
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#4.
CPU4: Intel Pentium III (Cascades) stepping 01
Booting processor 5/5 eip 2000
Initializing CPU#5
masked ExtINT on CPU#5
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#5.
CPU5: Intel Pentium III (Cascades) stepping 01
Booting processor 6/6 eip 2000
Initializing CPU#6
masked ExtINT on CPU#6
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#6.
CPU6: Intel Pentium III (Cascades) stepping 01
Booting processor 7/7 eip 2000
Initializing CPU#7
masked ExtINT on CPU#7
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
Intel machine check reporting enabled on CPU#7.
CPU7: Intel Pentium III (Cascades) stepping 01
Total of 8 processors activated (11190.27 BogoMIPS).
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 8 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................

.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 700.1068 MHz.
..... host bus clock speed is 100.0150 MHz.
cpu: 0, clocks: 1000150, slice: 111127
CPU0<T0:1000144,T1:889008,D:9,S:111127,C:1000150>
cpu: 7, clocks: 1000150, slice: 111127
cpu: 5, clocks: 1000150, slice: 111127
cpu: 1, clocks: 1000150, slice: 111127
cpu: 6, clocks: 1000150, slice: 111127
cpu: 3, clocks: 1000150, slice: 111127
cpu: 4, clocks: 1000150, slice: 111127
cpu: 2, clocks: 1000150, slice: 111127
CPU1<T0:1000144,T1:777888,D:2,S:111127,C:1000150>
CPU2<T0:1000144,T1:666752,D:11,S:111127,C:1000150>
CPU3<T0:1000144,T1:555632,D:4,S:111127,C:1000150>
CPU4<T0:1000144,T1:444496,D:13,S:111127,C:1000150>
CPU5<T0:1000144,T1:333376,D:6,S:111127,C:1000150>
CPU6<T0:1000144,T1:222240,D:15,S:111127,C:1000150>
CPU7<T0:1000144,T1:111120,D:8,S:111127,C:1000150>
checking TSC synchronization across CPUs: 
BIOS BUG: CPU#0 improperly initialized, has -2 usecs TSC skew! FIXED.
BIOS BUG: CPU#2 improperly initialized, has 3 usecs TSC skew! FIXED.
BIOS BUG: CPU#3 improperly initialized, has -2 usecs TSC skew! FIXED.
BIOS BUG: CPU#6 improperly initialized, has 3 usecs TSC skew! FIXED.
PCI: PCI BIOS revision 2.10 entry at 0xfdaca, last bus=5
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus 02 [IRQ]
PCI: Discovered primary peer bus 04 [IRQ]
PCI: Discovered primary peer bus 05 [IRQ]
PCI: Using IRQ router PIIX [8086/7110] at 00:0f.0
PCI->APIC IRQ transform: (B0,I0,P0) -> 59
PCI->APIC IRQ transform: (B0,I4,P0) -> 61
PCI->APIC IRQ transform: (B0,I10,P0) -> 58
PCI->APIC IRQ transform: (B0,I10,P1) -> 18
PCI->APIC IRQ transform: (B0,I12,P0) -> 48
PCI->APIC IRQ transform: (B0,I15,P3) -> 49
PCI->APIC IRQ transform: (B2,I0,P0) -> 59
PCI->APIC IRQ transform: (B2,I4,P0) -> 50
PCI->APIC IRQ transform: (B4,I0,P0) -> 59
PCI->APIC IRQ transform: (B4,I4,P0) -> 32
PCI->APIC IRQ transform: (B5,I0,P0) -> 59
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Unable to handle kernel paging request at virtual address f8801000
 printing eip:
c024fab6
*pde = 00000000
Oops: 0000
CPU:    7
EIP:    0010:[<c024fab6>]
EFLAGS: 00010203
eax: f8800000   ebx: f88000e9   ecx: 03ff810c   edx: 000006f0
esi: 00000f17   edi: c0203596   ebp: ecc3ff80   esp: c9cbbfbc
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c9cbb000)
Stack: c027f6ec c024bfc0 00000000 0008e000 51000000 03ff80e9 00000024 c024c884 
       c9cba000 c024c8c2 c0105075 00010f00 c024bfc0 c01054fc 00000000 00000078 
       00098700 
Call Trace: [<c0105075>] [<c01054fc>] 

Code: 8a 04 1e 00 44 24 13 46 39 ee 72 f4 80 7c 24 13 00 74 08 53 
 <0>Kernel panic: Attempted to kill init!
 
