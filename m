Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262679AbSJEVkA>; Sat, 5 Oct 2002 17:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262681AbSJEVkA>; Sat, 5 Oct 2002 17:40:00 -0400
Received: from nl-ams-slo-l4-02-pip-3.chellonetwork.com ([213.46.243.18]:41263
	"EHLO amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id <S262679AbSJEVjl>; Sat, 5 Oct 2002 17:39:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jos Hulzink <josh@stack.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40: some results...
Date: Sat, 5 Oct 2002 23:45:07 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021005214508.IKVD1253.amsfep12-int.chello.nl@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First one reaction: Whoooow this kernel boots / responds fast ! Nice job 
guys! No need to update this Dual PII 333 for the next century :)

Anyway. It boots and runs, only "scheduling while atomic" sounds very bad to 
me. Furthermore the famous Debug: sleeping function called from illegal 
context at slab.c:1374 and friends, I think you have seen most of them 
already.

I marked all places I found odd with "^^^^^" search for those and you'll find 
them. If any of these is new, please let me know, I'll provide details / test 
results on demand.

Uptime is half an hour now, no ide problems yet. Time to stress the bitch. 
Unfortunately I'm out of CD-rw's so no burning tests for the weekend.

I'm impressed, and back in the 2.5 testing business.

Jos

