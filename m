Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbWASQ6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWASQ6Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 11:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWASQ6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 11:58:25 -0500
Received: from mtl.rackplans.net ([65.39.167.249]:57731 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S932492AbWASQ6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 11:58:25 -0500
Date: Thu, 19 Jan 2006 11:53:08 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
To: linux-kernel@vger.kernel.org
Subject: oops in 2.6.15.1 x86_64/ipv6
Message-ID: <Pine.LNX.4.64.0601191142210.26789@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The system is a dual 3ghz Xeon blade running an amd64 install of debian 
with the kernel upgraded to 2.6.15.1.

The crash happened when I did an ifconfig eth0:1" to bring up a local 
ipv4 network address.  The system does not have any configured ipv6 
addresses.

The boot messages are included below the opps. Let me know if I can 
provide any more info.

	Gerhard

Unable to handle kernel paging request at ffff81007cb2adc0 RIP: 
[<ffff81007cb2adc0>]
PGD 8063 PUD a063 PMD 800000007ca001e3 PTE dfdfdfdfdfdfdfdf
Oops: 0011 [1] PREEMPT SMP 
CPU 3 
Modules linked in: ipv6
Pid: 1890, comm: modprobe Not tainted 2.6.15.1 #3
RIP: 0010:[<ffff81007cb2adc0>] [<ffff81007cb2adc0>]
RSP: 0000:ffff81007cea1f10  EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff81007f913000 RCX: 0000000000000240
RDX: ffff81007f913000 RSI: 0000000000000005 RDI: ffffffff88033c40
RBP: ffffffff88033c40 R08: 0000000000000000 R09: 0000024000000000
R10: 0000000000000000 R11: ffff81007d281000 R12: 0000000000000000
R13: 0000000000527d28 R14: 0000000000000000 R15: 0000000000527d60
FS:  00002aaaaae00640(0000) GS:ffffffff80415980(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffff81007cb2adc0 CR3: 000000007d1ed000 CR4: 00000000000006e0
Process modprobe (pid: 1890, threadinfo ffff81007cea0000, task ffff81007c834300)
Stack: ffffffff802a5d7e 0000000000000000 ffffffff88035e00 ffffffff80379040 
       ffffffff8803a4f8 ffffffff88011885 0000000000000202 0000000000000000 
       ffffffff8803a13e ffffffff80379080 
Call Trace:<ffffffff802a5d7e>{register_netdevice_notifier+60} <ffffffff8803a4f8>{:ipv6:ndisc_init+190}
       <ffffffff88011885>{:ipv6:ndisc_ifinfo_sysctl_strategy+0}
       <ffffffff8803a13e>{:ipv6:inet6_init+204} <ffffffff80148fd8>{sys_init_module+247}
       <ffffffff8010d87a>{system_call+126} 

Code: 2c 02 00 f0 0b 00 00 00 50 ae b2 7c 00 81 ff ff 24 81 00 00 
RIP [<ffff81007cb2adc0>] RSP <ffff81007cea1f10>
CR2: ffff81007cb2adc0
 




Bootdata ok (command line is root=/dev/sda2 ro console=tty0 )
Linux version 2.6.15.1 (root@relich132) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #3 SMP PREEMPT Thu Jan 19 04:34:47 HAST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 000000007ffc0000 (usable)
 BIOS-e820: 000000007ffc0000 - 000000007ffcfc00 (ACPI data)
 BIOS-e820: 000000007ffcfc00 - 000000007ffff000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000fec90000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 DELL                                  ) @ 0x00000000000fd650
ACPI: RSDT (v001 DELL   PE1855   0x00000001 MSFT 0x0100000a) @ 0x00000000000fd664
ACPI: FADT (v001 DELL   PE1855   0x00000001 MSFT 0x0100000a) @ 0x00000000000fd6b0
ACPI: MADT (v001 DELL   PE1855   0x00000001 MSFT 0x0100000a) @ 0x00000000000fd724
ACPI: SPCR (v001 DELL   PE1855   0x00000001 MSFT 0x0100000a) @ 0x00000000000fd7c0
ACPI: HPET (v001 DELL   PE1855   0x00000001 MSFT 0x0100000a) @ 0x00000000000fd810
ACPI: MCFG (v001 DELL   PE1855   0x00000001 MSFT 0x0100000a) @ 0x00000000000fd848
ACPI: DSDT (v001 DELL   PE1855   0x00000001 MSFT 0x0100000e) @ 0x0000000000000000
On node 0 totalpages: 516103
  DMA zone: 3086 pages, LIFO batch:0
  DMA32 zone: 513017 pages, LIFO batch:31
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:4 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec84000] gsi_base[32])
IOAPIC[1]: apic_id 9, version 32, address 0xfec84000, GSI 32-55
ACPI: IOAPIC (id[0x0a] address[0xfec84800] gsi_base[64])
IOAPIC[2]: apic_id 10, version 32, address 0xfec84800, GSI 64-87
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0xffffffff base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 7ffff000:60001000)
Checking aperture...
Built 1 zonelists
Kernel command line: root=/dev/sda2 ro console=tty0 
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 14.318180 MHz HPET timer.
time.c: Detected 3000.196 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 2060828k/2096896k available (2043k kernel code, 35492k reserved, 883k data, 176k init)
Calibrating delay using timer specific routine.. 6004.38 BogoMIPS (lpj=3002194)
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU0: Thermal monitoring enabled (TM1)
mtrr: v2.0 (20020519)
Using local APIC timer interrupts.
Detected 12.500 MHz APIC timer.
Booting processor 1/4 APIC 0x6
Initializing CPU#1
Calibrating delay using timer specific routine.. 6000.36 BogoMIPS (lpj=3000184)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 3
CPU1: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
APIC error on CPU1: 00(40)
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 3 cycles, maxerr 1313 cycles)
Booting processor 2/4 APIC 0x1
Initializing CPU#2
Calibrating delay using timer specific routine.. 6000.18 BogoMIPS (lpj=3000090)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU2: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
APIC error on CPU2: 00(40)
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff -173 cycles, maxerr 915 cycles)
Booting processor 3/4 APIC 0x7
Initializing CPU#3
Calibrating delay using timer specific routine.. 6000.18 BogoMIPS (lpj=3000092)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 3
CPU3: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
APIC error on CPU3: 00(40)
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff -1 cycles, maxerr 1335 cycles)
Brought up 4 CPUs
time.c: Using HPET/TSC based timekeeping.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0880-08bf claimed by ICH4 GPIO
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
Boot video device is 0000:06:0d.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PALO._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PBLO._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCLO._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCLO.PXHA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCLO.PXHB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PICH._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11 12) *15
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12) *14
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling IOMMU.
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:03:00.0
  IO window: e000-efff
  MEM window: dfd00000-dfefffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:03:00.2
  IO window: d000-dfff
  MEM window: dfb00000-dfcfffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:06.0
  IO window: d000-efff
  MEM window: df900000-dfefffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: c000-cfff
  MEM window: df700000-df8fffff
  PREFETCH window: d0000000-d7ffffff
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:02.0 to 64
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:04.0 to 64
ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:06.0 to 64
PCI: Setting latency timer of device 0000:03:00.0 to 64
PCI: Setting latency timer of device 0000:03:00.2 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Intel E7520/7320/7525 detected.<6>ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:02.0 to 64
Allocate Port Service[pcie00]
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:04.0 to 64
Allocate Port Service[pcie00]
ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:06.0 to 64
Allocate Port Service[pcie00]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: Power Button (FF) [PWRF]
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 6.1.16-k2-NAPI
Copyright (c) 1999-2005 Intel Corporation.
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:05:04.0[A] -> GSI 68 (level, low) -> IRQ 17
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:05:04.1[B] -> GSI 69 (level, low) -> IRQ 18
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
Fusion MPT base driver 3.03.04
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.03.04
GSI 19 sharing vector 0xC1 and IRQ 19
ACPI: PCI Interrupt 0000:04:04.0[A] -> GSI 42 (level, low) -> IRQ 19
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
scsi0 : ioc0: LSI53C1030, FwRev=01032397h, Ports=1, MaxQ=222, IRQ=19
  Vendor: SEAGATE   Model: ST373307LC        Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sda: 143374744 512-byte hdwr sectors (73408 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 143374744 512-byte hdwr sectors (73408 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
  Vendor: SEAGATE   Model: ST373307LC        Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdb: 143374744 512-byte hdwr sectors (73408 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 143374744 512-byte hdwr sectors (73408 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
sd 0:0:1:0: Attached scsi disk sdb
  Vendor: SDR       Model: GEM318P           Rev: 1   
  Type:   Processor                          ANSI SCSI revision: 02
Fusion MPT misc device (ioctl) driver 3.03.04
mptctl: Registered with Fusion MPT base driver
mptctl: /dev/mptctl @ (major,minor=10,220)
usbmon: debugfs is not available
GSI 20 sharing vector 0xC9 and IRQ 20
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 20, io mem 0xdff00000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
116x: driver isp116x-hcd, 05 Aug 2005
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000bce0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
GSI 21 sharing vector 0xD1 and IRQ 21
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 21, io base 0x0000bcc0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
input: AT Translated Set 2 keyboard as /class/input/input0
ReiserFS: sda2: found reiserfs format "3.6" with standard journal
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
ReiserFS: sda2: using ordered data mode
ReiserFS: sda2: journal params: device sda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda2: checking transaction log (sda2)
ReiserFS: sda2: replayed 28 transactions in 6 seconds
ReiserFS: sda2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 176k freed
Adding 192740k swap on /dev/sdb1.  Priority:-1 extents:1 across:192740k
ReiserFS: sdb2: found reiserfs format "3.6" with standard journal
ReiserFS: sdb2: using ordered data mode
ReiserFS: sdb2: journal params: device sdb2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdb2: checking transaction log (sdb2)
ReiserFS: sdb2: Using r5 hash to sort names
e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
NET: Registered protocol family 10

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
