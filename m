Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUHULe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUHULe1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 07:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUHULe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 07:34:27 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:64435 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S261234AbUHULda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 07:33:30 -0400
Subject: 2.6.8.1-mm IRQ routing problems
From: Alexander Nyberg <alexn@telia.com>
To: linux-kernel@vger.kernel.org
Cc: bjorn.helgaas@hp.com
Content-Type: text/plain
Message-Id: <1093088008.777.13.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 21 Aug 2004 13:33:28 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.6.8.1-mm3 I ran into some problems on x86_64. This
only happens when fsck runs at bootup because in my case
of the max-mount-count being reached (I use ext3). Booting 
with pci=routeirq makes problem go away.

Do I win the weird problem prize?


Bootdata ok (command line is root=/dev/hda2 ro debug console=tty0 console=ttyS1,38400 4)
Linux version 2.6.8.1-mm3 (alex@boxen) (gcc version 3.4.1 (Debian 3.4.1-5)) #5 SMP Sat Aug 21 12:14:16 CEST 2004
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
ACPI: RSDP (v002 ACPIAM                                    ) @ 0x00000000000f6490
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
IOAPIC[0]: Assigned apic_id 2
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
Kernel command line: root=/dev/hda2 ro debug console=tty0 console=ttyS1,38400 4
PID hash table entries: 16 (order 4: 256 bytes)
time.c: Using 14.318180 MHz HPET timer.
time.c: Detected 1590.795 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 1027380k/1048512k available (1585k kernel code, 20408k reserved, 572k data, 436k init)
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
Booting processor 1/1 rip 6000 rsp 10002157f58
Initializing CPU#1
Calibrating delay loop... 3178.49 BogoMIPS (lpj=1589248)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
AMD Opteron(tm) Processor 242 stepping 01
Total of 2 processors activated (6324.22 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
Detected 12.428 MHz APIC timer.
checking TSC synchronization across 2 CPUs: passed.
time.c: Using HPET based timekeeping.
Brought up 2 CPUs
CPU0:  online
 domain 0: span 3
  groups: 1 2
CPU1:  online
 domain 0: span 3
  groups: 2 1
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040715
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
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
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
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
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
.................................... done.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Initializing Cryptographic API
Real Time Clock Driver v1.12
hpet_acpi_add: no address or irqs in _CRS
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
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: ST380023A, ATA DISK drive
hdb: LITE-ON LTR-48126S, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: ST3200822A, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
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
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 436k freed
INIT: version 2.86 booting
Setting disc parameters: done.
Activating swap.
Adding 2047740k swap on /dev/hda3.  Priority:-1 extents:1
Checking root file system...
fsck 1.35 (28-Feb-2004)
Setting the System Clock using the Hardware Clock as reference...
System Clock set. System local time is now Sat Aug 21 12:49:46 CEST 2004.
Cleaning up ifupdown...done.
Calculating module dependencies... done.
Loading modules...
    e1000
e1000: Ignoring new-style parameters in presence of obsolete ones
Intel(R) PRO/1000 Network Driver - version 5.3.19-k2-NAPI
Copyright (c) 1999-2004 Intel Corporation.
Unable to handle kernel paging request at 0000000000002000 RIP: 
<ffffffff8035f090>{add_pin_to_irq+0}
PML4 3f55d067 PGD 3f77e067 PMD 0 
Oops: 0002 [1] SMP 
CPU 0 
Modules linked in: e1000
Pid: 121, comm: modprobe Not tainted 2.6.8.1-mm3
RIP: 0010:[<ffffffff8035f090>] <ffffffff8035f090>{add_pin_to_irq+0}
RSP: 0018:000001003eff1d40  EFLAGS: 00010216
RAX: 0000000000002000 RBX: 0000000000000012 RCX: 0000000000008000
RDX: 0000000000000012 RSI: 0000000000000000 RDI: 0000000000000012
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff80232fa0 R12: 0000000000000001
R13: 0000000000000001 R14: 0000000000000012 R15: 0000000000508b70
FS:  0000002a95ac8380(0000) GS:ffffffff80351d40(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000002000 CR3: 0000000000101000 CR4: 00000000000006e0
Process modprobe (pid: 121, threadinfo 000001003eff0000, task 000001003f44aa50)
Stack: ffffffff8011ac90 0000000000010000 0000000000000046 0000000000010000 
       010000000001a900 000001003ffda200 ffffffffa00115e8 0000000000000012 
       0000000000000001 0000000000000001 
Call Trace:<ffffffff8011ac90>{io_apic_set_pci_routing+160} <ffffffff80118b68>{acpi_register_gsi+104} 
       <ffffffff801e8688>{acpi_pci_irq_enable+413} <ffffffff801cbe26>{pci_enable_device_bars+38} 
       <ffffffff801cbe55>{pci_enable_device+21} <ffffffffa001408a>{:e1000:e1000_probe+42} 
       <ffffffff80185346>{d_rehash+118} <ffffffff801cca8f>{pci_device_probe+111} 
       <ffffffff8020afd7>{bus_match+71} <ffffffff8020b0fb>{driver_attach+75} 
       <ffffffff8020b490>{bus_add_driver+144} <ffffffff801cc8ce>{pci_register_driver+62} 
       <ffffffffa001403e>{:e1000:e1000_init_module+62} <ffffffff8014abb9>{sys_init_module+281} 
       <ffffffff8010e25e>{system_call+126} 

Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
RIP <ffffffff8035f090>{add_pin_to_irq+0} RSP <000001003eff1d40>
CR2: 0000000000002000
 /etc/rcS.d/S20module-init-tools: line 34:   121 Killed          <6>8139too Fast Ethernet driver 0.9.27
        modprobe $module $args
    8139too

SysRq : Show State

                                                       sibling
  task                 PC          pid father child younger older
init          S 0000000014e927ea     0     1      0     2               (NOTLB)
0000010002143d88 0000000000000006 0000000000000001 00000000802d7ac0 
       0000010002141070 ffffffff802c8140 0000010002141378 0000000000000000 
       0000010002143e68 0000000002143db8 
Call Trace:<ffffffff802890a6>{schedule_timeout+166} <ffffffff80139ce0>{process_timeout+0} 
       <ffffffff801806cc>{do_select+988} <ffffffff80180200>{__pollwait+0} 
       <ffffffff80180a95>{sys_select+885} <ffffffff8010e25e>{system_call+126} 
       
migration/0   S 0000000000000001     0     2      1             3       (L-TLB)
000001003ff0fe98 0000000000000046 000001003eff1cc8 000000000000007c 
       0000010002140030 000001003f44a230 0000010002140338 000001003eff1cb8 
       000001003eff1cc0 0000000000000001 
Call Trace:<ffffffff8012dd18>{migration_thread+568} <ffffffff8012dae0>{migration_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145320>{kthread+0} <ffffffff8010eda7>{child_rip+0} 
       
ksoftirqd/0   S 0000000000127c05     0     3      1             4     2 (L-TLB)
000001003ff13f08 0000000000000046 ffffffff803bf4c0 000000008012b0ff 
       000001003ff110b0 ffffffff802c8140 000001003ff113b8 0000000000000001 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80135e70>{ksoftirqd+0} <ffffffff80135eb5>{ksoftirqd+69} 
       <ffffffff80135e70>{ksoftirqd+0} <ffffffff801453f9>{kthread+217} 
       <ffffffff8010edaf>{child_rip+8} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
migration/1   S 0000000000000001     0     4      1             5     3 (L-TLB)
000001003ff15e98 0000000000000046 000001003efd1cc8 0000000100000084 
       000001003ff10890 000001003f44b270 000001003ff10b98 000001003efd1cb8 
       000001003efd1cc0 0000000000000000 
Call Trace:<ffffffff8012dd18>{migration_thread+568} <ffffffff8012dae0>{migration_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145320>{kthread+0} <ffffffff8010eda7>{child_rip+0} 
       
ksoftirqd/1   S 0000010001e19420     0     5      1             6     4 (L-TLB)
000001003ff49f08 0000000000000046 ffffffff803bf4c0 000000018012b0ff 
       000001003ff10070 0000010002140850 000001003ff10378 00000000fffffffc 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80135e70>{ksoftirqd+0} <ffffffff80135eb5>{ksoftirqd+69} 
       <ffffffff80135e70>{ksoftirqd+0} <ffffffff801453f9>{kthread+217} 
       <ffffffff8010edaf>{child_rip+8} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
events/0      R  running task       0     6      1     8       7     5 (L-TLB)
events/1      S 0000000014dde0c8     0     7      1            14     6 (L-TLB)
000001003ff5fe78 0000000000000046 000001003ffae000 0000000100000246 
       000001003ff5a8d0 0000010002140850 000001003ff5abd8 0000000000000000 
       0000000000000003 0000000000000000 
Call Trace:<ffffffff801412b6>{worker_thread+278} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff801411a0>{worker_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145320>{kthread+0} <ffffffff8010eda7>{child_rip+0} 
       
khelper       S 0000000000000000     0     8      6             9       (L-TLB)
000001003ff63e78 0000000000000046 0000000000000000 000000000000008c 
       000001003ff5a0b0 0000010002141070 000001003ff5a3b8 0000000000000001 
       000001003ff60b20 0000000000010000 
Call Trace:<ffffffff801412b6>{worker_thread+278} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff801411a0>{worker_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
kacpid        S 0000000000035298     0     9      6            10     8 (L-TLB)
000001003fc77e78 0000000000000046 0000000000000000 0000000100000000 
       000001003fc75130 0000010002140850 000001003fc75438 0000000000000001 
       000001003ff602e0 0000000000010000 
Call Trace:<ffffffff801412b6>{worker_thread+278} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff801411a0>{worker_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
kblockd/0     S 000000000255c015     0    10      6            11     9 (L-TLB)
000001003fca9e78 0000000000000046 ffffffff8033f8e8 000000008033f7a0 
       000001003fc74910 ffffffff802c8140 000001003fc74c18 0000000000000000 
       0000000000000003 0000000000000000 
Call Trace:<ffffffff801412b6>{worker_thread+278} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff801411a0>{worker_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
kblockd/1     S 000000000f483edf     0    11      6            12    10 (L-TLB)
000001003fcade78 0000000000000046 ffffffff8033f8e8 000000018033f7a0 
       000001003fc740f0 0000010002140850 000001003fc743f8 0000000000000000 
       0000000000000003 0000000000000000 
Call Trace:<ffffffff801412b6>{worker_thread+278} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff801411a0>{worker_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
pdflush       S ffffffff8012b3c1     0    12      6            13    11 (L-TLB)
000001003fce1ec8 0000000000000046 ffffffff803bf4c0 0000000000000077 
       000001003fcdf170 000001003ff5b0f0 000001003fcdf478 00000000fffffffc 
       000001003ff5dec8 0000000000000000 
Call Trace:<ffffffff80154058>{pdflush+184} <ffffffff80153fa0>{pdflush+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
pdflush       S 0000000014a57d09     0    13      6            15    12 (L-TLB)
000001003fce3ec8 0000000000000046 000000000004f8d7 000000000000007a 
       000001003fcde950 ffffffff802c8140 000001003fcdec58 0000000000000000 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80154058>{pdflush+184} <ffffffff80153fa0>{pdflush+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
kswapd0       S 0000010001dc15b0     0    14      1            17     7 (L-TLB)
000001003fce7e78 0000000000000046 0000010001dc1658 000000000000007a 
       000001003fcde130 000001003f5af330 000001003fcde438 0000000000000000 
       0000000000000000 ffffffff80158f31 
Call Trace:<ffffffff80158f31>{shrink_slab+321} <ffffffff8015a509>{kswapd+249} 
       <ffffffff8012e720>{autoremove_wake_function+0} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff8015a410>{kswapd+0} <ffffffff8010eda7>{child_rip+0} 
       
aio/0         S 0000000000000000     0    15      6            16    13 (L-TLB)
000001003fcfbe78 0000000000000046 0000000000000000 000000000000007c 
       000001003fcf91b0 000001003ff5b0f0 000001003fcf94b8 0000000000000001 
       000001003fce4ba0 0000000000010000 
Call Trace:<ffffffff801412b6>{worker_thread+278} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff801411a0>{worker_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
aio/1         S 00000000000ebed4     0    16      6                  15 (L-TLB)
000001003fcfde78 0000000000000046 0000010001e11420 0000000100000002 
       000001003fcf8990 0000010002140850 000001003fcf8c98 0000000000000001 
       000001003fce4360 0000000000010000 
Call Trace:<ffffffff801412b6>{worker_thread+278} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff801411a0>{worker_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
kseriod       S 0000000000127c10     0    17      1            18    14 (L-TLB)
000001003fd2fea8 0000000000000046 0000000000000000 0000000100000000 
       000001003fcf8170 0000010002140850 000001003fcf8478 0000000000000000 
       0000000000000e00 0000000000000000 
Call Trace:<ffffffff80202d13>{serio_thread+499} <ffffffff8012e720>{autoremove_wake_function+0} 
       <ffffffff8012e720>{autoremove_wake_function+0} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80202b20>{serio_thread+0} <ffffffff8010eda7>{child_rip+0} 
       
kjournald     S 00000000112725be     0    18      1            19    17 (L-TLB)
000001003fdcde58 0000000000000046 000001003f4c7558 000000003f4c7558 
       000001003fdcb1f0 ffffffff802c8140 000001003fdcb4f8 0000000000000000 
       0000000000000003 0000000000000000 
Call Trace:<ffffffff801bb5c4>{kjournald+532} <ffffffff8012e720>{autoremove_wake_function+0} 
       <ffffffff8012e720>{autoremove_wake_function+0} <ffffffff801bb390>{commit_timeout+0} 
       <ffffffff8010edaf>{child_rip+8} <ffffffff801bb3b0>{kjournald+0} 
       <ffffffff8010eda7>{child_rip+0} 
init          S 00000000003a9795     0    19      1    20            18 (NOTLB)
000001003fa53e78 0000000000000002 0000000000000206 000000003fdc0250 
       000001003fdca9d0 ffffffff802c8140 000001003fdcacd8 0000000000000000 
       0000000000508158 ffffffff8011c5b8 
Call Trace:<ffffffff8011c5b8>{do_page_fault+472} <ffffffff8012b0ff>{task_rq_lock+79} 
       <ffffffff80134a89>{do_wait+3193} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8013dcb1>{sys_rt_sigaction+113} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8010e25e>{system_call+126} 
rcS           S 000000000f48cb33     0    20     19   116               (NOTLB)
000001003fa55e78 0000000000000006 0000000000000206 000000013f975a70 
       000001003fdca1b0 0000010002140850 000001003fdca4b8 0000000000000000 
       00000000005bbce4 ffffffff8011c5b8 
Call Trace:<ffffffff8011c5b8>{do_page_fault+472} <ffffffff8012b0ff>{task_rq_lock+79} 
       <ffffffff80134a89>{do_wait+3193} <ffffffff8013d788>{do_sigaction+136} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff8013dcd4>{sys_rt_sigaction+148} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff8010e25e>{system_call+126} 
       
S20module-ini S 000000000f4a0c9e     0   116     20   120               (NOTLB)
0000010002173e78 0000000000000002 0000000000000206 0000000100000202 
       000001003f44b270 0000010002140850 000001003f44b578 0000000000000000 
       000001003f6d1aa4 0000000000000212 
Call Trace:<ffffffff80134a89>{do_wait+3193} <ffffffff8013d788>{do_sigaction+136} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff8013dcd4>{sys_rt_sigaction+148} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff8010e25e>{system_call+126} 
       
S20module-ini S 000000000f55367b     0   120    116   122               (NOTLB)
000001003f6c7e78 0000000000000006 0000000000000206 000000003f4c95d8 
       000001003f44a230 ffffffff802c8140 000001003f44a538 0000000000000000 
       00000000005c3250 ffffffff8011c5b8 
Call Trace:<ffffffff8011c5b8>{do_page_fault+472} <ffffffff8012b0ff>{task_rq_lock+79} 
       <ffffffff80134a89>{do_wait+3193} <ffffffff8013d788>{do_sigaction+136} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff8013dcd4>{sys_rt_sigaction+148} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff8010e25e>{system_call+126} 
       
modprobe      D 000000000f55a052     0   122    120                     (NOTLB)
000001003eff1e78 0000000000000006 0000000000002e86 0000000000002e86 
       000001003f44aa50 ffffffff802c8140 000001003f44ad58 0000000000000000 
       ffffffff803289c7 0000000000000027 
Call Trace:<ffffffff80289200>{__down_write+128} <ffffffff801c674c>{kobject_add+92} 
       <ffffffff801c6878>{kobject_register+40} <ffffffff8020b464>{bus_add_driver+100} 
       <ffffffff801cc8ce>{pci_register_driver+62} <ffffffffa00238ce>{:8139too:rtl8139_init_module+30} 
       <ffffffff8014abb9>{sys_init_module+281} <ffffffff8010e25e>{system_call+126} 
       
SysRq : Show State

                                                       sibling
  task                 PC          pid father child younger older
init          S 0000000014e927ea     0     1      0     2               (NOTLB)
0000010002143d88 0000000000000006 0000000000000001 00000000802d7ac0 
       0000010002141070 ffffffff802c8140 0000010002141378 0000000000000000 
       0000010002143e68 0000000002143db8 
Call Trace:<ffffffff802890a6>{schedule_timeout+166} <ffffffff80139ce0>{process_timeout+0} 
       <ffffffff801806cc>{do_select+988} <ffffffff80180200>{__pollwait+0} 
       <ffffffff80180a95>{sys_select+885} <ffffffff8010e25e>{system_call+126} 
       
migration/0   S 0000000000000001     0     2      1             3       (L-TLB)
000001003ff0fe98 0000000000000046 000001003eff1cc8 000000000000007c 
       0000010002140030 000001003f44a230 0000010002140338 000001003eff1cb8 
       000001003eff1cc0 0000000000000001 
Call Trace:<ffffffff8012dd18>{migration_thread+568} <ffffffff8012dae0>{migration_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145320>{kthread+0} <ffffffff8010eda7>{child_rip+0} 
       
ksoftirqd/0   S 0000000000127c05     0     3      1             4     2 (L-TLB)
000001003ff13f08 0000000000000046 ffffffff803bf4c0 000000008012b0ff 
       000001003ff110b0 ffffffff802c8140 000001003ff113b8 0000000000000001 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80135e70>{ksoftirqd+0} <ffffffff80135eb5>{ksoftirqd+69} 
       <ffffffff80135e70>{ksoftirqd+0} <ffffffff801453f9>{kthread+217} 
       <ffffffff8010edaf>{child_rip+8} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
migration/1   S 0000000000000001     0     4      1             5     3 (L-TLB)
000001003ff15e98 0000000000000046 000001003efd1cc8 0000000100000084 
       000001003ff10890 000001003f44b270 000001003ff10b98 000001003efd1cb8 
       000001003efd1cc0 0000000000000000 
Call Trace:<ffffffff8012dd18>{migration_thread+568} <ffffffff8012dae0>{migration_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145320>{kthread+0} <ffffffff8010eda7>{child_rip+0} 
       
ksoftirqd/1   S 0000010001e19420     0     5      1             6     4 (L-TLB)
000001003ff49f08 0000000000000046 ffffffff803bf4c0 000000018012b0ff 
       000001003ff10070 0000010002140850 000001003ff10378 00000000fffffffc 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80135e70>{ksoftirqd+0} <ffffffff80135eb5>{ksoftirqd+69} 
       <ffffffff80135e70>{ksoftirqd+0} <ffffffff801453f9>{kthread+217} 
       <ffffffff8010edaf>{child_rip+8} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
events/0      R  running task       0     6      1     8       7     5 (L-TLB)
events/1      S 000000001524fd5d     0     7      1            14     6 (L-TLB)
000001003ff5fe78 0000000000000046 000001003ffae000 0000000100000246 
       000001003ff5a8d0 0000010002140850 000001003ff5abd8 0000000000000000 
       0000000000000003 0000000000000000 
Call Trace:<ffffffff801412b6>{worker_thread+278} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff801411a0>{worker_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145320>{kthread+0} <ffffffff8010eda7>{child_rip+0} 
       
khelper       S 0000000000000000     0     8      6             9       (L-TLB)
000001003ff63e78 0000000000000046 0000000000000000 000000000000008c 
       000001003ff5a0b0 0000010002141070 000001003ff5a3b8 0000000000000001 
       000001003ff60b20 0000000000010000 
Call Trace:<ffffffff801412b6>{worker_thread+278} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff801411a0>{worker_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
kacpid        S 0000000000035298     0     9      6            10     8 (L-TLB)
000001003fc77e78 0000000000000046 0000000000000000 0000000100000000 
       000001003fc75130 0000010002140850 000001003fc75438 0000000000000001 
       000001003ff602e0 0000000000010000 
Call Trace:<ffffffff801412b6>{worker_thread+278} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff801411a0>{worker_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
kblockd/0     S 000000000255c015     0    10      6            11     9 (L-TLB)
000001003fca9e78 0000000000000046 ffffffff8033f8e8 000000008033f7a0 
       000001003fc74910 ffffffff802c8140 000001003fc74c18 0000000000000000 
       0000000000000003 0000000000000000 
Call Trace:<ffffffff801412b6>{worker_thread+278} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff801411a0>{worker_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
kblockd/1     S 000000000f483edf     0    11      6            12    10 (L-TLB)
000001003fcade78 0000000000000046 ffffffff8033f8e8 000000018033f7a0 
       000001003fc740f0 0000010002140850 000001003fc743f8 0000000000000000 
       0000000000000003 0000000000000000 
Call Trace:<ffffffff801412b6>{worker_thread+278} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff801411a0>{worker_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
pdflush       S ffffffff8012b3c1     0    12      6            13    11 (L-TLB)
000001003fce1ec8 0000000000000046 ffffffff803bf4c0 0000000000000077 
       000001003fcdf170 000001003ff5b0f0 000001003fcdf478 00000000fffffffc 
       000001003ff5dec8 0000000000000000 
Call Trace:<ffffffff80154058>{pdflush+184} <ffffffff80153fa0>{pdflush+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
pdflush       S 000000001524fb99     0    13      6            15    12 (L-TLB)
000001003fce3ec8 0000000000000046 0000000000051a41 000000000000007a 
       000001003fcde950 ffffffff802c8140 000001003fcdec58 0000000000000000 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80154058>{pdflush+184} <ffffffff80153fa0>{pdflush+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
kswapd0       S 0000010001dc15b0     0    14      1            17     7 (L-TLB)
000001003fce7e78 0000000000000046 0000010001dc1658 000000000000007a 
       000001003fcde130 000001003f5af330 000001003fcde438 0000000000000000 
       0000000000000000 ffffffff80158f31 
Call Trace:<ffffffff80158f31>{shrink_slab+321} <ffffffff8015a509>{kswapd+249} 
       <ffffffff8012e720>{autoremove_wake_function+0} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff8015a410>{kswapd+0} <ffffffff8010eda7>{child_rip+0} 
       
aio/0         S 0000000000000000     0    15      6            16    13 (L-TLB)
000001003fcfbe78 0000000000000046 0000000000000000 000000000000007c 
       000001003fcf91b0 000001003ff5b0f0 000001003fcf94b8 0000000000000001 
       000001003fce4ba0 0000000000010000 
Call Trace:<ffffffff801412b6>{worker_thread+278} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff801411a0>{worker_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
aio/1         S 00000000000ebed4     0    16      6                  15 (L-TLB)
000001003fcfde78 0000000000000046 0000010001e11420 0000000100000002 
       000001003fcf8990 0000010002140850 000001003fcf8c98 0000000000000001 
       000001003fce4360 0000000000010000 
Call Trace:<ffffffff801412b6>{worker_thread+278} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff801411a0>{worker_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
kseriod       S 0000000000127c10     0    17      1            18    14 (L-TLB)
000001003fd2fea8 0000000000000046 0000000000000000 0000000100000000 
       000001003fcf8170 0000010002140850 000001003fcf8478 0000000000000000 
       0000000000000e00 0000000000000000 
Call Trace:<ffffffff80202d13>{serio_thread+499} <ffffffff8012e720>{autoremove_wake_function+0} 
       <ffffffff8012e720>{autoremove_wake_function+0} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80202b20>{serio_thread+0} <ffffffff8010eda7>{child_rip+0} 
       
kjournald     S 00000000112725be     0    18      1            19    17 (L-TLB)
000001003fdcde58 0000000000000046 000001003f4c7558 000000003f4c7558 
       000001003fdcb1f0 ffffffff802c8140 000001003fdcb4f8 0000000000000000 
       0000000000000003 0000000000000000 
Call Trace:<ffffffff801bb5c4>{kjournald+532} <ffffffff8012e720>{autoremove_wake_function+0} 
       <ffffffff8012e720>{autoremove_wake_function+0} <ffffffff801bb390>{commit_timeout+0} 
       <ffffffff8010edaf>{child_rip+8} <ffffffff801bb3b0>{kjournald+0} 
       <ffffffff8010eda7>{child_rip+0} 
init          S 00000000003a9795     0    19      1    20            18 (NOTLB)
000001003fa53e78 0000000000000002 0000000000000206 000000003fdc0250 
       000001003fdca9d0 ffffffff802c8140 000001003fdcacd8 0000000000000000 
       0000000000508158 ffffffff8011c5b8 
Call Trace:<ffffffff8011c5b8>{do_page_fault+472} <ffffffff8012b0ff>{task_rq_lock+79} 
       <ffffffff80134a89>{do_wait+3193} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8013dcb1>{sys_rt_sigaction+113} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8010e25e>{system_call+126} 
rcS           S 000000000f48cb33     0    20     19   116               (NOTLB)
000001003fa55e78 0000000000000006 0000000000000206 000000013f975a70 
       000001003fdca1b0 0000010002140850 000001003fdca4b8 0000000000000000 
       00000000005bbce4 ffffffff8011c5b8 
Call Trace:<ffffffff8011c5b8>{do_page_fault+472} <ffffffff8012b0ff>{task_rq_lock+79} 
       <ffffffff80134a89>{do_wait+3193} <ffffffff8013d788>{do_sigaction+136} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff8013dcd4>{sys_rt_sigaction+148} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff8010e25e>{system_call+126} 
       
S20module-ini S 000000000f4a0c9e     0   116     20   120               (NOTLB)
0000010002173e78 0000000000000002 0000000000000206 0000000100000202 
       000001003f44b270 0000010002140850 000001003f44b578 0000000000000000 
       000001003f6d1aa4 0000000000000212 
Call Trace:<ffffffff80134a89>{do_wait+3193} <ffffffff8013d788>{do_sigaction+136} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff8013dcd4>{sys_rt_sigaction+148} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff8010e25e>{system_call+126} 
       
S20module-ini S 000000000f55367b     0   120    116   122               (NOTLB)
000001003f6c7e78 0000000000000006 0000000000000206 000000003f4c95d8 
       000001003f44a230 ffffffff802c8140 000001003f44a538 0000000000000000 
       00000000005c3250 ffffffff8011c5b8 
Call Trace:<ffffffff8011c5b8>{do_page_fault+472} <ffffffff8012b0ff>{task_rq_lock+79} 
       <ffffffff80134a89>{do_wait+3193} <ffffffff8013d788>{do_sigaction+136} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff8013dcd4>{sys_rt_sigaction+148} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff8010e25e>{system_call+126} 
       
modprobe      D 000000000f55a052     0   122    120                     (NOTLB)
000001003eff1e78 0000000000000006 0000000000002e86 0000000000002e86 
       000001003f44aa50 ffffffff802c8140 000001003f44ad58 0000000000000000 
       ffffffff803289c7 0000000000000027 
Call Trace:<ffffffff80289200>{__down_write+128} <ffffffff801c674c>{kobject_add+92} 
       <ffffffff801c6878>{kobject_register+40} <ffffffff8020b464>{bus_add_driver+100} 
       <ffffffff801cc8ce>{pci_register_driver+62} <ffffffffa00238ce>{:8139too:rtl8139_init_module+30} 
       <ffffffff8014abb9>{sys_init_module+281} <ffffffff8010e25e>{system_call+126} 
       
SysRq : Show State

                                                       sibling
  task                 PC          pid father child younger older
init          S 000000001568db31     0     1      0     2               (NOTLB)
0000010002143d88 0000000000000006 0000000000000001 00000000802d7ac0 
       0000010002141070 ffffffff802c8140 0000010002141378 0000000000000000 
       0000010002143e68 0000000002143db8 
Call Trace:<ffffffff802890a6>{schedule_timeout+166} <ffffffff80139ce0>{process_timeout+0} 
       <ffffffff801806cc>{do_select+988} <ffffffff80180200>{__pollwait+0} 
       <ffffffff80180a95>{sys_select+885} <ffffffff8010e25e>{system_call+126} 
       
migration/0   S 0000000000000001     0     2      1             3       (L-TLB)
000001003ff0fe98 0000000000000046 000001003eff1cc8 000000000000007c 
       0000010002140030 000001003f44a230 0000010002140338 000001003eff1cb8 
       000001003eff1cc0 0000000000000001 
Call Trace:<ffffffff8012dd18>{migration_thread+568} <ffffffff8012dae0>{migration_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145320>{kthread+0} <ffffffff8010eda7>{child_rip+0} 
       
ksoftirqd/0   S 0000000000127c05     0     3      1             4     2 (L-TLB)
000001003ff13f08 0000000000000046 ffffffff803bf4c0 000000008012b0ff 
       000001003ff110b0 ffffffff802c8140 000001003ff113b8 0000000000000001 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80135e70>{ksoftirqd+0} <ffffffff80135eb5>{ksoftirqd+69} 
       <ffffffff80135e70>{ksoftirqd+0} <ffffffff801453f9>{kthread+217} 
       <ffffffff8010edaf>{child_rip+8} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
migration/1   S 0000000000000001     0     4      1             5     3 (L-TLB)
000001003ff15e98 0000000000000046 000001003efd1cc8 0000000100000084 
       000001003ff10890 000001003f44b270 000001003ff10b98 000001003efd1cb8 
       000001003efd1cc0 0000000000000000 
Call Trace:<ffffffff8012dd18>{migration_thread+568} <ffffffff8012dae0>{migration_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145320>{kthread+0} <ffffffff8010eda7>{child_rip+0} 
       
ksoftirqd/1   S 0000010001e19420     0     5      1             6     4 (L-TLB)
000001003ff49f08 0000000000000046 ffffffff803bf4c0 000000018012b0ff 
       000001003ff10070 0000010002140850 000001003ff10378 00000000fffffffc 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80135e70>{ksoftirqd+0} <ffffffff80135eb5>{ksoftirqd+69} 
       <ffffffff80135e70>{ksoftirqd+0} <ffffffff801453f9>{kthread+217} 
       <ffffffff8010edaf>{child_rip+8} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
events/0      R  running task       0     6      1     8       7     5 (L-TLB)
events/1      S 000000001568dda7     0     7      1            14     6 (L-TLB)
000001003ff5fe78 0000000000000046 000001003ffae000 0000000100000246 
       000001003ff5a8d0 0000010002140850 000001003ff5abd8 0000000000000000 
       0000000000000003 0000000000000000 
Call Trace:<ffffffff801412b6>{worker_thread+278} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff801411a0>{worker_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145320>{kthread+0} <ffffffff8010eda7>{child_rip+0} 
       
khelper       S 0000000000000000     0     8      6             9       (L-TLB)
000001003ff63e78 0000000000000046 0000000000000000 000000000000008c 
       000001003ff5a0b0 0000010002141070 000001003ff5a3b8 0000000000000001 
       000001003ff60b20 0000000000010000 
Call Trace:<ffffffff801412b6>{worker_thread+278} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff801411a0>{worker_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
kacpid        S 0000000000035298     0     9      6            10     8 (L-TLB)
000001003fc77e78 0000000000000046 0000000000000000 0000000100000000 
       000001003fc75130 0000010002140850 000001003fc75438 0000000000000001 
       000001003ff602e0 0000000000010000 
Call Trace:<ffffffff801412b6>{worker_thread+278} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff801411a0>{worker_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
kblockd/0     S 000000000255c015     0    10      6            11     9 (L-TLB)
000001003fca9e78 0000000000000046 ffffffff8033f8e8 000000008033f7a0 
       000001003fc74910 ffffffff802c8140 000001003fc74c18 0000000000000000 
       0000000000000003 0000000000000000 
Call Trace:<ffffffff801412b6>{worker_thread+278} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff801411a0>{worker_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
kblockd/1     S 000000000f483edf     0    11      6            12    10 (L-TLB)
000001003fcade78 0000000000000046 ffffffff8033f8e8 000000018033f7a0 
       000001003fc740f0 0000010002140850 000001003fc743f8 0000000000000000 
       0000000000000003 0000000000000000 
Call Trace:<ffffffff801412b6>{worker_thread+278} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff801411a0>{worker_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
pdflush       S ffffffff8012b3c1     0    12      6            13    11 (L-TLB)
000001003fce1ec8 0000000000000046 ffffffff803bf4c0 0000000000000077 
       000001003fcdf170 000001003ff5b0f0 000001003fcdf478 00000000fffffffc 
       000001003ff5dec8 0000000000000000 
Call Trace:<ffffffff80154058>{pdflush+184} <ffffffff80153fa0>{pdflush+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
pdflush       S 00000000156f858b     0    13      6            15    12 (L-TLB)
000001003fce3ec8 0000000000000046 0000000000052dc9 000000000000007a 
       000001003fcde950 ffffffff802c8140 000001003fcdec58 0000000000000000 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80154058>{pdflush+184} <ffffffff80153fa0>{pdflush+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
kswapd0       S 0000010001dc15b0     0    14      1            17     7 (L-TLB)
000001003fce7e78 0000000000000046 0000010001dc1658 000000000000007a 
       000001003fcde130 000001003f5af330 000001003fcde438 0000000000000000 
       0000000000000000 ffffffff80158f31 
Call Trace:<ffffffff80158f31>{shrink_slab+321} <ffffffff8015a509>{kswapd+249} 
       <ffffffff8012e720>{autoremove_wake_function+0} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff8015a410>{kswapd+0} <ffffffff8010eda7>{child_rip+0} 
       
aio/0         S 0000000000000000     0    15      6            16    13 (L-TLB)
000001003fcfbe78 0000000000000046 0000000000000000 000000000000007c 
       000001003fcf91b0 000001003ff5b0f0 000001003fcf94b8 0000000000000001 
       000001003fce4ba0 0000000000010000 
Call Trace:<ffffffff801412b6>{worker_thread+278} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff801411a0>{worker_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
aio/1         S 00000000000ebed4     0    16      6                  15 (L-TLB)
000001003fcfde78 0000000000000046 0000010001e11420 0000000100000002 
       000001003fcf8990 0000010002140850 000001003fcf8c98 0000000000000001 
       000001003fce4360 0000000000010000 
Call Trace:<ffffffff801412b6>{worker_thread+278} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff801411a0>{worker_thread+0} 
       <ffffffff801453f9>{kthread+217} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80145440>{keventd_create_kthread+0} <ffffffff80145320>{kthread+0} 
       <ffffffff8010eda7>{child_rip+0} 
kseriod       S 0000000000127c10     0    17      1            18    14 (L-TLB)
000001003fd2fea8 0000000000000046 0000000000000000 0000000100000000 
       000001003fcf8170 0000010002140850 000001003fcf8478 0000000000000000 
       0000000000000e00 0000000000000000 
Call Trace:<ffffffff80202d13>{serio_thread+499} <ffffffff8012e720>{autoremove_wake_function+0} 
       <ffffffff8012e720>{autoremove_wake_function+0} <ffffffff8010edaf>{child_rip+8} 
       <ffffffff80202b20>{serio_thread+0} <ffffffff8010eda7>{child_rip+0} 
       
kjournald     S 00000000112725be     0    18      1            19    17 (L-TLB)
000001003fdcde58 0000000000000046 000001003f4c7558 000000003f4c7558 
       000001003fdcb1f0 ffffffff802c8140 000001003fdcb4f8 0000000000000000 
       0000000000000003 0000000000000000 
Call Trace:<ffffffff801bb5c4>{kjournald+532} <ffffffff8012e720>{autoremove_wake_function+0} 
       <ffffffff8012e720>{autoremove_wake_function+0} <ffffffff801bb390>{commit_timeout+0} 
       <ffffffff8010edaf>{child_rip+8} <ffffffff801bb3b0>{kjournald+0} 
       <ffffffff8010eda7>{child_rip+0} 
init          S 00000000003a9795     0    19      1    20            18 (NOTLB)
000001003fa53e78 0000000000000002 0000000000000206 000000003fdc0250 
       000001003fdca9d0 ffffffff802c8140 000001003fdcacd8 0000000000000000 
       0000000000508158 ffffffff8011c5b8 
Call Trace:<ffffffff8011c5b8>{do_page_fault+472} <ffffffff8012b0ff>{task_rq_lock+79} 
       <ffffffff80134a89>{do_wait+3193} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8013dcb1>{sys_rt_sigaction+113} <ffffffff8012cbf0>{default_wake_function+0} 
       <ffffffff8010e25e>{system_call+126} 
rcS           S 000000000f48cb33     0    20     19   116               (NOTLB)
000001003fa55e78 0000000000000006 0000000000000206 000000013f975a70 
       000001003fdca1b0 0000010002140850 000001003fdca4b8 0000000000000000 
       00000000005bbce4 ffffffff8011c5b8 
Call Trace:<ffffffff8011c5b8>{do_page_fault+472} <ffffffff8012b0ff>{task_rq_lock+79} 
       <ffffffff80134a89>{do_wait+3193} <ffffffff8013d788>{do_sigaction+136} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff8013dcd4>{sys_rt_sigaction+148} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff8010e25e>{system_call+126} 
       
S20module-ini S 000000000f4a0c9e     0   116     20   120               (NOTLB)
0000010002173e78 0000000000000002 0000000000000206 0000000100000202 
       000001003f44b270 0000010002140850 000001003f44b578 0000000000000000 
       000001003f6d1aa4 0000000000000212 
Call Trace:<ffffffff80134a89>{do_wait+3193} <ffffffff8013d788>{do_sigaction+136} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff8013dcd4>{sys_rt_sigaction+148} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff8010e25e>{system_call+126} 
       
S20module-ini S 000000000f55367b     0   120    116   122               (NOTLB)
000001003f6c7e78 0000000000000006 0000000000000206 000000003f4c95d8 
       000001003f44a230 ffffffff802c8140 000001003f44a538 0000000000000000 
       00000000005c3250 ffffffff8011c5b8 
Call Trace:<ffffffff8011c5b8>{do_page_fault+472} <ffffffff8012b0ff>{task_rq_lock+79} 
       <ffffffff80134a89>{do_wait+3193} <ffffffff8013d788>{do_sigaction+136} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff8013dcd4>{sys_rt_sigaction+148} 
       <ffffffff8012cbf0>{default_wake_function+0} <ffffffff8010e25e>{system_call+126} 
       
modprobe      D 000000000f55a052     0   122    120                     (NOTLB)
000001003eff1e78 0000000000000006 0000000000002e86 0000000000002e86 
       000001003f44aa50 ffffffff802c8140 000001003f44ad58 0000000000000000 
       ffffffff803289c7 0000000000000027 
Call Trace:<ffffffff80289200>{__down_write+128} <ffffffff801c674c>{kobject_add+92} 
       <ffffffff801c6878>{kobject_register+40} <ffffffff8020b464>{bus_add_driver+100} 
       <ffffffff801cc8ce>{pci_register_driver+62} <ffffffffa00238ce>{:8139too:rtl8139_init_module+30} 
       <ffffffff8014abb9>{sys_init_module+281} <ffffffff8010e25e>{system_call+126} 
       
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.8.1-mm3
# Sat Aug 21 11:50:28 2004
#
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=15
# CONFIG_HOTPLUG is not set
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
# CONFIG_CPUSETS is not set
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Processor type and features
#
CONFIG_MK8=y
# CONFIG_MPSC is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_L1_CACHE_BYTES=64
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_SMP=y
# CONFIG_PREEMPT is not set
# CONFIG_SCHED_SMT is not set
# CONFIG_K8_NUMA is not set
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NR_CPUS=2
# CONFIG_GART_IOMMU is not set
CONFIG_DUMMY_IOMMU=y
CONFIG_X86_MCE=y

#
# Performance-monitoring counters support
#
# CONFIG_PERFCTR is not set

#
# Power management options
#
# CONFIG_PM is not set
# CONFIG_PM_DEBUG is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
# CONFIG_ACPI_FAN is not set
# CONFIG_ACPI_PROCESSOR is not set
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_UNORDERED_IO is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_IA32_EMULATION=y
CONFIG_IA32_AOUT=y
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_UID16=y

<snip>