Oct  5 23:19:54 goofy syslogd 1.4.1: restart.
Oct  5 23:19:54 goofy syslog: syslogd startup succeeded
Oct  5 23:19:54 goofy kernel: klogd 1.4.1, log source = /proc/kmsg started.
Oct  5 23:19:54 goofy kernel: Inspecting /boot/System.map
Oct  5 23:19:54 goofy syslog: klogd startup succeeded
Oct  5 23:19:54 goofy kernel: Symbol table has incorrect version number.
Oct  5 23:19:54 goofy kernel: Cannot find map file.
Oct  5 23:19:54 goofy kernel: No module symbols loaded.
Oct  5 23:19:54 goofy kernel: Linux version 2.5.40 (root@goofy.foske.nl) (gcc 
version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 SMP Sat Oct 5 23:16:19 
CEST 2002
Oct  5 23:19:54 goofy kernel: Video mode to be used for restore is ffff
Oct  5 23:19:54 goofy kernel: BIOS-provided physical RAM map:
Oct  5 23:19:54 goofy kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 
(usable)
Oct  5 23:19:54 goofy kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 
(reserved)
Oct  5 23:19:54 goofy kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 
(reserved)
Oct  5 23:19:54 goofy kernel:  BIOS-e820: 0000000000100000 - 000000000fffd000 
(usable)
Oct  5 23:19:54 goofy kernel:  BIOS-e820: 000000000fffd000 - 000000000ffff000 
(ACPI data)
Oct  5 23:19:54 goofy kernel:  BIOS-e820: 000000000ffff000 - 0000000010000000 
(ACPI NVS)
Oct  5 23:19:54 goofy kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 
(reserved)
Oct  5 23:19:54 goofy kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 
(reserved)
Oct  5 23:19:54 goofy kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 
(reserved)
Oct  5 23:19:54 goofy kernel: 255MB LOWMEM available.
Oct  5 23:19:54 goofy kernel: found SMP MP-table at 000f6e30
Oct  5 23:19:54 goofy kernel: hm, page 000f6000 reserved twice.
Oct  5 23:19:54 goofy portmap: portmap startup succeeded
Oct  5 23:19:54 goofy kernel: hm, page 000f7000 reserved twice.
Oct  5 23:19:54 goofy kernel: hm, page 000f6000 reserved twice.
Oct  5 23:19:54 goofy kernel: hm, page 000f7000 reserved twice.
Oct  5 23:19:54 goofy kernel: On node 0 totalpages: 65533
Oct  5 23:19:54 goofy kernel:   DMA zone: 4096 pages
Oct  5 23:19:54 goofy kernel:   Normal zone: 61437 pages
Oct  5 23:19:54 goofy kernel:   HighMem zone: 0 pages
Oct  5 23:19:54 goofy kernel: ACPI: RSDP (v000 ASUS                       ) @ 
0x000f7ff0
Oct  5 23:19:54 goofy kernel: ACPI: RSDT (v001 ASUS   P2L97-DS 22616.11825) @ 
0x0fffd000
Oct  5 23:19:54 goofy kernel: ACPI: FADT (v001 ASUS   P2L97-DS 22616.11825) @ 
0x0fffd080
Oct  5 23:19:54 goofy kernel: ACPI: BOOT (v001 ASUS   P2L97-DS 22616.11825) @ 
0x0fffd040
Oct  5 23:19:54 goofy kernel: ACPI: DSDT (v001   ASUS P2L97-DS 00000.04096) @ 
0x00000000
Oct  5 23:19:54 goofy kernel: ACPI: BIOS passes blacklist
Oct  5 23:19:54 goofy kernel: ACPI: MADT not present
Oct  5 23:19:54 goofy kernel: Intel MultiProcessor Specification v1.1
Oct  5 23:19:54 goofy kernel:     Virtual Wire compatibility mode.
Oct  5 23:19:54 goofy kernel: OEM ID: OEM00000 Product ID: PROD00000000 APIC 
at: 0xFEE00000
Oct  5 23:19:54 goofy kernel: Processor #1 6:5 APIC version 17
Oct  5 23:19:54 goofy kernel: Processor #0 6:5 APIC version 17
Oct  5 23:19:54 goofy kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Oct  5 23:19:54 goofy kernel: Processors: 2
Oct  5 23:19:54 goofy kernel: Building zonelist for node : 0
Oct  5 23:19:54 goofy kernel: Kernel command line: ro root=/dev/hda2
Oct  5 23:19:54 goofy kernel: Initializing CPU#0
Oct  5 23:19:54 goofy kernel: Detected 342.101 MHz processor.
Oct  5 23:19:54 goofy kernel: Console: colour VGA+ 80x25
Oct  5 23:19:54 goofy kernel: Calibrating delay loop... 673.79 BogoMIPS
Oct  5 23:19:54 goofy kernel: Memory: 253912k/262132k available (2664k kernel 
code, 7832k reserved, 900k data, 132k init, 0k highmem)
Oct  5 23:19:54 goofy kernel: Security Scaffold v1.0.0 initialized
Oct  5 23:19:54 goofy kernel: Dentry-cache hash table entries: 32768 (order: 
6, 262144 bytes)
Oct  5 23:19:54 goofy kernel: Inode-cache hash table entries: 16384 (order: 
5, 131072 bytes)
Oct  5 23:19:54 goofy kernel: Mount-cache hash table entries: 512 (order: 0, 
4096 bytes)
Oct  5 23:19:54 goofy kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Oct  5 23:19:54 goofy kernel: CPU: L2 cache: 512K
Oct  5 23:19:54 goofy kernel: Intel machine check architecture supported.
Oct  5 23:19:54 goofy kernel: Intel machine check reporting enabled on CPU#0.
Oct  5 23:19:54 goofy kernel: Enabling fast FPU save and restore... done.
Oct  5 23:19:54 goofy kernel: Checking 'hlt' instruction... OK.
Oct  5 23:19:54 goofy kernel: POSIX conformance testing by UNIFIX
Oct  5 23:19:54 goofy kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Oct  5 23:19:54 goofy kernel: CPU: L2 cache: 512K
Oct  5 23:19:54 goofy kernel: Intel machine check reporting enabled on CPU#0.
Oct  5 23:19:54 goofy kernel: CPU0: Intel Pentium II (Deschutes) stepping 02
Oct  5 23:19:54 goofy kernel: per-CPU timeslice cutoff: 1462.92 usecs.
Oct  5 23:19:54 goofy kernel: task migration cache decay timeout: 2 msecs.
Oct  5 23:19:54 goofy kernel: enabled ExtINT on CPU#0
Oct  5 23:19:54 goofy kernel: ESR value before enabling vector: 00000000
Oct  5 23:19:54 goofy kernel: ESR value after enabling vector: 00000000
Oct  5 23:19:54 goofy kernel: Booting processor 1/0 eip 2000
Oct  5 23:19:54 goofy kernel: Initializing CPU#1
Oct  5 23:19:54 goofy kernel: masked ExtINT on CPU#1
Oct  5 23:19:54 goofy kernel: ESR value before enabling vector: 00000000
Oct  5 23:19:54 goofy kernel: ESR value after enabling vector: 00000000
Oct  5 23:19:54 goofy kernel: Calibrating delay loop... 681.98 BogoMIPS
Oct  5 23:19:54 goofy kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Oct  5 23:19:54 goofy kernel: CPU: L2 cache: 512K
Oct  5 23:19:54 goofy kernel: Intel machine check reporting enabled on CPU#1.
Oct  5 23:19:54 goofy kernel: CPU1: Intel Pentium II (Deschutes) stepping 02
Oct  5 23:19:54 goofy kernel: Total of 2 processors activated (1355.77 
BogoMIPS).
Oct  5 23:19:54 goofy kernel: ENABLING IO-APIC IRQs
Oct  5 23:19:54 goofy kernel: Setting 2 in the phys_id_present_map
Oct  5 23:19:54 goofy kernel: ...changing IO-APIC physical APIC ID to 2 ... 
ok. Oct  5 23:19:54 goofy kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Oct  5 23:19:54 goofy kernel: testing the IO APIC.......................
Oct  5 23:19:54 goofy kernel:
Oct  5 23:19:54 goofy kernel: .................................... done.
Oct  5 23:19:54 goofy kernel: Using local APIC timer interrupts.
Oct  5 23:19:54 goofy kernel: calibrating APIC timer ...
Oct  5 23:19:54 goofy kernel: ..... CPU clock speed is 341.0989 MHz.
Oct  5 23:19:54 goofy kernel: ..... host bus clock speed is 68.0397 MHz.
Oct  5 23:19:54 goofy kernel: cpu: 0, clocks: 68397, slice: 2072
Oct  5 23:19:54 goofy kernel: CPU0<T0:68384,T1:66304,D:8,S:2072,C:68397>
Oct  5 23:19:54 goofy kernel: checking TSC synchronization across 2 CPUs: 
passed.
Oct  5 23:19:54 goofy kernel: Starting migration thread for cpu 0
Oct  5 23:19:54 goofy kernel: Bringing up 1
Oct  5 23:19:54 goofy kernel: cpu: 1, clocks: 68397, slice: 2072
Oct  5 23:19:54 goofy kernel: CPU1<T0:68384,T1:64240,D:0,S:2072,C:68397>
Oct  5 23:19:54 goofy kernel: CPU 1 IS NOW UP!
Oct  5 23:19:54 goofy kernel: Starting migration thread for cpu 1

^^^^^

Oct  5 23:19:54 goofy kernel: bad: scheduling while atomic!

^^^^^

Oct  5 23:19:54 goofy kernel: c12b1ef8 c01172cd c03aaae0 00000000 00000000 
00000000 00000000 00000000
Oct  5 23:19:54 goofy kernel:        c12b0000 c12b1f94 c12b1f98 c12b1f78 
c0117bb9 00000000 c12b4060 c01177b0
Oct  5 23:19:54 goofy kernel:        00000000 00000000 c0116541 c12b1f58 
c04a64a0 00000001 c12b4060 c01177b0
Oct  5 23:19:54 goofy kernel: Call Trace:
Oct  5 23:19:54 goofy kernel:  [<c01172cd>]schedule+0x3d/0x4d0
Oct  5 23:19:54 goofy kernel:  [<c0117bb9>]wait_for_completion+0x129/0x1e0
Oct  5 23:19:54 goofy kernel:  [<c01177b0>]default_wake_function+0x0/0x40
Oct  5 23:19:54 goofy kernel:  [<c0116541>]try_to_wake_up+0x331/0x340
Oct  5 23:19:54 goofy kernel:  [<c01177b0>]default_wake_function+0x0/0x40
Oct  5 23:19:54 goofy kernel:  [<c01196de>]set_cpus_allowed+0x22e/0x250
Oct  5 23:19:54 goofy kernel:  [<c0119750>]migration_thread+0x50/0x5b0
Oct  5 23:19:54 goofy kernel:  [<c0119700>]migration_thread+0x0/0x5b0
Oct  5 23:19:54 goofy kernel:  [<c0119700>]migration_thread+0x0/0x5b0
Oct  5 23:19:54 goofy rpc.statd[665]: Version 0.3.1 Starting
Oct  5 23:19:54 goofy kernel:  [<c01055f9>]kernel_thread_helper+0x5/0xc
Oct  5 23:19:54 goofy nfslock: rpc.statd startup succeeded
Oct  5 23:19:54 goofy kernel:

^^^^^

Oct  5 23:19:54 goofy kernel: bad: scheduling while atomic!

^^^^^

Oct  5 23:19:54 goofy kernel: c12aff10 c01172cd c03aaae0 00000000 00000000 
00000000 00000000 00000000
Oct  5 23:19:54 goofy kernel:        c12ae000 c12affac c12affb0 c12aff90 
c0117bb9 00000000 c12b4780 c01177b0
Oct  5 23:19:54 goofy kernel:        00000000 00000000 c0116541 c12aff70 
c04a64a0 00000001 c12b4780 c01177b0
Oct  5 23:19:54 goofy kernel: Call Trace:
Oct  5 23:19:54 goofy kernel:  [<c01172cd>]schedule+0x3d/0x4d0
Oct  5 23:19:54 goofy kernel:  [<c0117bb9>]wait_for_completion+0x129/0x1e0
Oct  5 23:19:54 goofy kernel:  [<c01177b0>]default_wake_function+0x0/0x40
Oct  5 23:19:54 goofy kernel:  [<c0116541>]try_to_wake_up+0x331/0x340
Oct  5 23:19:54 goofy kernel:  [<c01177b0>]default_wake_function+0x0/0x40
Oct  5 23:19:54 goofy kernel:  [<c01196de>]set_cpus_allowed+0x22e/0x250
Oct  5 23:19:54 goofy kernel:  [<c012359b>]ksoftirqd+0x5b/0x110
Oct  5 23:19:54 goofy kernel:  [<c0123540>]ksoftirqd+0x0/0x110
Oct  5 23:19:54 goofy kernel:  [<c01055f9>]kernel_thread_helper+0x5/0xc
Oct  5 23:19:54 goofy kernel:
Oct  5 23:19:54 goofy kernel: CPUS done 4294967295
Oct  5 23:19:54 goofy kernel: Linux NET4.0 for Linux 2.4
Oct  5 23:19:54 goofy kernel: Based upon Swansea University Computer Society 
NET3.039
Oct  5 23:19:54 goofy kernel: Initializing RT netlink socket
Oct  5 23:19:54 goofy kernel: mtrr: v2.0 (20020519)
Oct  5 23:19:54 goofy kernel: mtrr: your CPUs had inconsistent fixed MTRR 
settings
Oct  5 23:19:54 goofy kernel: mtrr: your CPUs had inconsistent variable MTRR 
settings
Oct  5 23:19:54 goofy kernel: mtrr: probably your BIOS does not setup all CPUs
Oct  5 23:19:54 goofy kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0730, 
last bus=1
Oct  5 23:19:54 goofy kernel: PCI: Using configuration type 1
Oct  5 23:19:54 goofy kernel: ACPI: Subsystem revision 20020918
Oct  5 23:19:54 goofy kernel:  tbxface-0099 [03] Acpi_load_tables      : ACPI 
Tables successfully loaded
Oct  5 23:19:54 goofy kernel: Parsing 
Methods:...........................................................
Oct  5 23:19:54 goofy kernel: Table [DSDT] - 196 Objects with 27 Devices 59 
Methods 9 Regions
Oct  5 23:19:54 goofy kernel: ACPI Namespace successfully loaded at root 
c0530efc
Oct  5 23:19:54 goofy kernel: evxfevnt-0074 [04] Acpi_enable           : 
Transition to ACPI mode successful
Oct  5 23:19:54 goofy kernel: Executing all Device _STA and_INI 
methods:...........................
Oct  5 23:19:54 goofy kernel: 27 Devices found containing: 27 _STA, 0 _INI 
methods
Oct  5 23:19:54 goofy kernel: Completing Region/Field/Buffer/Package 
initialization:..................................
Oct  5 23:19:54 goofy kernel: Initialized 7/9 Regions 0/0 Fields 18/18 
Buffers 9/9 Packages (196 nodes)
Oct  5 23:19:54 goofy kernel: ACPI: Interpreter enabled
Oct  5 23:19:54 goofy kernel: ACPI: Using PIC for interrupt routing
Oct  5 23:19:54 goofy kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 
9 10 *11 12 14 15)
Oct  5 23:19:54 goofy kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 
9 *10 11 12 14 15)
Oct  5 23:19:54 goofy kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 
7 9 10 11 12 14 15)
Oct  5 23:19:54 goofy kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 
*7 9 10 11 12 14 15)
Oct  5 23:19:54 goofy kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Oct  5 23:19:54 goofy kernel: PCI: Probing PCI hardware (bus 00)
Oct  5 23:19:54 goofy kernel: isapnp: Scanning for PnP cards...
Oct  5 23:19:54 goofy kernel: isapnp: No Plug & Play device found
Oct  5 23:19:54 goofy kernel: usb.c: registered new driver usbfs
Oct  5 23:19:54 goofy kernel: usb.c: registered new driver hub
Oct  5 23:19:54 goofy kernel: PCI: Using ACPI for IRQ routing
Oct  5 23:19:54 goofy kernel: PCI: if you experience problems, try using 
option 'pci=noacpi' or even 'acpi=off'
Oct  5 23:19:54 goofy kernel: SBF: Simple Boot Flag extension found and 
enabled.Oct  5 23:19:54 goofy kernel: SBF: Setting boot flags 0x1
Oct  5 23:19:54 goofy kernel: Starting kswapd
Oct  5 23:19:54 goofy kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Oct  5 23:19:54 goofy kernel: biovec pool[0]:   1 bvecs: 256 entries (12 
bytes) Oct  5 23:19:54 goofy kernel: biovec pool[1]:   4 bvecs: 256 entries 
(48 bytes) Oct  5 23:19:54 goofy kernel: biovec pool[2]:  16 bvecs: 256 
entries (192 bytes)Oct  5 23:19:54 goofy kernel: biovec pool[3]:  64 bvecs: 
256 entries (768 bytes)Oct  5 23:19:55 goofy kernel: biovec pool[4]: 128 
bvecs: 256 entries (1536 bytes)
Oct  5 23:19:55 goofy kernel: biovec pool[5]: 256 bvecs: 256 entries (3072 
bytes)
Oct  5 23:19:55 goofy kernel: aio_setup: sizeof(struct page) = 40
Oct  5 23:19:55 goofy kernel: Journalled Block Device driver loaded
Oct  5 23:19:55 goofy kernel: Installing knfsd (copyright (C) 1996 
okir@monad.swb.de).
Oct  5 23:19:55 goofy kernel: NTFS driver 2.1.0 [Flags: R/O].
Oct  5 23:19:55 goofy kernel: udf: registering filesystem
Oct  5 23:19:55 goofy kernel: Capability LSM initialized
Oct  5 23:19:55 goofy kernel: Limiting direct PCI/PCI transfers.
Oct  5 23:19:55 goofy kernel: ACPI: Power Button (FF) [PWRF]
Oct  5 23:19:55 goofy kernel: ACPI: Processor [CPU0] (supports C1)
Oct  5 23:19:55 goofy kernel: Serial: 8250/16550 driver $Revision: 1.90 $ IRQ 
sharing disabled
Oct  5 23:19:55 goofy kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Oct  5 23:19:55 goofy kernel: parport0: PC-style at 0x278 (0x678) 
[PCSPP,TRISTATE,EPP]
Oct  5 23:19:55 goofy kernel: parport0: irq 5 detected
Oct  5 23:19:55 goofy kernel: pty: 256 Unix98 ptys configured
Oct  5 23:19:55 goofy kernel: lp0: using parport0 (polling).
Oct  5 23:19:55 goofy kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
Oct  5 23:19:55 goofy kernel: agpgart: Maximum main memory to use for agp 
memory: 203M
Oct  5 23:19:55 goofy kernel: agpgart: Detected Intel 440LX chipset
Oct  5 23:19:55 goofy kernel: agpgart: AGP aperture is 64M @ 0xe4000000
Oct  5 23:19:55 goofy kernel: [drm] AGP 0.99 on Intel 440LX @ 0xe4000000 64MB
Oct  5 23:19:55 goofy kernel: MTRR: setting reg 1
Oct  5 23:19:55 goofy kernel: MTRR: setting reg 1
Oct  5 23:19:55 goofy kernel: [drm] Initialized radeon 1.6.0 20020828 on 
minor 0Oct  5 23:19:55 goofy kernel: block request queues:
Oct  5 23:19:55 goofy kernel:  128 requests per read queue
Oct  5 23:19:55 goofy kernel:  128 requests per write queue
Oct  5 23:19:55 goofy kernel:  8 requests per batch
Oct  5 23:19:55 goofy kernel:  enter congestion at 31
Oct  5 23:19:55 goofy keytable: Loading keymap:  succeeded
Oct  5 23:19:55 goofy kernel:  exit congestion at 33
Oct  5 23:19:55 goofy kernel: Floppy drive(s): fd0 is 1.44M
Oct  5 23:19:55 goofy kernel: FDC 0 is a post-1991 82077
Oct  5 23:19:55 goofy kernel: 3c59x: Donald Becker and others. 
www.scyld.com/network/vortex.html
Oct  5 23:19:55 goofy kernel: 00:0b.0: 3Com PCI 3c905 Boomerang 100baseTx at 
0xb000. Vers LK1.1.18
Oct  5 23:19:55 goofy kernel: phy=0, phyx=24, mii_status=0x786f
Oct  5 23:19:55 goofy kernel: Uniform Multi-Platform E-IDE driver Revision: 
7.00alpha2
Oct  5 23:19:55 goofy kernel: ide: Assuming 33MHz system bus speed for PIO 
modes; override with idebus=xx
Oct  5 23:19:55 goofy kernel: PIIX4: IDE controller at PCI slot 00:04.1
Oct  5 23:19:55 goofy kernel: PIIX4: chipset revision 1
Oct  5 23:19:55 goofy kernel: PIIX4: not 100%% native mode: will probe irqs 
later
Oct  5 23:19:55 goofy kernel:     ide0: BM-DMA at 0xd800-0xd807, BIOS 
settings: hda:DMA, hdb:DMA
Oct  5 23:19:55 goofy kernel:     ide1: BM-DMA at 0xd808-0xd80f, BIOS 
settings: hdc:DMA, hdd:DMA
Oct  5 23:19:55 goofy kernel: hda: MAXTOR 6L020J1, ATA DISK drive
Oct  5 23:19:55 goofy kernel: hdb: Maxtor 32049H2, ATA DISK drive

