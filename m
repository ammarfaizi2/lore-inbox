Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbVLEWai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbVLEWai (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 17:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbVLEWai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 17:30:38 -0500
Received: from [82.153.166.94] ([82.153.166.94]:14765 "EHLO mail.inprovide.com")
	by vger.kernel.org with ESMTP id S1750917AbVLEWah convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 17:30:37 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.6.11 and later freeze without processor.nocst=1
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Mon, 05 Dec 2005 22:30:20 +0000
Message-ID: <yw1xd5kb5g8z.fsf@inprovide.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel versions 2.6.11 and later refuse to boot on my Asus P4V8X-X
board without the processor.nocst=1 option on the kernel command line.
Earlier versions work without any issues.

Is there any information I can supply to help fix this?

The kernel log from booting looks like this:

Linux version 2.6.14 (root@agrajag) (gcc version 3.3.6 (Gentoo 3.3.6, ssp-3.3.6-1.0, pie-8.7.8)) #2 PREEMPT Sat Dec 3 18:59:29 GMT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff30000 (usable)
 BIOS-e820: 000000001ff30000 - 000000001ff40000 (ACPI data)
 BIOS-e820: 000000001ff40000 - 000000001fff0000 (ACPI NVS)
 BIOS-e820: 000000001fff0000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 130864
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126768 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                ) @ 0x000fa3a0
ACPI: XSDT (v001 A M I  OEMXSDT  0x05000418 MSFT 0x00000097) @ 0x1ff30100
ACPI: FADT (v003 A M I  OEMFACP  0x05000418 MSFT 0x00000097) @ 0x1ff30290
ACPI: MADT (v001 A M I  OEMAPIC  0x05000418 MSFT 0x00000097) @ 0x1ff30390
ACPI: OEMB (v001 A M I  AMI_OEM  0x05000418 MSFT 0x00000097) @ 0x1ff40040
ACPI: DSDT (v001  A0017 A0017001 0x00000001 INTL 0x02002026) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:df7c0000)
Built 1 zonelists
Kernel command line: root=/dev/md0 acpi_irq_balance console=uart,io,0x3f8,38400n8 processor.nocst=1
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
CPU 0 irqstacks, hard=c03a5000 soft=c03a4000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2400.463 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Early serial console at I/O port 0x3f8 (options '38400n8')
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515012k/523456k available (1956k kernel code, 7884k reserved, 568k data, 152k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4812.32 BogoMIPS (lpj=9624645)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 0000441d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 0000441d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 0000441d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
CPU: Intel(R) Celeron(R) CPU 2.40GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
softlockup thread 0 started up.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: de700000-dfafffff
  PREFETCH window: da600000-de5fffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
Machine check exception polling timer started.
SGI XFS with ACLs, no debug enabled
Initializing Cryptographic API
PCI: Bypassing VIA 8237 APIC De-Assert Message
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]

**** Freeze here without nocst=1 ****

ACPI: CPU0 (power states: C1[C1])
ACPI: Processor [CPU1] (supports 16 throttling states)
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
mice: PS/2 mouse device common for all mice
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
libata version 1.12 loaded.
sata_via version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 16
PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 0
sata_via(0000:00:0f.0): routed to hard irq line 0


-- 
Måns Rullgård
mru@inprovide.com
