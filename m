Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVDETNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVDETNj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 15:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbVDETNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 15:13:05 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:57414 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261934AbVDETIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 15:08:04 -0400
Message-ID: <46802.192.168.1.5.1112727980.squirrel@www.rncbc.org>
In-Reply-To: <20050405071911.GA23653@elte.hu>
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu>
    <20050401104724.GA31971@elte.hu> <20050405071911.GA23653@elte.hu>
Date: Tue, 5 Apr 2005 20:06:20 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc2-V0.7.44-00
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       "Steven Rostedt" <rostedt@goodmis.org>
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050405200620_31823"
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 05 Apr 2005 19:07:54.0452 (UTC) FILETIME=[C5565940:01C53A12]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20050405200620_31823
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 8bit

>
> i have released the -V0.7.44-00 Real-Time Preemption patch, which can be
> downloaded from the usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/
>

I'm having plenty of this on boot, on my SMP/HT desktop (P4/x86), while
running RT-V0.7.44-01 (SMP+PREEMPT_RT):

  BUG: kstopmachine:xxxx RT task yield()-ing!

See sample dmesg and .config on attach.

OTOH, on my laptop (P4/UP), all seems to be clear fine.

Is this something to be affraid of? :)

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
------=_20050405200620_31823
Content-Type: text/plain; name="dmesg-2.6.12-rc2-RT-V0.7.44-01.0smp-0.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
      filename="dmesg-2.6.12-rc2-RT-V0.7.44-01.0smp-0.txt"

