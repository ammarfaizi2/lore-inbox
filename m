Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161242AbWF0SR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161242AbWF0SR3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161248AbWF0SR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:17:28 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:34737 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S1161242AbWF0SRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:17:25 -0400
From: Foli Ayivoh <it21@arcor.de>
Reply-To: 101551.753@compuserve.com
To: lkml <linux-kernel@vger.kernel.org>
Subject: Problems with [USB] on Kernel 2.6.x [2/3]
Date: Tue, 27 Jun 2006 20:19:16 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606272019.17233.it21@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dmesg

Linux version 2.6.17-mm3-default (testit@ktsthost) (gcc version 4.1.0 (SUSE Linux)) #1 Tue Jun 27 18:16:34 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.2 present.
ACPI: RSDP (v000 Nvidia                                ) @ 0x000f75e0
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff7640
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Detected 2205.063 MHz processor.
Built 1 zonelists.  Total pages: 262128
Kernel command line: root=/dev/sdc2 vga=795  splash=verbose   resume=/dev/sdc1  splash=verbose
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour dummy device 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      8192
... CHAINHASH_SIZE:          4096
 memory used by lock dependency info: 696 kB
 per task-struct memory footprint: 1200 bytes
------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |
  --------------------------------------------------------------------------
                     A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                    double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                  initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
  --------------------------------------------------------------------------
              recursive read-lock:             |  ok  |             |  ok  |
           recursive read-lock #2:             |  ok  |             |  ok  |
            mixed read-write-lock:             |  ok  |             |  ok  |
            mixed write-read-lock:             |  ok  |             |  ok  |
  --------------------------------------------------------------------------
     hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
       sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
       sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
      hard-irq read-recursion/123:  ok  |
      soft-irq read-recursion/123:  ok  |
      hard-irq read-recursion/132:  ok  |
      soft-irq read-recursion/132:  ok  |
      hard-irq read-recursion/213:  ok  |
      soft-irq read-recursion/213:  ok  |
      hard-irq read-recursion/231:  ok  |
      soft-irq read-recursion/231:  ok  |
      hard-irq read-recursion/312:  ok  |
      soft-irq read-recursion/312:  ok  |
      hard-irq read-recursion/321:  ok  |
      soft-irq read-recursion/321:  ok  |
