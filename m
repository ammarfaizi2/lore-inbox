Return-Path: <linux-kernel-owner+w=401wt.eu-S1751020AbXAUQlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbXAUQlR (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 11:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbXAUQlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 11:41:17 -0500
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:54872 "EHLO
	aa012msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbXAUQlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 11:41:14 -0500
Date: Sun, 21 Jan 2007 17:40:23 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Hancock <hancockr@shaw.ca>,
       =?ISO-8859-15?B?Qmr2cm4=?= Steinbrink <B.Steinbrink@gmx.de>,
       Jens Axboe <jens.axboe@oracle.com>, Jeff Garzik <jeff@garzik.org>,
       Tejun Heo <htejun@gmail.com>
Subject: Re: SATA exceptions triggered by XFS (since 2.6.18)
Message-ID: <20070121174023.68402ade@localhost>
In-Reply-To: <20070121152932.6dc1d9fb@localhost>
References: <20070121152932.6dc1d9fb@localhost>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.10.6; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=MP_2y+m36D+pGqu.k6jh.RpTPr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_2y+m36D+pGqu.k6jh.RpTPr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sun, 21 Jan 2007 15:29:32 +0100
Paolo Ornati <ornati@fastwebnet.it> wrote:

> Sorry for starting a new thread, but I've deleted the messages from my
> mail-box, and I'm sot sure it's the same problem as here:
> 	http://lkml.org/lkml/2007/1/14/108
> 
> Today I've decided to try XFS... and just doing anything on it
> (extracting a tarball, for example) make my SATA HD go crazy ;)
> 
> I don't remember to have seen this using Ext3.
> 
> [  877.839920] ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action
> 0x2 frozen [  877.839929] ata1.00: cmd
> 61/02:00:64:98:98/00:00:00:00:00/40 tag 0 cdb 0x0 data 1024 out
> [  877.839931]          res 40/00:00:00:4f:c2/00:00:00:4f:c2/00 Emask
> 0x4 (timeout) [  878.142367] ata1: soft resetting port [  878.351791]
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300) [  878.354384]
> ata1.00: configured for UDMA/133 [  878.354392] ata1: EH complete
> [  878.355696] SCSI device sda: 156301488 512-byte hdwr sectors
> (80026 MB) [  878.355716] sda: Write Protect is off
> [  878.355718] sda: Mode Sense: 00 3a 00 00
> [  878.355745] SCSI device sda: write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> 
> 
> It takes nothing to reproduce it.
> 
> My hardware is:
> 
> 00:00.0 Host bridge: Intel Corporation 82P965/G965 Memory Controller
> Hub (rev 02) 00:02.0 VGA compatible controller: Intel Corporation
> 82G965 Integrated Graphics Controller (rev 02) 00:03.0 Communication
> controller: Intel Corporation 82P965/G965 HECI Controller (rev 02)
> 00:19.0 Ethernet controller: Intel Corporation 82566DC Gigabit
> Network Connection (rev 02) 00:1a.0 USB Controller: Intel Corporation
> 82801H (ICH8 Family) USB UHCI #4 (rev 02) 00:1a.1 USB Controller:
> Intel Corporation 82801H (ICH8 Family) USB UHCI #5 (rev 02) 00:1a.7
> USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI #2
> (rev 02) 00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family)
> HD Audio Controller (rev 02) 00:1c.0 PCI bridge: Intel Corporation
> 82801H (ICH8 Family) PCI Express Port 1 (rev 02) 00:1c.1 PCI bridge:
> Intel Corporation 82801H (ICH8 Family) PCI Express Port 2 (rev 02)
> 00:1c.2 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI
> Express Port 3 (rev 02) 00:1c.3 PCI bridge: Intel Corporation 82801H
> (ICH8 Family) PCI Express Port 4 (rev 02) 00:1c.4 PCI bridge: Intel
> Corporation 82801H (ICH8 Family) PCI Express Port 5 (rev 02) 00:1d.0
> USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #1
> (rev 02) 00:1d.1 USB Controller: Intel Corporation 82801H (ICH8
> Family) USB UHCI #2 (rev 02) 00:1d.2 USB Controller: Intel
> Corporation 82801H (ICH8 Family) USB UHCI #3 (rev 02) 00:1d.7 USB
> Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI #1 (rev
> 02) 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev f2)
> 00:1f.0 ISA bridge: Intel Corporation 82801HB/HR (ICH8/R) LPC
> Interface Controller (rev 02) 00:1f.2 SATA controller: Intel
> Corporation 82801HB (ICH8) 4 port SATA AHCI Controller (rev 02)
> 00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus
> Controller (rev 02) 02:00.0 IDE interface: Marvell Technology Group
> Ltd. Unknown device 6101 (rev b1) 06:00.0 Ethernet controller:
> Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
> 
> 
> with a Seagate Barracurda 7200rpm 80GB HD
> 
> 
> I've so far tested these kernels:
> 2.6.20-rc5	BAD
> 2.6.20-rc4	BAD
> 2.6.19		BAD
> 2.6.18		BAD
> 2.6.17		Good !
> 
> I'll start a git-bisection...
> 

git-bisect points to this commit:

----------------------------------------------

12fad3f965830d71f6454f02b2af002a64cec4d3 is first bad commit
commit 12fad3f965830d71f6454f02b2af002a64cec4d3
Author: Tejun Heo <htejun@gmail.com>
Date:   Mon May 15 21:03:55 2006 +0900

[PATCH] ahci: implement NCQ suppport

Implement NCQ support.

Original implementation is from Jens Axboe.

Signed-off-by: Tejun Heo <htejun@gmail.com>

:040000 040000 be681c4b21f34da5241e72c97c6695d735e90771
3557b2db9d7c3d48a0408137b455ce12931bb18d M      drivers

----------------------------------------------

Problem just reproduced on 2.6.20-rc5:

[  431.374421] ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
[  431.374430] ata1.00: cmd 61/40:00:fe:aa:98/00:00:00:00:00/40 tag 0 cdb 0x0 data 32768 out
[  431.374432]          res 40/00:00:9e:9c:bd/00:00:01:00:00/40 Emask 0x4 (timeout)
[  431.677154] ata1: soft resetting port
[  431.886700] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  431.889277] ata1.00: configured for UDMA/133
[  431.889285] ata1: EH complete
[  431.890781] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[  431.890854] sda: Write Protect is off
[  431.890858] sda: Mode Sense: 00 3a 00 00
[  431.890903] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  450.800490] XFS mounting filesystem sda1
[  450.853731] Ending clean XFS mount for filesystem: sda1
[  481.131888] ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
[  481.131896] ata1.00: cmd 61/40:00:46:af:98/00:00:00:00:00/40 tag 0 cdb 0x0 data 32768 out
[  481.131898]          res 40/00:00:9e:9c:bd/00:00:01:00:00/40 Emask 0x4 (timeout)
[  481.436015] ata1: soft resetting port
[  481.645237] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  481.647825] ata1.00: configured for UDMA/133
[  481.647834] ata1: EH complete
[  481.649252] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[  481.649295] sda: Write Protect is off
[  481.649298] sda: Mode Sense: 00 3a 00 00
[  481.649358] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA


Full dmesg attached.

If you need more info, just ask.

-- 
	Paolo Ornati
	Linux 2.6.20-rc5 on x86_64

--MP_2y+m36D+pGqu.k6jh.RpTPr
Content-Type: text/plain; name=dmesg.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=dmesg.txt