^^^^^

Oct  5 23:19:55 goofy kernel: Debug: sleeping function called from illegal 
context at slab.c:1374

^^^^^

Oct  5 23:19:55 goofy kernel: c12bfe8c c0119d76 c03aac00 c03acba2 0000055e 
c054eb7c c013c6e1 c03acba2
Oct  5 23:19:55 goofy kernel:        0000055e c054ed00 00000000 00000046 
c010cc12 c12be000 c12be000 0000000e
Oct  5 23:19:55 goofy kernel:        c12be000 c054eb7c c054ebb4 c054eb6c 
c054eb7c c026e491 c13efcb0 000001d0
Oct  5 23:19:55 goofy kernel: Call Trace:
Oct  5 23:19:55 goofy kernel:  [<c0119d76>]__might_sleep+0x56/0x5d
Oct  5 23:19:55 goofy kernel:  [<c013c6e1>]kmem_cache_alloc+0x21/0x2f0
Oct  5 23:19:55 goofy kernel:  [<c010cc12>]i8259A_irq_pending+0xc2/0xd0
Oct  5 23:19:55 goofy kernel:  [<c026e491>]blk_init_free_list+0x61/0x100
Oct  5 23:19:55 goofy kernel:  [<c026e53d>]blk_init_queue+0xd/0xf0
Oct  5 23:19:55 goofy kernel:  [<c027fc28>]ide_init_queue+0x28/0x70
Oct  5 23:19:55 goofy kernel:  [<c0286860>]do_ide_request+0x0/0x20
Oct  5 23:19:55 goofy kernel:  [<c027ffa0>]init_irq+0x330/0x410
Oct  5 23:19:55 goofy kernel:  [<c028035c>]hwif_init+0x10c/0x260
Oct  5 23:19:55 goofy kernel:  [<c027fb4d>]probe_hwif_init+0x1d/0x70
Oct  5 23:19:55 goofy kernel:  [<c02916f1>]ide_setup_pci_device+0x41/0x70
Oct  5 23:19:55 goofy kernel:  [<c027eb65>]piix_init_one+0x35/0x40
Oct  5 23:19:55 goofy kernel:  [<c010511b>]init+0x8b/0x250
Oct  5 23:19:55 goofy kernel:  [<c0105090>]init+0x0/0x250
Oct  5 23:19:55 goofy kernel:  [<c01055f9>]kernel_thread_helper+0x5/0xc
Oct  5 23:19:55 goofy kernel:
Oct  5 23:19:55 goofy kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Oct  5 23:19:55 goofy kernel: hdc: Maxtor 32049H2, ATA DISK drive
Oct  5 23:19:55 goofy keytable: Loading system font:  succeeded
Oct  5 23:19:55 goofy kernel: hdd: Maxtor 32049H2, ATA DISK drive
Oct  5 23:19:55 goofy kernel: ide1 at 0x170-0x177,0x376 on irq 15
Oct  5 23:19:55 goofy kernel: hda: host protected area => 1
Oct  5 23:19:55 goofy kernel: hda: 40132503 sectors (20548 MB) w/1818KiB 
Cache, CHS=2498/255/63, UDMA(33)
Oct  5 23:19:55 goofy kernel:  hda: hda1 hda2 hda3
Oct  5 23:19:55 goofy kernel: hdb: host protected area => 1
Oct  5 23:19:55 goofy kernel: hdb: setmax LBA 40021632, native  39102336
Oct  5 23:19:55 goofy kernel: hdb: 39102336 sectors (20020 MB) w/2048KiB 
Cache, CHS=2434/255/63, UDMA(33)
Oct  5 23:19:55 goofy kernel:  hdb: hdb1 hdb2
Oct  5 23:19:55 goofy kernel: hdc: host protected area => 1
Oct  5 23:19:55 goofy kernel: hdc: setmax LBA 40021632, native  39102336
Oct  5 23:19:55 goofy kernel: hdc: 39102336 sectors (20020 MB) w/2048KiB 
Cache, CHS=38792/16/63, UDMA(33)
Oct  5 23:19:55 goofy kernel:  hdc: hdc1 hdc2
Oct  5 23:19:55 goofy kernel: hdd: host protected area => 1
Oct  5 23:19:55 goofy kernel: hdd: setmax LBA 40021632, native  39102336
Oct  5 23:19:55 goofy kernel: hdd: 39102336 sectors (20020 MB) w/2048KiB 
Cache, CHS=38792/16/63, UDMA(33)
Oct  5 23:19:55 goofy kernel:  hdd: hdd1 hdd2
Oct  5 23:19:55 goofy kernel: SCSI subsystem driver Revision: 1.00
Oct  5 23:19:55 goofy kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA 
DRIVER, Rev 6.2.4
Oct  5 23:19:55 goofy kernel:         <Adaptec aic7880 Ultra SCSI adapter>
Oct  5 23:19:55 goofy kernel:         aic7880: Ultra Wide Channel A, SCSI 
Id=7, 16/253 SCBs
Oct  5 23:19:55 goofy kernel:
Oct  5 23:19:55 goofy kernel: (scsi0:A:0): 5.000MB/s transfers (5.000MHz, 
offset 15)
Oct  5 23:19:55 goofy kernel:   Vendor: WangDAT   Model: Model 3400DX      
Rev: 1.10
Oct  5 23:19:55 goofy kernel:   Type:   Sequential-Access                  
ANSI SCSI revision: 02
Oct  5 23:19:55 goofy kernel: (scsi0:A:4): 10.000MB/s transfers (10.000MHz, 
offset 15)
Oct  5 23:19:55 goofy kernel:   Vendor: SONY      Model: CD-RW  CRX140S    
Rev: 1.0e
Oct  5 23:19:55 goofy kernel:   Type:   CD-ROM                             
ANSI SCSI revision: 04
Oct  5 23:19:55 goofy kernel: st: Version 20020929, fixed bufsize 32768, wrt 
30720, s/g segs 256
Oct  5 23:19:55 goofy kernel: Attached scsi tape st0 at scsi0, channel 0, id 
0, lun 0
Oct  5 23:19:55 goofy kernel: st0: try direct i/o: yes, max page reachable by 
HBA 1048575
Oct  5 23:19:55 goofy kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0, 
id 4, lun 0
Oct  5 23:19:55 goofy kernel: sr0: scsi3-mmc drive: 32x/32x writer cd/rw 
xa/form2 cdda tray
Oct  5 23:19:55 goofy kernel: Uniform CD-ROM driver Revision: 3.12

