Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUCXNxO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 08:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263371AbUCXNxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 08:53:14 -0500
Received: from linux-bt.org ([217.160.111.169]:54178 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S263370AbUCXNxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 08:53:02 -0500
Subject: ACPI problem with latest 2.6 snapshot
From: Marcel Holtmann <marcel@holtmann.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>
Content-Type: text/plain
Message-Id: <1080136312.2309.9.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 24 Mar 2004 14:51:53 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

using the latest Bitkeeper snapshot from 2.6 makes it impossible to use
my machine with IOAPIC. Only booting with pci=noacpi makes it usable
again. Here is my lspci

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 12)
00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 12)
00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 12)
00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 12)
00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 12)
00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 12)
00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio (rev 12)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
02:09.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
02:0a.0 Serial controller: Unknown device 17b0:9521
02:0b.0 SCSI storage controller: Adaptec AIC-7861 (rev 01)
02:0c.0 USB Controller: NEC Corporation USB (rev 43)
02:0c.1 USB Controller: NEC Corporation USB (rev 43)
02:0c.2 USB Controller: NEC Corporation USB 2.0 (rev 04)
02:0d.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394 Controller (Link)
02:0e.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
03:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 05)
03:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 05)

and this is the output of dmesg

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126972 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f75e0
ACPI: RSDT (v001 ASUS   <P4B>    0x42302e31 MSFT 0x31313031) @ 0x1fffc000
ACPI: FADT (v001 ASUS   <P4B>    0x42302e31 MSFT 0x31313031) @ 0x1fffc100
ACPI: BOOT (v001 ASUS   <P4B>    0x42302e31 MSFT 0x31313031) @ 0x1fffc040
ACPI: MADT (v001 ASUS   <P4B>    0x42302e31 MSFT 0x31313031) @ 0x1fffc080
ACPI: DSDT (v001   ASUS <P4B>    0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 22 low level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2018.651 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 516052k/524272k available (1477k kernel code, 7472k reserved, 514k data, 124k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3981.31 BogoMIPS
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 3febfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 2.00GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2017.0646 MHz.
..... host bus clock speed is 100.0882 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf11f0, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040311
ACPI: SCI (IRQ22) allocation failed
    ACPI-0133: *** Error: Unable to install System Control Interrupt Handler, AE_NOT_ACQUIRED
ACPI: Unable to start the ACPI Interpreter
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Enabled i801 SMBus device
Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/2440] at 0000:00:1f.0
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 1!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 2!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 2!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 2!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 2!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 2!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 2!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 2!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 3!
PCI BIOS passed nonexistent PCI bus 2!
PCI BIOS passed nonexistent PCI bus 3!
PCI BIOS passed nonexistent PCI bus 2!
Simple Boot Flag at 0x3a set to 0x1
Machine check exception polling timer started.

and later on the USB subsystem complains

usb 1-1: control timeout on ep0out
uhci_hcd 0000:00:1f.2: Unlink after no-IRQ?  Different ACPI or APIC settings may help.

and as a side note I had to remove the aic7xxx driver because it hangs
the machine on loading the module.

Regards

Marcel