[    0.000000] Linux version 2.6.20-rc5 (paolo@tux) (gcc version 4.1.1 (Gentoo 4.1.1-r1)) #12 SMP Sun Jan 21 13:31:25 CET 2007
[    0.000000] Command line: root=/dev/sda6 vga=0x305
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000008f000 (usable)
[    0.000000]  BIOS-e820: 000000000008f000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003e599000 (usable)
[    0.000000]  BIOS-e820: 000000003e599000 - 000000003e5a6000 (reserved)
[    0.000000]  BIOS-e820: 000000003e5a6000 - 000000003e655000 (usable)
[    0.000000]  BIOS-e820: 000000003e655000 - 000000003e6a6000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003e6a6000 - 000000003e6ab000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003e6ab000 - 000000003e6ac000 (usable)
[    0.000000]  BIOS-e820: 000000003e6ac000 - 000000003e6f2000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003e6f2000 - 000000003e6ff000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003e6ff000 - 000000003e700000 (usable)
[    0.000000]  BIOS-e820: 000000003e700000 - 000000003f000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000] Entering add_active_range(0, 0, 143) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 255385) 1 entries of 256 used
[    0.000000] Entering add_active_range(0, 255398, 255573) 2 entries of 256 used
[    0.000000] Entering add_active_range(0, 255659, 255660) 3 entries of 256 used
[    0.000000] Entering add_active_range(0, 255743, 255744) 4 entries of 256 used
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI 2.4 present.
[    0.000000] ACPI: RSDP (v000 INTEL                                 ) @ 0x00000000000fe020
[    0.000000] ACPI: RSDT (v001 INTEL  DG965SS  0x00000629      0x01000013) @ 0x000000003e6fd038
[    0.000000] ACPI: FADT (v001 INTEL  DG965SS  0x00000629 MSFT 0x01000013) @ 0x000000003e6fc000
[    0.000000] ACPI: MADT (v001 INTEL  DG965SS  0x00000629 MSFT 0x01000013) @ 0x000000003e6f6000
[    0.000000] ACPI: WDDT (v001 INTEL  DG965SS  0x00000629 MSFT 0x01000013) @ 0x000000003e6f5000
[    0.000000] ACPI: MCFG (v001 INTEL  DG965SS  0x00000629 MSFT 0x01000013) @ 0x000000003e6f4000
[    0.000000] ACPI: ASF! (v032 INTEL  DG965SS  0x00000629 MSFT 0x01000013) @ 0x000000003e6f3000
[    0.000000] ACPI: HPET (v001 INTEL  DG965SS  0x00000629 MSFT 0x01000013) @ 0x000000003e6f2000
[    0.000000] ACPI: SSDT (v001 INTEL     CpuPm 0x00000629 MSFT 0x01000013) @ 0x000000003e6aa000
[    0.000000] ACPI: SSDT (v001 INTEL   Cpu0Ist 0x00000629 MSFT 0x01000013) @ 0x000000003e6a9000
[    0.000000] ACPI: SSDT (v001 INTEL   Cpu1Ist 0x00000629 MSFT 0x01000013) @ 0x000000003e6a8000
[    0.000000] ACPI: SSDT (v001 INTEL   Cpu2Ist 0x00000629 MSFT 0x01000013) @ 0x000000003e6a7000
[    0.000000] ACPI: SSDT (v001 INTEL   Cpu3Ist 0x00000629 MSFT 0x01000013) @ 0x000000003e6a6000
[    0.000000] ACPI: DSDT (v001 INTEL  DG965SS  0x00000629 MSFT 0x01000013) @ 0x0000000000000000
[    0.000000] Entering add_active_range(0, 0, 143) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 255385) 1 entries of 256 used
[    0.000000] Entering add_active_range(0, 255398, 255573) 2 entries of 256 used
[    0.000000] Entering add_active_range(0, 255659, 255660) 3 entries of 256 used
[    0.000000] Entering add_active_range(0, 255743, 255744) 4 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] early_node_map[5] active PFN ranges
[    0.000000]     0:        0 ->      143
[    0.000000]     0:      256 ->   255385
[    0.000000]     0:   255398 ->   255573
[    0.000000]     0:   255659 ->   255660
[    0.000000]     0:   255743 ->   255744
[    0.000000] On node 0 totalpages: 255449
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 1286 pages reserved
[    0.000000]   DMA zone: 2641 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 3440 pages used for memmap
[    0.000000]   DMA32 zone: 248026 pages, LIFO batch:31
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Nosave address range: 000000000008f000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000e0000
[    0.000000] Nosave address range: 00000000000e0000 - 0000000000100000
[    0.000000] Nosave address range: 000000003e599000 - 000000003e5a6000
[    0.000000] Nosave address range: 000000003e655000 - 000000003e6a6000
[    0.000000] Nosave address range: 000000003e6a6000 - 000000003e6ab000
[    0.000000] Nosave address range: 000000003e6ac000 - 000000003e6f2000
[    0.000000] Nosave address range: 000000003e6f2000 - 000000003e6ff000
[    0.000000] Allocating PCI resources starting at 40000000 (gap: 3f000000:c0f00000)
[    0.000000] PERCPU: Allocating 32576 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 250667
[    0.000000] Kernel command line: root=/dev/sda6 vga=0x305
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   30.622927] Console: colour dummy device 80x25
[   30.623426] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   30.623788] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[   30.623872] Checking aperture...
[   30.633592] Memory: 998312k/1022976k available (2871k kernel code, 22812k reserved, 1529k data, 232k init)
[   30.693254] Calibrating delay using timer specific routine.. 3732.21 BogoMIPS (lpj=1866108)
[   30.693304] Mount-cache hash table entries: 256
[   30.693409] CPU: L1 I cache: 32K, L1 D cache: 32K
[   30.693414] CPU: L2 cache: 2048K
[   30.693417] using mwait in idle threads.
[   30.693421] CPU: Physical Processor ID: 0
[   30.693423] CPU: Processor Core ID: 0
[   30.693430] CPU0: Thermal monitoring enabled (TM2)
[   30.693444] Freeing SMP alternatives: 28k freed
[   30.693461] ACPI: Core revision 20060707
[   30.708480] Using local APIC timer interrupts.
[   30.762098] result 16650020
[   30.762101] Detected 16.650 MHz APIC timer.
[   30.762330] Booting processor 1/2 APIC 0x1
[   30.772913] Initializing CPU#1
[   30.833217] Calibrating delay using timer specific routine.. 3729.62 BogoMIPS (lpj=1864812)
[   30.833224] CPU: L1 I cache: 32K, L1 D cache: 32K
[   30.833226] CPU: L2 cache: 2048K
[   30.833229] CPU: Physical Processor ID: 0
[   30.833230] CPU: Processor Core ID: 1
[   30.833236] CPU1: Thermal monitoring enabled (TM2)
[   30.833533] Intel(R) Core(TM)2 CPU          6300  @ 1.86GHz stepping 06
[   30.834228] Brought up 2 CPUs
[   30.834277] testing NMI watchdog ... OK.
[   30.844290] time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
[   30.844294] time.c: Detected 1864.803 MHz processor.
[   30.898517] migration_cost=22
[   30.898779] NET: Registered protocol family 16
[   30.898854] ACPI: bus type pci registered
[   30.898861] PCI: Using configuration type 1
[   30.903472] ACPI: Interpreter enabled
[   30.903477] ACPI: Using IOAPIC for interrupt routing
[   30.903872] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   30.903878] PCI: Probing PCI hardware (bus 00)
[   30.903895] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
[   30.905108] Boot video device is 0000:00:02.0
[   30.905728] PCI quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO
[   30.905734] PCI quirk: region 0500-053f claimed by ICH6 GPIO
[   30.906325] PCI: Transparent bridge - 0000:00:1e.0
[   30.906390] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   30.912015] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
[   30.912793] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
[   30.913029] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12)
[   30.913271] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
[   30.913501] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12)
[   30.913738] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *9 10 11 12)
[   30.913969] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 *10 11 12)
[   30.914204] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 *9 10 11 12)
[   30.914436] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 *11 12)
[   30.916002] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
[   30.916265] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
[   30.916519] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
[   30.916773] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
[   30.917026] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX4._PRT]
[   30.918512] Linux Plug and Play Support v0.97 (c) Adam Belay
[   30.918521] pnp: PnP ACPI init
[   30.921536] pnp: PnP ACPI: found 13 devices
[   30.921672] SCSI subsystem initialized
[   30.921709] libata version 2.00 loaded.
[   30.921756] usbcore: registered new interface driver usbfs
[   30.921787] usbcore: registered new interface driver hub
[   30.921824] usbcore: registered new device driver usb
[   30.921886] PCI: Using ACPI for IRQ routing
[   30.921890] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   30.921974] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[   30.921981] hpet0: 3 64-bit timers, 14318180 Hz
[   30.923000] PCI-GART: No AMD northbridge found.
[   30.923060] pnp: 00:06: ioport range 0x500-0x53f has been reserved
[   30.923065] pnp: 00:06: ioport range 0x400-0x47f could not be reserved
[   30.923069] pnp: 00:06: ioport range 0x680-0x6ff has been reserved
[   30.923339] PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
[   30.923345] PCI: Bridge: 0000:00:1c.0
[   30.923348]   IO window: disabled.
[   30.923353]   MEM window: 50400000-504fffff
[   30.923358]   PREFETCH window: disabled.
[   30.923363] PCI: Bridge: 0000:00:1c.1
[   30.923367]   IO window: 2000-2fff
[   30.923372]   MEM window: 50100000-501fffff
[   30.923376]   PREFETCH window: disabled.
[   30.923381] PCI: Bridge: 0000:00:1c.2
[   30.923384]   IO window: disabled.
[   30.923389]   MEM window: 50500000-505fffff
[   30.923393]   PREFETCH window: disabled.
[   30.923399] PCI: Bridge: 0000:00:1c.3
[   30.923401]   IO window: disabled.
[   30.923406]   MEM window: 50600000-506fffff
[   30.923411]   PREFETCH window: disabled.
[   30.923416] PCI: Bridge: 0000:00:1c.4
[   30.923418]   IO window: disabled.
[   30.923424]   MEM window: 50700000-507fffff
[   30.923428]   PREFETCH window: disabled.
[   30.923433] PCI: Bridge: 0000:00:1e.0
[   30.923437]   IO window: 1000-1fff
[   30.923442]   MEM window: 50000000-500fffff
[   30.923446]   PREFETCH window: disabled.
[   30.923467] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
[   30.923475] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[   30.923490] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 16
[   30.923496] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[   30.923511] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
[   30.923518] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[   30.923533] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
[   30.923539] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[   30.923553] ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 17
[   30.923560] PCI: Setting latency timer of device 0000:00:1c.4 to 64
[   30.923569] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   30.923592] NET: Registered protocol family 2
[   30.936495] IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
[   30.936626] TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
[   30.937429] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   30.938075] TCP: Hash tables configured (established 131072 bind 65536)
[   30.938079] TCP reno registered
[   30.941694] checking if image is initramfs...it isn't (bad gzip magic numbers); looks like an initrd
[   30.943818] Freeing initrd memory: 2000k freed
[   30.944858] IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
[   30.945458] fuse init (API version 7.8)
[   30.945511] SGI XFS with large block/inode numbers, no debug enabled
[   30.945676] io scheduler noop registered
[   30.945689] io scheduler cfq registered (default)
[   30.946204] vesafb: framebuffer at 0x40000000, mapped to 0xffffc20000080000, using 1536k, total 7616k
[   30.946210] vesafb: mode is 1024x768x8, linelength=1024, pages=8
[   30.946214] vesafb: scrolling: redraw
[   30.946217] vesafb: Pseudocolor: size=8:8:8:8, shift=0:0:0:0
[   30.954761] Console: switching to colour frame buffer device 128x48
[   30.963319] fb0: VESA VGA frame buffer device
[   30.963456] input: Power Button (FF) as /class/input/input0
[   30.963546] ACPI: Power Button (FF) [PWRF]
[   30.963660] input: Sleep Button (CM) as /class/input/input1
[   30.963753] ACPI: Sleep Button (CM) [SLPB]
[   30.964061] ACPI: Processor [CPU0] (supports 8 throttling states)
[   30.964230] ACPI: Processor [CPU1] (supports 8 throttling states)
[   30.966361] Real Time Clock Driver v1.12ac
[   30.966471] hpet_resources: 0xfed00000 is busy
[   30.966490] Linux agpgart interface v0.101 (c) Dave Jones
[   30.966636] agpgart: Detected an Intel 965G Chipset.
[   30.967245] agpgart: Unknown page table size, assuming 512KB
[   30.967343] agpgart: Detected 7676K stolen memory.
[   30.979835] agpgart: AGP aperture is 256M @ 0x40000000
[   30.979956] [drm] Initialized drm 1.1.0 20060810
[   30.980047] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
[   30.980221] [drm] Initialized i915 1.6.0 20060119 on minor 0
[   30.980313] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[   30.980544] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   30.982444] 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   30.984136] Floppy drive(s): fd0 is 1.44M
[   30.999821] FDC 0 is a National Semiconductor PC87306
[   31.002866] RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
[   31.004881] loop: loaded (max 8 devices)
[   31.006710] Intel(R) PRO/10GbE Network Driver - version 1.0.126-k2
[   31.008648] Copyright (c) 1999-2006 Intel Corporation.
[   31.010866] 8139too Fast Ethernet driver 0.9.28
[   31.012935] ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 21 (level, low) -> IRQ 21
[   31.015439] eth0: RealTek RTL8139 at 0xffffc2000000e000, 00:e0:4c:f0:a9:84, IRQ 21
[   31.017719] eth0:  Identified 8139 chip type 'RTL-8139C'
[   31.017724] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   31.020080] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   31.022624] Probing IDE interface ide0...
[   31.536077] Probing IDE interface ide1...
[   32.049444] ahci 0000:00:1f.2: version 2.0
[   32.049457] ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 19 (level, low) -> IRQ 19
[   33.053438] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   33.053445] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0x33 impl SATA mode
[   33.056162] ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part 
[   33.058971] ata1: SATA max UDMA/133 cmd 0xFFFFC20000024100 ctl 0x0 bmdma 0x0 irq 19
[   33.061879] ata2: SATA max UDMA/133 cmd 0xFFFFC20000024180 ctl 0x0 bmdma 0x0 irq 19
[   33.064763] ata3: DUMMY
[   33.067649] ata4: DUMMY
[   33.070574] ata5: SATA max UDMA/133 cmd 0xFFFFC20000024300 ctl 0x0 bmdma 0x0 irq 19
[   33.073666] ata6: SATA max UDMA/133 cmd 0xFFFFC20000024380 ctl 0x0 bmdma 0x0 irq 19
[   33.076718] scsi0 : ahci
[   33.537612] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   33.541952] ata1.00: ATA-6, max UDMA/133, 156301488 sectors: LBA48 NCQ (depth 31/32)
[   33.546612] ata1.00: configured for UDMA/133
[   33.549812] scsi1 : ahci
[   33.856779] ata2: SATA link down (SStatus 0 SControl 300)
[   33.859895] scsi2 : ahci
[   33.863049] scsi3 : ahci
[   33.866148] scsi4 : ahci
[   34.171860] ata5: SATA link down (SStatus 0 SControl 300)
[   34.174931] scsi5 : ahci
[   34.480952] ata6: SATA link down (SStatus 0 SControl 300)
[   34.484083] scsi 0:0:0:0: Direct-Access     ATA      ST380817AS       3.42 PQ: 0 ANSI: 5
[   34.487315] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[   34.490502] sda: Write Protect is off
[   34.493660] sda: Mode Sense: 00 3a 00 00
[   34.493675] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   34.497010] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[   34.500315] sda: Write Protect is off
[   34.503558] sda: Mode Sense: 00 3a 00 00
[   34.503573] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   34.506920]  sda: sda1 sda2 < sda5 sda6 sda7 sda8 >
[   34.570981] sd 0:0:0:0: Attached scsi disk sda
[   34.574292] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   34.577577] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 17
[   34.580884] PCI: Setting latency timer of device 0000:02:00.0 to 64
[   34.580903] ata7: PATA max UDMA/100 cmd 0x2018 ctl 0x2026 bmdma 0x2000 irq 17
[   34.584160] scsi6 : pata_marvell
[   34.587447] BAR5:00:00 01:7F 02:22 03:CA 04:00 05:00 06:00 07:00 08:00 09:00 0A:00 0B:00 0C:01 0D:00 0E:00 0F:00 
[   34.754096] ATA: abnormal status 0x8 on port 0x201F
[   34.769209] ATA: abnormal status 0x8 on port 0x201F
[   34.943029] ata7.01: ATAPI, max UDMA/33
[   35.117489] ata7.01: configured for UDMA/33
[   35.124371] scsi 6:0:1:0: CD-ROM            HL-DT-ST DVDRAM GSA-4167B DL11 PQ: 0 ANSI: 5
[   35.146129] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[   35.149422] Uniform CD-ROM driver Revision: 3.20
[   35.152680] sr 6:0:1:0: Attached scsi CD-ROM sr0
[   35.152733] sr 6:0:1:0: Attached scsi generic sg1 type 5
[   35.155964] ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 18 (level, low) -> IRQ 18
[   35.159175] PCI: Setting latency timer of device 0000:00:1a.7 to 64
[   35.159179] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[   35.162397] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
[   35.165598] ehci_hcd 0000:00:1a.7: debug port 1
[   35.168784] PCI: cache line size of 32 is not supported by device 0000:00:1a.7
[   35.168791] ehci_hcd 0000:00:1a.7: irq 18, io mem 0x50325c00
[   35.175808] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   35.179141] usb usb1: configuration #1 chosen from 1 choice
[   35.182385] hub 1-0:1.0: USB hub found
[   35.185625] hub 1-0:1.0: 4 ports detected
[   35.289849] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
[   35.293120] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   35.293123] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   35.296363] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
[   35.299612] ehci_hcd 0000:00:1d.7: debug port 1
[   35.302811] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[   35.302818] ehci_hcd 0000:00:1d.7: irq 23, io mem 0x50325800
[   35.309902] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   35.313202] usb usb2: configuration #1 chosen from 1 choice
[   35.316505] hub 2-0:1.0: USB hub found
[   35.319802] hub 2-0:1.0: 6 ports detected
[   35.423852] USB Universal Host Controller Interface driver v3.0
[   35.427206] ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level, low) -> IRQ 16
[   35.430572] PCI: Setting latency timer of device 0000:00:1a.0 to 64
[   35.430575] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[   35.433925] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[   35.437262] uhci_hcd 0000:00:1a.0: irq 16, io base 0x000030c0
[   35.440634] usb usb3: configuration #1 chosen from 1 choice
[   35.443886] hub 3-0:1.0: USB hub found
[   35.447056] hub 3-0:1.0: 2 ports detected
[   35.551901] ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level, low) -> IRQ 21
[   35.555078] PCI: Setting latency timer of device 0000:00:1a.1 to 64
[   35.555081] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[   35.558204] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[   35.561364] uhci_hcd 0000:00:1a.1: irq 21, io base 0x000030a0
[   35.564605] usb usb4: configuration #1 chosen from 1 choice
[   35.567757] hub 4-0:1.0: USB hub found
[   35.570823] hub 4-0:1.0: 2 ports detected
[   35.674942] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
[   35.677998] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   35.678001] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   35.680990] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
[   35.684056] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00003080
[   35.687166] usb usb5: configuration #1 chosen from 1 choice
[   35.690247] hub 5-0:1.0: USB hub found
[   35.693235] hub 5-0:1.0: 2 ports detected
[   35.797979] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
[   35.800971] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   35.800974] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   35.803973] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
[   35.806959] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00003060
[   35.809972] usb usb6: configuration #1 chosen from 1 choice
[   35.812916] hub 6-0:1.0: USB hub found
[   35.815806] hub 6-0:1.0: 2 ports detected
[   35.920021] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
[   35.922994] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   35.922997] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   35.925960] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
[   35.928932] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00003040
[   35.931994] usb usb7: configuration #1 chosen from 1 choice
[   35.934965] hub 7-0:1.0: USB hub found
[   35.937844] hub 7-0:1.0: 2 ports detected
[   36.042093] usbcore: registered new interface driver cdc_acm
[   36.044991] drivers/usb/class/cdc-acm.c: v0.25:USB Abstract Control Model driver for USB modems and ISDN adapters
[   36.048065] usbcore: registered new interface driver usblp
[   36.051105] drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
[   36.054174] Initializing USB Mass Storage driver...
[   36.057250] usbcore: registered new interface driver usb-storage
[   36.060363] USB Mass Storage support registered.
[   36.063533] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[   36.069536] serio: i8042 KBD port at 0x60,0x64 irq 1
[   36.072646] serio: i8042 AUX port at 0x60,0x64 irq 12
[   36.075753] mice: PS/2 mouse device common for all mice
[   36.078970] i2c /dev entries driver
[   36.082061] ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 21 (level, low) -> IRQ 21
[   36.105452] EDAC MC: Ver: 2.0.1 Jan 21 2007
[   36.108861] Advanced Linux Sound Architecture Driver Version 1.0.14rc1 (Tue Jan 09 09:56:17 2007 UTC).
[   36.112489] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 22
[   36.115735] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[   36.236274] ALSA device list:
[   36.239468]   #0: HDA Intel at 0x50320000 irq 22
[   36.242691] nf_conntrack version 0.5.0 (3996 buckets, 31968 max)
[   36.246129] ip_tables: (C) 2000-2006 Netfilter Core Team
[   36.292245] TCP cubic registered
[   36.295496] NET: Registered protocol family 1
[   36.298716] NET: Registered protocol family 17
[   36.301848] NET: Registered protocol family 15
[   36.817332] input: ImPS/2 Logitech Wheel Mouse as /class/input/input2
[   36.844024] input: AT Translated Set 2 keyboard as /class/input/input3
[   36.911624] RAMDISK: ext2 filesystem found at block 0
[   36.914791] RAMDISK: Loading 2000KiB [1 disk] into ram disk... |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|done.
[   36.922467] VFS: Mounted root (ext2 filesystem).
[   36.946396] kjournald starting.  Commit interval 5 seconds
[   36.946405] EXT3-fs: mounted filesystem with ordered data mode.
[   36.946440] VFS: Mounted root (ext3 filesystem) readonly.
[   36.946442] Trying to move old root to /initrd ... /initrd does not exist. Ignored.
[   36.946615] Unmounting old root
[   36.946720] Trying to free ramdisk memory ... okay
[   36.946984] Freeing unused kernel memory: 232k freed
[   41.104813] EXT3 FS on sda6, internal journal
[   41.550123] Adding 1004016k swap on /dev/sda7.  Priority:-1 extents:1 across:1004016k
[   62.630799] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[  399.563221] XFS mounting filesystem sda1
[  399.603500] Ending clean XFS mount for filesystem: sda1
[  431.374421] ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
[  431.374430] ata1.00: cmd 61/40:00:fe:aa:98/00:00:00:00:00/40 tag 0 cdb 0x0 data 32768 out
[  431.374432]          res 40/00:00:9e:9c:bd/00:00:01:00:00/40 Emask 0x4 (timeout)
[  431.677154] ata1: soft resetting port
[  431.886700] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  431.889277] ata1.00: configured for UDMA/133
[  431.889285] ata1: EH complete
[  431.890781] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[  431.890854] sda: Write Protect is off
[  431.890858] sda: Mode Sense: 00 3a 00 00
[  431.890903] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  450.800490] XFS mounting filesystem sda1
[  450.853731] Ending clean XFS mount for filesystem: sda1
[  481.131888] ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
[  481.131896] ata1.00: cmd 61/40:00:46:af:98/00:00:00:00:00/40 tag 0 cdb 0x0 data 32768 out
[  481.131898]          res 40/00:00:9e:9c:bd/00:00:01:00:00/40 Emask 0x4 (timeout)
[  481.436015] ata1: soft resetting port
[  481.645237] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  481.647825] ata1.00: configured for UDMA/133
[  481.647834] ata1: EH complete
[  481.649252] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[  481.649295] sda: Write Protect is off
[  481.649298] sda: Mode Sense: 00 3a 00 00
[  481.649358] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA

--MP_2y+m36D+pGqu.k6jh.RpTPr
Content-Type: text/plain; name=interrupts.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=interrupts.txt

           CPU0       CPU1       
  0:     617966          0   IO-APIC-edge      timer
  1:       2361          0   IO-APIC-edge      i8042
  6:          5          0   IO-APIC-edge      floppy
  8:          1          0   IO-APIC-edge      rtc
  9:          0          0   IO-APIC-fasteoi   acpi
 12:      28043          0   IO-APIC-edge      i8042
 16:      43984          0   IO-APIC-fasteoi   uhci_hcd:usb3, i915@pci:0000:00:02.0
 17:       6551          0   IO-APIC-fasteoi   libata
 18:          0          0   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb7
 19:       9176          0   IO-APIC-fasteoi   libata, uhci_hcd:usb6
 21:        375          0   IO-APIC-fasteoi   uhci_hcd:usb4, eth0
 22:        192          0   IO-APIC-fasteoi   HDA Intel
 23:          0          0   IO-APIC-fasteoi   ehci_hcd:usb2, uhci_hcd:usb5
NMI:        170         85 
LOC:     605529     605586 
ERR:          0

--MP_2y+m36D+pGqu.k6jh.RpTPr
Content-Type: text/plain; name=lspci.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=lspci.txt

