Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265678AbUFOPCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265678AbUFOPCr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 11:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265676AbUFOPCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 11:02:47 -0400
Received: from crianza.bmb.uga.edu ([128.192.34.109]:65408 "EHLO crianza")
	by vger.kernel.org with ESMTP id S265678AbUFOPAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 11:00:48 -0400
Date: Tue, 15 Jun 2004 11:00:36 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: processes hung in D (raid5/dm/ext3)
Message-ID: <20040615150036.GB12818@porto.bmb.uga.edu>
Reply-To: foo@porto.bmb.uga.edu
References: <20040615062236.GA12818@porto.bmb.uga.edu> <20040615030932.3ff1be80.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615030932.3ff1be80.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: foo@porto.bmb.uga.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 03:09:32AM -0700, Andrew Morton wrote:
> Wait for it to happen again, then do
> 
> 	echo t > /proc/sysrq-trigger
> 	dmesg -s 1000000 > foo
> 
> then send foo, foo.

Here you go.  I did dump 2f /dev/null /export/home.  The first time it
completed, the second it hung right away.

This is with 2.6.7-rc3-bk6 with no other patches, also compiled with a
newer gcc.

-ryan

Bootdata ok (command line is BOOT_IMAGE=Linux ro root=851 console=ttyS0,19200n8)
Linux version 2.6.7-rc3-bk6 (root@carignan) (gcc version 3.3.4 (Debian)) #1 SMP Tue Jun 15 02:35:08 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
 BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