^^^^^

Oct  5 23:19:55 goofy kernel: Debug: sleeping function called from illegal 
context at slab.c:1374

^^^^^

Oct  5 23:19:55 goofy kernel: c12bfee8 c0119d76 c03aac00 c03acba2 0000055e 
cfffc060 c013c9ff c03acba2
Oct  5 23:19:55 goofy kernel:        0000055e cfff9c00 c13652e8 cfff9c00 
c0167da1 c0167dc4 cfdeb95c cfff9c00
Oct  5 23:19:55 goofy kernel:        cfff9c00 c13652e8 c0470ad8 cfffd000 
00001000 c12be000 00001000 c013aa1d
Oct  5 23:19:55 goofy kernel: Call Trace:
Oct  5 23:19:55 goofy kernel:  [<c0119d76>]__might_sleep+0x56/0x5d
Oct  5 23:19:55 goofy kernel:  [<c013c9ff>]kmalloc+0x4f/0x330
Oct  5 23:19:55 goofy kernel:  [<c0167da1>]alloc_inode+0x31/0x170
Oct  5 23:19:55 goofy kernel:  [<c0167dc4>]alloc_inode+0x54/0x170
Oct  5 23:19:55 goofy kernel:  [<c013aa1d>]get_vm_area+0x1d/0x140
Oct  5 23:19:55 goofy kernel:  [<c013ad8b>]__vmalloc+0x3b/0x120
Oct  5 23:19:55 goofy kernel:  [<c013ae86>]vmalloc+0x16/0x20
Oct  5 23:19:55 goofy kernel:  [<c02c274e>]sg_init+0xbe/0x160
Oct  5 23:19:55 goofy kernel:  [<c029681d>]scsi_register_device+0x8d/0x130
Oct  5 23:19:55 goofy kernel:  [<c010511b>]init+0x8b/0x250
Oct  5 23:19:55 goofy kernel:  [<c0105090>]init+0x0/0x250
Oct  5 23:19:55 goofy kernel:  [<c01055f9>]kernel_thread_helper+0x5/0xc
Oct  5 23:19:55 goofy kernel:
Oct  5 23:19:55 goofy kernel: uhci-hcd.c: USB Universal Host Controller 
Interface driver v2.0
Oct  5 23:19:55 goofy kernel: hcd-pci.c: uhci-hcd @ 00:04.2, Intel Corp. 
82371AB/EB/MB PIIX4 USB
Oct  5 23:19:55 goofy kernel: hcd-pci.c: irq 7, io base 0000d400
Oct  5 23:19:55 goofy kernel: hcd.c: new USB bus registered, assigned bus 
number 1
Oct  5 23:19:55 goofy kernel: hub.c: USB hub found at 0
Oct  5 23:19:55 goofy kernel: hub.c: 2 ports detected
Oct  5 23:19:55 goofy kernel: Initializing USB Mass Storage driver...
Oct  5 23:19:55 goofy kernel: usb.c: registered new driver usb-storage
Oct  5 23:19:55 goofy kernel: USB Mass Storage support registered.
Oct  5 23:19:55 goofy kernel: mice: PS/2 mouse device common for all mice
Oct  5 23:19:55 goofy kernel: input: ImPS/2 Logitech Wheel Mouse on 
isa0060/serio1
Oct  5 23:19:55 goofy kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Oct  5 23:19:55 goofy kernel: input: AT Set 2 Extended keyboard on 
isa0060/serio0
Oct  5 23:19:55 goofy kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Oct  5 23:19:55 goofy kernel: Advanced Linux Sound Architecture Driver 
Version 0.9.0rc2 (Mon Aug 05 14:24:05 2002 UTC).
Oct  5 23:19:55 goofy kernel: request_module[snd-card-0]: not ready
Oct  5 23:19:55 goofy kernel: request_module[snd-card-1]: not ready
Oct  5 23:19:55 goofy kernel: request_module[snd-card-2]: not ready
Oct  5 23:19:55 goofy kernel: request_module[snd-card-3]: not ready
Oct  5 23:19:55 goofy kernel: request_module[snd-card-4]: not ready
Oct  5 23:19:55 goofy kernel: request_module[snd-card-5]: not ready
Oct  5 23:19:55 goofy kernel: request_module[snd-card-6]: not ready
Oct  5 23:19:55 goofy kernel: request_module[snd-card-7]: not ready
Oct  5 23:19:55 goofy kernel: ALSA device list:
Oct  5 23:19:55 goofy kernel:   #0: Sound Blaster Live! at 0xb800, irq 7
Oct  5 23:19:55 goofy kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Oct  5 23:19:55 goofy kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Oct  5 23:19:55 goofy kernel: IP: routing cache hash table of 1024 buckets, 
16Kbytes
Oct  5 23:19:55 goofy kernel: TCP: Hash tables configured (established 8192 
bind 10922)
Oct  5 23:19:55 goofy kernel: NET4: Unix domain sockets 1.0/SMP for Linux 
NET4.0.
Oct  5 23:19:55 goofy random: Initializing random number generator:  succeeded
Oct  5 23:19:55 goofy kernel: kjournald starting.  Commit interval 5 seconds
Oct  5 23:19:55 goofy kernel: EXT3-fs: mounted filesystem with ordered data 
mode.
Oct  5 23:19:55 goofy kernel: VFS: Mounted root (ext3 filesystem) readonly.
Oct  5 23:19:55 goofy kernel: Freeing unused kernel memory: 132k freed
Oct  5 23:19:55 goofy kernel: hub.c: new USB device 00:04.2-2, assigned 
address 2
Oct  5 23:19:55 goofy kernel: hub.c: USB hub found at 2
Oct  5 23:19:55 goofy kernel: hub.c: 4 ports detected
Oct  5 23:19:55 goofy kernel: Adding 594396k swap on /dev/hda3.  Priority:-1 
extents:1
Oct  5 23:19:55 goofy kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), 
internal journal
Oct  5 23:19:55 goofy kernel: NTFS volume version 3.0.
Oct  5 23:19:55 goofy kernel: kjournald starting.  Commit interval 5 seconds
Oct  5 23:19:55 goofy kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,65), 
internal journal
Oct  5 23:19:55 goofy kernel: EXT3-fs: mounted filesystem with ordered data 
mode.
Oct  5 23:19:55 goofy kernel: kjournald starting.  Commit interval 5 seconds
Oct  5 23:19:55 goofy kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,66), 
internal journal
Oct  5 23:19:55 goofy kernel: EXT3-fs: mounted filesystem with ordered data 
mode.
Oct  5 23:19:55 goofy kernel: kjournald starting.  Commit interval 5 seconds
Oct  5 23:19:55 goofy kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide1(22,1), 
internal journal
Oct  5 23:19:55 goofy kernel: EXT3-fs: mounted filesystem with ordered data 
mode.
Oct  5 23:19:55 goofy kernel: kjournald starting.  Commit interval 5 seconds
Oct  5 23:19:55 goofy kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide1(22,2), 
internal journal
Oct  5 23:19:55 goofy kernel: EXT3-fs: mounted filesystem with ordered data 
mode.
Oct  5 23:19:55 goofy kernel: FAT: Using codepage cp437
Oct  5 23:19:55 goofy kernel: FAT: Using IO charset iso8859-1
Oct  5 23:19:55 goofy kernel: FAT: Using codepage cp437
Oct  5 23:19:55 goofy kernel: FAT: Using IO charset iso8859-1
Oct  5 23:19:55 goofy netfs: Mounting other filesystems:  succeeded
Oct  5 23:19:56 goofy ntpd[780]: ntpd 4.1.0 Wed Sep  5 06:54:30 EDT 2001 (1)
Oct  5 23:19:56 goofy ntpd: ntpd startup succeeded
Oct  5 23:19:56 goofy ntpd[780]: precision = 6 usec
Oct  5 23:19:56 goofy ntpd[780]: kernel time discipline status 0040
Oct  5 23:19:56 goofy ntpd[780]: getnetnum: "time.nist.gov" invalid host 
number, line ignored
Oct  5 23:19:56 goofy ntpd[780]: frequency initialized -318.481 from 
/etc/ntp/drift
Oct  5 23:19:56 goofy ntpd[780]: bind() fd 9, family 2, port 123, addr 
224.0.1.1, in_classd=1 flags=0 fails: Address already in use
Oct  5 23:19:56 goofy ntpd[780]: ...multicast address 224.0.1.1 using 
wildcard socket
Oct  5 23:19:56 goofy autofs: automount startup succeeded
Oct  5 23:19:53 goofy ifup: Determining IP information for eth0...
Oct  5 23:19:53 goofy ifup:  done.
Oct  5 23:19:53 goofy network: Bringing up interface eth0:  succeeded
Oct  5 23:19:56 goofy sshd: Starting sshd:
Oct  5 23:19:56 goofy sshd:  succeeded
Oct  5 23:19:56 goofy modprobe: modprobe: Can't open dependencies file 
/lib/modules/2.5.40/modules.dep (No such file or directory)
Oct  5 23:19:56 goofy sshd: ^[[60G
Oct  5 23:19:56 goofy sshd:
Oct  5 23:19:56 goofy rc: Starting sshd:  succeeded
Oct  5 23:19:57 goofy xinetd[867]: chargen disabled, removing
Oct  5 23:19:57 goofy xinetd[867]: chargen disabled, removing
Oct  5 23:19:57 goofy xinetd[867]: daytime disabled, removing
Oct  5 23:19:57 goofy xinetd[867]: daytime disabled, removing
Oct  5 23:19:57 goofy xinetd[867]: echo disabled, removing
Oct  5 23:19:57 goofy xinetd[867]: echo disabled, removing
Oct  5 23:19:57 goofy xinetd[867]: finger disabled, removing
Oct  5 23:19:57 goofy xinetd[867]: ntalk disabled, removing
Oct  5 23:19:57 goofy xinetd[867]: exec disabled, removing
Oct  5 23:19:57 goofy xinetd[867]: login disabled, removing
Oct  5 23:19:57 goofy xinetd[867]: shell disabled, removing
Oct  5 23:19:57 goofy xinetd[867]: rsync disabled, removing
Oct  5 23:19:57 goofy xinetd[867]: talk disabled, removing
Oct  5 23:19:57 goofy xinetd[867]: telnet disabled, removing
Oct  5 23:19:57 goofy xinetd[867]: time disabled, removing
Oct  5 23:19:57 goofy xinetd[867]: time disabled, removing
Oct  5 23:19:58 goofy xinetd[867]: xinetd Version 2.3.3 started with libwrap 
options compiled in.
Oct  5 23:19:58 goofy xinetd[867]: Started working: 1 available service
Oct  5 23:20:00 goofy xinetd: xinetd startup succeeded
Oct  5 23:20:01 goofy lpd: lpd startup succeeded
Oct  5 23:20:02 goofy modprobe: modprobe: Can't open dependencies file 
/lib/modules/2.5.40/modules.dep (No such file or directory)
Oct  5 23:20:02 goofy modprobe: modprobe: Can't open dependencies file 
/lib/modules/2.5.40/modules.dep (No such file or directory)
Oct  5 23:20:02 goofy sendmail: sendmail startup succeeded
Oct  5 23:20:02 goofy gpm: gpm startup succeeded
Oct  5 23:20:03 goofy crond: crond startup succeeded
Oct  5 23:20:04 goofy xfs: listening on port 7100
Oct  5 23:20:04 goofy xfs: xfs startup succeeded
Oct  5 23:20:04 goofy anacron: anacron startup succeeded
Oct  5 23:20:04 goofy xfs: ignoring font path element 
/usr/X11R6/lib/X11/fonts/cyrillic (unreadable)
Oct  5 23:20:04 goofy atd: atd startup succeeded
Oct  5 23:20:04 goofy xfs: ignoring font path element 
/usr/X11R6/lib/X11/fonts/local (unreadable)
Oct  5 23:20:05 goofy xfs: ignoring font path element 
/usr/share/AbiSuite/fonts (unreadable)
Oct  5 23:20:10 goofy login(pam_unix)[1047]: session opened for user josh by 
LOGIN(uid=0)

^^^^^

Oct  5 23:20:10 goofy  -- josh[1047]: LOGIN ON tty1 BY josh
Oct  5 23:20:12 goofy kernel: Debug: sleeping function called from illegal 
context at slab.c:1374

^^^^^

Oct  5 23:20:12 goofy kernel: cda87f40 c0119d76 c03aac00 c03acba2 0000055e 
cfffc6c0 c013c9ff c03acba2
Oct  5 23:20:12 goofy kernel:        0000055e cef40cb4 c0134b3a c1286810 
cdbcbb68 cda86000 cdbcbb68 c0134f5a
Oct  5 23:20:12 goofy kernel:        cef40cb4 cdbcbb68 cef40ce4 00000000 
00000400 08080da0 cddb0480 c010d0b3
Oct  5 23:20:12 goofy kernel: Call Trace:
Oct  5 23:20:12 goofy kernel:  [<c0119d76>]__might_sleep+0x56/0x5d
Oct  5 23:20:12 goofy kernel:  [<c013c9ff>]kmalloc+0x4f/0x330
Oct  5 23:20:12 goofy kernel:  [<c0134b3a>]unmap_vma_list+0x1a/0x30
Oct  5 23:20:12 goofy kernel:  [<c0134f5a>]do_munmap+0x18a/0x1a0
Oct  5 23:20:12 goofy kernel:  [<c010d0b3>]sys_ioperm+0x93/0x130
Oct  5 23:20:12 goofy kernel:  [<c01078bf>]syscall_call+0x7/0xb
Oct  5 23:20:12 goofy kernel:
Oct  5 23:20:15 goofy kernel: mtrr: no MTRR for e3000000,800000 found
Oct  5 23:20:21 goofy modprobe: modprobe: Can't open dependencies file 
/lib/modules/2.5.40/modules.dep (No such file or directory)
Oct  5 23:20:22 goofy xinetd[1183]: warning: can't get client address: 
Transport endpoint is not connected
Oct  5 23:20:28 goofy modprobe: modprobe: Can't open dependencies file 
/lib/modules/2.5.40/modules.dep (No such file or directory)
Oct  5 23:20:28 goofy last message repeated 3 times

^^^^^

Oct  5 23:20:29 goofy kernel: Debug: sleeping function called from illegal 
context at /usr/src/linux-2.5.40/include/asm/semaphore.h:119

^^^^^

Oct  5 23:20:29 goofy kernel: cbab7c50 c0119d76 c03aac00 c03a41c0 00000077 
0806fbe0 c02fef87 c03a41c0
Oct  5 23:20:29 goofy kernel:        00000077 00000000 cfdeac00 cfd77a24 
cbab6000 ccc3c400 0806fbe0 c0301683
Oct  5 23:20:29 goofy kernel:        cfd77a24 cbab6000 00000000 00001000 
c0301c21 cfd77a24 00004140 00000000
Oct  5 23:20:29 goofy kernel: Call Trace:
Oct  5 23:20:29 goofy kernel:  [<c0119d76>]__might_sleep+0x56/0x5d
Oct  5 23:20:29 goofy kernel:  [<c02fef87>]snd_pcm_prepare+0x27/0x2e0
Oct  5 23:20:29 goofy kernel:  [<c0301683>]snd_pcm_common_ioctl1+0x213/0x3f0
Oct  5 23:20:29 goofy kernel:  [<c0301c21>]snd_pcm_playback_ioctl1+0x3c1/0x3d0
Oct  5 23:20:29 goofy kernel:  [<c01496cd>]do_page_cache_readahead+0xad/0x1e0
Oct  5 23:20:29 goofy kernel:  [<c0136c18>]find_get_page+0x48/0x70
Oct  5 23:20:29 goofy kernel:  [<c01379e2>]filemap_nopage+0xf2/0x250
Oct  5 23:20:29 goofy kernel:  [<c0133411>]do_no_page+0x2b1/0x3a0
Oct  5 23:20:29 goofy kernel:  [<c01335a2>]handle_mm_fault+0xa2/0x1b0
Oct  5 23:20:29 goofy kernel:  
[<c0301fe7>]snd_pcm_kernel_playback_ioctl+0x27/0x30
Oct  5 23:20:29 goofy kernel:  [<c02f3f65>]snd_pcm_oss_prepare+0x15/0x30
Oct  5 23:20:29 goofy kernel:  [<c02f3fb8>]snd_pcm_oss_make_ready+0x38/0x50
Oct  5 23:20:29 goofy kernel:  [<c02f437b>]snd_pcm_oss_write1+0x3b/0x170
Oct  5 23:20:29 goofy kernel:  [<c02f62e8>]snd_pcm_oss_write+0x38/0x70
Oct  5 23:20:29 goofy kernel:  [<c014da46>]vfs_write+0xb6/0x180
Oct  5 23:20:29 goofy kernel:  [<c012314b>]do_softirq+0x5b/0xc0
Oct  5 23:20:29 goofy kernel:  [<c014db7a>]sys_write+0x2a/0x40
Oct  5 23:20:29 goofy kernel:  [<c01078bf>]syscall_call+0x7/0xb

^^^^^

Oct  5 23:20:29 goofy kernel:
Oct  5 23:20:32 goofy kernel: Debug: sleeping function called from illegal 
context at /usr/src/linux-2.5.40/include/asm/semaphore.h:119

^^^^^

Oct  5 23:20:32 goofy kernel: cbab7c14 c0119d76 c03aac00 c03a41c0 00000077 
ccc3c400 c02fef87 c03a41c0
Oct  5 23:20:32 goofy kernel:        00000077 00000000 cfdeac00 cfd77a24 
cbab6000 ccc3c400 ccc3c400 c0301683
Oct  5 23:20:32 goofy kernel:        cfd77a24 cbab6000 00000000 cfd77a24 
c0301c21 cfd77a24 00004140 00000000
Oct  5 23:20:32 goofy kernel: Call Trace:
Oct  5 23:20:32 goofy kernel:  [<c0119d76>]__might_sleep+0x56/0x5d
Oct  5 23:20:32 goofy kernel:  [<c02fef87>]snd_pcm_prepare+0x27/0x2e0
Oct  5 23:20:32 goofy kernel:  [<c0301683>]snd_pcm_common_ioctl1+0x213/0x3f0
Oct  5 23:20:32 goofy kernel:  [<c0301c21>]snd_pcm_playback_ioctl1+0x3c1/0x3d0
Oct  5 23:20:32 goofy kernel:  [<c0301c21>]snd_pcm_playback_ioctl1+0x3c1/0x3d0
Oct  5 23:20:32 goofy kernel:  [<c01903c1>]journal_dirty_metadata+0x1b1/0x220
Oct  5 23:20:32 goofy kernel:  [<c014f62b>]wake_up_buffer+0xb/0x30
Oct  5 23:20:32 goofy kernel:  [<c018fb7c>]do_get_write_access+0x68c/0x6b0
Oct  5 23:20:32 goofy kernel:  [<c01903c1>]journal_dirty_metadata+0x1b1/0x220
Oct  5 23:20:32 goofy kernel:  [<c01887e5>]ext3_do_update_inode+0x2d5/0x360
Oct  5 23:20:32 goofy kernel:  [<c018883d>]ext3_do_update_inode+0x32d/0x360
Oct  5 23:20:32 goofy kernel:  [<c013c592>]free_block+0x192/0x2c0
Oct  5 23:20:32 goofy kernel:  [<c013cf8d>]kfree+0x14d/0x160
Oct  5 23:20:32 goofy kernel:  [<c01908ac>]journal_stop+0x18c/0x1a0
Oct  5 23:20:32 goofy kernel:  [<c013e451>]__pagevec_release+0x11/0x20
Oct  5 23:20:32 goofy kernel:  [<c013e82b>]__pagevec_lru_add+0x19b/0x1b0
Oct  5 23:20:32 goofy kernel:  [<c01496cd>]do_page_cache_readahead+0xad/0x1e0
Oct  5 23:20:32 goofy kernel:  [<c0136c18>]find_get_page+0x48/0x70
Oct  5 23:20:32 goofy kernel:  [<c01379e2>]filemap_nopage+0xf2/0x250
Oct  5 23:20:32 goofy kernel:  
[<c0301fe7>]snd_pcm_kernel_playback_ioctl+0x27/0x30
Oct  5 23:20:32 goofy kernel:  [<c02f3f65>]snd_pcm_oss_prepare+0x15/0x30
Oct  5 23:20:32 goofy kernel:  [<c02f4065>]snd_pcm_oss_write3+0x95/0xa0
Oct  5 23:20:32 goofy kernel:  [<c02f4321>]snd_pcm_oss_write2+0xb1/0xd0
Oct  5 23:20:32 goofy kernel:  [<c02f4478>]snd_pcm_oss_write1+0x138/0x170
Oct  5 23:20:32 goofy kernel:  [<c02f62e8>]snd_pcm_oss_write+0x38/0x70
Oct  5 23:20:32 goofy kernel:  [<c014da46>]vfs_write+0xb6/0x180
Oct  5 23:20:32 goofy kernel:  [<c0160597>]sys_ioctl+0x287/0x30a
Oct  5 23:20:32 goofy kernel:  [<c014db7a>]sys_write+0x2a/0x40
Oct  5 23:20:32 goofy kernel:  [<c01078bf>]syscall_call+0x7/0xb
Oct  5 23:20:32 goofy kernel:

Configuration:

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_NET=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PPRO_FENCE=y
# CONFIG_HUGETLB_PAGE is not set
CONFIG_SMP=y
CONFIG_PREEMPT=y
# CONFIG_X86_NUMA is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_CPU_FREQ is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#

#
# ACPI Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
# CONFIG_ACPI_SLEEP is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
# CONFIG_ACPI_SLEEP is not set
CONFIG_ACPI_SYSTEM=y
CONFIG_PM=y
# CONFIG_APM is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set

#
# ATA/ATAPI/MFM/RLL device support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NFORCE is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
CONFIG_BLK_DEV_RZ1000=y
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI device support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=y
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_REPORT_LUNS is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=64
CONFIG_AIC7XXX_RESET_DELAY_MS=2000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
CONFIG_SCSI_QLOGIC_1280=y
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old non-SCSI/ATAPI CD-ROM drives
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set

#
#    SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_IPX_INTERN is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
CONFIG_VORTEX=y
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_INTEL_RNG=y
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
CONFIG_AGP_SWORKS=y
# CONFIG_AGP_AMD_8151 is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=y
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_REISERFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=y
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_XFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
CONFIG_NFSD=y
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_EXPORTFS=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=y

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_DT019X is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
CONFIG_SND_EMU10K1=y
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
CONFIG_SND_INTEL8X0=y
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA686 is not set
# CONFIG_SND_VIA8233 is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_LONG_TIMEOUT=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD_ALT=y

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
# CONFIG_USB_HID is not set
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
#   Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_SOFTWARE_SUSPEND is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SLAB=y
# CONFIG_DEBUG_IOVIRT is not set
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_DEBUG_SPINLOCK=y
CONFIG_KALLSYMS=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
CONFIG_SECURITY_CAPABILITIES=y

#
# Library routines
#
# CONFIG_CRC32 is not set
# CONFIG_ZLIB_INFLATE is not set
# CONFIG_ZLIB_DEFLATE is not set
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y