00:00.0 Host bridge: Intel Corporation 82P965/G965 Memory Controller Hub (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 82G965 Integrated Graphics Controller (rev 02)
00:03.0 Communication controller: Intel Corporation 82P965/G965 HECI Controller (rev 02)
00:19.0 Ethernet controller: Intel Corporation 82566DC Gigabit Network Connection (rev 02)
00:1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #4 (rev 02)
00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #5 (rev 02)
00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI #2 (rev 02)
00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 1 (rev 02)
00:1c.1 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 2 (rev 02)
00:1c.2 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 3 (rev 02)
00:1c.3 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 4 (rev 02)
00:1c.4 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 5 (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #3 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI #1 (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev f2)
00:1f.0 ISA bridge: Intel Corporation 82801HB/HR (ICH8/R) LPC Interface Controller (rev 02)
00:1f.2 SATA controller: Intel Corporation 82801HB (ICH8) 4 port SATA AHCI Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller (rev 02)
02:00.0 IDE interface: Marvell Technology Group Ltd. Unknown device 6101 (rev b1)
06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)

--MP_2y+m36D+pGqu.k6jh.RpTPr
Content-Type: application/octet-stream; name=CONFIG
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=CONFIG

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24ndCBlZGl0CiMgTGlu
dXgga2VybmVsIHZlcnNpb246IDIuNi4yMC1yYzUKIyBTdW4gSmFuIDIxIDEzOjI5OjU5IDIwMDcK
IwpDT05GSUdfWDg2XzY0PXkKQ09ORklHXzY0QklUPXkKQ09ORklHX1g4Nj15CkNPTkZJR19aT05F
X0RNQTMyPXkKQ09ORklHX0xPQ0tERVBfU1VQUE9SVD15CkNPTkZJR19TVEFDS1RSQUNFX1NVUFBP
UlQ9eQpDT05GSUdfU0VNQVBIT1JFX1NMRUVQRVJTPXkKQ09ORklHX01NVT15CkNPTkZJR19SV1NF
TV9HRU5FUklDX1NQSU5MT0NLPXkKQ09ORklHX0dFTkVSSUNfSFdFSUdIVD15CkNPTkZJR19HRU5F
UklDX0NBTElCUkFURV9ERUxBWT15CkNPTkZJR19YODZfQ01QWENIRz15CkNPTkZJR19FQVJMWV9Q
UklOVEs9eQpDT05GSUdfR0VORVJJQ19JU0FfRE1BPXkKQ09ORklHX0dFTkVSSUNfSU9NQVA9eQpD
T05GSUdfQVJDSF9NQVlfSEFWRV9QQ19GREM9eQpDT05GSUdfQVJDSF9QT1BVTEFURVNfTk9ERV9N
QVA9eQpDT05GSUdfRE1JPXkKQ09ORklHX0FVRElUX0FSQ0g9eQpDT05GSUdfR0VORVJJQ19CVUc9
eQojIENPTkZJR19BUkNIX0hBU19JTE9HMl9VMzIgaXMgbm90IHNldAojIENPTkZJR19BUkNIX0hB
U19JTE9HMl9VNjQgaXMgbm90IHNldApDT05GSUdfREVGQ09ORklHX0xJU1Q9Ii9saWIvbW9kdWxl
cy8kVU5BTUVfUkVMRUFTRS8uY29uZmlnIgoKIwojIENvZGUgbWF0dXJpdHkgbGV2ZWwgb3B0aW9u
cwojCkNPTkZJR19FWFBFUklNRU5UQUw9eQpDT05GSUdfTE9DS19LRVJORUw9eQpDT05GSUdfSU5J
VF9FTlZfQVJHX0xJTUlUPTMyCgojCiMgR2VuZXJhbCBzZXR1cAojCkNPTkZJR19MT0NBTFZFUlNJ
T049IiIKQ09ORklHX0xPQ0FMVkVSU0lPTl9BVVRPPXkKQ09ORklHX1NXQVA9eQpDT05GSUdfU1lT
VklQQz15CiMgQ09ORklHX0lQQ19OUyBpcyBub3Qgc2V0CkNPTkZJR19QT1NJWF9NUVVFVUU9eQpD
T05GSUdfQlNEX1BST0NFU1NfQUNDVD15CkNPTkZJR19CU0RfUFJPQ0VTU19BQ0NUX1YzPXkKIyBD
T05GSUdfVEFTS1NUQVRTIGlzIG5vdCBzZXQKIyBDT05GSUdfVVRTX05TIGlzIG5vdCBzZXQKIyBD
T05GSUdfQVVESVQgaXMgbm90IHNldAojIENPTkZJR19JS0NPTkZJRyBpcyBub3Qgc2V0CiMgQ09O
RklHX0NQVVNFVFMgaXMgbm90IHNldAojIENPTkZJR19TWVNGU19ERVBSRUNBVEVEIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUkVMQVkgaXMgbm90IHNldApDT05GSUdfSU5JVFJBTUZTX1NPVVJDRT0iIgpD
T05GSUdfQ0NfT1BUSU1JWkVfRk9SX1NJWkU9eQpDT05GSUdfU1lTQ1RMPXkKIyBDT05GSUdfRU1C
RURERUQgaXMgbm90IHNldApDT05GSUdfVUlEMTY9eQpDT05GSUdfU1lTQ1RMX1NZU0NBTEw9eQpD
T05GSUdfS0FMTFNZTVM9eQpDT05GSUdfS0FMTFNZTVNfQUxMPXkKIyBDT05GSUdfS0FMTFNZTVNf
RVhUUkFfUEFTUyBpcyBub3Qgc2V0CkNPTkZJR19IT1RQTFVHPXkKQ09ORklHX1BSSU5USz15CkNP
TkZJR19CVUc9eQpDT05GSUdfRUxGX0NPUkU9eQpDT05GSUdfQkFTRV9GVUxMPXkKQ09ORklHX0ZV
VEVYPXkKQ09ORklHX0VQT0xMPXkKQ09ORklHX1NITUVNPXkKQ09ORklHX1NMQUI9eQpDT05GSUdf
Vk1fRVZFTlRfQ09VTlRFUlM9eQpDT05GSUdfUlRfTVVURVhFUz15CiMgQ09ORklHX1RJTllfU0hN
RU0gaXMgbm90IHNldApDT05GSUdfQkFTRV9TTUFMTD0wCiMgQ09ORklHX1NMT0IgaXMgbm90IHNl
dAoKIwojIExvYWRhYmxlIG1vZHVsZSBzdXBwb3J0CiMKQ09ORklHX01PRFVMRVM9eQpDT05GSUdf
TU9EVUxFX1VOTE9BRD15CiMgQ09ORklHX01PRFVMRV9GT1JDRV9VTkxPQUQgaXMgbm90IHNldAoj
IENPTkZJR19NT0RWRVJTSU9OUyBpcyBub3Qgc2V0CiMgQ09ORklHX01PRFVMRV9TUkNWRVJTSU9O
X0FMTCBpcyBub3Qgc2V0CkNPTkZJR19LTU9EPXkKQ09ORklHX1NUT1BfTUFDSElORT15CgojCiMg
QmxvY2sgbGF5ZXIKIwpDT05GSUdfQkxPQ0s9eQojIENPTkZJR19CTEtfREVWX0lPX1RSQUNFIGlz
IG5vdCBzZXQKCiMKIyBJTyBTY2hlZHVsZXJzCiMKQ09ORklHX0lPU0NIRURfTk9PUD15CiMgQ09O
RklHX0lPU0NIRURfQVMgaXMgbm90IHNldAojIENPTkZJR19JT1NDSEVEX0RFQURMSU5FIGlzIG5v
dCBzZXQKQ09ORklHX0lPU0NIRURfQ0ZRPXkKIyBDT05GSUdfREVGQVVMVF9BUyBpcyBub3Qgc2V0
CiMgQ09ORklHX0RFRkFVTFRfREVBRExJTkUgaXMgbm90IHNldApDT05GSUdfREVGQVVMVF9DRlE9
eQojIENPTkZJR19ERUZBVUxUX05PT1AgaXMgbm90IHNldApDT05GSUdfREVGQVVMVF9JT1NDSEVE
PSJjZnEiCgojCiMgUHJvY2Vzc29yIHR5cGUgYW5kIGZlYXR1cmVzCiMKQ09ORklHX1g4Nl9QQz15
CiMgQ09ORklHX1g4Nl9WU01QIGlzIG5vdCBzZXQKIyBDT05GSUdfTUs4IGlzIG5vdCBzZXQKIyBD
T05GSUdfTVBTQyBpcyBub3Qgc2V0CkNPTkZJR19NQ09SRTI9eQojIENPTkZJR19HRU5FUklDX0NQ
VSBpcyBub3Qgc2V0CkNPTkZJR19YODZfTDFfQ0FDSEVfQllURVM9NjQKQ09ORklHX1g4Nl9MMV9D
QUNIRV9TSElGVD02CkNPTkZJR19YODZfSU5URVJOT0RFX0NBQ0hFX0JZVEVTPTY0CkNPTkZJR19Y
ODZfVFNDPXkKQ09ORklHX1g4Nl9HT09EX0FQSUM9eQpDT05GSUdfTUlDUk9DT0RFPXkKQ09ORklH
X01JQ1JPQ09ERV9PTERfSU5URVJGQUNFPXkKQ09ORklHX1g4Nl9NU1I9eQpDT05GSUdfWDg2X0NQ
VUlEPXkKQ09ORklHX1g4Nl9IVD15CkNPTkZJR19YODZfSU9fQVBJQz15CkNPTkZJR19YODZfTE9D
QUxfQVBJQz15CkNPTkZJR19NVFJSPXkKQ09ORklHX1NNUD15CiMgQ09ORklHX1NDSEVEX1NNVCBp
cyBub3Qgc2V0CkNPTkZJR19TQ0hFRF9NQz15CiMgQ09ORklHX1BSRUVNUFRfTk9ORSBpcyBub3Qg
c2V0CkNPTkZJR19QUkVFTVBUX1ZPTFVOVEFSWT15CiMgQ09ORklHX1BSRUVNUFQgaXMgbm90IHNl
dAojIENPTkZJR19QUkVFTVBUX0JLTCBpcyBub3Qgc2V0CiMgQ09ORklHX05VTUEgaXMgbm90IHNl
dApDT05GSUdfQVJDSF9TUEFSU0VNRU1fRU5BQkxFPXkKQ09ORklHX0FSQ0hfRkxBVE1FTV9FTkFC
TEU9eQpDT05GSUdfU0VMRUNUX01FTU9SWV9NT0RFTD15CkNPTkZJR19GTEFUTUVNX01BTlVBTD15
CiMgQ09ORklHX0RJU0NPTlRJR01FTV9NQU5VQUwgaXMgbm90IHNldAojIENPTkZJR19TUEFSU0VN
RU1fTUFOVUFMIGlzIG5vdCBzZXQKQ09ORklHX0ZMQVRNRU09eQpDT05GSUdfRkxBVF9OT0RFX01F
TV9NQVA9eQojIENPTkZJR19TUEFSU0VNRU1fU1RBVElDIGlzIG5vdCBzZXQKQ09ORklHX1NQTElU
X1BUTE9DS19DUFVTPTQKQ09ORklHX1JFU09VUkNFU182NEJJVD15CkNPTkZJR19OUl9DUFVTPTQK
IyBDT05GSUdfSE9UUExVR19DUFUgaXMgbm90IHNldApDT05GSUdfQVJDSF9FTkFCTEVfTUVNT1JZ
X0hPVFBMVUc9eQpDT05GSUdfSFBFVF9USU1FUj15CkNPTkZJR19IUEVUX0VNVUxBVEVfUlRDPXkK
Q09ORklHX0lPTU1VPXkKIyBDT05GSUdfQ0FMR0FSWV9JT01NVSBpcyBub3Qgc2V0CkNPTkZJR19T
V0lPVExCPXkKQ09ORklHX1g4Nl9NQ0U9eQpDT05GSUdfWDg2X01DRV9JTlRFTD15CiMgQ09ORklH
X1g4Nl9NQ0VfQU1EIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VYRUMgaXMgbm90IHNldAojIENPTkZJ
R19DUkFTSF9EVU1QIGlzIG5vdCBzZXQKQ09ORklHX1BIWVNJQ0FMX1NUQVJUPTB4MjAwMDAwCiMg
Q09ORklHX1NFQ0NPTVAgaXMgbm90IHNldAojIENPTkZJR19DQ19TVEFDS1BST1RFQ1RPUiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0haXzEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0haXzI1MCBpcyBub3Qg
c2V0CiMgQ09ORklHX0haXzMwMCBpcyBub3Qgc2V0CkNPTkZJR19IWl8xMDAwPXkKQ09ORklHX0ha
PTEwMDAKIyBDT05GSUdfUkVPUkRFUiBpcyBub3Qgc2V0CkNPTkZJR19LOF9OQj15CkNPTkZJR19H
RU5FUklDX0hBUkRJUlFTPXkKQ09ORklHX0dFTkVSSUNfSVJRX1BST0JFPXkKQ09ORklHX0lTQV9E
TUFfQVBJPXkKQ09ORklHX0dFTkVSSUNfUEVORElOR19JUlE9eQoKIwojIFBvd2VyIG1hbmFnZW1l
bnQgb3B0aW9ucwojCkNPTkZJR19QTT15CiMgQ09ORklHX1BNX0xFR0FDWSBpcyBub3Qgc2V0CiMg
Q09ORklHX1BNX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfUE1fU1lTRlNfREVQUkVDQVRFRCBp
cyBub3Qgc2V0CgojCiMgQUNQSSAoQWR2YW5jZWQgQ29uZmlndXJhdGlvbiBhbmQgUG93ZXIgSW50
ZXJmYWNlKSBTdXBwb3J0CiMKQ09ORklHX0FDUEk9eQojIENPTkZJR19BQ1BJX0FDIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQUNQSV9CQVRURVJZIGlzIG5vdCBzZXQKQ09ORklHX0FDUElfQlVUVE9OPXkK
Q09ORklHX0FDUElfVklERU89eQojIENPTkZJR19BQ1BJX0hPVEtFWSBpcyBub3Qgc2V0CkNPTkZJ
R19BQ1BJX0ZBTj15CiMgQ09ORklHX0FDUElfRE9DSyBpcyBub3Qgc2V0CkNPTkZJR19BQ1BJX1BS
T0NFU1NPUj15CkNPTkZJR19BQ1BJX1RIRVJNQUw9eQojIENPTkZJR19BQ1BJX0FTVVMgaXMgbm90
IHNldAojIENPTkZJR19BQ1BJX0lCTSBpcyBub3Qgc2V0CiMgQ09ORklHX0FDUElfVE9TSElCQSBp
cyBub3Qgc2V0CkNPTkZJR19BQ1BJX0JMQUNLTElTVF9ZRUFSPTAKIyBDT05GSUdfQUNQSV9ERUJV
RyBpcyBub3Qgc2V0CkNPTkZJR19BQ1BJX0VDPXkKQ09ORklHX0FDUElfUE9XRVI9eQpDT05GSUdf
QUNQSV9TWVNURU09eQpDT05GSUdfWDg2X1BNX1RJTUVSPXkKIyBDT05GSUdfQUNQSV9DT05UQUlO
RVIgaXMgbm90IHNldAojIENPTkZJR19BQ1BJX1NCUyBpcyBub3Qgc2V0CgojCiMgQ1BVIEZyZXF1
ZW5jeSBzY2FsaW5nCiMKIyBDT05GSUdfQ1BVX0ZSRVEgaXMgbm90IHNldAoKIwojIEJ1cyBvcHRp
b25zIChQQ0kgZXRjLikKIwpDT05GSUdfUENJPXkKQ09ORklHX1BDSV9ESVJFQ1Q9eQojIENPTkZJ
R19QQ0lfTU1DT05GSUcgaXMgbm90IHNldAojIENPTkZJR19QQ0lFUE9SVEJVUyBpcyBub3Qgc2V0
CiMgQ09ORklHX1BDSV9NU0kgaXMgbm90IHNldAojIENPTkZJR19QQ0lfREVCVUcgaXMgbm90IHNl
dApDT05GSUdfSFRfSVJRPXkKCiMKIyBQQ0NBUkQgKFBDTUNJQS9DYXJkQnVzKSBzdXBwb3J0CiMK
IyBDT05GSUdfUENDQVJEIGlzIG5vdCBzZXQKCiMKIyBQQ0kgSG90cGx1ZyBTdXBwb3J0CiMKIyBD
T05GSUdfSE9UUExVR19QQ0kgaXMgbm90IHNldAoKIwojIEV4ZWN1dGFibGUgZmlsZSBmb3JtYXRz
IC8gRW11bGF0aW9ucwojCkNPTkZJR19CSU5GTVRfRUxGPXkKQ09ORklHX0JJTkZNVF9NSVNDPXkK
Q09ORklHX0lBMzJfRU1VTEFUSU9OPXkKIyBDT05GSUdfSUEzMl9BT1VUIGlzIG5vdCBzZXQKQ09O
RklHX0NPTVBBVD15CkNPTkZJR19TWVNWSVBDX0NPTVBBVD15CgojCiMgTmV0d29ya2luZwojCkNP
TkZJR19ORVQ9eQoKIwojIE5ldHdvcmtpbmcgb3B0aW9ucwojCiMgQ09ORklHX05FVERFQlVHIGlz
IG5vdCBzZXQKQ09ORklHX1BBQ0tFVD15CkNPTkZJR19QQUNLRVRfTU1BUD15CkNPTkZJR19VTklY
PXkKQ09ORklHX1hGUk09eQojIENPTkZJR19YRlJNX1VTRVIgaXMgbm90IHNldAojIENPTkZJR19Y
RlJNX1NVQl9QT0xJQ1kgaXMgbm90IHNldApDT05GSUdfTkVUX0tFWT15CkNPTkZJR19JTkVUPXkK
Q09ORklHX0lQX01VTFRJQ0FTVD15CiMgQ09ORklHX0lQX0FEVkFOQ0VEX1JPVVRFUiBpcyBub3Qg
c2V0CkNPTkZJR19JUF9GSUJfSEFTSD15CiMgQ09ORklHX0lQX1BOUCBpcyBub3Qgc2V0CiMgQ09O
RklHX05FVF9JUElQIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0lQR1JFIGlzIG5vdCBzZXQKIyBD
T05GSUdfSVBfTVJPVVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfQVJQRCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NZTl9DT09LSUVTIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9BSCBpcyBub3Qgc2V0CiMg
Q09ORklHX0lORVRfRVNQIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9JUENPTVAgaXMgbm90IHNl
dAojIENPTkZJR19JTkVUX1hGUk1fVFVOTkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9UVU5O
RUwgaXMgbm90IHNldApDT05GSUdfSU5FVF9YRlJNX01PREVfVFJBTlNQT1JUPXkKQ09ORklHX0lO
RVRfWEZSTV9NT0RFX1RVTk5FTD15CkNPTkZJR19JTkVUX1hGUk1fTU9ERV9CRUVUPXkKQ09ORklH
X0lORVRfRElBRz15CkNPTkZJR19JTkVUX1RDUF9ESUFHPXkKIyBDT05GSUdfVENQX0NPTkdfQURW
QU5DRUQgaXMgbm90IHNldApDT05GSUdfVENQX0NPTkdfQ1VCSUM9eQpDT05GSUdfREVGQVVMVF9U
Q1BfQ09ORz0iY3ViaWMiCiMgQ09ORklHX1RDUF9NRDVTSUcgaXMgbm90IHNldAoKIwojIElQOiBW
aXJ0dWFsIFNlcnZlciBDb25maWd1cmF0aW9uCiMKIyBDT05GSUdfSVBfVlMgaXMgbm90IHNldAoj
IENPTkZJR19JUFY2IGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVDZfWEZSTV9UVU5ORUwgaXMgbm90
IHNldAojIENPTkZJR19JTkVUNl9UVU5ORUwgaXMgbm90IHNldAojIENPTkZJR19ORVRXT1JLX1NF
Q01BUksgaXMgbm90IHNldApDT05GSUdfTkVURklMVEVSPXkKIyBDT05GSUdfTkVURklMVEVSX0RF
QlVHIGlzIG5vdCBzZXQKCiMKIyBDb3JlIE5ldGZpbHRlciBDb25maWd1cmF0aW9uCiMKIyBDT05G
SUdfTkVURklMVEVSX05FVExJTksgaXMgbm90IHNldApDT05GSUdfTkZfQ09OTlRSQUNLX0VOQUJM
RUQ9eQpDT05GSUdfTkZfQ09OTlRSQUNLX1NVUFBPUlQ9eQojIENPTkZJR19JUF9ORl9DT05OVFJB
Q0tfU1VQUE9SVCBpcyBub3Qgc2V0CkNPTkZJR19ORl9DT05OVFJBQ0s9eQojIENPTkZJR19ORl9D
VF9BQ0NUIGlzIG5vdCBzZXQKIyBDT05GSUdfTkZfQ09OTlRSQUNLX01BUksgaXMgbm90IHNldAoj
IENPTkZJR19ORl9DT05OVFJBQ0tfRVZFTlRTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkZfQ1RfUFJP
VE9fU0NUUCBpcyBub3Qgc2V0CiMgQ09ORklHX05GX0NPTk5UUkFDS19BTUFOREEgaXMgbm90IHNl
dAojIENPTkZJR19ORl9DT05OVFJBQ0tfRlRQIGlzIG5vdCBzZXQKIyBDT05GSUdfTkZfQ09OTlRS
QUNLX0gzMjMgaXMgbm90IHNldAojIENPTkZJR19ORl9DT05OVFJBQ0tfSVJDIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkZfQ09OTlRSQUNLX05FVEJJT1NfTlMgaXMgbm90IHNldAojIENPTkZJR19ORl9D
T05OVFJBQ0tfUFBUUCBpcyBub3Qgc2V0CiMgQ09ORklHX05GX0NPTk5UUkFDS19TSVAgaXMgbm90
IHNldAojIENPTkZJR19ORl9DT05OVFJBQ0tfVEZUUCBpcyBub3Qgc2V0CkNPTkZJR19ORVRGSUxU
RVJfWFRBQkxFUz15CiMgQ09ORklHX05FVEZJTFRFUl9YVF9UQVJHRVRfQ0xBU1NJRlkgaXMgbm90
IHNldAojIENPTkZJR19ORVRGSUxURVJfWFRfVEFSR0VUX01BUksgaXMgbm90IHNldAojIENPTkZJ
R19ORVRGSUxURVJfWFRfVEFSR0VUX05GUVVFVUUgaXMgbm90IHNldAojIENPTkZJR19ORVRGSUxU
RVJfWFRfVEFSR0VUX05GTE9HIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSX1hUX01BVENI
X0NPTU1FTlQgaXMgbm90IHNldAojIENPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfQ09OTlRSQUNL
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSX1hUX01BVENIX0RDQ1AgaXMgbm90IHNldAoj
IENPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfRFNDUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVEZJ
TFRFUl9YVF9NQVRDSF9FU1AgaXMgbm90IHNldAojIENPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hf
SEVMUEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSX1hUX01BVENIX0xFTkdUSCBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9MSU1JVCBpcyBub3Qgc2V0CiMgQ09O
RklHX05FVEZJTFRFUl9YVF9NQVRDSF9NQUMgaXMgbm90IHNldAojIENPTkZJR19ORVRGSUxURVJf
WFRfTUFUQ0hfTUFSSyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9QT0xJ
Q1kgaXMgbm90IHNldAojIENPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfTVVMVElQT1JUIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkVURklMVEVSX1hUX01BVENIX1BLVFRZUEUgaXMgbm90IHNldAojIENP
TkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfUVVPVEEgaXMgbm90IHNldAojIENPTkZJR19ORVRGSUxU
RVJfWFRfTUFUQ0hfUkVBTE0gaXMgbm90IHNldAojIENPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hf
U0NUUCBpcyBub3Qgc2V0CkNPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfU1RBVEU9eQojIENPTkZJ
R19ORVRGSUxURVJfWFRfTUFUQ0hfU1RBVElTVElDIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklM
VEVSX1hUX01BVENIX1NUUklORyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVEZJTFRFUl9YVF9NQVRD
SF9UQ1BNU1MgaXMgbm90IHNldAojIENPTkZJR19ORVRGSUxURVJfWFRfTUFUQ0hfSEFTSExJTUlU
IGlzIG5vdCBzZXQKCiMKIyBJUDogTmV0ZmlsdGVyIENvbmZpZ3VyYXRpb24KIwpDT05GSUdfTkZf
Q09OTlRSQUNLX0lQVjQ9eQpDT05GSUdfTkZfQ09OTlRSQUNLX1BST0NfQ09NUEFUPXkKQ09ORklH
X0lQX05GX1FVRVVFPXkKQ09ORklHX0lQX05GX0lQVEFCTEVTPXkKIyBDT05GSUdfSVBfTkZfTUFU
Q0hfSVBSQU5HRSBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX01BVENIX1RPUyBpcyBub3Qgc2V0
CiMgQ09ORklHX0lQX05GX01BVENIX1JFQ0VOVCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX01B
VENIX0VDTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX01BVENIX0FIIGlzIG5vdCBzZXQKIyBD
T05GSUdfSVBfTkZfTUFUQ0hfVFRMIGlzIG5vdCBzZXQKQ09ORklHX0lQX05GX01BVENIX09XTkVS
PXkKIyBDT05GSUdfSVBfTkZfTUFUQ0hfQUREUlRZUEUgaXMgbm90IHNldApDT05GSUdfSVBfTkZf
RklMVEVSPXkKIyBDT05GSUdfSVBfTkZfVEFSR0VUX1JFSkVDVCBpcyBub3Qgc2V0CiMgQ09ORklH
X0lQX05GX1RBUkdFVF9MT0cgaXMgbm90IHNldAojIENPTkZJR19JUF9ORl9UQVJHRVRfVUxPRyBp
cyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX1RBUkdFVF9UQ1BNU1MgaXMgbm90IHNldAojIENPTkZJ
R19ORl9OQVQgaXMgbm90IHNldAojIENPTkZJR19JUF9ORl9NQU5HTEUgaXMgbm90IHNldAojIENP
TkZJR19JUF9ORl9SQVcgaXMgbm90IHNldAojIENPTkZJR19JUF9ORl9BUlBUQUJMRVMgaXMgbm90
IHNldAoKIwojIERDQ1AgQ29uZmlndXJhdGlvbiAoRVhQRVJJTUVOVEFMKQojCiMgQ09ORklHX0lQ
X0RDQ1AgaXMgbm90IHNldAoKIwojIFNDVFAgQ29uZmlndXJhdGlvbiAoRVhQRVJJTUVOVEFMKQoj
CiMgQ09ORklHX0lQX1NDVFAgaXMgbm90IHNldAoKIwojIFRJUEMgQ29uZmlndXJhdGlvbiAoRVhQ
RVJJTUVOVEFMKQojCiMgQ09ORklHX1RJUEMgaXMgbm90IHNldAojIENPTkZJR19BVE0gaXMgbm90
IHNldAojIENPTkZJR19CUklER0UgaXMgbm90IHNldAojIENPTkZJR19WTEFOXzgwMjFRIGlzIG5v
dCBzZXQKIyBDT05GSUdfREVDTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfTExDMiBpcyBub3Qgc2V0
CiMgQ09ORklHX0lQWCBpcyBub3Qgc2V0CiMgQ09ORklHX0FUQUxLIGlzIG5vdCBzZXQKIyBDT05G
SUdfWDI1IGlzIG5vdCBzZXQKIyBDT05GSUdfTEFQQiBpcyBub3Qgc2V0CiMgQ09ORklHX0VDT05F
VCBpcyBub3Qgc2V0CiMgQ09ORklHX1dBTl9ST1VURVIgaXMgbm90IHNldAoKIwojIFFvUyBhbmQv
b3IgZmFpciBxdWV1ZWluZwojCiMgQ09ORklHX05FVF9TQ0hFRCBpcyBub3Qgc2V0CgojCiMgTmV0
d29yayB0ZXN0aW5nCiMKIyBDT05GSUdfTkVUX1BLVEdFTiBpcyBub3Qgc2V0CiMgQ09ORklHX0hB
TVJBRElPIGlzIG5vdCBzZXQKIyBDT05GSUdfSVJEQSBpcyBub3Qgc2V0CiMgQ09ORklHX0JUIGlz
IG5vdCBzZXQKIyBDT05GSUdfSUVFRTgwMjExIGlzIG5vdCBzZXQKCiMKIyBEZXZpY2UgRHJpdmVy
cwojCgojCiMgR2VuZXJpYyBEcml2ZXIgT3B0aW9ucwojCkNPTkZJR19TVEFOREFMT05FPXkKQ09O
RklHX1BSRVZFTlRfRklSTVdBUkVfQlVJTEQ9eQpDT05GSUdfRldfTE9BREVSPXkKIyBDT05GSUdf
REVCVUdfRFJJVkVSIGlzIG5vdCBzZXQKIyBDT05GSUdfU1lTX0hZUEVSVklTT1IgaXMgbm90IHNl
dAoKIwojIENvbm5lY3RvciAtIHVuaWZpZWQgdXNlcnNwYWNlIDwtPiBrZXJuZWxzcGFjZSBsaW5r
ZXIKIwojIENPTkZJR19DT05ORUNUT1IgaXMgbm90IHNldAoKIwojIE1lbW9yeSBUZWNobm9sb2d5
IERldmljZXMgKE1URCkKIwojIENPTkZJR19NVEQgaXMgbm90IHNldAoKIwojIFBhcmFsbGVsIHBv
cnQgc3VwcG9ydAojCiMgQ09ORklHX1BBUlBPUlQgaXMgbm90IHNldAoKIwojIFBsdWcgYW5kIFBs
YXkgc3VwcG9ydAojCkNPTkZJR19QTlA9eQojIENPTkZJR19QTlBfREVCVUcgaXMgbm90IHNldAoK
IwojIFByb3RvY29scwojCkNPTkZJR19QTlBBQ1BJPXkKCiMKIyBCbG9jayBkZXZpY2VzCiMKQ09O
RklHX0JMS19ERVZfRkQ9eQojIENPTkZJR19CTEtfQ1BRX0RBIGlzIG5vdCBzZXQKIyBDT05GSUdf
QkxLX0NQUV9DSVNTX0RBIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9EQUM5NjAgaXMgbm90
IHNldAojIENPTkZJR19CTEtfREVWX1VNRU0gaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0NP
V19DT01NT04gaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9MT09QPXkKIyBDT05GSUdfQkxLX0RF
Vl9DUllQVE9MT09QIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9OQkQgaXMgbm90IHNldAoj
IENPTkZJR19CTEtfREVWX1NYOCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfVUIgaXMgbm90
IHNldApDT05GSUdfQkxLX0RFVl9SQU09eQpDT05GSUdfQkxLX0RFVl9SQU1fQ09VTlQ9MTYKQ09O
RklHX0JMS19ERVZfUkFNX1NJWkU9NDA5NgpDT05GSUdfQkxLX0RFVl9SQU1fQkxPQ0tTSVpFPTEw
MjQKQ09ORklHX0JMS19ERVZfSU5JVFJEPXkKIyBDT05GSUdfQ0RST01fUEtUQ0RWRCBpcyBub3Qg
c2V0CiMgQ09ORklHX0FUQV9PVkVSX0VUSCBpcyBub3Qgc2V0CgojCiMgTWlzYyBkZXZpY2VzCiMK
IyBDT05GSUdfSUJNX0FTTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NHSV9JT0M0IGlzIG5vdCBzZXQK
IyBDT05GSUdfVElGTV9DT1JFIGlzIG5vdCBzZXQKCiMKIyBBVEEvQVRBUEkvTUZNL1JMTCBzdXBw
b3J0CiMKQ09ORklHX0lERT15CkNPTkZJR19CTEtfREVWX0lERT15CgojCiMgUGxlYXNlIHNlZSBE
b2N1bWVudGF0aW9uL2lkZS50eHQgZm9yIGhlbHAvaW5mbyBvbiBJREUgZHJpdmVzCiMKIyBDT05G
SUdfQkxLX0RFVl9JREVfU0FUQSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfSERfSURFIGlz
IG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9JREVESVNLIGlzIG5vdCBzZXQKIyBDT05GSUdfSURF
RElTS19NVUxUSV9NT0RFIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfSURFQ0Q9eQojIENPTkZJ
R19CTEtfREVWX0lERVRBUEUgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0lERUZMT1BQWSBp
cyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfSURFU0NTSSBpcyBub3Qgc2V0CiMgQ09ORklHX0lE
RV9UQVNLX0lPQ1RMIGlzIG5vdCBzZXQKCiMKIyBJREUgY2hpcHNldCBzdXBwb3J0L2J1Z2ZpeGVz
CiMKQ09ORklHX0lERV9HRU5FUklDPXkKIyBDT05GSUdfQkxLX0RFVl9DTUQ2NDAgaXMgbm90IHNl
dAojIENPTkZJR19CTEtfREVWX0lERVBOUCBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0lERVBD
ST15CiMgQ09ORklHX0lERVBDSV9TSEFSRV9JUlEgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVW
X09GRkJPQVJEIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfR0VORVJJQz15CiMgQ09ORklHX0JM
S19ERVZfT1BUSTYyMSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfUloxMDAwIGlzIG5vdCBz
ZXQKQ09ORklHX0JMS19ERVZfSURFRE1BX1BDST15CiMgQ09ORklHX0JMS19ERVZfSURFRE1BX0ZP
UkNFRCBpcyBub3Qgc2V0CkNPTkZJR19JREVETUFfUENJX0FVVE89eQojIENPTkZJR19JREVETUFf
T05MWURJU0sgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0FFQzYyWFggaXMgbm90IHNldAoj
IENPTkZJR19CTEtfREVWX0FMSTE1WDMgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0FNRDc0
WFggaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0FUSUlYUCBpcyBub3Qgc2V0CiMgQ09ORklH
X0JMS19ERVZfQ01ENjRYIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9UUklGTEVYIGlzIG5v
dCBzZXQKIyBDT05GSUdfQkxLX0RFVl9DWTgyQzY5MyBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19E
RVZfQ1M1NTIwIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9DUzU1MzAgaXMgbm90IHNldAoj
IENPTkZJR19CTEtfREVWX0hQVDM0WCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfSFBUMzY2
IGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9KTUlDUk9OIGlzIG5vdCBzZXQKIyBDT05GSUdf
QkxLX0RFVl9TQzEyMDAgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1BJSVggaXMgbm90IHNl
dAojIENPTkZJR19CTEtfREVWX0lUODIxWCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfTlM4
NzQxNSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfUERDMjAyWFhfT0xEIGlzIG5vdCBzZXQK
IyBDT05GSUdfQkxLX0RFVl9QREMyMDJYWF9ORVcgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVW
X1NWV0tTIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9TSUlNQUdFIGlzIG5vdCBzZXQKIyBD
T05GSUdfQkxLX0RFVl9TSVM1NTEzIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9TTEM5MEU2
NiBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfVFJNMjkwIGlzIG5vdCBzZXQKIyBDT05GSUdf
QkxLX0RFVl9WSUE4MkNYWFggaXMgbm90IHNldAojIENPTkZJR19JREVfQVJNIGlzIG5vdCBzZXQK
Q09ORklHX0JMS19ERVZfSURFRE1BPXkKIyBDT05GSUdfSURFRE1BX0lWQiBpcyBub3Qgc2V0CkNP
TkZJR19JREVETUFfQVVUTz15CiMgQ09ORklHX0JMS19ERVZfSEQgaXMgbm90IHNldAoKIwojIFND
U0kgZGV2aWNlIHN1cHBvcnQKIwojIENPTkZJR19SQUlEX0FUVFJTIGlzIG5vdCBzZXQKQ09ORklH
X1NDU0k9eQojIENPTkZJR19TQ1NJX1RHVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTkVUTElO
SyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfUFJPQ19GUyBpcyBub3Qgc2V0CgojCiMgU0NTSSBz
dXBwb3J0IHR5cGUgKGRpc2ssIHRhcGUsIENELVJPTSkKIwpDT05GSUdfQkxLX0RFVl9TRD15CiMg
Q09ORklHX0NIUl9ERVZfU1QgaXMgbm90IHNldAojIENPTkZJR19DSFJfREVWX09TU1QgaXMgbm90
IHNldApDT05GSUdfQkxLX0RFVl9TUj15CiMgQ09ORklHX0JMS19ERVZfU1JfVkVORE9SIGlzIG5v
dCBzZXQKQ09ORklHX0NIUl9ERVZfU0c9eQojIENPTkZJR19DSFJfREVWX1NDSCBpcyBub3Qgc2V0
CgojCiMgU29tZSBTQ1NJIGRldmljZXMgKGUuZy4gQ0QganVrZWJveCkgc3VwcG9ydCBtdWx0aXBs
ZSBMVU5zCiMKIyBDT05GSUdfU0NTSV9NVUxUSV9MVU4gaXMgbm90IHNldApDT05GSUdfU0NTSV9D
T05TVEFOVFM9eQojIENPTkZJR19TQ1NJX0xPR0dJTkcgaXMgbm90IHNldAojIENPTkZJR19TQ1NJ
X1NDQU5fQVNZTkMgaXMgbm90IHNldAoKIwojIFNDU0kgVHJhbnNwb3J0cwojCiMgQ09ORklHX1ND
U0lfU1BJX0FUVFJTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9GQ19BVFRSUyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NDU0lfSVNDU0lfQVRUUlMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NBU19B
VFRSUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU0FTX0xJQlNBUyBpcyBub3Qgc2V0CgojCiMg
U0NTSSBsb3ctbGV2ZWwgZHJpdmVycwojCiMgQ09ORklHX0lTQ1NJX1RDUCBpcyBub3Qgc2V0CiMg
Q09ORklHX0JMS19ERVZfM1dfWFhYWF9SQUlEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV8zV185
WFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BQ0FSRCBpcyBub3Qgc2V0CiMgQ09ORklHX1ND
U0lfQUFDUkFJRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQUlDN1hYWCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NDU0lfQUlDN1hYWF9PTEQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FJQzc5WFgg
aXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FJQzk0WFggaXMgbm90IHNldAojIENPTkZJR19TQ1NJ
X0FSQ01TUiBpcyBub3Qgc2V0CiMgQ09ORklHX01FR0FSQUlEX05FV0dFTiBpcyBub3Qgc2V0CiMg
Q09ORklHX01FR0FSQUlEX0xFR0FDWSBpcyBub3Qgc2V0CiMgQ09ORklHX01FR0FSQUlEX1NBUyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSFBUSU9QIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9C
VVNMT0dJQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfRE1YMzE5MUQgaXMgbm90IHNldAojIENP
TkZJR19TQ1NJX0VBVEEgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0ZVVFVSRV9ET01BSU4gaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX0dEVEggaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lQUyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSU5JVElPIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9J
TklBMTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9TVEVYIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0NTSV9TWU01M0M4WFhfMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSVBSIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0NTSV9RTE9HSUNfMTI4MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfUUxBX0ZD
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9RTEFfSVNDU0kgaXMgbm90IHNldAojIENPTkZJR19T
Q1NJX0xQRkMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0RDMzk1eCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfREMzOTBUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9ERUJVRyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NDU0lfU1JQIGlzIG5vdCBzZXQKCiMKIyBTZXJpYWwgQVRBIChwcm9kKSBhbmQg
UGFyYWxsZWwgQVRBIChleHBlcmltZW50YWwpIGRyaXZlcnMKIwpDT05GSUdfQVRBPXkKQ09ORklH
X1NBVEFfQUhDST15CiMgQ09ORklHX1NBVEFfU1ZXIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRBX1BJ
SVggaXMgbm90IHNldAojIENPTkZJR19TQVRBX01WIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9O
ViBpcyBub3Qgc2V0CiMgQ09ORklHX1BEQ19BRE1BIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9R
U1RPUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfUFJPTUlTRSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NBVEFfU1g0IGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9TSUwgaXMgbm90IHNldAojIENPTkZJ
R19TQVRBX1NJTDI0IGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9TSVMgaXMgbm90IHNldAojIENP
TkZJR19TQVRBX1VMSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfVklBIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0FUQV9WSVRFU1NFIGlzIG5vdCBzZXQKQ09ORklHX1NBVEFfSU5URUxfQ09NQklORUQ9
eQojIENPTkZJR19QQVRBX0FMSSBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfQU1EIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUEFUQV9BUlRPUCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfQVRJSVhQIGlz
IG5vdCBzZXQKIyBDT05GSUdfUEFUQV9DTUQ2NFggaXMgbm90IHNldAojIENPTkZJR19QQVRBX0NT
NTUyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfQ1M1NTMwIGlzIG5vdCBzZXQKIyBDT05GSUdf
UEFUQV9DWVBSRVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9FRkFSIGlzIG5vdCBzZXQKIyBD
T05GSUdfQVRBX0dFTkVSSUMgaXMgbm90IHNldAojIENPTkZJR19QQVRBX0hQVDM2NiBpcyBub3Qg
c2V0CiMgQ09ORklHX1BBVEFfSFBUMzdYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9IUFQzWDJO
IGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9IUFQzWDMgaXMgbm90IHNldAojIENPTkZJR19QQVRB
X0lUODIxWCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfSk1JQ1JPTiBpcyBub3Qgc2V0CiMgQ09O
RklHX1BBVEFfVFJJRkxFWCBpcyBub3Qgc2V0CkNPTkZJR19QQVRBX01BUlZFTEw9eQojIENPTkZJ
R19QQVRBX01QSUlYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9PTERQSUlYIGlzIG5vdCBzZXQK
IyBDT05GSUdfUEFUQV9ORVRDRUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9OUzg3NDEwIGlz
IG5vdCBzZXQKIyBDT05GSUdfUEFUQV9PUFRJIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9PUFRJ
RE1BIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9QRENfT0xEIGlzIG5vdCBzZXQKIyBDT05GSUdf
UEFUQV9SQURJU1lTIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9SWjEwMDAgaXMgbm90IHNldAoj
IENPTkZJR19QQVRBX1NDMTIwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfU0VSVkVSV09SS1Mg
aXMgbm90IHNldAojIENPTkZJR19QQVRBX1BEQzIwMjdYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFU
QV9TSUw2ODAgaXMgbm90IHNldAojIENPTkZJR19QQVRBX1NJUyBpcyBub3Qgc2V0CiMgQ09ORklH
X1BBVEFfVklBIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9XSU5CT05EIGlzIG5vdCBzZXQKCiMK
IyBNdWx0aS1kZXZpY2Ugc3VwcG9ydCAoUkFJRCBhbmQgTFZNKQojCiMgQ09ORklHX01EIGlzIG5v
dCBzZXQKCiMKIyBGdXNpb24gTVBUIGRldmljZSBzdXBwb3J0CiMKIyBDT05GSUdfRlVTSU9OIGlz
IG5vdCBzZXQKIyBDT05GSUdfRlVTSU9OX1NQSSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZVU0lPTl9G
QyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZVU0lPTl9TQVMgaXMgbm90IHNldAoKIwojIElFRUUgMTM5
NCAoRmlyZVdpcmUpIHN1cHBvcnQKIwojIENPTkZJR19JRUVFMTM5NCBpcyBub3Qgc2V0CgojCiMg
STJPIGRldmljZSBzdXBwb3J0CiMKIyBDT05GSUdfSTJPIGlzIG5vdCBzZXQKCiMKIyBOZXR3b3Jr
IGRldmljZSBzdXBwb3J0CiMKQ09ORklHX05FVERFVklDRVM9eQpDT05GSUdfRFVNTVk9eQojIENP
TkZJR19CT05ESU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfRVFVQUxJWkVSIGlzIG5vdCBzZXQKIyBD
T05GSUdfVFVOIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NCMTAwMCBpcyBub3Qgc2V0CgojCiMg
QVJDbmV0IGRldmljZXMKIwojIENPTkZJR19BUkNORVQgaXMgbm90IHNldAoKIwojIFBIWSBkZXZp
Y2Ugc3VwcG9ydAojCiMgQ09ORklHX1BIWUxJQiBpcyBub3Qgc2V0CgojCiMgRXRoZXJuZXQgKDEw
IG9yIDEwME1iaXQpCiMKQ09ORklHX05FVF9FVEhFUk5FVD15CkNPTkZJR19NSUk9eQojIENPTkZJ
R19IQVBQWU1FQUwgaXMgbm90IHNldAojIENPTkZJR19TVU5HRU0gaXMgbm90IHNldAojIENPTkZJ
R19DQVNTSU5JIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl8zQ09NIGlzIG5vdCBzZXQK
CiMKIyBUdWxpcCBmYW1pbHkgbmV0d29yayBkZXZpY2Ugc3VwcG9ydAojCiMgQ09ORklHX05FVF9U
VUxJUCBpcyBub3Qgc2V0CiMgQ09ORklHX0hQMTAwIGlzIG5vdCBzZXQKQ09ORklHX05FVF9QQ0k9
eQojIENPTkZJR19QQ05FVDMyIGlzIG5vdCBzZXQKIyBDT05GSUdfQU1EODExMV9FVEggaXMgbm90
IHNldAojIENPTkZJR19BREFQVEVDX1NUQVJGSVJFIGlzIG5vdCBzZXQKIyBDT05GSUdfQjQ0IGlz
IG5vdCBzZXQKIyBDT05GSUdfRk9SQ0VERVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfREdSUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0VFUFJPMTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfRTEwMCBpcyBub3Qg
c2V0CiMgQ09ORklHX0ZFQUxOWCBpcyBub3Qgc2V0CiMgQ09ORklHX05BVFNFTUkgaXMgbm90IHNl
dAojIENPTkZJR19ORTJLX1BDSSBpcyBub3Qgc2V0CiMgQ09ORklHXzgxMzlDUCBpcyBub3Qgc2V0
CkNPTkZJR184MTM5VE9PPXkKIyBDT05GSUdfODEzOVRPT19QSU8gaXMgbm90IHNldAojIENPTkZJ
R184MTM5VE9PX1RVTkVfVFdJU1RFUiBpcyBub3Qgc2V0CiMgQ09ORklHXzgxMzlUT09fODEyOSBp
cyBub3Qgc2V0CiMgQ09ORklHXzgxMzlfT0xEX1JYX1JFU0VUIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0lTOTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfRVBJQzEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NV
TkRBTkNFIGlzIG5vdCBzZXQKIyBDT05GSUdfVklBX1JISU5FIGlzIG5vdCBzZXQKCiMKIyBFdGhl
cm5ldCAoMTAwMCBNYml0KQojCiMgQ09ORklHX0FDRU5JQyBpcyBub3Qgc2V0CiMgQ09ORklHX0RM
MksgaXMgbm90IHNldAojIENPTkZJR19FMTAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX05TODM4MjAg
aXMgbm90IHNldAojIENPTkZJR19IQU1BQ0hJIGlzIG5vdCBzZXQKIyBDT05GSUdfWUVMTE9XRklO
IGlzIG5vdCBzZXQKIyBDT05GSUdfUjgxNjkgaXMgbm90IHNldAojIENPTkZJR19TSVMxOTAgaXMg
bm90IHNldApDT05GSUdfU0tHRT15CiMgQ09ORklHX1NLWTIgaXMgbm90IHNldAojIENPTkZJR19T
Szk4TElOIGlzIG5vdCBzZXQKIyBDT05GSUdfVklBX1ZFTE9DSVRZIGlzIG5vdCBzZXQKIyBDT05G
SUdfVElHT04zIGlzIG5vdCBzZXQKIyBDT05GSUdfQk5YMiBpcyBub3Qgc2V0CiMgQ09ORklHX1FM
QTNYWFggaXMgbm90IHNldAoKIwojIEV0aGVybmV0ICgxMDAwMCBNYml0KQojCiMgQ09ORklHX0NI
RUxTSU9fVDEgaXMgbm90IHNldApDT05GSUdfSVhHQj15CiMgQ09ORklHX0lYR0JfTkFQSSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1MySU8gaXMgbm90IHNldAojIENPTkZJR19NWVJJMTBHRSBpcyBub3Qg
c2V0CiMgQ09ORklHX05FVFhFTl9OSUMgaXMgbm90IHNldAoKIwojIFRva2VuIFJpbmcgZGV2aWNl
cwojCiMgQ09ORklHX1RSIGlzIG5vdCBzZXQKCiMKIyBXaXJlbGVzcyBMQU4gKG5vbi1oYW1yYWRp
bykKIwojIENPTkZJR19ORVRfUkFESU8gaXMgbm90IHNldAoKIwojIFdhbiBpbnRlcmZhY2VzCiMK
IyBDT05GSUdfV0FOIGlzIG5vdCBzZXQKIyBDT05GSUdfRkRESSBpcyBub3Qgc2V0CiMgQ09ORklH
X0hJUFBJIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBQIGlzIG5vdCBzZXQKIyBDT05GSUdfU0xJUCBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9GQyBpcyBub3Qgc2V0CiMgQ09ORklHX1NIQVBFUiBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVENPTlNPTEUgaXMgbm90IHNldAojIENPTkZJR19ORVRQT0xMIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX1BPTExfQ09OVFJPTExFUiBpcyBub3Qgc2V0CgojCiMgSVNE
TiBzdWJzeXN0ZW0KIwojIENPTkZJR19JU0ROIGlzIG5vdCBzZXQKCiMKIyBUZWxlcGhvbnkgU3Vw
cG9ydAojCiMgQ09ORklHX1BIT05FIGlzIG5vdCBzZXQKCiMKIyBJbnB1dCBkZXZpY2Ugc3VwcG9y
dAojCkNPTkZJR19JTlBVVD15CiMgQ09ORklHX0lOUFVUX0ZGX01FTUxFU1MgaXMgbm90IHNldAoK
IwojIFVzZXJsYW5kIGludGVyZmFjZXMKIwpDT05GSUdfSU5QVVRfTU9VU0VERVY9eQojIENPTkZJ
R19JTlBVVF9NT1VTRURFVl9QU0FVWCBpcyBub3Qgc2V0CkNPTkZJR19JTlBVVF9NT1VTRURFVl9T
Q1JFRU5fWD0xMDI0CkNPTkZJR19JTlBVVF9NT1VTRURFVl9TQ1JFRU5fWT03NjgKIyBDT05GSUdf
SU5QVVRfSk9ZREVWIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfVFNERVYgaXMgbm90IHNldAoj
IENPTkZJR19JTlBVVF9FVkRFViBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0VWQlVHIGlzIG5v
dCBzZXQKCiMKIyBJbnB1dCBEZXZpY2UgRHJpdmVycwojCkNPTkZJR19JTlBVVF9LRVlCT0FSRD15
CkNPTkZJR19LRVlCT0FSRF9BVEtCRD15CiMgQ09ORklHX0tFWUJPQVJEX1NVTktCRCBpcyBub3Qg
c2V0CiMgQ09ORklHX0tFWUJPQVJEX0xLS0JEIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRf
WFRLQkQgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9ORVdUT04gaXMgbm90IHNldAojIENP
TkZJR19LRVlCT0FSRF9TVE9XQVdBWSBpcyBub3Qgc2V0CkNPTkZJR19JTlBVVF9NT1VTRT15CkNP
TkZJR19NT1VTRV9QUzI9eQojIENPTkZJR19NT1VTRV9TRVJJQUwgaXMgbm90IHNldAojIENPTkZJ
R19NT1VTRV9WU1hYWEFBIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfSk9ZU1RJQ0sgaXMgbm90
IHNldAojIENPTkZJR19JTlBVVF9UT1VDSFNDUkVFTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVU
X01JU0MgaXMgbm90IHNldAoKIwojIEhhcmR3YXJlIEkvTyBwb3J0cwojCkNPTkZJR19TRVJJTz15
CkNPTkZJR19TRVJJT19JODA0Mj15CiMgQ09ORklHX1NFUklPX1NFUlBPUlQgaXMgbm90IHNldAoj
IENPTkZJR19TRVJJT19DVDgyQzcxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklPX1BDSVBTMiBp
cyBub3Qgc2V0CkNPTkZJR19TRVJJT19MSUJQUzI9eQojIENPTkZJR19TRVJJT19SQVcgaXMgbm90
IHNldAojIENPTkZJR19HQU1FUE9SVCBpcyBub3Qgc2V0CgojCiMgQ2hhcmFjdGVyIGRldmljZXMK
IwpDT05GSUdfVlQ9eQpDT05GSUdfVlRfQ09OU09MRT15CkNPTkZJR19IV19DT05TT0xFPXkKIyBD
T05GSUdfVlRfSFdfQ09OU09MRV9CSU5ESU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX05P
TlNUQU5EQVJEIGlzIG5vdCBzZXQKCiMKIyBTZXJpYWwgZHJpdmVycwojCkNPTkZJR19TRVJJQUxf
ODI1MD15CkNPTkZJR19TRVJJQUxfODI1MF9DT05TT0xFPXkKQ09ORklHX1NFUklBTF84MjUwX1BD
ST15CkNPTkZJR19TRVJJQUxfODI1MF9QTlA9eQpDT05GSUdfU0VSSUFMXzgyNTBfTlJfVUFSVFM9
NApDT05GSUdfU0VSSUFMXzgyNTBfUlVOVElNRV9VQVJUUz00CiMgQ09ORklHX1NFUklBTF84MjUw
X0VYVEVOREVEIGlzIG5vdCBzZXQKCiMKIyBOb24tODI1MCBzZXJpYWwgcG9ydCBzdXBwb3J0CiMK
Q09ORklHX1NFUklBTF9DT1JFPXkKQ09ORklHX1NFUklBTF9DT1JFX0NPTlNPTEU9eQojIENPTkZJ
R19TRVJJQUxfSlNNIGlzIG5vdCBzZXQKQ09ORklHX1VOSVg5OF9QVFlTPXkKIyBDT05GSUdfTEVH
QUNZX1BUWVMgaXMgbm90IHNldAoKIwojIElQTUkKIwojIENPTkZJR19JUE1JX0hBTkRMRVIgaXMg
bm90IHNldAoKIwojIFdhdGNoZG9nIENhcmRzCiMKIyBDT05GSUdfV0FUQ0hET0cgaXMgbm90IHNl
dApDT05GSUdfSFdfUkFORE9NPXkKQ09ORklHX0hXX1JBTkRPTV9JTlRFTD15CiMgQ09ORklHX0hX
X1JBTkRPTV9BTUQgaXMgbm90IHNldAojIENPTkZJR19IV19SQU5ET01fR0VPREUgaXMgbm90IHNl
dAojIENPTkZJR19OVlJBTSBpcyBub3Qgc2V0CkNPTkZJR19SVEM9eQojIENPTkZJR19EVExLIGlz
IG5vdCBzZXQKIyBDT05GSUdfUjM5NjQgaXMgbm90IHNldAojIENPTkZJR19BUFBMSUNPTSBpcyBu
b3Qgc2V0CkNPTkZJR19BR1A9eQpDT05GSUdfQUdQX0FNRDY0PXkKQ09ORklHX0FHUF9JTlRFTD15
CiMgQ09ORklHX0FHUF9TSVMgaXMgbm90IHNldAojIENPTkZJR19BR1BfVklBIGlzIG5vdCBzZXQK
Q09ORklHX0RSTT15CiMgQ09ORklHX0RSTV9UREZYIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1Ix
MjggaXMgbm90IHNldAojIENPTkZJR19EUk1fUkFERU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJN
X0k4MTAgaXMgbm90IHNldAojIENPTkZJR19EUk1fSTgzMCBpcyBub3Qgc2V0CkNPTkZJR19EUk1f
STkxNT15CiMgQ09ORklHX0RSTV9NR0EgaXMgbm90IHNldAojIENPTkZJR19EUk1fU0lTIGlzIG5v
dCBzZXQKIyBDT05GSUdfRFJNX1ZJQSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9TQVZBR0UgaXMg
bm90IHNldAojIENPTkZJR19NV0FWRSBpcyBub3Qgc2V0CiMgQ09ORklHX1BDODczNnhfR1BJTyBp
cyBub3Qgc2V0CiMgQ09ORklHX1JBV19EUklWRVIgaXMgbm90IHNldApDT05GSUdfSFBFVD15CiMg
Q09ORklHX0hQRVRfUlRDX0lSUSBpcyBub3Qgc2V0CkNPTkZJR19IUEVUX01NQVA9eQojIENPTkZJ
R19IQU5HQ0hFQ0tfVElNRVIgaXMgbm90IHNldAoKIwojIFRQTSBkZXZpY2VzCiMKIyBDT05GSUdf
VENHX1RQTSBpcyBub3Qgc2V0CiMgQ09ORklHX1RFTENMT0NLIGlzIG5vdCBzZXQKCiMKIyBJMkMg
c3VwcG9ydAojCkNPTkZJR19JMkM9eQpDT05GSUdfSTJDX0NIQVJERVY9eQoKIwojIEkyQyBBbGdv
cml0aG1zCiMKQ09ORklHX0kyQ19BTEdPQklUPXkKIyBDT05GSUdfSTJDX0FMR09QQ0YgaXMgbm90
IHNldAojIENPTkZJR19JMkNfQUxHT1BDQSBpcyBub3Qgc2V0CgojCiMgSTJDIEhhcmR3YXJlIEJ1
cyBzdXBwb3J0CiMKIyBDT05GSUdfSTJDX0FMSTE1MzUgaXMgbm90IHNldAojIENPTkZJR19JMkNf
QUxJMTU2MyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTEkxNVgzIGlzIG5vdCBzZXQKIyBDT05G
SUdfSTJDX0FNRDc1NiBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTUQ4MTExIGlzIG5vdCBzZXQK
Q09ORklHX0kyQ19JODAxPXkKIyBDT05GSUdfSTJDX0k4MTAgaXMgbm90IHNldAojIENPTkZJR19J
MkNfUElJWDQgaXMgbm90IHNldAojIENPTkZJR19JMkNfTkZPUkNFMiBpcyBub3Qgc2V0CiMgQ09O
RklHX0kyQ19PQ09SRVMgaXMgbm90IHNldAojIENPTkZJR19JMkNfUEFSUE9SVF9MSUdIVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0kyQ19QUk9TQVZBR0UgaXMgbm90IHNldAojIENPTkZJR19JMkNfU0FW
QUdFNCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19TSVM1NTk1IGlzIG5vdCBzZXQKIyBDT05GSUdf
STJDX1NJUzYzMCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19TSVM5NlggaXMgbm90IHNldAojIENP
TkZJR19JMkNfU1RVQiBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19WSUEgaXMgbm90IHNldAojIENP
TkZJR19JMkNfVklBUFJPIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1ZPT0RPTzMgaXMgbm90IHNl
dAojIENPTkZJR19JMkNfUENBX0lTQSBpcyBub3Qgc2V0CgojCiMgTWlzY2VsbGFuZW91cyBJMkMg
Q2hpcCBzdXBwb3J0CiMKIyBDT05GSUdfU0VOU09SU19EUzEzMzcgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX0RTMTM3NCBpcyBub3Qgc2V0CkNPTkZJR19TRU5TT1JTX0VFUFJPTT15CiMgQ09O
RklHX1NFTlNPUlNfUENGODU3NCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfUENBOTUzOSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfUENGODU5MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfTUFYNjg3NSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19ERUJVR19DT1JFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSTJDX0RFQlVHX0FMR08gaXMgbm90IHNldAojIENPTkZJR19JMkNfREVCVUdf
QlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0RFQlVHX0NISVAgaXMgbm90IHNldAoKIwojIFNQ
SSBzdXBwb3J0CiMKIyBDT05GSUdfU1BJIGlzIG5vdCBzZXQKIyBDT05GSUdfU1BJX01BU1RFUiBp
cyBub3Qgc2V0CgojCiMgRGFsbGFzJ3MgMS13aXJlIGJ1cwojCiMgQ09ORklHX1cxIGlzIG5vdCBz
ZXQKCiMKIyBIYXJkd2FyZSBNb25pdG9yaW5nIHN1cHBvcnQKIwojIENPTkZJR19IV01PTiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0hXTU9OX1ZJRCBpcyBub3Qgc2V0CgojCiMgTXVsdGltZWRpYSBkZXZp
Y2VzCiMKIyBDT05GSUdfVklERU9fREVWIGlzIG5vdCBzZXQKCiMKIyBEaWdpdGFsIFZpZGVvIEJy
b2FkY2FzdGluZyBEZXZpY2VzCiMKIyBDT05GSUdfRFZCIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X0RBQlVTQiBpcyBub3Qgc2V0CgojCiMgR3JhcGhpY3Mgc3VwcG9ydAojCkNPTkZJR19GSVJNV0FS
RV9FRElEPXkKQ09ORklHX0ZCPXkKIyBDT05GSUdfRkJfRERDIGlzIG5vdCBzZXQKQ09ORklHX0ZC
X0NGQl9GSUxMUkVDVD15CkNPTkZJR19GQl9DRkJfQ09QWUFSRUE9eQpDT05GSUdfRkJfQ0ZCX0lN
QUdFQkxJVD15CiMgQ09ORklHX0ZCX01BQ01PREVTIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfQkFD
S0xJR0hUIGlzIG5vdCBzZXQKQ09ORklHX0ZCX01PREVfSEVMUEVSUz15CiMgQ09ORklHX0ZCX1RJ
TEVCTElUVElORyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0NJUlJVUyBpcyBub3Qgc2V0CiMgQ09O
RklHX0ZCX1BNMiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0NZQkVSMjAwMCBpcyBub3Qgc2V0CiMg
Q09ORklHX0ZCX0FSQyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0FTSUxJQU5UIGlzIG5vdCBzZXQK
IyBDT05GSUdfRkJfSU1TVFQgaXMgbm90IHNldAojIENPTkZJR19GQl9WR0ExNiBpcyBub3Qgc2V0
CkNPTkZJR19GQl9WRVNBPXkKIyBDT05GSUdfRkJfSEdBIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJf
UzFEMTNYWFggaXMgbm90IHNldAojIENPTkZJR19GQl9OVklESUEgaXMgbm90IHNldAojIENPTkZJ
R19GQl9SSVZBIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfSU5URUwgaXMgbm90IHNldAojIENPTkZJ
R19GQl9NQVRST1ggaXMgbm90IHNldAojIENPTkZJR19GQl9SQURFT04gaXMgbm90IHNldAojIENP
TkZJR19GQl9BVFkxMjggaXMgbm90IHNldAojIENPTkZJR19GQl9BVFkgaXMgbm90IHNldAojIENP
TkZJR19GQl9TQVZBR0UgaXMgbm90IHNldAojIENPTkZJR19GQl9TSVMgaXMgbm90IHNldAojIENP
TkZJR19GQl9ORU9NQUdJQyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0tZUk8gaXMgbm90IHNldAoj
IENPTkZJR19GQl8zREZYIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfVk9PRE9PMSBpcyBub3Qgc2V0
CiMgQ09ORklHX0ZCX1RSSURFTlQgaXMgbm90IHNldAojIENPTkZJR19GQl9HRU9ERSBpcyBub3Qg
c2V0CiMgQ09ORklHX0ZCX1ZJUlRVQUwgaXMgbm90IHNldAoKIwojIENvbnNvbGUgZGlzcGxheSBk
cml2ZXIgc3VwcG9ydAojCkNPTkZJR19WR0FfQ09OU09MRT15CiMgQ09ORklHX1ZHQUNPTl9TT0ZU
X1NDUk9MTEJBQ0sgaXMgbm90IHNldApDT05GSUdfVklERU9fU0VMRUNUPXkKQ09ORklHX0RVTU1Z
X0NPTlNPTEU9eQpDT05GSUdfRlJBTUVCVUZGRVJfQ09OU09MRT15CiMgQ09ORklHX0ZSQU1FQlVG
RkVSX0NPTlNPTEVfUk9UQVRJT04gaXMgbm90IHNldAojIENPTkZJR19GT05UUyBpcyBub3Qgc2V0
CkNPTkZJR19GT05UXzh4OD15CkNPTkZJR19GT05UXzh4MTY9eQoKIwojIExvZ28gY29uZmlndXJh
dGlvbgojCkNPTkZJR19MT0dPPXkKIyBDT05GSUdfTE9HT19MSU5VWF9NT05PIGlzIG5vdCBzZXQK
IyBDT05GSUdfTE9HT19MSU5VWF9WR0ExNiBpcyBub3Qgc2V0CkNPTkZJR19MT0dPX0xJTlVYX0NM
VVQyMjQ9eQojIENPTkZJR19CQUNLTElHSFRfTENEX1NVUFBPUlQgaXMgbm90IHNldAoKIwojIFNv
dW5kCiMKQ09ORklHX1NPVU5EPXkKCiMKIyBBZHZhbmNlZCBMaW51eCBTb3VuZCBBcmNoaXRlY3R1
cmUKIwpDT05GSUdfU05EPXkKQ09ORklHX1NORF9USU1FUj15CkNPTkZJR19TTkRfUENNPXkKQ09O
RklHX1NORF9TRVFVRU5DRVI9eQojIENPTkZJR19TTkRfU0VRX0RVTU1ZIGlzIG5vdCBzZXQKQ09O
RklHX1NORF9PU1NFTVVMPXkKQ09ORklHX1NORF9NSVhFUl9PU1M9eQpDT05GSUdfU05EX1BDTV9P
U1M9eQpDT05GSUdfU05EX1BDTV9PU1NfUExVR0lOUz15CkNPTkZJR19TTkRfU0VRVUVOQ0VSX09T
Uz15CkNPTkZJR19TTkRfUlRDVElNRVI9eQpDT05GSUdfU05EX1NFUV9SVENUSU1FUl9ERUZBVUxU
PXkKIyBDT05GSUdfU05EX0RZTkFNSUNfTUlOT1JTIGlzIG5vdCBzZXQKQ09ORklHX1NORF9TVVBQ
T1JUX09MRF9BUEk9eQojIENPTkZJR19TTkRfVkVSQk9TRV9QUk9DRlMgaXMgbm90IHNldAojIENP
TkZJR19TTkRfVkVSQk9TRV9QUklOVEsgaXMgbm90IHNldAojIENPTkZJR19TTkRfREVCVUcgaXMg
bm90IHNldAoKIwojIEdlbmVyaWMgZGV2aWNlcwojCiMgQ09ORklHX1NORF9EVU1NWSBpcyBub3Qg
c2V0CiMgQ09ORklHX1NORF9WSVJNSURJIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX01UUEFWIGlz
IG5vdCBzZXQKIyBDT05GSUdfU05EX1NFUklBTF9VMTY1NTAgaXMgbm90IHNldAojIENPTkZJR19T
TkRfTVBVNDAxIGlzIG5vdCBzZXQKCiMKIyBQQ0kgZGV2aWNlcwojCiMgQ09ORklHX1NORF9BRDE4
ODkgaXMgbm90IHNldAojIENPTkZJR19TTkRfQUxTMzAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X0FMUzQwMDAgaXMgbm90IHNldAojIENPTkZJR19TTkRfQUxJNTQ1MSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NORF9BVElJWFAgaXMgbm90IHNldAojIENPTkZJR19TTkRfQVRJSVhQX01PREVNIGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX0FVODgxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9BVTg4MjAg
aXMgbm90IHNldAojIENPTkZJR19TTkRfQVU4ODMwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0Fa
VDMzMjggaXMgbm90IHNldAojIENPTkZJR19TTkRfQlQ4N1ggaXMgbm90IHNldAojIENPTkZJR19T
TkRfQ0EwMTA2IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0NNSVBDSSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NORF9DUzQyODEgaXMgbm90IHNldAojIENPTkZJR19TTkRfQ1M0NlhYIGlzIG5vdCBzZXQK
IyBDT05GSUdfU05EX0RBUkxBMjAgaXMgbm90IHNldAojIENPTkZJR19TTkRfR0lOQTIwIGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX0xBWUxBMjAgaXMgbm90IHNldAojIENPTkZJR19TTkRfREFSTEEy
NCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9HSU5BMjQgaXMgbm90IHNldAojIENPTkZJR19TTkRf
TEFZTEEyNCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9NT05BIGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX01JQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9FQ0hPM0cgaXMgbm90IHNldAojIENPTkZJ
R19TTkRfSU5ESUdPIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0lORElHT0lPIGlzIG5vdCBzZXQK
IyBDT05GSUdfU05EX0lORElHT0RKIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0VNVTEwSzEgaXMg
bm90IHNldAojIENPTkZJR19TTkRfRU1VMTBLMVggaXMgbm90IHNldAojIENPTkZJR19TTkRfRU5T
MTM3MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9FTlMxMzcxIGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX0VTMTkzOCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9FUzE5NjggaXMgbm90IHNldAojIENP
TkZJR19TTkRfRk04MDEgaXMgbm90IHNldApDT05GSUdfU05EX0hEQV9JTlRFTD15CiMgQ09ORklH
X1NORF9IRFNQIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0hEU1BNIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX0lDRTE3MTIgaXMgbm90IHNldAojIENPTkZJR19TTkRfSUNFMTcyNCBpcyBub3Qgc2V0
CiMgQ09ORklHX1NORF9JTlRFTDhYMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9JTlRFTDhYME0g
aXMgbm90IHNldAojIENPTkZJR19TTkRfS09SRzEyMTIgaXMgbm90IHNldAojIENPTkZJR19TTkRf
TUFFU1RSTzMgaXMgbm90IHNldAojIENPTkZJR19TTkRfTUlYQVJUIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX05NMjU2IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1BDWEhSIGlzIG5vdCBzZXQKIyBD
T05GSUdfU05EX1JJUFRJREUgaXMgbm90IHNldAojIENPTkZJR19TTkRfUk1FMzIgaXMgbm90IHNl
dAojIENPTkZJR19TTkRfUk1FOTYgaXMgbm90IHNldAojIENPTkZJR19TTkRfUk1FOTY1MiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9TT05JQ1ZJQkVTIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1RS
SURFTlQgaXMgbm90IHNldAojIENPTkZJR19TTkRfVklBODJYWCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9WSUE4MlhYX01PREVNIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1ZYMjIyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU05EX1lNRlBDSSBpcyBub3Qgc2V0CgojCiMgVVNCIGRldmljZXMKIwojIENP
TkZJR19TTkRfVVNCX0FVRElPIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1VTQl9VU1gyWSBpcyBu
b3Qgc2V0CgojCiMgT3BlbiBTb3VuZCBTeXN0ZW0KIwojIENPTkZJR19TT1VORF9QUklNRSBpcyBu
b3Qgc2V0CgojCiMgSElEIERldmljZXMKIwojIENPTkZJR19ISUQgaXMgbm90IHNldAoKIwojIFVT
QiBzdXBwb3J0CiMKQ09ORklHX1VTQl9BUkNIX0hBU19IQ0Q9eQpDT05GSUdfVVNCX0FSQ0hfSEFT
X09IQ0k9eQpDT05GSUdfVVNCX0FSQ0hfSEFTX0VIQ0k9eQpDT05GSUdfVVNCPXkKIyBDT05GSUdf
VVNCX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBNaXNjZWxsYW5lb3VzIFVTQiBvcHRpb25zCiMKQ09O
RklHX1VTQl9ERVZJQ0VGUz15CiMgQ09ORklHX1VTQl9CQU5EV0lEVEggaXMgbm90IHNldAojIENP
TkZJR19VU0JfRFlOQU1JQ19NSU5PUlMgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1VTUEVORCBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9NVUxUSVRIUkVBRF9QUk9CRSBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9PVEcgaXMgbm90IHNldAoKIwojIFVTQiBIb3N0IENvbnRyb2xsZXIgRHJpdmVycwoj
CkNPTkZJR19VU0JfRUhDSV9IQ0Q9eQojIENPTkZJR19VU0JfRUhDSV9TUExJVF9JU08gaXMgbm90
IHNldAojIENPTkZJR19VU0JfRUhDSV9ST09UX0hVQl9UVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9FSENJX1RUX05FV1NDSEVEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0lTUDExNlhfSENEIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX09IQ0lfSENEIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9VSENJ
X0hDRD15CiMgQ09ORklHX1VTQl9TTDgxMV9IQ0QgaXMgbm90IHNldAoKIwojIFVTQiBEZXZpY2Ug
Q2xhc3MgZHJpdmVycwojCkNPTkZJR19VU0JfQUNNPXkKQ09ORklHX1VTQl9QUklOVEVSPXkKCiMK
IyBOT1RFOiBVU0JfU1RPUkFHRSBlbmFibGVzIFNDU0ksIGFuZCAnU0NTSSBkaXNrIHN1cHBvcnQn
CiMKCiMKIyBtYXkgYWxzbyBiZSBuZWVkZWQ7IHNlZSBVU0JfU1RPUkFHRSBIZWxwIGZvciBtb3Jl
IGluZm9ybWF0aW9uCiMKQ09ORklHX1VTQl9TVE9SQUdFPXkKIyBDT05GSUdfVVNCX1NUT1JBR0Vf
REVCVUcgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9EQVRBRkFCIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX1NUT1JBR0VfRlJFRUNPTSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9S
QUdFX0lTRDIwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0RQQ00gaXMgbm90IHNl
dAojIENPTkZJR19VU0JfU1RPUkFHRV9VU0JBVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9S
QUdFX1NERFIwOSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX1NERFI1NSBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0pVTVBTSE9UIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X1NUT1JBR0VfQUxBVURBIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfS0FSTUEgaXMg
bm90IHNldAojIENPTkZJR19VU0JfTElCVVNVQUwgaXMgbm90IHNldAoKIwojIFVTQiBJbnB1dCBE
ZXZpY2VzCiMKIyBDT05GSUdfVVNCX0hJRCBpcyBub3Qgc2V0CgojCiMgVVNCIEhJRCBCb290IFBy
b3RvY29sIGRyaXZlcnMKIwojIENPTkZJR19VU0JfS0JEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X01PVVNFIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0FJUFRFSyBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9XQUNPTSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9BQ0VDQUQgaXMgbm90IHNldAojIENP
TkZJR19VU0JfS0JUQUIgaXMgbm90IHNldAojIENPTkZJR19VU0JfUE9XRVJNQVRFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX1RPVUNIU0NSRUVOIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1lFQUxJ
TksgaXMgbm90IHNldAojIENPTkZJR19VU0JfWFBBRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9B
VElfUkVNT1RFIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0FUSV9SRU1PVEUyIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX0tFWVNQQU5fUkVNT1RFIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0FQUExF
VE9VQ0ggaXMgbm90IHNldAoKIwojIFVTQiBJbWFnaW5nIGRldmljZXMKIwojIENPTkZJR19VU0Jf
TURDODAwIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX01JQ1JPVEVLIGlzIG5vdCBzZXQKCiMKIyBV
U0IgTmV0d29yayBBZGFwdGVycwojCiMgQ09ORklHX1VTQl9DQVRDIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX0tBV0VUSCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9QRUdBU1VTIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX1JUTDgxNTAgaXMgbm90IHNldAojIENPTkZJR19VU0JfVVNCTkVUX01JSSBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9VU0JORVQgaXMgbm90IHNldAojIENPTkZJR19VU0JfTU9O
IGlzIG5vdCBzZXQKCiMKIyBVU0IgcG9ydCBkcml2ZXJzCiMKCiMKIyBVU0IgU2VyaWFsIENvbnZl
cnRlciBzdXBwb3J0CiMKIyBDT05GSUdfVVNCX1NFUklBTCBpcyBub3Qgc2V0CgojCiMgVVNCIE1p
c2NlbGxhbmVvdXMgZHJpdmVycwojCiMgQ09ORklHX1VTQl9FTUk2MiBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9FTUkyNiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9BRFVUVVggaXMgbm90IHNldAoj
IENPTkZJR19VU0JfQVVFUlNXQUxEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1JJTzUwMCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9MRUdPVE9XRVIgaXMgbm90IHNldAojIENPTkZJR19VU0JfTENE
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0xFRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9DWVBS
RVNTX0NZN0M2MyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9DWVRIRVJNIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX1BISURHRVQgaXMgbm90IHNldAojIENPTkZJR19VU0JfSURNT1VTRSBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9GVERJX0VMQU4gaXMgbm90IHNldAojIENPTkZJR19VU0JfQVBQTEVE
SVNQTEFZIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NJU1VTQlZHQSBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9MRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9UUkFOQ0VWSUJSQVRPUiBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9URVNUIGlzIG5vdCBzZXQKCiMKIyBVU0IgRFNMIG1vZGVtIHN1cHBv
cnQKIwoKIwojIFVTQiBHYWRnZXQgU3VwcG9ydAojCiMgQ09ORklHX1VTQl9HQURHRVQgaXMgbm90
IHNldAoKIwojIE1NQy9TRCBDYXJkIHN1cHBvcnQKIwojIENPTkZJR19NTUMgaXMgbm90IHNldAoK
IwojIExFRCBkZXZpY2VzCiMKIyBDT05GSUdfTkVXX0xFRFMgaXMgbm90IHNldAoKIwojIExFRCBk
cml2ZXJzCiMKCiMKIyBMRUQgVHJpZ2dlcnMKIwoKIwojIEluZmluaUJhbmQgc3VwcG9ydAojCiMg
Q09ORklHX0lORklOSUJBTkQgaXMgbm90IHNldAoKIwojIEVEQUMgLSBlcnJvciBkZXRlY3Rpb24g
YW5kIHJlcG9ydGluZyAoUkFTKSAoRVhQRVJJTUVOVEFMKQojCkNPTkZJR19FREFDPXkKCiMKIyBS
ZXBvcnRpbmcgc3Vic3lzdGVtcwojCiMgQ09ORklHX0VEQUNfREVCVUcgaXMgbm90IHNldApDT05G
SUdfRURBQ19NTV9FREFDPXkKIyBDT05GSUdfRURBQ19FNzUyWCBpcyBub3Qgc2V0CkNPTkZJR19F
REFDX1BPTEw9eQoKIwojIFJlYWwgVGltZSBDbG9jawojCiMgQ09ORklHX1JUQ19DTEFTUyBpcyBu
b3Qgc2V0CgojCiMgRE1BIEVuZ2luZSBzdXBwb3J0CiMKQ09ORklHX0RNQV9FTkdJTkU9eQoKIwoj
IERNQSBDbGllbnRzCiMKQ09ORklHX05FVF9ETUE9eQoKIwojIERNQSBEZXZpY2VzCiMKQ09ORklH
X0lOVEVMX0lPQVRETUE9eQoKIwojIFZpcnR1YWxpemF0aW9uCiMKIyBDT05GSUdfS1ZNIGlzIG5v
dCBzZXQKCiMKIyBGaXJtd2FyZSBEcml2ZXJzCiMKIyBDT05GSUdfRUREIGlzIG5vdCBzZXQKIyBD
T05GSUdfREVMTF9SQlUgaXMgbm90IHNldAojIENPTkZJR19EQ0RCQVMgaXMgbm90IHNldAoKIwoj
IEZpbGUgc3lzdGVtcwojCkNPTkZJR19FWFQyX0ZTPXkKIyBDT05GSUdfRVhUMl9GU19YQVRUUiBp
cyBub3Qgc2V0CiMgQ09ORklHX0VYVDJfRlNfWElQIGlzIG5vdCBzZXQKQ09ORklHX0VYVDNfRlM9
eQojIENPTkZJR19FWFQzX0ZTX1hBVFRSIGlzIG5vdCBzZXQKIyBDT05GSUdfRVhUNERFVl9GUyBp
cyBub3Qgc2V0CkNPTkZJR19KQkQ9eQojIENPTkZJR19KQkRfREVCVUcgaXMgbm90IHNldAojIENP
TkZJR19SRUlTRVJGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0pGU19GUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0ZTX1BPU0lYX0FDTCBpcyBub3Qgc2V0CkNPTkZJR19YRlNfRlM9eQojIENPTkZJR19Y
RlNfUVVPVEEgaXMgbm90IHNldAojIENPTkZJR19YRlNfU0VDVVJJVFkgaXMgbm90IHNldAojIENP
TkZJR19YRlNfUE9TSVhfQUNMIGlzIG5vdCBzZXQKIyBDT05GSUdfWEZTX1JUIGlzIG5vdCBzZXQK
IyBDT05GSUdfR0ZTMl9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX09DRlMyX0ZTIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUlOSVhfRlMgaXMgbm90IHNldAojIENPTkZJR19ST01GU19GUyBpcyBub3Qgc2V0
CkNPTkZJR19JTk9USUZZPXkKQ09ORklHX0lOT1RJRllfVVNFUj15CiMgQ09ORklHX1FVT1RBIGlz
IG5vdCBzZXQKQ09ORklHX0ROT1RJRlk9eQojIENPTkZJR19BVVRPRlNfRlMgaXMgbm90IHNldApD
T05GSUdfQVVUT0ZTNF9GUz15CkNPTkZJR19GVVNFX0ZTPXkKCiMKIyBDRC1ST00vRFZEIEZpbGVz
eXN0ZW1zCiMKQ09ORklHX0lTTzk2NjBfRlM9eQpDT05GSUdfSk9MSUVUPXkKIyBDT05GSUdfWklT
T0ZTIGlzIG5vdCBzZXQKQ09ORklHX1VERl9GUz15CkNPTkZJR19VREZfTkxTPXkKCiMKIyBET1Mv
RkFUL05UIEZpbGVzeXN0ZW1zCiMKQ09ORklHX0ZBVF9GUz15CkNPTkZJR19NU0RPU19GUz15CkNP
TkZJR19WRkFUX0ZTPXkKQ09ORklHX0ZBVF9ERUZBVUxUX0NPREVQQUdFPTQzNwpDT05GSUdfRkFU
X0RFRkFVTFRfSU9DSEFSU0VUPSJpc284ODU5LTEiCiMgQ09ORklHX05URlNfRlMgaXMgbm90IHNl
dAoKIwojIFBzZXVkbyBmaWxlc3lzdGVtcwojCkNPTkZJR19QUk9DX0ZTPXkKQ09ORklHX1BST0Nf
S0NPUkU9eQpDT05GSUdfUFJPQ19TWVNDVEw9eQpDT05GSUdfU1lTRlM9eQpDT05GSUdfVE1QRlM9
eQojIENPTkZJR19UTVBGU19QT1NJWF9BQ0wgaXMgbm90IHNldAojIENPTkZJR19IVUdFVExCRlMg
aXMgbm90IHNldAojIENPTkZJR19IVUdFVExCX1BBR0UgaXMgbm90IHNldApDT05GSUdfUkFNRlM9
eQojIENPTkZJR19DT05GSUdGU19GUyBpcyBub3Qgc2V0CgojCiMgTWlzY2VsbGFuZW91cyBmaWxl
c3lzdGVtcwojCiMgQ09ORklHX0FERlNfRlMgaXMgbm90IHNldAojIENPTkZJR19BRkZTX0ZTIGlz
IG5vdCBzZXQKIyBDT05GSUdfSEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSEZTUExVU19GUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0JFRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19CRlNfRlMgaXMg
bm90IHNldAojIENPTkZJR19FRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19DUkFNRlMgaXMgbm90
IHNldAojIENPTkZJR19WWEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSFBGU19GUyBpcyBub3Qg
c2V0CiMgQ09ORklHX1FOWDRGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NZU1ZfRlMgaXMgbm90
IHNldAojIENPTkZJR19VRlNfRlMgaXMgbm90IHNldAoKIwojIE5ldHdvcmsgRmlsZSBTeXN0ZW1z
CiMKQ09ORklHX05GU19GUz1tCkNPTkZJR19ORlNfVjM9eQojIENPTkZJR19ORlNfVjNfQUNMIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkZTX1Y0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkZTX0RJUkVDVElP
IGlzIG5vdCBzZXQKQ09ORklHX05GU0Q9bQpDT05GSUdfTkZTRF9WMz15CiMgQ09ORklHX05GU0Rf
VjNfQUNMIGlzIG5vdCBzZXQKIyBDT05GSUdfTkZTRF9WNCBpcyBub3Qgc2V0CkNPTkZJR19ORlNE
X1RDUD15CkNPTkZJR19MT0NLRD1tCkNPTkZJR19MT0NLRF9WND15CkNPTkZJR19FWFBPUlRGUz1t
CkNPTkZJR19ORlNfQ09NTU9OPXkKQ09ORklHX1NVTlJQQz1tCiMgQ09ORklHX1JQQ1NFQ19HU1Nf
S1JCNSBpcyBub3Qgc2V0CiMgQ09ORklHX1JQQ1NFQ19HU1NfU1BLTTMgaXMgbm90IHNldApDT05G
SUdfU01CX0ZTPW0KIyBDT05GSUdfU01CX05MU19ERUZBVUxUIGlzIG5vdCBzZXQKQ09ORklHX0NJ
RlM9bQojIENPTkZJR19DSUZTX1NUQVRTIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0lGU19XRUFLX1BX
X0hBU0ggaXMgbm90IHNldAojIENPTkZJR19DSUZTX1hBVFRSIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q0lGU19ERUJVRzIgaXMgbm90IHNldAojIENPTkZJR19DSUZTX0VYUEVSSU1FTlRBTCBpcyBub3Qg
c2V0CiMgQ09ORklHX05DUF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NPREFfRlMgaXMgbm90IHNl
dAojIENPTkZJR19BRlNfRlMgaXMgbm90IHNldAojIENPTkZJR185UF9GUyBpcyBub3Qgc2V0Cgoj
CiMgUGFydGl0aW9uIFR5cGVzCiMKIyBDT05GSUdfUEFSVElUSU9OX0FEVkFOQ0VEIGlzIG5vdCBz
ZXQKQ09ORklHX01TRE9TX1BBUlRJVElPTj15CgojCiMgTmF0aXZlIExhbmd1YWdlIFN1cHBvcnQK
IwpDT05GSUdfTkxTPXkKQ09ORklHX05MU19ERUZBVUxUPSJ1dGY4IgpDT05GSUdfTkxTX0NPREVQ
QUdFXzQzNz15CiMgQ09ORklHX05MU19DT0RFUEFHRV83MzcgaXMgbm90IHNldAojIENPTkZJR19O
TFNfQ09ERVBBR0VfNzc1IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1MCBpcyBu
b3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NTIgaXMgbm90IHNldAojIENPTkZJR19OTFNf
Q09ERVBBR0VfODU1IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1NyBpcyBub3Qg
c2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjAgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09E
RVBBR0VfODYxIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MiBpcyBub3Qgc2V0
CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjMgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBB
R0VfODY0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2NSBpcyBub3Qgc2V0CiMg
Q09ORklHX05MU19DT0RFUEFHRV84NjYgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0Vf
ODY5IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzkzNiBpcyBub3Qgc2V0CiMgQ09O
RklHX05MU19DT0RFUEFHRV85NTAgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTMy
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzk0OSBpcyBub3Qgc2V0CiMgQ09ORklH
X05MU19DT0RFUEFHRV84NzQgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV84IGlzIG5v
dCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzEyNTAgaXMgbm90IHNldAojIENPTkZJR19OTFNf
Q09ERVBBR0VfMTI1MSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19BU0NJSSBpcyBub3Qgc2V0CkNP
TkZJR19OTFNfSVNPODg1OV8xPXkKIyBDT05GSUdfTkxTX0lTTzg4NTlfMiBpcyBub3Qgc2V0CiMg
Q09ORklHX05MU19JU084ODU5XzMgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV80IGlz
IG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfNSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19J
U084ODU5XzYgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV83IGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX0lTTzg4NTlfOSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzEzIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfMTQgaXMgbm90IHNldApDT05GSUdfTkxTX0lT
Tzg4NTlfMTU9eQojIENPTkZJR19OTFNfS09JOF9SIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0tP
SThfVSBpcyBub3Qgc2V0CkNPTkZJR19OTFNfVVRGOD15CgojCiMgRGlzdHJpYnV0ZWQgTG9jayBN
YW5hZ2VyCiMKIyBDT05GSUdfRExNIGlzIG5vdCBzZXQKCiMKIyBJbnN0cnVtZW50YXRpb24gU3Vw
cG9ydAojCiMgQ09ORklHX1BST0ZJTElORyBpcyBub3Qgc2V0CiMgQ09ORklHX0tQUk9CRVMgaXMg
bm90IHNldAoKIwojIEtlcm5lbCBoYWNraW5nCiMKQ09ORklHX1RSQUNFX0lSUUZMQUdTX1NVUFBP
UlQ9eQpDT05GSUdfUFJJTlRLX1RJTUU9eQojIENPTkZJR19FTkFCTEVfTVVTVF9DSEVDSyBpcyBu
b3Qgc2V0CkNPTkZJR19NQUdJQ19TWVNSUT15CiMgQ09ORklHX1VOVVNFRF9TWU1CT0xTIGlzIG5v
dCBzZXQKIyBDT05GSUdfREVCVUdfRlMgaXMgbm90IHNldAojIENPTkZJR19IRUFERVJTX0NIRUNL
IGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHX0tFUk5FTD15CkNPTkZJR19MT0dfQlVGX1NISUZUPTE3
CkNPTkZJR19ERVRFQ1RfU09GVExPQ0tVUD15CiMgQ09ORklHX1NDSEVEU1RBVFMgaXMgbm90IHNl
dAojIENPTkZJR19ERUJVR19TTEFCIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfUlRfTVVURVhF
UyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUX01VVEVYX1RFU1RFUiBpcyBub3Qgc2V0CiMgQ09ORklH
X0RFQlVHX1NQSU5MT0NLIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfTVVURVhFUyBpcyBub3Qg
c2V0CiMgQ09ORklHX0RFQlVHX1JXU0VNUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0xPQ0tf
QUxMT0MgaXMgbm90IHNldAojIENPTkZJR19QUk9WRV9MT0NLSU5HIGlzIG5vdCBzZXQKQ09ORklH
X0RFQlVHX1NQSU5MT0NLX1NMRUVQPXkKIyBDT05GSUdfREVCVUdfTE9DS0lOR19BUElfU0VMRlRF
U1RTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfS09CSkVDVCBpcyBub3Qgc2V0CkNPTkZJR19E
RUJVR19CVUdWRVJCT1NFPXkKIyBDT05GSUdfREVCVUdfSU5GTyBpcyBub3Qgc2V0CiMgQ09ORklH
X0RFQlVHX1ZNIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfTElTVCBpcyBub3Qgc2V0CiMgQ09O
RklHX0ZSQU1FX1BPSU5URVIgaXMgbm90IHNldAojIENPTkZJR19GT1JDRURfSU5MSU5JTkcgaXMg
bm90IHNldAojIENPTkZJR19SQ1VfVE9SVFVSRV9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfREVC
VUdfUk9EQVRBIGlzIG5vdCBzZXQKIyBDT05GSUdfSU9NTVVfREVCVUcgaXMgbm90IHNldAojIENP
TkZJR19ERUJVR19TVEFDS09WRVJGTE9XIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfU1RBQ0tf
VVNBR0UgaXMgbm90IHNldAoKIwojIFNlY3VyaXR5IG9wdGlvbnMKIwojIENPTkZJR19LRVlTIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VDVVJJVFkgaXMgbm90IHNldAoKIwojIENyeXB0b2dyYXBoaWMg
b3B0aW9ucwojCiMgQ09ORklHX0NSWVBUTyBpcyBub3Qgc2V0CgojCiMgTGlicmFyeSByb3V0aW5l
cwojCkNPTkZJR19CSVRSRVZFUlNFPXkKIyBDT05GSUdfQ1JDX0NDSVRUIGlzIG5vdCBzZXQKIyBD
T05GSUdfQ1JDMTYgaXMgbm90IHNldApDT05GSUdfQ1JDMzI9eQojIENPTkZJR19MSUJDUkMzMkMg
aXMgbm90IHNldApDT05GSUdfUExJU1Q9eQpDT05GSUdfSU9NQVBfQ09QWT15Cg==

--MP_2y+m36D+pGqu.k6jh.RpTPr--
