Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265025AbUFRHE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265025AbUFRHE0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 03:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265022AbUFRHE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 03:04:26 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:33409 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S265009AbUFRHEB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 03:04:01 -0400
Date: Fri, 18 Jun 2004 10:04:00 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-smp@vger.kernel.org
Subject: 2.6.7 ACPI OOPS (random dereferrencing)
Message-ID: <Pine.LNX.4.60.0406180957470.977@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Booting 2.6.7 on a machine, stops after "ACPI: Subsystem revision 
2004????" with a derefferencing NULL at random addresses. First was 
00000292, then 00000084. This changes after every reboot.
With "acpi=off" it boots ok (but without sibling cpu).

2.6.5 was ok.

I can try some patches if you want.
Thank you.

00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub 
Interface (rev 02)
00:02.0 VGA compatible controller: Intel Corp. 82865G Integrated Graphics 
Device (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 
(rev 02)
00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 
(rev 02)
00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 
(rev 02)
00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 
(rev 02)
00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI 
Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI 
Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 
02)
00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 
Storage Controller (rev 02)
00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage 
Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 
02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) 
AC'97 Audio Controller (rev 02)
01:08.0 Ethernet controller: Intel Corp. 82562EZ 10/100 Ethernet 
Controller (rev 01)


2.6.5 says:
Linux version 2.6.7 (root@hosting) (gcc version 3.3.4) #1 SMP Fri Jun 18 
09:20:0
4 EEST 2004
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001fe2fc00 (usable)
  BIOS-e820: 000000001fe2fc00 - 000000001fe30000 (ACPI NVS)
  BIOS-e820: 000000001fe30000 - 000000001fe40000 (ACPI data)
  BIOS-e820: 000000001fe40000 - 000000001fef0000 (ACPI NVS)
  BIOS-e820: 000000001fef0000 - 000000001ff00000 (reserved)
  BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (reserved)
  BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
510MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 130607
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 126511 pages, LIFO batch:16
   HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Intel MultiProcessor Specification v1.4
     Virtual Wire compatibility mode.
OEM ID:  Product ID: Springdale-G APIC at: 0xFEE00000
Processor #0 15:2 APIC version 20
I/O APIC #2 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Built 1 zonelists
Kernel command line: BOOT_IMAGE=K2.6.7 ro root=302 elevator=deadline 
init=/sbin/
init2 acpi=off
Initializing CPU#0
CPU 0 irqstacks, hard=c03f3000 soft=c03f1000
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2793.240 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 514084k/522428k available (1873k kernel code, 7572k reserved, 961k 
data,
  164k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... 
Ok.
Calibrating delay loop... 5521.40 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
per-CPU timeslice cutoff: 1462.56 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Total of 1 processors activated (5521.40 BogoMIPS).
WARNING: 1 siblings found for CPU0, should be 2
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
  IO-APIC (apicid-pin) 2-0, 2-21, 2-22 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 24.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... IRQ redirection table:
  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
  00 000 00  1    0    0   0   0    0    0    00
  01 001 01  0    0    0   0   0    1    1    39
  02 001 01  0    0    0   0   0    1    1    31
  03 001 01  0    0    0   0   0    1    1    41
  04 001 01  0    0    0   0   0    1    1    49
  05 001 01  0    0    0   0   0    1    1    51
  06 001 01  0    0    0   0   0    1    1    59
  07 001 01  0    0    0   0   0    1    1    61
  08 001 01  0    0    0   0   0    1    1    69
  09 001 01  1    1    0   0   0    1    1    71
  0a 001 01  0    0    0   0   0    1    1    79
  0b 001 01  0    0    0   0   0    1    1    81
  0c 001 01  0    0    0   0   0    1    1    89
  0d 001 01  0    0    0   0   0    1    1    91
  0e 001 01  0    0    0   0   0    1    1    99
  0f 001 01  0    0    0   0   0    1    1    A1
  10 001 01  1    1    0   1   0    1    1    A9
  11 001 01  1    1    0   1   0    1    1    B1
  12 001 01  1    1    0   1   0    1    1    B9
  13 001 01  1    1    0   1   0    1    1    C1
  14 001 01  1    1    0   1   0    1    1    C9
  15 009 09  1    0    0   0   0    0    2    00
  16 000 00  1    0    0   0   0    0    0    00
  17 001 01  1    1    0   1   0    1    1    D1
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ23 -> 0:23
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2792.0842 MHz.
..... host bus clock speed is 199.0488 MHz.
Brought up 1 CPUs
CPU0:  online
  domain 0: span 1
   groups: 1
   domain 1: span 1
    groups: 1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter disabled.
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 0000:00:1f.0
PCI->APIC IRQ transform: (B0,I2,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P2) -> 18
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P3) -> 23
PCI->APIC IRQ transform: (B0,I31,P0) -> 18
PCI->APIC IRQ transform: (B0,I31,P0) -> 18
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B1,I8,P0) -> 20
Machine check exception polling timer started.
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
...

---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/
