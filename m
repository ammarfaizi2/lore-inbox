Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269424AbUIYWCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269424AbUIYWCE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 18:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269422AbUIYWCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 18:02:03 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:55988 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S269424AbUIYWBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 18:01:43 -0400
Subject: Re: 2.6.9-rc2-mm3
From: Alexander Nyberg <alexn@dsv.su.se>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040924014643.484470b1.akpm@osdl.org>
References: <20040924014643.484470b1.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1096149701.601.6.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 26 Sep 2004 00:01:42 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm3/
> 
> - This is a quick not-very-well-tested release - it can't be worse than
>   2.6.9-rc2-mm2, which had a few networking problems.
> 

Alan,

I think I've seen this reported but I haven't seen any real backtraces
yet, so I'll give you one just in case.
 
NMI output is at bottom of mail, backing out tty-driver-take-4-try-2.patch 
makes problem go away. Sorry if you already know all this.


Bootdata ok (command line is root=/dev/hda2 ro debug console=tty0 console=ttyS0,38400)
Linux version 2.6.9-rc2-mm3 (alex@boxen) (gcc version 3.4.2 (Debian 3.4.2-2)) #1 SMP Sat Sep 25 22:58:58 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
No mptable found.
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 258032 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000f6490
ACPI: XSDT (v001 A M I  OEMXSDT  0x05000410 MSFT 0x00000097) @ 0x000000003fff0100
ACPI: FADT (v001 A M I  OEMFACP  0x05000410 MSFT 0x00000097) @ 0x000000003fff0281
ACPI: MADT (v001 A M I  OEMAPIC  0x05000410 MSFT 0x00000097) @ 0x000000003fff0380
ACPI: OEMB (v001 A M I  OEMBIOS  0x05000410 MSFT 0x00000097) @ 0x000000003ffff040
ACPI: HPET (v001 A M I  OEMHPET  0x05000410 MSFT 0x00000097) @ 0x000000003fff3330
ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0x000000003fff3370
ACPI: DSDT (v001  0AAAA 0AAAA000 0x00000000 INTL 0x02002026) @ 0x0000000000000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
ACPI: HPET id: 0x102282a0 base: 0xfec01000
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hda2 ro debug console=tty0 console=ttyS0,38400
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 14.318180 MHz HPET timer.
time.c: Detected 1590.675 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 1026716k/1048512k available (1655k kernel code, 21008k reserved, 840k data, 452k init)
Calibrating delay loop... 3145.72 BogoMIPS (lpj=1572864)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU0: AMD Opteron(tm) Processor 242 stepping 01
per-CPU timeslice cutoff: 1024.17 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 rip 6000 rsp 1003ffb7f58
Initializing CPU#1
Calibrating delay loop... 3178.49 BogoMIPS (lpj=1589248)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
AMD Opteron(tm) Processor 242 stepping 01
Total of 2 processors activated (6324.22 BogoMIPS).
Using local APIC timer interrupts.
Detected 12.427 MHz APIC timer.
checking TSC synchronization across 2 CPUs: passed.
time.c: Using HPET based timekeeping.
Brought up 2 CPUs
CPU0:
 domain 0: span 3
  groups: 1 2
CPU1:
 domain 0: span 3
  groups: 2 1
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Initializing Cryptographic API
Real Time Clock Driver v1.12
hpet_acpi_add: no address or irqs in _CRS
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: ST380023A, ATA DISK drive
hdb: LITE-ON LTR-48126S, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: ST3200822A, ATA DISK drive
hdd: SAMSUNG DVD-ROM SD-616E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
hdc: max request size: 1024KiB
hdc: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
PM: Reading pmdisk image.
swsusp: Resume From Partition: /dev/hda3
<3>swsusp: Suspend partition has wrong signature?
pmdisk: Error -22 resuming
PM: Resume from disk failed.
ACPI: (supports S0 S1 S4 S5)
ACPI wakeup devices: 
PCI1 USB0 USB1 PS2K PS2M UAR1 UAR2 SMBC AC97 MODM PWRB 
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 452k freed
NMI Watchdog detected LOCKUP on CPU0, registers:
CPU 0 
Modules linked in:
Pid: 1, comm: init Tainted: MG   2.6.9-rc2-mm3
RIP: 0010:[<ffffffff8029a424>] <ffffffff8029a424>{_spin_lock_irqsave+52}
RSP: 0018:000001003ffa3c28  EFLAGS: 00000006
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 000001003fd3d440 RDI: ffffffff80339fa0
RBP: ffffffff80339fa0 R08: 000000000001c200 R09: 0000000000000004
R10: 0000002a95569000 R11: ffffffff80216130 R12: 0000000000000000
R13: 0000000000009600 R14: 000000000001c200 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff803c0a00(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000002a9572ff30 CR3: 0000000000101000 CR4: 00000000000006e0
Process init (pid: 1, threadinfo 000001003ffa2000, task 000001003ffa10f0)
Stack: 0000000000000006 000001003fd3d440 000001003fd3d440 ffffffff801fcefd 
       0000000000000046 000001003fd3d440 000001003ffa3d38 ffffffff80211f9d 
       0000000000000046 ffffffff803afb60 
Call Trace:<ffffffff801fcefd>{tty_termios_baud_rate+29} <ffffffff80211f9d>{uart_get_baud_rate+125} 
       <ffffffff802161dd>{serial8250_set_termios+173} <ffffffff802133ed>{uart_set_termios+125} 
       <ffffffff80200267>{set_termios+855} <ffffffff80131793>{__wake_up+67} 
       <ffffffff801fca81>{tty_ioctl+3393} <ffffffff80166fa1>{handle_mm_fault+369} 
       <ffffffff801d1b7d>{__up_read+29} <ffffffff8011fe0c>{do_page_fault+524} 
       <ffffffff8017235e>{filp_open+62} <ffffffff801862e0>{sys_ioctl+928} 
       <ffffffff8010f3c6>{system_call+126} 

Code: 65 48 8b 04 25 18 00 00 00 ff 88 44 e0 ff ff 65 48 8b 04 25 
console shuts up ...
  