Scanning NUMA topology in Northbridge 24
Number of nodes 2 (10010)
Node 0 MemBase 0000000000000000 Limit 000000003fffffff
Node 1 MemBase 0000000040000000 Limit 000000007fff0000
Using node hash shift of 24
Bootmem setup node 0 0000000000000000-000000003fffffff
Bootmem setup node 1 0000000040000000-000000007fff0000
No mptable found.
On node 0 totalpages: 262143
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 258047 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 262128
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 262128 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v002 ACPIAM                                    ) @ 0x00000000000f4680
ACPI: XSDT (v001 A M I  OEMXSDT  0x06000318 MSFT 0x00000097) @ 0x000000007fff0100
ACPI: FADT (v001 A M I  OEMFACP  0x06000318 MSFT 0x00000097) @ 0x000000007fff0281
ACPI: MADT (v001 A M I  OEMAPIC  0x06000318 MSFT 0x00000097) @ 0x000000007fff0380
ACPI: OEMB (v001 A M I  OEMBIOS  0x06000318 MSFT 0x00000097) @ 0x000000007ffff040
ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0x000000007fff3530
ACPI: DSDT (v001  0ABCF 0ABCF007 0x00000007 INTL 0x02002026) @ 0x0000000000000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfebfe000] global_irq_base[0x18])
IOAPIC[1]: Assigned apic_id 3
IOAPIC[1]: apic_id 3, version 17, address 0xfebfe000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xfebff000] global_irq_base[0x1c])
IOAPIC[2]: Assigned apic_id 4
IOAPIC[2]: apic_id 4, version 17, address 0xfebff000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ 1ee0000000 size 64 MB
Aperture from northbridge cpu 0 beyond 4GB. Ignoring.
No AGP bridge found
Built 2 zonelists
Kernel command line: BOOT_IMAGE=Linux ro root=851 console=ttyS0,19200n8
Initializing CPU#0
PID hash table entries: 16 (order 4: 256 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1394.765 MHz processor.
Console: colour VGA+ 80x25
Memory: 2062532k/2097088k available (2540k kernel code, 0k reserved, 1204k data, 180k init)
Calibrating delay loop... 2736.12 BogoMIPS
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU0: AMD Opteron(tm) Processor 240 stepping 01
per-CPU timeslice cutoff: 1024.50 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 rip 6000 rsp 10040e3ff58
Initializing CPU#1
Calibrating delay loop... 2785.28 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
AMD Opteron(tm) Processor 240 stepping 01
Total of 2 processors activated (5521.40 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23, 3-0, 3-1, 3-2, 3-3, 4-0, 4-1, 4-2, 4-3 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
Detected 12.453 MHz APIC timer.
checking TSC synchronization across 2 CPUs: passed.
time.c: Using PIT/TSC based timekeeping.
Brought up 2 CPUs
CPU0:  online
 domain 0: span 01
  groups: 01
  domain 1: span 03
   groups: 01 02
CPU1:  online
 domain 0: span 02
  groups: 02
  domain 1: span 03
   groups: 02 01
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
00:00:07[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
00:00:07[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18 Mode:1 Active:1)
00:00:07[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
00:00:07[D] -> 2-19 -> IRQ 19
IOAPIC[1]: Set PCI routing entry (3-3 -> 0xc9 -> IRQ 27 Mode:1 Active:1)
00:02:08[A] -> 3-3 -> IRQ 27
IOAPIC[1]: Set PCI routing entry (3-0 -> 0xd1 -> IRQ 24 Mode:1 Active:1)
00:02:08[B] -> 3-0 -> IRQ 24
IOAPIC[1]: Set PCI routing entry (3-1 -> 0xd9 -> IRQ 25 Mode:1 Active:1)
00:02:08[C] -> 3-1 -> IRQ 25
IOAPIC[1]: Set PCI routing entry (3-2 -> 0xe1 -> IRQ 26 Mode:1 Active:1)
00:02:08[D] -> 3-2 -> IRQ 26
IOAPIC[2]: Set PCI routing entry (4-0 -> 0xe9 -> IRQ 28 Mode:1 Active:1)
00:01:03[A] -> 4-0 -> IRQ 28
IOAPIC[2]: Set PCI routing entry (4-1 -> 0x32 -> IRQ 29 Mode:1 Active:1)
00:01:03[B] -> 4-1 -> IRQ 29
IOAPIC[2]: Set PCI routing entry (4-2 -> 0x3a -> IRQ 30 Mode:1 Active:1)
00:01:03[C] -> 4-2 -> IRQ 30
IOAPIC[2]: Set PCI routing entry (4-3 -> 0x42 -> IRQ 31 Mode:1 Active:1)
00:01:03[D] -> 4-3 -> IRQ 31
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
number of IO-APIC #3 registers: 4.
number of IO-APIC #4 registers: 4.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 02000000
.......     : arbitration: 02
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
 09 001 01  0    1    0   1   0    1    1    71
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
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #3......
.... register #00: 03000000
.......    : physical APIC id: 03
.... register #01: 00030011
.......     : max redirection entries: 0003
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  1    1    0   1   0    1    1    D1
 01 001 01  1    1    0   1   0    1    1    D9
 02 001 01  1    1    0   1   0    1    1    E1
 03 001 01  1    1    0   1   0    1    1    C9

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.... register #01: 00030011
.......     : max redirection entries: 0003
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  1    1    0   1   0    1    1    E9
 01 001 01  1    1    0   1   0    1    1    32
 02 001 01  1    1    0   1   0    1    1    3A
 03 001 01  1    1    0   1   0    1    1    42
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
IRQ24 -> 1:0
IRQ25 -> 1:1
IRQ26 -> 1:2
IRQ27 -> 1:3
IRQ28 -> 2:0
IRQ29 -> 2:1
IRQ30 -> 2:2
IRQ31 -> 2:3
.................................... done.
PCI: Using ACPI for IRQ routing
PCI-DMA: Disabling IOMMU.
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU1] (supports C1, 8 throttling states)
ACPI: Processor [CPU2] (supports C1)
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
hw_random: AMD768 system management I/O registers at 0x5000.
hw_random hardware driver 1.0.0 loaded
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 sec (nowayout= 0)
Linux agpgart interface v0.100 (c) Dave Jones
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
tg3.c:v3.5 (May 25, 2004)
eth0: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:51:d6:c9
eth0: HostTXDS[0] RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth1: Tigon3 [partno(BCM95704A7) rev 2003 PHY(5704)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:51:d6:ca
eth1: HostTXDS[0] RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
sym0: <875> rev 0x26 at pci 0000:03:04.0 irq 16
sym0: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18j
  Vendor: SONY      Model: SDX-400C          Rev: 0702
  Type:   Sequential-Access                  ANSI SCSI revision: 02
scsi(0:0:4:0): Beginning Domain Validation
sym0:4: wide asynchronous.
sym0:4: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 15)
scsi(0:0:4:0): Domain Validation skipping write tests
scsi(0:0:4:0): Ending Domain Validation
  Vendor: OVERLAND  Model: LIBRARYPRO        Rev: 0417
  Type:   Medium Changer                     ANSI SCSI revision: 02
scsi(0:0:6:0): Beginning Domain Validation
sym0:6: wide asynchronous.
sym0:6: FAST-10 WIDE SCSI 20.0 MB/s ST (100.0 ns, offset 15)
scsi(0:0:6:0): Domain Validation skipping write tests
scsi(0:0:6:0): Ending Domain Validation
st: Version 20040403, fixed bufsize 32768, s/g segs 256
Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
st0: try direct i/o: yes (alignment 512 B), max page reachable by HBA 1048575
Attached scsi generic sg0 at scsi0, channel 0, id 4, lun 0,  type 1
Attached scsi generic sg1 at scsi0, channel 0, id 6, lun 0,  type 8
Fusion MPT base driver 3.01.06
Copyright (c) 1999-2004 LSI Logic Corporation
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
mptbase: Initiating ioc1 bringup
ioc1: 53C1030: Capabilities={Initiator}
Fusion MPT SCSI Host driver 3.01.06
scsi1 : ioc0: LSI53C1030, FwRev=01030600h, Ports=1, MaxQ=255, IRQ=24
  Vendor: SUPER     Model: GEM318            Rev: 0   
  Type:   Processor                          ANSI SCSI revision: 02
Attached scsi generic sg2 at scsi1, channel 0, id 8, lun 0,  type 3
  Vendor: SEAGATE   Model: ST3146807LC       Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sda: 286749488 512-byte hdwr sectors (146816 MB)
SCSI device sda: drive cache: write back
 sda: sda1
Attached scsi disk sda at scsi1, channel 0, id 9, lun 0
Attached scsi generic sg3 at scsi1, channel 0, id 9, lun 0,  type 0
  Vendor: SEAGATE   Model: ST3146807LC       Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdb: 286749488 512-byte hdwr sectors (146816 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 10, lun 0
Attached scsi generic sg4 at scsi1, channel 0, id 10, lun 0,  type 0
  Vendor: SEAGATE   Model: ST3146807LC       Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdc: 286749488 512-byte hdwr sectors (146816 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1
Attached scsi disk sdc at scsi1, channel 0, id 11, lun 0
Attached scsi generic sg5 at scsi1, channel 0, id 11, lun 0,  type 0
  Vendor: SEAGATE   Model: ST3146807LC       Rev: 0007
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdd: 286749488 512-byte hdwr sectors (146816 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1
Attached scsi disk sdd at scsi1, channel 0, id 12, lun 0
Attached scsi generic sg6 at scsi1, channel 0, id 12, lun 0,  type 0
  Vendor: SEAGATE   Model: ST3146807LC       Rev: 0007
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sde: 286749488 512-byte hdwr sectors (146816 MB)
SCSI device sde: drive cache: write back
 sde: sde1
Attached scsi disk sde at scsi1, channel 0, id 13, lun 0
Attached scsi generic sg7 at scsi1, channel 0, id 13, lun 0,  type 0
scsi2 : ioc1: LSI53C1030, FwRev=01030600h, Ports=1, MaxQ=255, IRQ=25
  Vendor: SEAGATE   Model: ST336607LW        Rev: 0007
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdf: 71687372 512-byte hdwr sectors (36704 MB)
SCSI device sdf: drive cache: write back
 sdf: sdf1 sdf2 sdf3 sdf4
Attached scsi disk sdf at scsi2, channel 0, id 0, lun 0
Attached scsi generic sg8 at scsi2, channel 0, id 0, lun 0,  type 0
USB Universal Host Controller Interface driver v2.2
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c /dev entries driver
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   generic_sse:  4256.000 MB/sec
raid5: using function: generic_sse (4256.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sde1 ...
md:  adding sde1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: bind<sdc1>
md: bind<sdd1>
md: bind<sde1>
md: running: <sde1><sdd1><sdc1><sdb1><sda1>
raid5: device sde1 operational as raid disk 4
raid5: device sdd1 operational as raid disk 3
raid5: device sdc1 operational as raid disk 2
raid5: device sdb1 operational as raid disk 1
raid5: device sda1 operational as raid disk 0
raid5: allocated 5300kB for md0
raid5: raid level 5 set md0 active with 5 out of 5 devices, algorithm 2
RAID5 conf printout:
 --- rd:5 wd:5 fd:0
 disk 0, o:1, dev:sda1
 disk 1, o:1, dev:sdb1
 disk 2, o:1, dev:sdc1
 disk 3, o:1, dev:sdd1
 disk 4, o:1, dev:sde1
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 180k freed
Adding 2097136k swap on /dev/sdf2.  Priority:-1 extents:1
EXT3 FS on sdf1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdf3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-32, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-34, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-33, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-35, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-11, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-12, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-13, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-14, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-15, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-16, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-17, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-18, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-19, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-20, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-21, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-22, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-23, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-24, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-25, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-26, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-27, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-28, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-29, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-30, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-31, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Ethernet Channel Bonding Driver: v2.6.0 (January 14, 2004)
bonding: MII link monitoring set to 100 ms
bonding: bond0: enslaving eth0 as an active interface with a down link.
bonding: bond0: enslaving eth1 as an active interface with a down link.
tg3: eth0: Link is up at 1000 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.
bonding: bond0: link status definitely up for interface eth0.
tg3: eth1: Link is up at 1000 Mbps, full duplex.
tg3: eth1: Flow control is off for TX and off for RX.
bonding: bond0: link status definitely up for interface eth1.
process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
SCSI-3 Opcodes & ASC/ASCQ Strings 3.01.06
mptbase: English readable SCSI-3 strings enabled:-)
isense: Registered SCSI-3 Opcodes & ASC/ASCQ Strings
st0: Block limits 2 - 16777215 bytes.
nfs warning: mount version older than kernel
SysRq : Show State

                                                       sibling
  task                 PC          pid father child younger older
init          S 000017faefb01bbf     0     1      0     2               (NOTLB)
000001003ff8fd88 0000000000000006 000000790000d700 000001007ff9b070 
       0000000000000825 ffffffff803e23a0 000001007ff9b388 0000000000000246 
       0000000000000216 ffffffff8015a512 
Call Trace:<ffffffff8015a512>{__alloc_pages+818} <ffffffff80377eb4>{schedule_timeout+180} 
       <ffffffff80141b20>{process_timeout+0} <ffffffff8019188a>{do_select+906} 
       <ffffffff80186c64>{vfs_stat+68} <ffffffff80191340>{__pollwait+0} 
       <ffffffff80186bcb>{vfs_getattr+59} <ffffffff801ab861>{compat_sys_select+1105} 
       <ffffffff80123f81>{ia32_sysret+0} 
migration/0   S 0000010001e0f760     0     2      1             3       (L-TLB)
0000010040e73ed8 0000000000000046 0000007302dadcc8 000001007ff9a030 
       00000000000000eb 000001003e614230 000001007ff9a348 0000010002dadcb8 
       0000010002dadcc0 0000000000000000 
Call Trace:<ffffffff80133661>{complete+1} <ffffffff8013487c>{migration_thread+236} 
       <ffffffff80134790>{migration_thread+0} <ffffffff80134790>{migration_thread+0} 
       <ffffffff8014e502>{kthread+146} <ffffffff801115f7>{child_rip+8} 
       <ffffffff80134790>{migration_thread+0} <ffffffff8014e470>{kthread+0} 
       <ffffffff801115ef>{child_rip+0} 
ksoftirqd/0   S 00001742a3bbf0ed     0     3      1             4     2 (L-TLB)
0000010040e71f08 0000000000000046 0000010040e71e98 0000010001e6d0b0 
       000000000000083d ffffffff803e23a0 0000010001e6d3c8 0000010040e71e98 
       0000010001e12b20 0000000000000000 
Call Trace:<ffffffff8013d0ff>{tasklet_action+111} <ffffffff8013d2a0>{ksoftirqd+0} 
       <ffffffff8013d2df>{ksoftirqd+63} <ffffffff8014e502>{kthread+146} 
       <ffffffff801115f7>{child_rip+8} <ffffffff8013d2a0>{ksoftirqd+0} 
       <ffffffff8014e470>{kthread+0} <ffffffff801115ef>{child_rip+0} 
       
migration/1   S 0000010040e1b5e0     0     4      1             5     3 (L-TLB)
0000010001e6bed8 0000000000000046 000000746a6b3cc8 0000010001e6c890 
       000000000000012a 000001003e614230 0000010001e6cba8 000001006a6b3cb8 
       000001006a6b3cc0 0000000000000001 
Call Trace:<ffffffff8013487c>{migration_thread+236} <ffffffff80134790>{migration_thread+0} 
       <ffffffff80134790>{migration_thread+0} <ffffffff8014e502>{kthread+146} 
       <ffffffff801115f7>{child_rip+8} <ffffffff80134790>{migration_thread+0} 
       <ffffffff8014e470>{kthread+0} <ffffffff801115ef>{child_rip+0} 
       
ksoftirqd/1   S 00001659ca121eaf     0     5      1             6     4 (L-TLB)
0000010001e69f08 0000000000000046 0000010001e69e98 0000010001e6c070 
       0000000000000bbe 000001007ff9a850 0000010001e6c388 0000010001e69e98 
       0000010040e1e9a0 0000000000000000 
Call Trace:<ffffffff8013d0ff>{tasklet_action+111} <ffffffff8013d2a0>{ksoftirqd+0} 
       <ffffffff8013d2df>{ksoftirqd+63} <ffffffff8014e502>{kthread+146} 
       <ffffffff801115f7>{child_rip+8} <ffffffff8013d2a0>{ksoftirqd+0} 
       <ffffffff8014e470>{kthread+0} <ffffffff801115ef>{child_rip+0} 
       
events/0      S 000017f74d04529d     0     6      1     8       7     5 (L-TLB)
0000010001e53e58 0000000000000046 0000000000000000 0000010040e410f0 
       00000000000001b5 ffffffff803e23a0 0000010040e41408 0000000000000001 
       0000000000000003 0000000000000000 
Call Trace:<ffffffff80149df5>{worker_thread+261} <ffffffff8037748c>{thread_return+41} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80149cf0>{worker_thread+0} <ffffffff80149cf0>{worker_thread+0} 
       <ffffffff8014e502>{kthread+146} <ffffffff801115f7>{child_rip+8} 
       <ffffffff80149cf0>{worker_thread+0} <ffffffff8014e470>{kthread+0} 
       <ffffffff801115ef>{child_rip+0} 
events/1      S 000017fb99b9a166     0     7      1            42     6 (L-TLB)
000001007ff7fe58 0000000000000046 0000007300000212 0000010040e408d0 
       0000000000000079 000001003dba32f0 0000010040e40be8 0000000000000001 
       0000000000000003 0000000000000000 
Call Trace:<ffffffff80149df5>{worker_thread+261} <ffffffff8037748c>{thread_return+41} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80149cf0>{worker_thread+0} <ffffffff80149cf0>{worker_thread+0} 
       <ffffffff8014e502>{kthread+146} <ffffffff801115f7>{child_rip+8} 
       <ffffffff80149cf0>{worker_thread+0} <ffffffff8014e470>{kthread+0} 
       <ffffffff801115ef>{child_rip+0} 
khelper       S 00000012722456ce     0     8      6             9       (L-TLB)
0000010001e4fe58 0000000000000046 000001007f14dd38 0000010040e400b0 
       000000000000021a 000001007ff9a850 0000010040e403c8 0000000000000001 
       0000000000000003 0000000000000000 
Call Trace:<ffffffff801115ef>{child_rip+0} <ffffffff80149df5>{worker_thread+261} 
       <ffffffff8037748c>{thread_return+41} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80149cf0>{worker_thread+0} 
       <ffffffff80149cf0>{worker_thread+0} <ffffffff8014e502>{kthread+146} 
       <ffffffff801115f7>{child_rip+8} <ffffffff8014e540>{keventd_create_kthread+0} 
       <ffffffff8014e470>{kthread+0} <ffffffff801115ef>{child_rip+0} 
       
kacpid        S 00000000087a8e53     0     9      6            40     8 (L-TLB)
000001007fefde58 0000000000000046 000001007fefde18 0000010001e8d130 
       0000000000002df5 000001007ff9a850 0000010001e8d448 0000000000000001 
       0000000000010000 0000010001e8d130 
Call Trace:<ffffffff80146273>{do_sigaction+659} <ffffffff80145361>{sigprocmask+241} 
       <ffffffff80149df5>{worker_thread+261} <ffffffff8037748c>{thread_return+41} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80149cf0>{worker_thread+0} <ffffffff80149cf0>{worker_thread+0} 
       <ffffffff8014e502>{kthread+146} <ffffffff801115f7>{child_rip+8} 
       <ffffffff8014e540>{keventd_create_kthread+0} <ffffffff8014e470>{kthread+0} 
       <ffffffff801115ef>{child_rip+0} 
kblockd/0     S 000017f472fc5923     0    40      6            41     9 (L-TLB)
000001007fe93e58 0000000000000046 0000000000000216 0000010001ffa170 
       0000000000000797 ffffffff803e23a0 0000010001ffa488 0000000000000001 
       0000000000000003 0000000000000000 
Call Trace:<ffffffff80149df5>{worker_thread+261} <ffffffff8037748c>{thread_return+41} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80149cf0>{worker_thread+0} <ffffffff80149cf0>{worker_thread+0} 
       <ffffffff8014e502>{kthread+146} <ffffffff801115f7>{child_rip+8} 
       <ffffffff8014e540>{keventd_create_kthread+0} <ffffffff8014e470>{kthread+0} 
       <ffffffff801115ef>{child_rip+0} 
kblockd/1     S 000017f478cb748d     0    41      6            54    40 (L-TLB)
0000010001fb9e58 0000000000000046 0000010040e56800 000001007fec71f0 
       00000000000004d9 000001007ff9a850 000001007fec7508 0000000000000001 
       0000000000000003 0000000000000000 
Call Trace:<ffffffff80149df5>{worker_thread+261} <ffffffff8037748c>{thread_return+41} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80149cf0>{worker_thread+0} <ffffffff80149cf0>{worker_thread+0} 
       <ffffffff8014e502>{kthread+146} <ffffffff801115f7>{child_rip+8} 
       <ffffffff8014e540>{keventd_create_kthread+0} <ffffffff8014e470>{kthread+0} 
       <ffffffff801115ef>{child_rip+0} 
khubd         S 000000001aca374c     0    42      1            56     7 (L-TLB)
0000010001f87f08 0000000000000046 0000000000000000 000001007fec69d0 
       0000000000002ff6 000001007ff9a850 000001007fec6ce8 0000000000000000 
       0000000000000000 0000000000000216 
Call Trace:<ffffffff802d1871>{hub_thread+161} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff802d17d0>{hub_thread+0} 
       <ffffffff801115ef>{child_rip+0} 
pdflush       S 00000000246bfb3c     0    54      6            55    41 (L-TLB)
0000010001f85e98 0000000000000046 0000006a01e0f760 000001007fec61b0 
       000000000000064c 0000010040e410f0 000001007fec64c8 0000010040e410f0 
       0000010001e0f760 0000010001e100a0 
Call Trace:<ffffffff8015cae0>{pdflush+0} <ffffffff8015c8c5>{__pdflush+261} 
       <ffffffff8015cae0>{pdflush+0} <ffffffff8015cafc>{pdflush+28} 
       <ffffffff8015cae0>{pdflush+0} <ffffffff8014e502>{kthread+146} 
       <ffffffff801115f7>{child_rip+8} <ffffffff8014e540>{keventd_create_kthread+0} 
       <ffffffff8014e470>{kthread+0} <ffffffff801115ef>{child_rip+0} 
       
pdflush       S 000017fc7012083d     0    55      6            58    54 (L-TLB)
000001007fe51e98 0000000000000046 0000000000000000 000001007fec3230 
       0000000000000a30 000001007ff9a850 000001007fec3548 0000000000000000 
       000001007fe51e18 0000000000000400 
Call Trace:<ffffffff8015cae0>{pdflush+0} <ffffffff8015c8c5>{__pdflush+261} 
       <ffffffff8015cae0>{pdflush+0} <ffffffff8015cafc>{pdflush+28} 
       <ffffffff8014e502>{kthread+146} <ffffffff801115f7>{child_rip+8} 
       <ffffffff8014e540>{keventd_create_kthread+0} <ffffffff8014e470>{kthread+0} 
       <ffffffff801115ef>{child_rip+0} 
kswapd1       S 000017ed9504b784     0    56      1            57    42 (L-TLB)
0000010001f83eb8 0000000000000046 0000007300000000 0000010001fce2f0 
       0000000000020b32 000001007febf270 0000010001fce608 0000000000000202 
       00000000000000ec 0000000000000000 
Call Trace:<ffffffff80164e6f>{kswapd+239} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff80131341>{schedule_tail+17} 
       <ffffffff801115f7>{child_rip+8} <ffffffff80164d80>{kswapd+0} 
       <ffffffff801115ef>{child_rip+0} 
kswapd0       S 000001000000e798     0    57      1           170    56 (L-TLB)
000001007fe4feb8 0000000000000046 0000007800000000 0000010001fceb10 
       000000000001f8e0 000001006a752e90 0000010001fcee28 0000000000000202 
       00000000000000de 00000000000000e0 
Call Trace:<ffffffff80164af2>{balance_pgdat+2} <ffffffff80164e6f>{kswapd+239} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff80131341>{schedule_tail+17} <ffffffff801115f7>{child_rip+8} 
       <ffffffff80164d80>{kswapd+0} <ffffffff801115ef>{child_rip+0} 
       
aio/0         S 0000010001f9d800     0    58      6            59    55 (L-TLB)
000001007fe4de58 0000000000000046 0000006b7fe4de18 0000010001fcf330 
       000000000000046e 0000010040e410f0 0000010001fcf648 0000000000000001 
       0000000000010000 0000010001fcf330 
Call Trace:<ffffffff80146273>{do_sigaction+659} <ffffffff80145361>{sigprocmask+241} 
       <ffffffff80149df5>{worker_thread+261} <ffffffff8037748c>{thread_return+41} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80149cf0>{worker_thread+0} <ffffffff80149cf0>{worker_thread+0} 
       <ffffffff8014e502>{kthread+146} <ffffffff801115f7>{child_rip+8} 
       <ffffffff8014e540>{keventd_create_kthread+0} <ffffffff8014e470>{kthread+0} 
       <ffffffff801115ef>{child_rip+0} 
aio/1         S 00000000246e1c84     0    59      6                  58 (L-TLB)
0000010001f71e58 0000000000000046 0000010001f71e18 0000010001fd22b0 
       0000000000001224 000001007ff9a850 0000010001fd25c8 0000000000000001 
       0000000000010000 0000010001fd22b0 
Call Trace:<ffffffff80146273>{do_sigaction+659} <ffffffff80145361>{sigprocmask+241} 
       <ffffffff80149df5>{worker_thread+261} <ffffffff8037748c>{thread_return+41} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80149cf0>{worker_thread+0} <ffffffff80149cf0>{worker_thread+0} 
       <ffffffff8014e502>{kthread+146} <ffffffff801115f7>{child_rip+8} 
       <ffffffff8014e540>{keventd_create_kthread+0} <ffffffff8014e470>{kthread+0} 
       <ffffffff801115ef>{child_rip+0} 
scsi_eh_0     S 00000000602b4d13     0   170      1           188    57 (L-TLB)
0000010040fbde28 0000000000000046 0000000000000246 000001007febe230 
       0000000000007288 000001007ff9a850 000001007febe548 0000000035c0ce5f 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80376ced>{__down_interruptible+301} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80133493>{__wake_up_common+67} <ffffffff8037802b>{__down_failed_interruptible+53} 
       <ffffffff80298e13>{.text.lock.scsi_error+213} <ffffffff801115f7>{child_rip+8} 
       <ffffffff80298970>{scsi_error_handler+0} <ffffffff801115ef>{child_rip+0} 
       
scsi_eh_1     S 00000002545d74a3     0   188      1           218   170 (L-TLB)
000001003fdbde28 0000000000000046 0000000000000246 000001007febb2b0 
       0000000000002b4d 000001007ff9a850 000001007febb5c8 000000003caba6fa 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80376ced>{__down_interruptible+301} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80133493>{__wake_up_common+67} <ffffffff8037802b>{__down_failed_interruptible+53} 
       <ffffffff80298e13>{.text.lock.scsi_error+213} <ffffffff801115f7>{child_rip+8} 
       <ffffffff80298970>{scsi_error_handler+0} <ffffffff801115ef>{child_rip+0} 
       
scsi_eh_2     S 0000000326cfd7ba     0   218      1           230   188 (L-TLB)
000001003fd59e28 0000000000000046 0000000000000246 000001007febaa90 
       0000000000002611 000001007ff9a850 000001007febada8 000000003ccbef01 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80376ced>{__down_interruptible+301} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80133493>{__wake_up_common+67} <ffffffff8037802b>{__down_failed_interruptible+53} 
       <ffffffff80298e13>{.text.lock.scsi_error+213} <ffffffff801115f7>{child_rip+8} 
       <ffffffff80298970>{scsi_error_handler+0} <ffffffff801115ef>{child_rip+0} 
       
kseriod       S 0000000426f4b3d8     0   230      1           238   218 (L-TLB)
000001007fec5ef8 0000000000000046 0000006900000000 000001007feba270 
       00000000178c3ce3 0000010040e400b0 000001007feba588 00000000ffffffff 
       0000000000000001 0000000000000000 
Call Trace:<ffffffff802edbf4>{serio_thread+244} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80131341>{schedule_tail+17} <ffffffff801115f7>{child_rip+8} 
       <ffffffff802edb00>{serio_thread+0} <ffffffff801115ef>{child_rip+0} 
       
md0_raid5     S 000017f4796cf330     0   238      1           239   230 (L-TLB)
000001003fcf5ee8 0000000000000046 0000000000000202 000001007febf270 
       000000000000011b 000001007ff9a850 000001007febf588 000001003ffd5948 
       000001003ffd5980 000001003ffd59f4 
Call Trace:<ffffffff802fdc6a>{raid5d+490} <ffffffff802fda89>{raid5d+9} 
       <ffffffff80303d81>{md_thread+417} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80131341>{schedule_tail+17} <ffffffff802fda80>{raid5d+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff802fda80>{raid5d+0} 
       <ffffffff80303be0>{md_thread+0} <ffffffff801115ef>{child_rip+0} 
       
kjournald     S 000017fb77fbef50     0   239      1           560   238 (L-TLB)
000001003f3c5e38 0000000000000046 0000010058b3f980 000001007febea50 
       000000000000036f ffffffff803e23a0 000001007febed68 0000000000000001 
       0000000000000003 000001003ffbdac8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 00000976de89effe     0   560      1           561   239 (L-TLB)
000001003e085e38 0000000000000046 000001007f87af80 000001007fec2a10 
       0000000000002462 ffffffff803e23a0 000001007fec2d28 0000000000000001 
       0000000000000003 0000010040e4f6c8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000096164d10d42     0   561      1           562   560 (L-TLB)
000001003dc63e38 0000000000000046 000000763dc63de8 0000010001e763f0 
       00000000000026b5 000001007ff9a850 0000010001e76708 0000000000000001 
       0000000000000003 0000010040e4f4c8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 000009617118a193     0   562      1           563   561 (L-TLB)
000001003ddc5e38 0000000000000046 000000763ddc5de8 0000010001fd2ad0 
       00000000000015f4 000001007ff9a850 0000010001fd2de8 0000000000000001 
       0000000000000003 0000010040e4f2c8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000096183755c0c     0   563      1           564   562 (L-TLB)
000001003f107e38 0000000000000046 000000773f107de8 0000010001e77430 
       0000000000002045 000001007ff9a850 0000010001e77748 0000000000000001 
       0000000000000003 0000010001e62ec8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000096178225e26     0   564      1           565   563 (L-TLB)
000001003dcfbe38 0000000000000046 000001003dbb49e0 0000010001fd32f0 
       0000000000002094 000001007ff9a850 0000010001fd3608 0000000000000001 
       0000000000000003 0000010001e62cc8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000176656f9a527     0   565      1           566   564 (L-TLB)
000001003e84be38 0000000000000046 000001001dea6c80 0000010001ffb1b0 
       00000000000002fc 000001007ff9a850 0000010001ffb4c8 0000000000000001 
       0000000000000003 0000010001e62ac8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 000009701981bade     0   566      1           567   565 (L-TLB)
000001003e641e38 0000000000000046 0000007371e57260 0000010001e8c0f0 
       0000000000012748 000001007febf270 0000010001e8c408 0000000000000001 
       0000000000000003 0000010001e628c8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 000009717f79762d     0   567      1           568   566 (L-TLB)
000001003e0e9e38 0000000000000046 0000007371df64a0 000001007f9e4c90 
       00000000000035b4 000001007ff9a850 000001007f9e4fa8 0000000000000001 
       0000000000000003 0000010001e626c8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 00001743d3b35306     0   568      1           569   567 (L-TLB)
000001003e66be38 0000000000000046 000001006fb59ec0 000001007f9b8c50 
       0000000000001605 ffffffff803e23a0 000001007f9b8f68 0000000000000001 
       0000000000000003 0000010001e624c8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 00000968e46b17ba     0   569      1           570   568 (L-TLB)
000001003e075e38 0000000000000046 000001007a81f920 000001007f9b8430 
       000000000001be2f 000001007ff9a850 000001007f9b8748 0000000000000001 
       0000000000000003 0000010001e622c8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000096933e1707b     0   570      1           571   569 (L-TLB)
000001003dd87e38 0000000000000046 0000010079c36980 000001007f9e54b0 
       0000000000018cab 000001007ff9a850 000001007f9e57c8 0000000000000001 
       0000000000000003 000001007ffa6ec8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 00000969964f3cf9     0   571      1           572   570 (L-TLB)
000001003dca5e38 0000000000000046 000000763dca5de8 000001007f950e10 
       00000000000091d0 000001007ff9a850 000001007f951128 0000000000000001 
       0000000000000003 000001007ffa6cc8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 00000969b431f4f3     0   572      1           573   571 (L-TLB)
000001003dfe7e38 0000000000000046 000000763dfe7de8 000001007f9e4470 
       0000000000008d33 000001007ff9a850 000001007f9e4788 0000000000000001 
       0000000000000003 000001007feb46c8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 00000969ca9247be     0   573      1           574   572 (L-TLB)
000001003e14be38 0000000000000046 0000010079c36440 000001007f9b2cd0 
       000000000000c0f7 000001007ff9a850 000001007f9b2fe8 0000000000000001 
       0000000000000003 000001007feb44c8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000096a0692e7a6     0   574      1           575   573 (L-TLB)
000001003e149e38 0000000000000046 0000010079be2ec0 000001007f9f2d90 
       0000000000042b94 000001007ff9a850 000001007f9f30a8 0000000000000001 
       0000000000000003 000001007feb42c8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000096ab3afede2     0   575      1           576   574 (L-TLB)
000001003e803e38 0000000000000046 00000100795b80e0 000001007f9505f0 
       000000000001e924 000001007ff9a850 000001007f950908 0000000000000001 
       0000000000000003 0000010001fe5ec8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000096b42c9907c     0   576      1           577   575 (L-TLB)
000001003dd53e38 0000000000000046 000001007878b740 000001007f9d25b0 
       00000000000135f1 000001007ff9a850 000001007f9d28c8 0000000000000001 
       0000000000000003 0000010001fe5cc8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000096b6b94417d     0   577      1           578   576 (L-TLB)
000001003e305e38 0000000000000046 000000763e305de8 000001007f9d2dd0 
       000000000000e345 000001007ff9a850 000001007f9d30e8 0000000000000001 
       0000000000000003 0000010001fe5ac8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000096b8c06b387     0   578      1           579   577 (L-TLB)
000001003e083e38 0000000000000046 000000763e083de8 000001007f951630 
       0000000000008ee6 000001007ff9a850 000001007f951948 0000000000000001 
       0000000000000003 0000010001fe58c8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000096ba589b3de     0   579      1           580   578 (L-TLB)
000001003e721e38 0000000000000046 0000010077fcb740 000001003e723670 
       00000000000225a9 000001007ff9a850 000001003e723988 0000000000000001 
       0000000000000003 0000010001fe56c8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000096c386dac3a     0   580      1           581   579 (L-TLB)
000001003e0efe38 0000000000000046 0000010076f35740 000001003e722e50 
       0000000000011412 000001007ff9a850 000001003e723168 0000000000000001 
       0000000000000003 0000010001fe54c8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000096c683e0386     0   581      1           582   580 (L-TLB)
000001003e089e38 0000000000000046 000000763e089de8 000001003e722630 
       0000000000007e8d 000001007ff9a850 000001003e722948 0000000000000001 
       0000000000000003 0000010001fe52c8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000096c8bb6f7d7     0   582      1           583   581 (L-TLB)
000001003e77be38 0000000000000046 00000100769f0860 000001003eeb56b0 
       000000000006575c 000001007ff9a850 000001003eeb59c8 0000000000000001 
       0000000000000003 000001007fed1ec8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000096d480f2cfa     0   583      1           584   582 (L-TLB)
000001003dd09e38 0000000000000046 000000763dd09de8 000001003eeb4e90 
       000000000000613f 000001007ff9a850 000001003eeb51a8 0000000000000001 
       0000000000000003 000001007fed1cc8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 000001007fed1a00     0   584      1           585   583 (L-TLB)
000001003e4f3e38 0000000000000046 0000007624d772c0 000001003eeb4670 
       0000000000014bf9 000001003d123170 000001003eeb4988 0000000000000001 
       0000000000000003 000001007fed1ac8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff80180f70>{end_bio_bh_io_sync+0} 
       <ffffffff801cee80>{commit_timeout+0} <ffffffff801115f7>{child_rip+8} 
       <ffffffff801ceea0>{kjournald+0} <ffffffff801115ef>{child_rip+0} 
       
kjournald     S 00000968bc48ecb3     0   585      1           586   584 (L-TLB)
000001003e3d9e38 0000000000000046 000001002d74a1a0 000001003e3db6f0 
       000000000001778f ffffffff803e23a0 000001003e3dba08 0000000000000001 
       0000000000000003 000001007fed18c8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 00000974f0dafff5     0   586      1           587   585 (L-TLB)
000001003e83fe38 0000000000000046 000000763e83fde8 000001003e3daed0 
       00000000000096ab 000001007ff9a850 000001003e3db1e8 0000000000000001 
       0000000000000003 000001007fed16c8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000097506481ea5     0   587      1           588   586 (L-TLB)
000001003e63de38 0000000000000046 000001006e9af200 000001003e3da6b0 
       000000000004ee43 000001007ff9a850 000001003e3da9c8 0000000000000001 
       0000000000000003 000001007fed14c8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 00000975c19fa960     0   588      1           589   587 (L-TLB)
000001003e157e38 0000000000000046 00000100177da620 000001003e4f9730 
       00000000000284d2 000001007ff9a850 000001003e4f9a48 0000000000000001 
       0000000000000003 000001007fed12c8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000097612db91c3     0   589      1           590   588 (L-TLB)
000001003e435e38 0000000000000046 000000763e435de8 000001003e4f8f10 
       0000000000009591 000001007ff9a850 000001003e4f9228 0000000000000001 
       0000000000000003 0000010001ff2ec8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 000009762ed04e39     0   590      1           591   589 (L-TLB)
000001003dc53e38 0000000000000046 000000773dc53de8 000001003e4f86f0 
       0000000000008b45 000001007ff9a850 000001003e4f8a08 0000000000000001 
       0000000000000003 0000010001ff2cc8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 000009764664377f     0   591      1           592   590 (L-TLB)
000001003deb5e38 0000000000000046 000000773deb5de8 000001003deb7770 
       0000000000002879 000001007ff9a850 000001003deb7a88 0000000000000001 
       0000000000000003 0000010001ff2ac8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 0000097648373d9d     0   592      1           593   591 (L-TLB)
000001003deb3e38 0000000000000046 000000773deb3de8 000001003deb6f50 
       00000000000015ff 000001007ff9a850 000001003deb7268 0000000000000001 
       0000000000000003 0000010001ff28c8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 000009764abd6fa4     0   593      1           594   592 (L-TLB)
000001003e131e38 0000000000000046 000001002cd99e60 000001003deb6730 
       00000000000201f4 000001007ff9a850 000001003deb6a48 0000000000000001 
       0000000000000003 0000010001ff26c8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 00000968b83fefb2     0   594      1           595   593 (L-TLB)
000001003de23e38 0000000000000046 000000773de23de8 000001003de25070 
       0000000000001a18 ffffffff803e23a0 000001003de25388 0000000000000001 
       0000000000000003 0000010001ff24c8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 00000968bbdaa6c8     0   595      1           596   594 (L-TLB)
000001003e7e1e38 0000000000000046 000000773e7e1de8 000001003de24850 
       0000000000001171 ffffffff803e23a0 000001003de24b68 0000000000000001 
       0000000000000003 0000010001ff22c8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
kjournald     S 00000968bc4563a5     0   596      1           634   595 (L-TLB)
000001003e7f7e38 0000000000000046 000000773e7f7de8 000001003de24030 
       00000000000011aa ffffffff803e23a0 000001003de24348 0000000000000001 
       0000000000000003 000001007fed2ec8 
Call Trace:<ffffffff801cf1ac>{kjournald+780} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801cee80>{commit_timeout+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801ceea0>{kjournald+0} 
       <ffffffff801115ef>{child_rip+0} 
portmap       S 00000001fffd6d6a     0   634      1           840   596 (NOTLB)
000001003e21de68 0000000000000006 0000007680000000 000001003e21f0f0 
       000000000000390b 000001007faa0950 000001003e21f408 0000000000000246 
       000001003e01e970 0000000000000002 
Call Trace:<ffffffff80377eb4>{schedule_timeout+180} <ffffffff80141b20>{process_timeout+0} 
       <ffffffff80191fd1>{do_poll+177} <ffffffff8019215e>{sys_poll+350} 
       <ffffffff80191340>{__pollwait+0} <ffffffff80123f81>{ia32_sysret+0} 
       
syslogd       S 000001007f907ec0     0   840      1           843   634 (NOTLB)
000001003dc0bd88 0000000000000006 0000007400000000 0000010001e76c10 
       0000000000000f32 000001007f9b34f0 0000010001e76f28 0000000000000216 
       0000000000000216 ffffffff8015a512 
Call Trace:<ffffffff8015a512>{__alloc_pages+818} <ffffffff80377e25>{schedule_timeout+37} 
       <ffffffff80313e05>{datagram_poll+21} <ffffffff8019188a>{do_select+906} 
       <ffffffff80191340>{__pollwait+0} <ffffffff801ab861>{compat_sys_select+1105} 
       <ffffffff80123f81>{ia32_sysret+0} 
klogd         R  running task       0   843      1           846   840 (NOTLB)
rpc.statd     S 0000001ce1b6dffc     0   846      1           857   843 (NOTLB)
000001003dde5d88 0000000000000006 3256cc8432343731 000001007f9b24b0 
       00000000000047ec ffffffff803e23a0 000001007f9b27c8 0000000000000216 
       0000000000000216 ffffffff8015a512 
Call Trace:<ffffffff8015a512>{__alloc_pages+818} <ffffffff80377e25>{schedule_timeout+37} 
       <ffffffff80330301>{tcp_poll+33} <ffffffff8019188a>{do_select+906} 
       <ffffffff80198a12>{destroy_inode+50} <ffffffff80191340>{__pollwait+0} 
       <ffffffff801ab861>{compat_sys_select+1105} <ffffffff80123f81>{ia32_sysret+0} 
       
exim          S 00001706db11617f     0   857      1           864   846 (NOTLB)
000001003e5d9d88 0000000000000006 000001000000d700 000001007f9f35b0 
       0000000000007d07 ffffffff803e23a0 000001007f9f38c8 ffffffff8015a512 
       000001000000d700 0000000000000001 
Call Trace:<ffffffff8015a512>{__alloc_pages+818} <ffffffff80377e25>{schedule_timeout+37} 
       <ffffffff80330301>{tcp_poll+33} <ffffffff8019188a>{do_select+906} 
       <ffffffff80191340>{__pollwait+0} <ffffffff80154c01>{compat_sys_wait4+65} 
       <ffffffff801ab861>{compat_sys_select+1105} <ffffffff80123f81>{ia32_sysret+0} 
       
inetd         S 0000001d2c815e9e     0   864      1           870   857 (NOTLB)
000001003e0b1d88 0000000000000006 0000000000000000 000001007f9d35f0 
       0000000000285906 ffffffff803e23a0 000001007f9d3908 0000000000000216 
       0000000000000216 ffffffff8015a512 
Call Trace:<ffffffff8015a512>{__alloc_pages+818} <ffffffff80377e25>{schedule_timeout+37} 
       <ffffffff80330301>{tcp_poll+33} <ffffffff8019188a>{do_select+906} 
       <ffffffff80191340>{__pollwait+0} <ffffffff8016c109>{unmap_region+409} 
       <ffffffff801ab861>{compat_sys_select+1105} <ffffffff80123f81>{ia32_sysret+0} 
       
rngd          S 000017f3d0d7e2ea     0   870      1           880   864 (NOTLB)
000001003e219e68 0000000000000006 00000010ffffd36c 000001003e21e8d0 
       0000000000000f34 ffffffff803e23a0 000001003e21ebe8 0000000000000246 
       ffffffff80443c80 0000000000000001 
Call Trace:<ffffffff8015a555>{__get_free_pages+37} <ffffffff80377eb4>{schedule_timeout+180} 
       <ffffffff80141b20>{process_timeout+0} <ffffffff80191fd1>{do_poll+177} 
       <ffffffff8019215e>{sys_poll+350} <ffffffff80191340>{__pollwait+0} 
       <ffffffff80123f81>{ia32_sysret+0} 
lpd           S 000000a9189b63b6     0   880      1           890   870 (NOTLB)
000001003e23dd88 0000000000000006 000001000000d700 000001007fec21f0 
       0000000000003366 ffffffff803e23a0 000001007fec2508 ffffffff8015a512 
       000001000000d700 0000000000000001 
Call Trace:<ffffffff8015a512>{__alloc_pages+818} <ffffffff80377e25>{schedule_timeout+37} 
       <ffffffff8018a7d2>{pipe_poll+50} <ffffffff8019188a>{do_select+906} 
       <ffffffff80191340>{__pollwait+0} <ffffffff80154c01>{compat_sys_wait4+65} 
       <ffffffff801ab861>{compat_sys_select+1105} <ffffffff80123f81>{ia32_sysret+0} 
       
nfsd          S 00001605f7be1cc7     0   890      1           892   880 (L-TLB)
000001003e0abd98 0000000000000046 0000007301cc8838 000001003e22b1b0 
       0000000000003a7a 000001003e22a170 000001003e22b4c8 0000000000000246 
       000001007fe7b8a0 000001003e0be180 
Call Trace:<ffffffff8015a1c3>{buffered_rmqueue+515} <ffffffff80377eb4>{schedule_timeout+180} 
       <ffffffff80141b20>{process_timeout+0} <ffffffff8036e0bb>{svc_recv+987} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80145361>{sigprocmask+241} <ffffffff801f8d70>{nfsd+0} 
       <ffffffff801f8f47>{nfsd+471} <ffffffff801f8d70>{nfsd+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801f8d70>{nfsd+0} 
       <ffffffff801f8d70>{nfsd+0} <ffffffff801115ef>{child_rip+0} 
       
nfsd          S 00001588597d8af1     0   892      1           896   890 (L-TLB)
000001003e4d1d98 0000000000000046 0000007301d8bbc0 000001003df551f0 
       000000000000fc14 000001003df541b0 000001003df55508 0000000000000246 
       000001007fe7d8a0 000001003e0be180 
Call Trace:<ffffffff8015a1c3>{buffered_rmqueue+515} <ffffffff80377eb4>{schedule_timeout+180} 
       <ffffffff80141b20>{process_timeout+0} <ffffffff8036e0bb>{svc_recv+987} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80145361>{sigprocmask+241} <ffffffff801f8d70>{nfsd+0} 
       <ffffffff801f8f47>{nfsd+471} <ffffffff801f8d70>{nfsd+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801f8d70>{nfsd+0} 
       <ffffffff801f8d70>{nfsd+0} <ffffffff801115ef>{child_rip+0} 
       
nfsd          S 0000172b46986b0f     0   896      1           891   892 (L-TLB)
000001003df43d98 0000000000000046 0000010001a00320 000001003dd3ea10 
       00000000000059bc ffffffff803e23a0 000001003dd3ed28 0000000000000246 
       000001007fe71ca0 000001003e0be180 
Call Trace:<ffffffff8015a1c3>{buffered_rmqueue+515} <ffffffff80377eb4>{schedule_timeout+180} 
       <ffffffff80141b20>{process_timeout+0} <ffffffff8036e0bb>{svc_recv+987} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80145361>{sigprocmask+241} <ffffffff801f8d70>{nfsd+0} 
       <ffffffff801f8f47>{nfsd+471} <ffffffff801f8d70>{nfsd+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801f8d70>{nfsd+0} 
       <ffffffff801f8d70>{nfsd+0} <ffffffff801115ef>{child_rip+0} 
       
nfsd          S 00001605f7be22db     0   891      1           897   896 (L-TLB)
000001003e2c7d98 0000000000000046 0000007301c984b0 000001003e22a170 
       0000000000000614 ffffffff803e23a0 000001003e22a488 0000000000000246 
       0000010001fa78a0 0000000000000216 
Call Trace:<ffffffff8015a1c3>{buffered_rmqueue+515} <ffffffff80377eb4>{schedule_timeout+180} 
       <ffffffff80141b20>{process_timeout+0} <ffffffff8036e0bb>{svc_recv+987} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80145361>{sigprocmask+241} <ffffffff801f8d70>{nfsd+0} 
       <ffffffff801f8f47>{nfsd+471} <ffffffff801f8d70>{nfsd+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801f8d70>{nfsd+0} 
       <ffffffff801f8d70>{nfsd+0} <ffffffff801115ef>{child_rip+0} 
       
nfsd          S 0000172b46983432     0   897      1           893   891 (L-TLB)
000001003e6dfd98 0000000000000046 0000007301523858 000001003dd3e1f0 
       00000000000001ee 000001007ff9a850 000001003dd3e508 0000000000000246 
       0000010001f9cca0 0000000000000216 
Call Trace:<ffffffff8015a1c3>{buffered_rmqueue+515} <ffffffff80377eb4>{schedule_timeout+180} 
       <ffffffff80141b20>{process_timeout+0} <ffffffff8036e0bb>{svc_recv+987} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80145361>{sigprocmask+241} <ffffffff801f8d70>{nfsd+0} 
       <ffffffff801f8f47>{nfsd+471} <ffffffff801f8d70>{nfsd+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801f8d70>{nfsd+0} 
       <ffffffff801f8d70>{nfsd+0} <ffffffff801115ef>{child_rip+0} 
       
nfsd          R  running task       0   893      1           894   897 (L-TLB)
nfsd          S 00001588597d9384     0   894      1           895   893 (L-TLB)
000001003e6d7d98 0000000000000046 0000010040a0aef0 000001003df541b0 
       00000000000000db 000001007ff9a850 000001003df544c8 0000000000000246 
       000001007fe808a0 0000000000000216 
Call Trace:<ffffffff80377eb4>{schedule_timeout+180} <ffffffff80141b20>{process_timeout+0} 
       <ffffffff8036e0bb>{svc_recv+987} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80145361>{sigprocmask+241} 
       <ffffffff801f8d70>{nfsd+0} <ffffffff801f8f47>{nfsd+471} 
       <ffffffff801f8d70>{nfsd+0} <ffffffff801115f7>{child_rip+8} 
       <ffffffff801f8d70>{nfsd+0} <ffffffff801f8d70>{nfsd+0} 
       <ffffffff801115ef>{child_rip+0} 
nfsd          S 000017fca38dfc47     0   895      1           899   894 (L-TLB)
000001003dd3dd98 0000000000000046 0000007301b2ad10 000001003dd3f230 
       0000000000000214 000001007ff9a850 000001003dd3f548 0000000000000246 
       0000010001f9bca0 0000000000000216 
Call Trace:<ffffffff80141011>{del_timer_sync+49} <ffffffff80377eb4>{schedule_timeout+180} 
       <ffffffff80141b20>{process_timeout+0} <ffffffff8036e0bb>{svc_recv+987} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80145361>{sigprocmask+241} <ffffffff801f8d70>{nfsd+0} 
       <ffffffff801f8f47>{nfsd+471} <ffffffff801f8d70>{nfsd+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff801f8d70>{nfsd+0} 
       <ffffffff801f8d70>{nfsd+0} <ffffffff801115ef>{child_rip+0} 
       
lockd         S 0000001df0430c1a     0   899      1           900   895 (L-TLB)
000001007f77fde8 0000000000000046 000001003e22a990 000001003e22a990 
       00000000000011a0 000001007ff9a850 000001003e22aca8 ffffffff8037748c 
       0000007700000001 0000000000000212 
Call Trace:<ffffffff8037748c>{thread_return+41} <ffffffff80377e25>{schedule_timeout+37} 
       <ffffffff8036c639>{svc_sock_release+569} <ffffffff8036e0bb>{svc_recv+987} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80377ff1>{__down_failed+53} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff8020a699>{lockd+377} <ffffffff8020a520>{lockd+0} 
       <ffffffff801115f7>{child_rip+8} <ffffffff8020a520>{lockd+0} 
       <ffffffff8020a520>{lockd+0} <ffffffff801115ef>{child_rip+0} 
       
rpciod        S 000001007f109ee8     0   900      1           902   899 (L-TLB)
000001007f109e88 0000000000000046 0000007840000000 000001007f9b9470 
       0000000000001312 000001003e22b1b0 000001007f9b9788 000001003e290c68 
       ffffffff8020a520 0000000000000008 
Call Trace:<ffffffff8020a520>{lockd+0} <ffffffff8037809f>{__up_wakeup+53} 
       <ffffffff8020a520>{lockd+0} <ffffffff803694ea>{rpciod+1050} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff80131341>{schedule_tail+17} <ffffffff801115f7>{child_rip+8} 
       <ffffffff8020a520>{lockd+0} <ffffffff803690d0>{rpciod+0} 
       <ffffffff801115ef>{child_rip+0} 
rpc.mountd    S 00000001fffd73a1     0   902      1           905   900 (NOTLB)
000001003e613e68 0000000000000006 0000007300000000 000001003e615270 
       0000000000014334 000001007faa0950 000001003e615588 0000000000000246 
       000001007f7da430 0000000000000002 
Call Trace:<ffffffff80377eb4>{schedule_timeout+180} <ffffffff80141b20>{process_timeout+0} 
       <ffffffff80191fd1>{do_poll+177} <ffffffff8019215e>{sys_poll+350} 
       <ffffffff80191340>{__pollwait+0} <ffffffff80123f81>{ia32_sysret+0} 
       
smartd        S 0000170806fc9a7f     0   905      1           911   902 (NOTLB)
000001003e113ee8 0000000000000006 000001003ffba600 000001007faa0950 
       0000000000002ce5 ffffffff803e23a0 000001007faa0c68 0000000000000246 
       0000000000000009 ffffffff8027619b 
Call Trace:<ffffffff8027619b>{blkdev_ioctl+955} <ffffffff80190cb6>{sys_ioctl+678} 
       <ffffffff80377eb4>{schedule_timeout+180} <ffffffff80141b20>{process_timeout+0} 
       <ffffffff801541e1>{compat_sys_nanosleep+193} <ffffffff80123f81>{ia32_sysret+0} 
       
sshd          S 00001742a268c884     0   911      1  1283     914   905 (NOTLB)
000001003e59dd88 0000000000000006 000001000000d700 000001003e614a50 
       00000000000067ee ffffffff803e23a0 000001003e614d68 ffffffff8015a512 
       000001000000d700 0000000000000001 
Call Trace:<ffffffff8015a512>{__alloc_pages+818} <ffffffff80377e25>{schedule_timeout+37} 
       <ffffffff80330301>{tcp_poll+33} <ffffffff8019188a>{do_select+906} 
       <ffffffff80191340>{__pollwait+0} <ffffffff801ab861>{compat_sys_select+1105} 
       <ffffffff80123f81>{ia32_sysret+0} 
ntpd          S 000017fcc1e2c8a8     0   914      1           918   911 (NOTLB)
000001007f631d88 0000000000000006 0000007940000700 000001007f9f2570 
       00000000000003a2 000001007ff9a850 000001007f9f2888 0000000000000216 
       0000000000000216 ffffffff8015a512 
Call Trace:<ffffffff8015a512>{__alloc_pages+818} <ffffffff80377e25>{schedule_timeout+37} 
       <ffffffff80313e05>{datagram_poll+21} <ffffffff8019188a>{do_select+906} 
       <ffffffff80191340>{__pollwait+0} <ffffffff8011084f>{do_signal+175} 
       <ffffffff801ab861>{compat_sys_select+1105} <ffffffff80123f81>{ia32_sysret+0} 
       
atd           S 00001708155c9ab5     0   918      1           921   914 (NOTLB)
000001003dce1ee8 0000000000000006 0000000000000000 000001007faa1170 
       0000000000005c07 000001007ff9a850 000001007faa1488 0000000000000246 
       0000000000000000 ffffffff80186c64 
Call Trace:<ffffffff80186c64>{vfs_stat+68} <ffffffff80141011>{del_timer_sync+49} 
       <ffffffff80377eb4>{schedule_timeout+180} <ffffffff80141b20>{process_timeout+0} 
       <ffffffff801541e1>{compat_sys_nanosleep+193} <ffffffff80123f81>{ia32_sysret+0} 
       
cron          R  running task       0   921      1           925   918 (NOTLB)
irqbalance    S 000017fc5ba4b8d4     0   925      1           935   921 (NOTLB)
000001003dbb7ee8 0000000000000006 0000000000000212 000001003e56c270 
       00000000000063f8 000001007ff9a850 000001003e56c588 0000000000000246 
       0000000000000216 00000100275c7d68 
Call Trace:<ffffffff8016a7c7>{remove_vm_struct+231} <ffffffff8016c109>{unmap_region+409} 
       <ffffffff80377eb4>{schedule_timeout+180} <ffffffff80141b20>{process_timeout+0} 
       <ffffffff801541e1>{compat_sys_nanosleep+193} <ffffffff80123f81>{ia32_sysret+0} 
       
getty         S 0000001eb703d85f     0   935      1          1492   925 (NOTLB)
000001003e551d38 0000000000000006 ffffffff804b4378 000001003db57330 
       000000000000c4e6 ffffffff803e23a0 000001003db57648 00000000fffd7a5e 
       000001003e551db8 ffffffff80141135 
Call Trace:<ffffffff80141135>{del_singleshot_timer_sync+21} <ffffffff80377ebc>{schedule_timeout+188} 
       <ffffffff80377e25>{schedule_timeout+37} <ffffffff8026263b>{uart_write+699} 
       <ffffffff8024cb55>{read_chan+1109} <ffffffff8024d38c>{write_chan+556} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff8024685f>{tty_read+303} 
       <ffffffff8017bca7>{vfs_read+199} <ffffffff8017bf19>{sys_read+73} 
       <ffffffff80123f81>{ia32_sysret+0} 
sshd          S 000001003f270e00     0  1283    911  1294    1304       (NOTLB)
000001003daf5c18 0000000000000006 0000007500001000 000001007faa0130 
       000000000000040a 000001003e582b90 000001007faa0448 ffffffff80382230 
       000001003db0d3a0 0000000000000374 
Call Trace:<ffffffff801c46cd>{__ext3_journal_stop+45} <ffffffff80377e25>{schedule_timeout+37} 
       <ffffffff801582b7>{generic_file_aio_write_nolock+2055} 
       <ffffffff8035dc17>{unix_stream_data_wait+263} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff8035ddf1>{unix_stream_recvmsg+369} 
       <ffffffff8030d564>{sock_aio_read+180} <ffffffff8017bb93>{do_sync_read+115} 
       <ffffffff8017ae77>{dentry_open+263} <ffffffff8017ad52>{filp_open+66} 
       <ffffffff8017bcba>{vfs_read+218} <ffffffff8017bf19>{sys_read+73} 
       <ffffffff80123f81>{ia32_sysret+0} 
sshd          S 000017fc6c343dc8     0  1294   1283  1295               (NOTLB)
000001003f269d88 0000000000000006 0000010040000700 000001003e582b90 
       0000000000001030 000001007ff9a850 000001003e582ea8 ffffffff8015a512 
       0000000000000030 0000000000000001 
Call Trace:<ffffffff8015a512>{__alloc_pages+818} <ffffffff80377e25>{schedule_timeout+37} 
       <ffffffff8024e4eb>{pty_write_room+43} <ffffffff8024d4e1>{normal_poll+305} 
       <ffffffff8019188a>{do_select+906} <ffffffff80191340>{__pollwait+0} 
       <ffffffff801ab861>{compat_sys_select+1105} <ffffffff80123f81>{ia32_sysret+0} 
       
zsh           S 0000175e190daa09     0  1295   1294  1884               (NOTLB)
000001003dbfbf18 0000000000000006 0000007900000216 000001003dba22b0 
       000000000000bbac 000001006a6f96f0 000001003dba25c8 0000010040e7b280 
       0000010040e7b280 ffffffff80145361 
Call Trace:<ffffffff80145361>{sigprocmask+241} <ffffffff80195891>{dput+33} 
       <ffffffff80123f81>{ia32_sysret+0} <ffffffff8010fde9>{sys_rt_sigsuspend+297} 
       <ffffffff801249fe>{sys32_rt_sigprocmask+206} <ffffffff801240d8>{ia32_ptregs_common+40} 
       
sshd          S 000001003f270300     0  1304    911  1306    1834  1283 (NOTLB)
000001003dacdc18 0000000000000006 0000007600001000 000001003e5833b0 
       00000000000003af 000001003e582370 000001003e5836c8 ffffffff80382230 
       000001003db0d3a0 0000000000000374 
Call Trace:<ffffffff801c46cd>{__ext3_journal_stop+45} <ffffffff80377e25>{schedule_timeout+37} 
       <ffffffff801582b7>{generic_file_aio_write_nolock+2055} 
       <ffffffff8035dc17>{unix_stream_data_wait+263} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff8035ddf1>{unix_stream_recvmsg+369} 
       <ffffffff8030d564>{sock_aio_read+180} <ffffffff8017bb93>{do_sync_read+115} 
       <ffffffff8017ae77>{dentry_open+263} <ffffffff8017ad52>{filp_open+66} 
       <ffffffff8017bcba>{vfs_read+218} <ffffffff8017bf19>{sys_read+73} 
       <ffffffff80123f81>{ia32_sysret+0} 
sshd          S 000017fade524bf8     0  1306   1304  1307               (NOTLB)
000001003d869d88 0000000000000006 000001000000d700 000001003e582370 
       00000000000011ff ffffffff803e23a0 000001003e582688 ffffffff8015a512 
       0000000008098460 0000000000000001 
Call Trace:<ffffffff8015a512>{__alloc_pages+818} <ffffffff80377e25>{schedule_timeout+37} 
       <ffffffff8024e4eb>{pty_write_room+43} <ffffffff8024d4e1>{normal_poll+305} 
       <ffffffff8019188a>{do_select+906} <ffffffff80191340>{__pollwait+0} 
       <ffffffff801ab861>{compat_sys_select+1105} <ffffffff80123f81>{ia32_sysret+0} 
       
zsh           S 0000174b6cc3cd6f     0  1307   1306  1853               (NOTLB)
000001003d72df18 0000000000000006 0000000000000216 000001003db562f0 
       000000000000b46b ffffffff803e23a0 000001003db56608 000001007f75d280 
       000001007f75d280 ffffffff80145361 
Call Trace:<ffffffff80145361>{sigprocmask+241} <ffffffff80195891>{dput+33} 
       <ffffffff80123f81>{ia32_sysret+0} <ffffffff8010fde9>{sys_rt_sigsuspend+297} 
       <ffffffff801249fe>{sys32_rt_sigprocmask+206} <ffffffff801240d8>{ia32_ptregs_common+40} 
       
apcupsd       S 000009632df819fd     0  1492      1  1538           935 (NOTLB)
000001003d0ddde8 0000000000000006 000001003e3f5cd8 000001003e21e0b0 
       000000000000b969 000001007ff9a850 000001003e21e3c8 ffffffff801584eb 
       00000000ffffdbdc 0000000000000038 
Call Trace:<ffffffff801584eb>{generic_file_aio_write+107} <ffffffff801bbbb3>{ext3_file_write+35} 
       <ffffffff8013bdb2>{sys_wait4+642} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80154c01>{compat_sys_wait4+65} 
       <ffffffff80146273>{do_sigaction+659} <ffffffff8017bea7>{vfs_write+247} 
       <ffffffff8017bf99>{sys_write+73} <ffffffff80123f81>{ia32_sysret+0} 
       
apcupsd       S 000017fcc6b703d8     0  1538   1492                     (NOTLB)
000001007c2d9d88 0000000000000006 0000010040001500 000001003dba32f0 
       00000000000010a5 000001007ff9a850 000001003dba3608 0000000000000246 
       0000001000000000 000000d000000000 
Call Trace:<ffffffff80377eb4>{schedule_timeout+180} <ffffffff80141b20>{process_timeout+0} 
       <ffffffff8019188a>{do_select+906} <ffffffff80191340>{__pollwait+0} 
       <ffffffff80246c5c>{tty_write+844} <ffffffff801ab861>{compat_sys_select+1105} 
       <ffffffff80123f81>{ia32_sysret+0} 
sshd          S 00001742a3a95af9     0  1834    911  1836          1304 (NOTLB)
000001002e86dc18 0000000000000006 0000000000001000 000001003db56b10 
       00000000000ab8bf 000001007ff9a850 000001003db56e28 ffffffff80382230 
       000001002f40e6a0 0000000000000374 
Call Trace:<ffffffff801c46cd>{__ext3_journal_stop+45} <ffffffff80377e25>{schedule_timeout+37} 
       <ffffffff801582b7>{generic_file_aio_write_nolock+2055} 
       <ffffffff8035dc17>{unix_stream_data_wait+263} <ffffffff801358f0>{autoremove_wake_function+0} 
       <ffffffff801358f0>{autoremove_wake_function+0} <ffffffff8035ddf1>{unix_stream_recvmsg+369} 
       <ffffffff8030d564>{sock_aio_read+180} <ffffffff8017bb93>{do_sync_read+115} 
       <ffffffff8017ae77>{dentry_open+263} <ffffffff8017ad52>{filp_open+66} 
       <ffffffff8017bcba>{vfs_read+218} <ffffffff8017bf19>{sys_read+73} 
       <ffffffff80123f81>{ia32_sysret+0} 
sshd          S 000017fc00e962b2     0  1836   1834  1837               (NOTLB)
000001006e029d88 0000000000000006 000000740000d700 0000010001e8c910 
       0000000000009f32 000001003dba2ad0 0000010001e8cc28 ffffffff8015a512 
       0000000008099438 0000000000000001 
Call Trace:<ffffffff8015a512>{__alloc_pages+818} <ffffffff80377e25>{schedule_timeout+37} 
       <ffffffff8024e4eb>{pty_write_room+43} <ffffffff8024d4e1>{normal_poll+305} 
       <ffffffff8019188a>{do_select+906} <ffffffff80191340>{__pollwait+0} 
       <ffffffff801ab861>{compat_sys_select+1105} <ffffffff80123f81>{ia32_sysret+0} 
       
zsh           S 00001743a8714734     0  1837   1836  1845               (NOTLB)
0000010028cf9f18 0000000000000006 0000000000000216 0000010001ffa990 
       000000000000d3bf ffffffff803e23a0 0000010001ffaca8 000001007f75d4c0 
       000001007f75d4c0 ffffffff80145361 
Call Trace:<ffffffff80145361>{sigprocmask+241} <ffffffff80195891>{dput+33} 
       <ffffffff80123f81>{ia32_sysret+0} <ffffffff8010fde9>{sys_rt_sigsuspend+297} 
       <ffffffff801249fe>{sys32_rt_sigprocmask+206} <ffffffff801240d8>{ia32_ptregs_common+40} 
       
zsh           R  running task       0  1845   1837                     (NOTLB)
zsh           S 000017fade51a9f9     0  1853   1307  1887               (NOTLB)
0000010024123d38 0000000000000006 0000007400000246 000001003e614230 
       00000000000054ed 000001003e582370 000001003e614548 000001007ffee680 
       000001000000e500 0000000000000216 
Call Trace:<ffffffff8015a512>{__alloc_pages+818} <ffffffff80377e25>{schedule_timeout+37} 
       <ffffffff8024a7a1>{opost_block+401} <ffffffff8024cb55>{read_chan+1109} 
       <ffffffff80168375>{do_wp_page+261} <ffffffff801699ff>{handle_mm_fault+399} 
       <ffffffff80133440>{default_wake_function+0} <ffffffff80133440>{default_wake_function+0} 
       <ffffffff8024685f>{tty_read+303} <ffffffff8017bca7>{vfs_read+199} 
       <ffffffff8017bf19>{sys_read+73} <ffffffff80123f81>{ia32_sysret+0} 
       
top           S 000017fc68844929     0  1884   1295                     (NOTLB)
000001006d4f7d88 0000000000000006 0000007440001500 000001006a6f86b0 
       0000000000000121 000001007ff9a850 000001006a6f89c8 0000000000000246 
       000000103f2359d8 000000d000000000 
Call Trace:<ffffffff80377eb4>{schedule_timeout+180} <ffffffff80141b20>{process_timeout+0} 
       <ffffffff8019188a>{do_select+906} <ffffffff80191340>{__pollwait+0} 
       <ffffffff801ab861>{compat_sys_select+1105} <ffffffff80123f81>{ia32_sysret+0} 
       
dump          D 000017f4796ce9b2     0  1887   1853                     (NOTLB)
000001001ae8dbb8 0000000000000006 000001003ffd5948 000001006a6f96f0 
       0000000000009235 ffffffff803e23a0 000001006a6f9a08 ffffffff802fd643 
       0000000000000212 0000000000000001 
Call Trace:<ffffffff802fd643>{raid5_unplug_device+291} <ffffffff80377d0b>{io_schedule+43} 
       <ffffffff80155f6a>{__lock_page+250} <ffffffff80155c40>{page_wake_function+0} 
       <ffffffff80155c40>{page_wake_function+0} <ffffffff801567f6>{do_generic_mapping_read+502} 
       <ffffffff80156a70>{file_read_actor+0} <ffffffff80156d14>{__generic_file_aio_read+372} 
       <ffffffff80156dfb>{generic_file_read+123} <ffffffff80169994>{handle_mm_fault+292} 
       <ffffffff80122ad8>{do_page_fault+440} <ffffffff80130948>{recalc_task_prio+424} 
       <ffffffff8037748c>{thread_return+41} <ffffffff8017bca7>{vfs_read+199} 
       <ffffffff8017bf19>{sys_read+73} <ffffffff80123f81>{ia32_sysret+0} 
       
