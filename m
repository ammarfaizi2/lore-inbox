Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268164AbUJGVLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268164AbUJGVLS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267815AbUJGVIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:08:46 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:8432 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S268146AbUJGUle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:41:34 -0400
Subject: Re: 2.6.9-rc3-mm3 fails to detect aic7xxx
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "K.R. Foley" <kr@cybsft.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
In-Reply-To: <20041007133956.39c2427e.akpm@osdl.org>
References: <1097178019.24355.39.camel@localhost>
	 <4165A369.60306@cybsft.com>  <20041007133956.39c2427e.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1097181679.25526.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 07 Oct 2004 13:41:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 13:39, Andrew Morton wrote:
> Were some earlier messages printed out, during the scsi bringup stage?
> 
> A full dmesg dump would be nice.

Curiously enough, there were no extra messages.  Are there some SCSI
debug cmdline things that I should include?

kernel --no-mem-option (nd)/dave/vmlinuz root=/dev/sda2 console=ttyS0,57600 pro
file=2 mem=512M debug
   [Linux-bzImage, setup=0xa00, size=0x16b451]

Linux version 2.6.9-rc3-mm3 (dave@kernel) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Thu Oct 7 12:32:50 PDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000e7ff9380 (usable)
 BIOS-e820: 00000000e7ff9380 - 00000000e8000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009dc00 (usable)
 user: 000000000009dc00 - 00000000000a0000 (reserved)
 user: 00000000000e0000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 0000000020000000 (usable)
0MB HIGHMEM available.
512MB LOWMEM available.
found SMP MP-table at 0009e1d0
On node 0 totalpages: 131072
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126976 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 IBM                                   ) @ 0x000fdfd0
ACPI: RSDT (v001 IBM    SERASSLT 0x00001001 IBM  0x45444f43) @ 0xe7ffff80
ACPI: FADT (v001 IBM    SERASSLT 0x00001001 IBM  0x45444f43) @ 0xe7ffff00
ACPI: MADT (v001 IBM    SERASSLT 0x00001001 IBM  0x45444f43) @ 0xe7fffe80
ACPI: DSDT (v001 IBM    SERASSLT 0x00001001 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x03] enabled)
Processor #3 6:10 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 17
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:10 APIC version 17
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
Processor #2 6:10 APIC version 17
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: IBM ENSW Product ID: NF 6000R SMP APIC at: 0xFEE00000
I/O APIC #14 Version 17 at 0xFEC00000.
I/O APIC #13 Version 17 at 0xFEC01000.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Processors: 4
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/sda2 console=ttyS0,57600 profile=2 mem=512M debugkernel profiling enabled (shift: 2)
CPU 0 irqstacks, hard=c043c000 soft=c041c000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 699.650 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 511192k/524288k available (1833k kernel code, 12556k reserved, 1161k data, 164k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1376.25 BogoMIPS (lpj=688128)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: After all inits, caps:        0383fbf7 00000000 00000000 00000040
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Cascades) stepping 01
per-CPU timeslice cutoff: 2927.35 usecs.
task migration cache decay timeout: 3 msecs.
Booting processor 1/0 eip 2000
CPU 1 irqstacks, hard=c043d000 soft=c041d000
Initializing CPU#1
Calibrating delay loop... 1396.73 BogoMIPS (lpj=698368)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: After all inits, caps:        0383fbf7 00000000 00000000 00000040
CPU1: Intel Pentium III (Cascades) stepping 01
Booting processor 2/1 eip 2000
CPU 2 irqstacks, hard=c043e000 soft=c041e000
Initializing CPU#2
Calibrating delay loop... 1396.73 BogoMIPS (lpj=698368)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: After all inits, caps:        0383fbf7 00000000 00000000 00000040
CPU2: Intel Pentium III (Cascades) stepping 01
Booting processor 3/2 eip 2000
CPU 3 irqstacks, hard=c043f000 soft=c041f000
Initializing CPU#3
Calibrating delay loop... 1396.73 BogoMIPS (lpj=698368)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: After all inits, caps:        0383fbf7 00000000 00000000 00000040
CPU3: Intel Pentium III (Cascades) stepping 01
Total of 4 processors activated (5566.46 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
checking TSC synchronization across 4 CPUs: passed.
Brought up 4 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd32c, last bus=8
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Discovered peer bus 02
PCI: Discovered peer bus 05
PCI->APIC IRQ transform: (B0,I5,P0) -> 16
PCI->APIC IRQ transform: (B0,I15,P0) -> 19
PCI->APIC IRQ transform: (B2,I1,P0) -> 17
PCI->APIC IRQ transform: (B2,I1,P1) -> 18
PCI->APIC IRQ transform: (B2,I5,P0) -> 24
PCI->APIC IRQ transform: (B5,I2,P0) -> 21
PCI->APIC IRQ transform: (B5,I2,P1) -> 26
PCI->APIC IRQ transform: (B6,I4,P0) -> 22
PCI->APIC IRQ transform: (B6,I5,P0) -> 27
PCI->APIC IRQ transform: (B6,I6,P0) -> 28
PCI->APIC IRQ transform: (B6,I7,P0) -> 29
IBM machine detected. Enabling interrupts during APM calls.
apm: BIOS not found.
Starting balanced_irq
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 5.3.19-k2
Copyright (c) 1999-2004 Intel Corporation.
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
pcnet32.c:v1.30i 06.28.2004 tsbogend@alpha.franken.de
pcnet32: PCnet/FAST III 79C975 at 0x2200, 00 02 55 fc 43 20 assigned IRQ 16.
eth2: registered as PCnet/FAST III 79C975
pcnet32: 1 cards_found.
e100: Intel(R) PRO/100 Network Driver, 3.1.4-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
e100: eth3: e100_probe: addr 0xefbfd000, irq 24, MAC addr 00:90:27:EE:90:09
st: Version 20040403, fixed bufsize 32768, s/g segs 256
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS/2 Generic Mouse on isa0060/serio1
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
VFS: Cannot open root device "sda2" or unknown-block(0,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)


-- Dave