Linux version 2.6.12-rc2-RT-V0.7.44-01.0smp (root@gamma-suse1) (gcc version 3.3.4 (pre 3.3.5 20040809)) #1 SMP Tue Apr 5 19:21:11 WEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff30000 (usable)
 BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
 BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 261936
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32560 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                ) @ 0x000f9e60
ACPI: XSDT (v001 A M I  OEMXSDT  0x08000320 MSFT 0x00000097) @ 0x3ff30100
ACPI: FADT (v003 A M I  OEMFACP  0x08000320 MSFT 0x00000097) @ 0x3ff30290
ACPI: MADT (v001 A M I  OEMAPIC  0x08000320 MSFT 0x00000097) @ 0x3ff30390
ACPI: OEMB (v001 A M I  OEMBIOS  0x08000320 MSFT 0x00000097) @ 0x3ff40040
ACPI: DSDT (v001  P4P81 P4P81086 0x00000086 INTL 0x02002026) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 40000000:bfb80000)
Real-Time Preemption Support (c) Ingo Molnar
Built 1 zonelists
Kernel command line: root=/dev/hda2
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3360.970 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1035212k/1047744k available (1872k kernel code, 12144k reserved, 598k data, 176k init, 130240k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 6668.28 BogoMIPS (lpj=3334144)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay loop... 6717.44 BogoMIPS (lpj=3358720)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Total of 2 processors activated (13385.72 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
spawn_desched_task(00000000)
desched cpu_callback 3/00000000
ksoftirqd started up.
softirq RT prio: 24.
desched cpu_callback 2/00000000
desched thread 0 started up.
desched cpu_callback 3/00000001
desched cpu_callback 2/00000001
ksoftirqd started up.
softirq RT prio: 24.
Brought up 2 CPUs
desched thread 1 started up.
CPU0 attaching sched-domain:
 domain 0: span 3
  groups: 1 2
  domain 1: span 3
   groups: 3
CPU1 attaching sched-domain:
 domain 0: span 3
  groups: 2 1
  domain 1: span 3
   groups: 3
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
highmem bounce pool size: 64 pages
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: IC35L120AVVA07-0, ATA DISK drive
hdb: IC35L120AVVA07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SONY DVD RW DRU-500A, ATAPI CD/DVD-ROM drive
hdd: HL-DT-ST RW/DVD GCC-4120B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
hdb: max request size: 128KiB
hdb: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 hdb11 >
hdc: ATAPI 32X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 32X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 64Kbytes
TCP established hash table entries: 65536 (order: 9, 2621440 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
input: AT Translated Set 2 keyboard on isa0060/serio0
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
logips2pp: Detected unknown logitech mouse model 0
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 176k freed
Adding 987956k swap on /dev/hda11.  Priority:42 extents:1
Adding 963860k swap on /dev/hdb11.  Priority:42 extents:1
ReiserFS: hda2: warning: noacl not supported.
ReiserFS: hda2: warning: noacl not supported.
BUG: kstopmachine:1507 RT task yield()-ing!
 [<c02d245d>] yield+0x5d/0x60 (8)
 [<c013a695>] stop_machine+0xa5/0x140 (24)
 [<c013a740>] do_stop+0x0/0x70 (32)
 [<c013a749>] do_stop+0x9/0x70 (4)
 [<c01302e5>] kthread+0xa5/0xf0 (12)
 [<c0130240>] kthread+0x0/0xf0 (16)
 [<c0100fd5>] kernel_thread_helper+0x5/0x10 (16)
BUG: kstopmachine:1507 RT task yield()-ing!
 [<c02d245d>] yield+0x5d/0x60 (8)
 [<c013a695>] stop_machine+0xa5/0x140 (24)
 [<c013a740>] do_stop+0x0/0x70 (32)
 [<c013a749>] do_stop+0x9/0x70 (4)
 [<c01302e5>] kthread+0xa5/0xf0 (12)
 [<c0130240>] kthread+0x0/0xf0 (16)
 [<c0100fd5>] kernel_thread_helper+0x5/0x10 (16)
BUG: kstopmachine:1508 RT task yield()-ing!
 [<c02d245d>] yield+0x5d/0x60 (8)
 [<c013a575>] stopmachine+0x95/0xe0 (24)
 [<c013a4e0>] stopmachine+0x0/0xe0 (4)
 [<c0100fd5>] kernel_thread_helper+0x5/0x10 (12)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
BUG: kstopmachine:1649 RT task yield()-ing!
 [<c02d245d>] yield+0x5d/0x60 (8)
 [<c013a695>] stop_machine+0xa5/0x140 (24)
 [<c013a740>] do_stop+0x0/0x70 (32)
 [<c013a749>] do_stop+0x9/0x70 (4)
 [<c01302e5>] kthread+0xa5/0xf0 (12)
 [<c0130240>] kthread+0x0/0xf0 (16)
 [<c0100fd5>] kernel_thread_helper+0x5/0x10 (16)
BUG: kstopmachine:1649 RT task yield()-ing!
 [<c02d245d>] yield+0x5d/0x60 (8)
 [<c013a695>] stop_machine+0xa5/0x140 (24)
 [<c013a740>] do_stop+0x0/0x70 (32)
 [<c013a749>] do_stop+0x9/0x70 (4)
 [<c01302e5>] kthread+0xa5/0xf0 (12)
 [<c0130240>] kthread+0x0/0xf0 (16)
 [<c0100fd5>] kernel_thread_helper+0x5/0x10 (16)
BUG: kstopmachine:1649 RT task yield()-ing!
BUG: kstopmachine:1650 RT task yield()-ing!
 [<c02d245d>] yield+0x5d/0x60 (8)
 [<c013a575>] stopmachine+0x95/0xe0 (24)
 [<c013a4e0>] stopmachine+0x0/0xe0 (4)
 [<c0100fd5>] kernel_thread_helper+0x5/0x10 (12)
BUG: kstopmachine:1650 RT task yield()-ing!
 [<c02d245d>] yield+0x5d/0x60 (8)
 [<c013a575>] stopmachine+0x95/0xe0 (24)
 [<c013a4e0>] stopmachine+0x0/0xe0 (4)
 [<c0100fd5>] kernel_thread_helper+0x5/0x10 (12)
BUG: kstopmachine:1650 RT task yield()-ing!
 [<c02d245d>] yield+0x5d/0x60 (8)
 [<c013a575>] stopmachine+0x95/0xe0 (24)
 [<c013a4e0>] stopmachine+0x0/0xe0 (4)
 [<c0100fd5>] kernel_thread_helper+0x5/0x10 (12)
BUG: kstopmachine:1650 RT task yield()-ing!
 [<c02d245d>] yield+0x5d/0x60 (8)
 [<c013a575>] stopmachine+0x95/0xe0 (24)
 [<c013a4e0>] stopmachine+0x0/0xe0 (4)
 [<c0100fd5>] kernel_thread_helper+0x5/0x10 (12)
 [<c02d245d>] yield+0x5d/0x60 (8)
 [<c013a695>] stop_machine+0xa5/0x140 (24)
 [<c013a740>] do_stop+0x0/0x70 (32)
 [<c013a749>] do_stop+0x9/0x70 (4)
 [<c01302e5>] kthread+0xa5/0xf0 (12)
 [<c0130240>] kthread+0x0/0xf0 (16)
 [<c0100fd5>] kernel_thread_helper+0x5/0x10 (16)
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 22
ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 22
eth0: 3Com Gigabit LOM (3C940)
      PrefPort:A  RlmtMode:Check Link State
ReiserFS: hda6: warning: noacl not supported.
ReiserFS: hda6: found reiserfs format "3.6" with standard journal
ReiserFS: hda6: using ordered data mode
printk: 307 messages suppressed.
BUG: kstopmachine:2083 RT task yield()-ing!
 [<c02d245d>] yield+0x5d/0x60 (8)
 [<c013a695>] stop_machine+0xa5/0x140 (24)
 [<c013a740>] do_stop+0x0/0x70 (32)
 [<c013a749>] do_stop+0x9/0x70 (4)
 [<c01302e5>] kthread+0xa5/0xf0 (12)
 [<c0130240>] kthread+0x0/0xf0 (16)
 [<c0100fd5>] kernel_thread_helper+0x5/0x10 (16)
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfebffc00
ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda6: checking transaction log (hda6)
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ReiserFS: hda6: Using r5 hash to sort names
ReiserFS: hda8: warning: noacl not supported.
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
ReiserFS: hda8: found reiserfs format "3.6" with standard journal
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000ef00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000ef20
ReiserFS: hda8: using ordered data mode
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
ReiserFS: hda8: journal params: device hda8, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda8: checking transaction log (hda8)
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ef80
ReiserFS: hda8: Using r5 hash to sort names
usb 3-1: new low speed USB device using uhci_hcd and address 2
subfs 0.9
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 20 (level, low) -> IRQ 20
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[20]  MMIO=[feaff800-feafffff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e01800003252fa]
printk: 34 messages suppressed.
BUG: kstopmachine:3125 RT task yield()-ing!
 [<c02d245d>] yield+0x5d/0x60 (8)
 [<c013a695>] stop_machine+0xa5/0x140 (24)
 [<c013a740>] do_stop+0x0/0x70 (32)
 [<c013a749>] do_stop+0x9/0x70 (4)
 [<c01302e5>] kthread+0xa5/0xf0 (12)
 [<c0130240>] kthread+0x0/0xf0 (16)
 [<c0100fd5>] kernel_thread_helper+0x5/0x10 (16)
BUG: kstopmachine:3125 RT task yield()-ing!
 [<c02d245d>] yield+0x5d/0x60 (8)
 [<c013a695>] stop_machine+0xa5/0x140 (24)
 [<c013a740>] do_stop+0x0/0x70 (32)
 [<c013a749>] do_stop+0x9/0x70 (4)
 [<c01302e5>] kthread+0xa5/0xf0 (12)
 [<c0130240>] kthread+0x0/0xf0 (16)
 [<c0100fd5>] kernel_thread_helper+0x5/0x10 (16)
usbhid: probe of 3-1:1.0 failed with error -5
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
Realtime LSM initialized (group 17, mlock=1)
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     half
    flowctrl:        none
    irq moderation:  disabled
    scatter-gather:  enabled
printk: 28 messages suppressed.
BUG: kstopmachine:3768 RT task yield()-ing!
 [<c02d245d>] yield+0x5d/0x60 (8)
 [<c013a695>] stop_machine+0xa5/0x140 (24)
 [<c013a740>] do_stop+0x0/0x70 (32)
 [<c013a749>] do_stop+0x9/0x70 (4)
 [<c01302e5>] kthread+0xa5/0xf0 (12)
 [<c0130240>] kthread+0x0/0xf0 (16)
 [<c0100fd5>] kernel_thread_helper+0x5/0x10 (16)
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
AC'97 0 analog subsections not ready
intel8x0_measure_ac97_clock: measured 49237 usecs
intel8x0: clocking to 48000
ACPI: PCI Interrupt 0000:02:0d.0[A] -> GSI 21 (level, low) -> IRQ 21
printk: 47 messages suppressed.
BUG: kstopmachine:4131 RT task yield()-ing!
 [<c02d245d>] yield+0x5d/0x60 (8)
 [<c013a695>] stop_machine+0xa5/0x140 (24)
 [<c013a740>] do_stop+0x0/0x70 (32)
 [<c013a749>] do_stop+0x9/0x70 (4)
 [<c01302e5>] kthread+0xa5/0xf0 (12)
 [<c0130240>] kthread+0x0/0xf0 (16)
 [<c0100fd5>] kernel_thread_helper+0x5/0x10 (16)
ACPI: PCI Interrupt 0000:02:0a.0[A] -> GSI 22 (level, low) -> IRQ 22
usbcore: registered new driver snd-usb-usx2y
vt: argh, driver_data is NULL !
vt: argh, driver_data is NULL !
vt: argh, driver_data is NULL !
vt: argh, driver_data is NULL !
vt: argh, driver_data is NULL !
vt: argh, driver_data is NULL !
printk: 55 messages suppressed.
BUG: kstopmachine:6187 RT task yield()-ing!
 [<c02d245d>] yield+0x5d/0x60 (8)
 [<c013a695>] stop_machine+0xa5/0x140 (24)
 [<c013a740>] do_stop+0x0/0x70 (32)
 [<c013a749>] do_stop+0x9/0x70 (4)
 [<c01302e5>] kthread+0xa5/0xf0 (12)
 [<c0130240>] kthread+0x0/0xf0 (16)
 [<c0100fd5>] kernel_thread_helper+0x5/0x10 (16)
BUG: kstopmachine:6187 RT task yield()-ing!
 [<c02d245d>] yield+0x5d/0x60 (8)
 [<c013a695>] stop_machine+0xa5/0x140 (24)
 [<c013a740>] do_stop+0x0/0x70 (32)
 [<c013a749>] do_stop+0x9/0x70 (4)
 [<c01302e5>] kthread+0xa5/0xf0 (12)
 [<c0130240>] kthread+0x0/0xf0 (16)
 [<c0100fd5>] kernel_thread_helper+0x5/0x10 (16)
Linux agpgart interface v0.101 (c) Dave Jones
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-7167  Fri Feb 25 09:08:22 PST 2005
printk: 6 messages suppressed.
BUG: kstopmachine:6653 RT task yield()-ing!
 [<c02d245d>] yield+0x5d/0x60 (8)
 [<c013a695>] stop_machine+0xa5/0x140 (24)
 [<c013a740>] do_stop+0x0/0x70 (32)
 [<c013a749>] do_stop+0x9/0x70 (4)
 [<c01302e5>] kthread+0xa5/0xf0 (12)
 [<c0130240>] kthread+0x0/0xf0 (16)
 [<c0100fd5>] kernel_thread_helper+0x5/0x10 (16)
BUG: kstopmachine:6653 RT task yield()-ing!
 [<c02d245d>] yield+0x5d/0x60 (8)
 [<c013a695>] stop_machine+0xa5/0x140 (24)
 [<c013a740>] do_stop+0x0/0x70 (32)
 [<c013a749>] do_stop+0x9/0x70 (4)
 [<c01302e5>] kthread+0xa5/0xf0 (12)
 [<c0130240>] kthread+0x0/0xf0 (16)
 [<c0100fd5>] kernel_thread_helper+0x5/0x10 (16)
BUG: kstopmachine:6653 RT task yield()-ing!
BUG: kstopmachine:6654 RT task yield()-ing!
 [<c02d245d>] [<c02d245d>] yield+0x5d/0x60 yield+0x5d/0x60 (8)
 (8)
 [<c013a695>] [<c013a575>] stop_machine+0xa5/0x140 (24)
 stopmachine+0x95/0xe0 (24)
 [<c013a4e0>] stopmachine+0x0/0xe0 (4)
 [<c013a740>] [<c0100fd5>] do_stop+0x0/0x70 kernel_thread_helper+0x5/0x10 (32)
 [<c013a749>] (12)
 do_stop+0x9/0x70 (4)
 [<c01302e5>]<3>BUG: kstopmachine:6654 RT task yield()-ing!
 kthread+0xa5/0xf0 (12)
 [<c02d245d>] [<c0130240>] yield+0x5d/0x60 kthread+0x0/0xf0 (16)
 (8)
 [<c0100fd5>] kernel_thread_helper+0x5/0x10 (16)
 [<c013a575>] stopmachine+0x95/0xe0 (24)
 [<c013a4e0>] stopmachine+0x0/0xe0 (4)
 [<c0100fd5>] kernel_thread_helper+0x5/0x10 (12)
input: Wacom Graphire2 4x5 on usb-0000:00:1d.1-1
usbcore: registered new driver wacom
drivers/usb/input/wacom.c: v1.40:USB Wacom Graphire and Wacom Intuos tablet driver
------=_20050405200620_31823
Content-Type: application/x-gzip;
      name="config-2.6.12-rc2-RT-V0.7.44-01.0smp.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
      filename="config-2.6.12-rc2-RT-V0.7.44-01.0smp.gz"

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
ryqsMcytLNUDdqnA9/8HVhZlT/6DAAA=
------=_20050405200620_31823--