-------------------------------------------------------
Good, all 218 testcases passed! |
---------------------------------
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1030896k/1048512k available (1767k kernel code, 16800k reserved, 1026k data, 192k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4414.57 BogoMIPS (lpj=8829157)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000420 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: AMD Athlon(tm) XP 3200+ stepping 00
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ACPI: Core revision 20060608
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=0 apic2=-1 pin2=-1
checking if image is initramfs... it is
Freeing initrd memory: 2663k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb410, last bus=3
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: nForce2 C1 Halt Disconnect fixup
Boot video device is 0000:03:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
pnp: 00:00: ioport range 0x4000-0x407f could not be reserved
pnp: 00:00: ioport range 0x4080-0x40ff has been reserved
pnp: 00:00: ioport range 0x4400-0x447f has been reserved
pnp: 00:00: ioport range 0x4480-0x44ff could not be reserved
pnp: 00:00: ioport range 0x4200-0x427f has been reserved
pnp: 00:00: ioport range 0x4280-0x42ff has been reserved
pnp: 00:01: ioport range 0x5000-0x503f has been reserved
pnp: 00:01: ioport range 0x5500-0x553f has been reserved
PCI: Bridge: 0000:00:08.0
  IO window: 7000-afff
  MEM window: eb000000-ecffffff
  PREFETCH window: 50000000-500fffff
PCI: Bridge: 0000:00:1e.0
  IO window: c000-cfff
  MEM window: e9000000-eaffffff
  PREFETCH window: c0000000-dfffffff
PCI: Setting latency timer of device 0000:00:08.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 32768 (order: 9, 3145728 bytes)
TCP bind hash table entries: 16384 (order: 8, 1638400 bytes)
TCP: Hash tables configured (established 32768 bind 16384)
TCP reno registered
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
Initializing RT-Tester: OK
audit: initializing netlink socket (disabled)
audit(1151426841.844:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
vesafb: framebuffer at 0xc0000000, mapped to 0xf8880000, using 7680k, total 16384k
vesafb: mode is 1280x1024x24, linelength=3840, pages=3
vesafb: protected mode interface info at c000:5824
vesafb: pmi: set display start = c00c58b8, set palette = c00c5904
vesafb: pmi: ports = c010 c016 c054 c038 c03c c05c c000 c004 c0b0 c0b2 c0b4 
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
imacfb: framebuffer at 0x80010000, mapped to 0xf9080000, using 14175k, total 16384k
imacfb: mode is 1680x1050x32, linelength=6912, pages=1
imacfb: scrolling: redraw
imacfb: Truecolor: size=8:8:8:8, shift=24:16:8:0
fb1: IMAC VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
iTCO_wdt: No card detected
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0b: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
raid6: int32x1    755 MB/s
raid6: int32x2    868 MB/s
raid6: int32x4    755 MB/s
raid6: int32x8    573 MB/s
raid6: mmxx1     1784 MB/s
raid6: mmxx2     2805 MB/s
raid6: sse1x1    1665 MB/s
raid6: sse1x2    2640 MB/s
raid6: using algorithm sse1x2 (2640 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  5802.000 MB/sec
raid5: using function: pIII_sse (5802.000 MB/sec)
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP watch registered (port=0)
TCP veno registered
TCP lp registered
TCP compound registered
NET: Registered protocol family 1
Using IPI Shortcut mode
ACPI: (supports S0 S1 S3 S4 S5)
Time: tsc clocksource has been installed.
/home/testit/kernel-source/linux-2.6.17/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Freeing unused kernel memory: 192k freed
Write protecting the kernel read-only data: 396k
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SCSI subsystem initialized
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: TOSHIBA CD-ROM XM-6702B, ATAPI CD/DVD-ROM drive
hdb: YAMAHA CRW-F1E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Pioneer DVD-ROM ATAPIModel DVD-106S 012, ATAPI CD/DVD-ROM drive
hdd: PLEXTOR DVDR PX-716AL, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
libata version 1.30 loaded.
sata_sil 0000:01:0b.0: version 1.0
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [APC3] -> GSI 18 (level, high) -> IRQ 177
ata1: SATA max UDMA/100 cmd 0xF8828080 ctl 0xF882808A bmdma 0xF8828000 irq 177
ata2: SATA max UDMA/100 cmd 0xF88280C0 ctl 0xF88280CA bmdma 0xF8828008 irq 177
scsi0 : sata_sil
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/100
scsi1 : sata_sil
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: configured for UDMA/100
  Vendor: ATA       Model: WDC WD1500ADFD-0  Rev: 20.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 293046768 512-byte hdwr sectors (150040 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 293046768 512-byte hdwr sectors (150040 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1
sd 0:0:0:0: Attached scsi disk sda
  Vendor: ATA       Model: WDC WD1500ADFD-0  Rev: 20.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
sd 0:0:0:0: Attached scsi generic sg0 type 0
SCSI device sdb: 293046768 512-byte hdwr sectors (150040 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 293046768 512-byte hdwr sectors (150040 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
sd 1:0:0:0: Attached scsi generic sg1 type 0
HPT372N: IDE controller at PCI slot 0000:01:0a.0
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI Interrupt 0000:01:0a.0[A] -> Link [APC1] -> GSI 16 (level, high) -> IRQ 185
HPT372N: chipset revision 2
HPT372N: 100% native mode on irq 185
HPT372N: FREQ: 81, PLL: 35
HPT372N: using 50MHz internal PLL
    ide2: BM-DMA at 0x8c00-0x8c07, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0x8c08-0x8c0f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: WDC WD800BB-00CAA1, ATA DISK drive
hdf: WDC WD800BB-00BSA0, ATA DISK drive
ide2 at 0x7c00-0x7c07,0x8002 on irq 185
hde: max request size: 128KiB
hde: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hde: cache flushes not supported
 hde: hde1
hdf: max request size: 128KiB
hdf: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hdf: cache flushes not supported
 hdf: hdf1
Probing IDE interface ide3...
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [APCL] -> GSI 22 (level, high) -> IRQ 193
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: EHCI Host Controller
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.2: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: irq 193, io mem 0xed083000
ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.17-mm3-default ehci_hcd
usb usb1: SerialNumber: 0000:00:02.2
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2006 May 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 21 (level, high) -> IRQ 201
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 201, io mem 0xed087000
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.17-mm3-default ohci_hcd
usb usb2: SerialNumber: 0000:00:02.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCG] -> GSI 20 (level, high) -> IRQ 209
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: OHCI Host Controller
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:02.1: irq 209, io mem 0xed082000
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: OHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.17-mm3-default ohci_hcd
usb usb3: SerialNumber: 0000:00:02.1
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
usb 1-2: new high speed USB device using ehci_hcd and address 3
Initializing USB Mass Storage driver...
usb 1-2: new device found, idVendor=050d, idProduct=0237
usb 1-2: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-2: configuration #1 chosen from 1 choice
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 7 ports detected
usb 2-1: new full speed USB device using ohci_hcd and address 2
usb 2-1: new device found, idVendor=0557, idProduct=7000
usb 2-1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1: configuration #1 chosen from 1 choice
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 4 ports detected
usb 3-1: new full speed USB device using ohci_hcd and address 2
usb 3-1: new device found, idVendor=0451, idProduct=2036
usb 3-1: new device strings: Mfr=0, Product=1, SerialNumber=0
usb 3-1: Product: General Purpose USB Hub
usb 3-1: configuration #1 chosen from 1 choice
hub 3-1:1.0: USB hub found
hub 3-1:1.0: 2 ports detected
usb 3-2: new full speed USB device using ohci_hcd and address 3
usb 3-2: new device found, idVendor=03eb, idProduct=3301
usb 3-2: new device strings: Mfr=0, Product=2, SerialNumber=0
usb 3-2: Product: Standard USB Hub
usb 3-2: configuration #1 chosen from 1 choice
hub 3-2:1.0: USB hub found
hub 3-2:1.0: 4 ports detected
usb 1-2.7: new high speed USB device using ehci_hcd and address 6
usb 1-2.7: new device found, idVendor=04b4, idProduct=6830
usb 1-2.7: new device strings: Mfr=56, Product=58, SerialNumber=60
usb 1-2.7: Product:  
usb 1-2.7: Manufacturer:  
usb 1-2.7: SerialNumber: D
usb 1-2.7: configuration #1 chosen from 1 choice
usb 2-1.1: new low speed USB device using ohci_hcd and address 3
usb 2-1.1: new device found, idVendor=046a, idProduct=0023
usb 2-1.1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.1: configuration #1 chosen from 1 choice
usb 2-1.4: new low speed USB device using ohci_hcd and address 4
usb 2-1.4: new device found, idVendor=046d, idProduct=c50e
usb 2-1.4: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-1.4: Product: USB Receiver
usb 2-1.4: Manufacturer: Logitech
usb 2-1.4: configuration #1 chosen from 1 choice
usb 3-1.1: new full speed USB device using ohci_hcd and address 4
usb 3-1.1: new device found, idVendor=054c, idProduct=002c
usb 3-1.1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 3-1.1: Product: USB Floppy Drive
usb 3-1.1: Manufacturer: Sony
usb 3-1.1: configuration #1 chosen from 1 choice
usb 3-1.2: new full speed USB device using ohci_hcd and address 5
usb 3-1.2: new device found, idVendor=054c, idProduct=00b0
usb 3-1.2: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 3-1.2: Product: MPF-MSRW1
usb 3-1.2: Manufacturer: Sony
usb 3-1.2: configuration #1 chosen from 1 choice
usb 3-2.4: new low speed USB device using ohci_hcd and address 6
usb 3-2.4: new device found, idVendor=1038, idProduct=0100
usb 3-2.4: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 3-2.4: Product: Zboard
usb 3-2.4: Manufacturer: Ideazon
usb 3-2.4: configuration #1 chosen from 1 choice
scsi2 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 6
usb-storage: waiting for device to settle before scanning
scsi3 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 4
usb-storage: waiting for device to settle before scanning
scsi4 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 5
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
md: raid1 personality registered for level 1
md: md0 stopped.
md: md0 stopped.
  Vendor: WDC AC26  Model: 400B              Rev: 0000
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdc: 12594960 512-byte hdwr sectors (6449 MB)
sdc: Write Protect is off
sdc: Mode Sense: 27 00 00 00
sdc: assuming drive cache: write through
SCSI device sdc: 12594960 512-byte hdwr sectors (6449 MB)
  Vendor: Sony      Model: MPF-MSRW1         Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: SONY      Model: USB-FDU           Rev: 5.01
  Type:   Direct-Access                      ANSI SCSI revision: 00
sdc: Write Protect is off
sdc: Mode Sense: 27 00 00 00
sdc: assuming drive cache: write through
 sdc:<5>sd 4:0:0:0: Attached scsi removable disk sdd
sd 4:0:0:0: Attached scsi generic sg2 type 0
 sdc1 sdc2
sd 2:0:0:0: Attached scsi disk sdc
sd 2:0:0:0: Attached scsi generic sg3 type 0
usb-storage: device scan complete
usb-storage: device scan complete
sd 3:0:0:0: Attached scsi removable disk sde
sd 3:0:0:0: Attached scsi generic sg4 type 0
usb-storage: device scan complete
ReiserFS: sdc2: found reiserfs format "3.6" with standard journal
ReiserFS: sdc2: using ordered data mode
ReiserFS: sdc2: journal params: device sdc2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdc2: checking transaction log (sdc2)
ReiserFS: sdc2: Using r5 hash to sort names
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
lp0: using parport0 (interrupt-driven).
usbcore: registered new driver hiddev
input: HID 046a:0023 as /class/input/input1
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:02.0-1.1
/home/testit/kernel-source/linux-2.6.17/drivers/usb/input/hid-core.c: ctrl urb status -110 received
input: HID 046a:0023 as /class/input/input2
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:02.0-1.1
input: Logitech USB Receiver as /class/input/input3
input: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:00:02.0-1.4
input: Ideazon Zboard as /class/input/input4
input: USB HID v1.10 Keyboard [Ideazon Zboard] on usb-0000:00:02.1-2.4
usbcore: registered new driver usbhid
/home/testit/kernel-source/linux-2.6.17/drivers/usb/input/hid-core.c: v2.6:USB HID core driver
hda: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
gameport: NS558 PnP Gameport is pnp00:0e/gameport0, io 0x201, speed 710kHz
hdb: ATAPI 44X CD-ROM CD-R/RW drive, 8192kB Cache, UDMA(33)
hdc: ATAPI 126X DVD-ROM drive, 256kB Cache, UDMA(33)
usb 2-1.1: reset low speed USB device using ohci_hcd and address 3
usb 2-1.1: failed to restore interface 0 altsetting 0 (error=-110)
usb 2-1.1: USB disconnect, address 3
usb 2-1.1: new low speed USB device using ohci_hcd and address 5
usb 2-1.1: new device found, idVendor=046a, idProduct=0023
usb 2-1.1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.1: configuration #1 chosen from 1 choice
input: HID 046a:0023 as /class/input/input5
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:02.0-1.1
ieee1394: Initialized config rom entry `ip1394'
input: HID 046a:0023 as /class/input/input6
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:02.0-1.1
ACPI: PCI Interrupt Link [APCM] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [APCM] -> GSI 22 (level, high) -> IRQ 193
PCI: Setting latency timer of device 0000:00:0d.0 to 64
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[193]  MMIO=[ed084000-ed0847ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
ACPI: PCI Interrupt 0000:01:08.2[B] -> Link [APC4] -> GSI 19 (level, high) -> IRQ 217
ohci1394: fw-host1: OHCI-1394 1.1 (PCI): IRQ=[217]  MMIO=[ec008000-ec0087ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
ACPI: PCI Interrupt 0000:01:04.0[A] -> Link [APC2] -> GSI 17 (level, high) -> IRQ 225
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.56.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [APCH] -> GSI 21 (level, high) -> IRQ 201
PCI: Setting latency timer of device 0000:00:04.0 to 64
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
hdd: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)
eth1: forcedeth.c: subsystem: 01043:80a7 bound to 0000:00:04.0
gameport: EMU10K1 is pci0000:01:08.1/gameport0, io 0x7800, speed 903kHz
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x5000
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5500
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: AGP aperture is 128M @ 0xe0000000
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
usb 2-1.1: reset low speed USB device using ohci_hcd and address 5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
usb 2-1.1: failed to restore interface 0 altsetting 0 (error=-110)
ohci1394: fw-host0: SelfID received outside of bus reset sequence
usb 2-1.1: USB disconnect, address 5
usb 2-1.1: new low speed USB device using ohci_hcd and address 6
usb 2-1.1: new device found, idVendor=046a, idProduct=0023
usb 2-1.1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.1: configuration #1 chosen from 1 choice
input: HID 046a:0023 as /class/input/input7
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:02.0-1.1
/home/testit/kernel-source/linux-2.6.17/drivers/usb/input/hid-core.c: ctrl urb status -110 received
input: HID 046a:0023 as /class/input/input8
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:02.0-1.1
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e0180000c311de]
ieee1394: Host added: ID:BUS[1-01:1023]  GUID[00023c0141006ed2]
usb 2-1.1: reset low speed USB device using ohci_hcd and address 6
usb 2-1.1: failed to restore interface 0 altsetting 0 (error=-110)
usb 2-1.1: USB disconnect, address 6
usb 2-1.1: new low speed USB device using ohci_hcd and address 7
usb 2-1.1: new device found, idVendor=046a, idProduct=0023
usb 2-1.1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.1: configuration #1 chosen from 1 choice
input: HID 046a:0023 as /class/input/input9
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:02.0-1.1
input: HID 046a:0023 as /class/input/input10
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:02.0-1.1
device-mapper: ioctl: 4.8.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
md: md0 stopped.
usb 2-1.1: reset low speed USB device using ohci_hcd and address 7
usb 2-1.1: failed to restore interface 0 altsetting 0 (error=-110)
usb 2-1.1: USB disconnect, address 7
usb 2-1.1: new low speed USB device using ohci_hcd and address 8
usb 2-1.1: new device found, idVendor=046a, idProduct=0023
usb 2-1.1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.1: configuration #1 chosen from 1 choice
input: HID 046a:0023 as /class/input/input11
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:02.0-1.1
input: HID 046a:0023 as /class/input/input12
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:02.0-1.1
loop: loaded (max 8 devices)
usb 2-1.1: reset low speed USB device using ohci_hcd and address 8
usb 2-1.1: failed to restore interface 0 altsetting 0 (error=-110)
usb 2-1.1: USB disconnect, address 8
usb 2-1.1: new low speed USB device using ohci_hcd and address 9
usb 2-1.1: new device found, idVendor=046a, idProduct=0023
usb 2-1.1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.1: configuration #1 chosen from 1 choice
input: HID 046a:0023 as /class/input/input13
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:02.0-1.1
input: HID 046a:0023 as /class/input/input14
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:02.0-1.1
usb 2-1.1: reset low speed USB device using ohci_hcd and address 9
usb 2-1.1: failed to restore interface 0 altsetting 0 (error=-110)
usb 2-1.1: USB disconnect, address 9
usb 2-1.1: new low speed USB device using ohci_hcd and address 10
usb 2-1.1: new device found, idVendor=046a, idProduct=0023
usb 2-1.1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.1: configuration #1 chosen from 1 choice
input: HID 046a:0023 as /class/input/input15
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:02.0-1.1
input: HID 046a:0023 as /class/input/input16
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:02.0-1.1
usb 2-1.1: reset low speed USB device using ohci_hcd and address 10
usb 2-1.1: failed to restore interface 0 altsetting 0 (error=-110)
usb 2-1.1: USB disconnect, address 10
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
usb 2-1.1: new low speed USB device using ohci_hcd and address 11
usb 2-1.1: new device found, idVendor=046a, idProduct=0023
usb 2-1.1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.1: configuration #1 chosen from 1 choice
ip6_tables: (C) 2000-2006 Netfilter Core Team
input: HID 046a:0023 as /class/input/input17
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:02.0-1.1
/home/testit/kernel-source/linux-2.6.17/drivers/usb/input/hid-core.c: ctrl urb status -110 received
input: HID 046a:0023 as /class/input/input18
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:02.0-1.1
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (8191 buckets, 65528 max) - 228 bytes per conntrack
usb 2-1.1: reset low speed USB device using ohci_hcd and address 11
usb 2-1.1: failed to restore interface 0 altsetting 0 (error=-110)
usb 2-1.1: USB disconnect, address 11
.
.
.
usb 2-1.1: new low speed USB device using ohci_hcd and address 47
usb 2-1.1: new device found, idVendor=046a, idProduct=0023
usb 2-1.1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.1: configuration #1 chosen from 1 choice
input: HID 046a:0023 as /class/input/input89
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:02.0-1.1
/home/testit/kernel-source/linux-2.6.17/drivers/usb/input/hid-core.c: ctrl urb status -110 received
input: HID 046a:0023 as /class/input/input90
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:02.0-1.1
usb 1-2.7: reset high speed USB device using ehci_hcd and address 6
BUG: trying to register non-static key!
turning off the locking correctness validator.
 [<c0104353>] show_trace_log_lvl+0x54/0xfd
 [<c01048dd>] show_trace+0xd/0x10
 [<c010497a>] dump_stack+0x19/0x1b
 [<c012f0e7>] __lock_acquire+0x101/0x964
 [<c012fc0f>] lock_acquire+0x60/0x80
 [<c02b75b1>] _spin_lock_irq+0x1f/0x2e
 [<c02b53f9>] wait_for_completion_timeout+0x2c/0x12e
 [<f902fe0f>] scsi_send_eh_cmnd+0x11d/0x20c [scsi_mod]
 [<f9030044>] scsi_eh_tur+0x7c/0xda [scsi_mod]
 [<f903098c>] scsi_error_handler+0x4b2/0xa7b [scsi_mod]
 [<c0129ce5>] kthread+0xb0/0xdc
 [<c0101005>] kernel_thread_helper+0x5/0xb
usb 2-1.1: reset low speed USB device using ohci_hcd and address 47
usb 2-1.1: failed to restore interface 0 altsetting 0 (error=-110)
usb 2-1.1: USB disconnect, address 47
usb 2-1.1: new low speed USB device using ohci_hcd and address 48
usb 2-1.1: new device found, idVendor=046a, idProduct=0023
usb 2-1.1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.1: configuration #1 chosen from 1 choice
input: HID 046a:0023 as /class/input/input91
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:02.0-1.1
input: HID 046a:0023 as /class/input/input92
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:02.0-1.1
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
usb 2-1.1: reset low speed USB device using ohci_hcd and address 48
usb 2-1.1: failed to restore interface 0 altsetting 0 (error=-110)
usb 2-1.1: USB disconnect, address 48
usb 2-1.1: new low speed USB device using ohci_hcd and address 49
usb 2-1.1: new device found, idVendor=046a, idProduct=0023
usb 2-1.1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.1: configuration #1 chosen from 1 choice
input: HID 046a:0023 as /class/input/input93
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:02.0-1.1
/home/testit/kernel-source/linux-2.6.17/drivers/usb/input/hid-core.c: ctrl urb status -110 received
input: HID 046a:0023 as /class/input/input94
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:02.0-1.1
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
ADDRCONF(NETDEV_UP): eth2: link is not ready
usb 2-1.1: reset low speed USB device using ohci_hcd and address 49
usb 2-1.1: failed to restore interface 0 altsetting 0 (error=-110)
usb 2-1.1: USB disconnect, address 49
usb 2-1.1: new low speed USB device using ohci_hcd and address 50
usb 2-1.1: new device found, idVendor=046a, idProduct=0023
usb 2-1.1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.1: configuration #1 chosen from 1 choice
input: HID 046a:0023 as /class/input/input95
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:02.0-1.1
input: HID 046a:0023 as /class/input/input96
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:02.0-1.1
usb 2-1.1: reset low speed USB device using ohci_hcd and address 50
eth2: network connection up using port A
    speed:           1000
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    role:            master
    irq moderation:  disabled
    scatter-gather:  disabled
    tx-checksum:     disabled
    rx-checksum:     disabled
usb 2-1.1: failed to restore interface 0 altsetting 0 (error=-110)
ADDRCONF(NETDEV_CHANGE): eth2: link becomes ready
usb 2-1.1: USB disconnect, address 50
audit(1151426992.163:2): audit_backlog_limit=256 old=64 by auid=4294967295
usb 2-1.1: new low speed USB device using ohci_hcd and address 51
usb 2-1.1: new device found, idVendor=046a, idProduct=0023
usb 2-1.1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.1: configuration #1 chosen from 1 choice
input: HID 046a:0023 as /class/input/input97
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:02.0-1.1
input: HID 046a:0023 as /class/input/input98
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:02.0-1.1
audit(1151426992.583:3): audit_pid=6801 old=0 by auid=4294967295
usb 2-1.1: reset low speed USB device using ohci_hcd and address 51
usb 2-1.1: failed to restore interface 0 altsetting 0 (error=-110)
usb 2-1.1: USB disconnect, address 51
.
.
.
usb 2-1.1: new low speed USB device using ohci_hcd and address 55
usb 2-1.1: new device found, idVendor=046a, idProduct=0023
usb 2-1.1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.1: configuration #1 chosen from 1 choice
input: HID 046a:0023 as /class/input/input105
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:02.0-1.1
/home/testit/kernel-source/linux-2.6.17/drivers/usb/input/hid-core.c: ctrl urb status -110 received
input: HID 046a:0023 as /class/input/input106
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:02.0-1.1
powernow-k8: Processor cpuid 6a0 not supported
usb 2-1.1: reset low speed USB device using ohci_hcd and address 55
usb 2-1.1: failed to restore interface 0 altsetting 0 (error=-110)
usb 2-1.1: USB disconnect, address 55
usb 2-1.1: new low speed USB device using ohci_hcd and address 56
usb 2-1.1: new device found, idVendor=046a, idProduct=0023
usb 2-1.1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.1: configuration #1 chosen from 1 choice
input: HID 046a:0023 as /class/input/input107
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:02.0-1.1
/home/testit/kernel-source/linux-2.6.17/drivers/usb/input/hid-core.c: ctrl urb status -110 received
input: HID 046a:0023 as /class/input/input108
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:02.0-1.1
eth2: no IPv6 routers present
usb 2-1.1: reset low speed USB device using ohci_hcd and address 56
usb 2-1.1: failed to restore interface 0 altsetting 0 (error=-110)
usb 2-1.1: USB disconnect, address 56
.
.
.
usb 2-1.1: new low speed USB device using ohci_hcd and address 64
usb 2-1.1: new device found, idVendor=046a, idProduct=0023
usb 2-1.1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.1: configuration #1 chosen from 1 choice
input: HID 046a:0023 as /class/input/input123
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:02.0-1.1
/home/testit/kernel-source/linux-2.6.17/drivers/usb/input/hid-core.c: ctrl urb status -110 received
input: HID 046a:0023 as /class/input/input124
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:02.0-1.1
usb 2-1.1: reset low speed USB device using ohci_hcd and address 64
usb 2-1.1: failed to restore interface 0 altsetting 0 (error=-110)
/home/testit/kernel-source/linux-2.6.17/drivers/usb/input/hid-core.c: usb_submit_urb(ctrl) failed
usb 2-1.1: USB disconnect, address 64
usb 2-1.1: new low speed USB device using ohci_hcd and address 65
usb 2-1.1: new device found, idVendor=046a, idProduct=0023
usb 2-1.1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.1: configuration #1 chosen from 1 choice
input: HID 046a:0023 as /class/input/input125
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:02.0-1.1
/home/testit/kernel-source/linux-2.6.17/drivers/usb/input/hid-core.c: ctrl urb status -110 received
input: HID 046a:0023 as /class/input/input126
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:02.0-1.1
usb 2-1.1: reset low speed USB device using ohci_hcd and address 65
usb 2-1.1: failed to restore interface 0 altsetting 0 (error=-110)
usb 2-1.1: USB disconnect, address 65
.
.
.
usb 2-1.1: new low speed USB device using ohci_hcd and address 68
usb 2-1.1: new device found, idVendor=046a, idProduct=0023
usb 2-1.1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.1: configuration #1 chosen from 1 choice
input: HID 046a:0023 as /class/input/input131
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:02.0-1.1
/home/testit/kernel-source/linux-2.6.17/drivers/usb/input/hid-core.c: ctrl urb status -110 received
input: HID 046a:0023 as /class/input/input132
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:02.0-1.1
usb 2-1.4: reset low speed USB device using ohci_hcd and address 4
usb 2-1.1: reset low speed USB device using ohci_hcd and address 68
usb 2-1.1: failed to restore interface 0 altsetting 0 (error=-110)
usb 2-1.1: USB disconnect, address 68
usb 2-1.4: reset low speed USB device using ohci_hcd and address 4
usb 2-1.1: new low speed USB device using ohci_hcd and address 69
usb 2-1.1: new device found, idVendor=046a, idProduct=0023
usb 2-1.1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.1: configuration #1 chosen from 1 choice
input: HID 046a:0023 as /class/input/input133
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:02.0-1.1
/home/testit/kernel-source/linux-2.6.17/drivers/usb/input/hid-core.c: ctrl urb status -110 received
input: HID 046a:0023 as /class/input/input134
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:02.0-1.1
usb 2-1.4: reset low speed USB device using ohci_hcd and address 4
usb 2-1.1: reset low speed USB device using ohci_hcd and address 69
usb 2-1.1: failed to restore interface 0 altsetting 0 (error=-110)
usb 2-1.1: USB disconnect, address 69
.
.
.
usb 2-1.1: new low speed USB device using ohci_hcd and address 76
usb 2-1.1: new device found, idVendor=046a, idProduct=0023
usb 2-1.1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.1: configuration #1 chosen from 1 choice
input: HID 046a:0023 as /class/input/input147
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:02.0-1.1
/home/testit/kernel-source/linux-2.6.17/drivers/usb/input/hid-core.c: ctrl urb status -110 received
input: HID 046a:0023 as /class/input/input148
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:02.0-1.1
usb 2-1.4: reset low speed USB device using ohci_hcd and address 4
usb 2-1.1: reset low speed USB device using ohci_hcd and address 76
usb 2-1.1: failed to restore interface 0 altsetting 0 (error=-110)
usb 2-1.1: USB disconnect, address 76
usb 2-1.1: new low speed USB device using ohci_hcd and address 77
usb 2-1.1: new device found, idVendor=046a, idProduct=0023
usb 2-1.1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.1: configuration #1 chosen from 1 choice
input: HID 046a:0023 as /class/input/input149
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:02.0-1.1
input: HID 046a:0023 as /class/input/input150
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:02.0-1.1
usb 2-1.1: reset low speed USB device using ohci_hcd and address 77
usb 2-1.1: failed to restore interface 0 altsetting 0 (error=-110)
usb 2-1.1: USB disconnect, address 77
.
.
.
usb 2-1.1: new low speed USB device using ohci_hcd and address 100
usb 2-1.1: new device found, idVendor=046a, idProduct=0023
usb 2-1.1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.1: configuration #1 chosen from 1 choice
input: HID 046a:0023 as /class/input/input195
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:02.0-1.1
/home/testit/kernel-source/linux-2.6.17/drivers/usb/input/hid-core.c: ctrl urb status -110 received
input: HID 046a:0023 as /class/input/input196
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:02.0-1.1
usb 2-1.1: reset low speed USB device using ohci_hcd and address 100
usb 2-1.1: failed to restore interface 0 altsetting 0 (error=-110)
usb 2-1.1: USB disconnect, address 100
usb 2-1.1: new low speed USB device using ohci_hcd and address 101

up to address 127
and then starts all over again
