Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268581AbUIGUHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268581AbUIGUHf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 16:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268303AbUIGUBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 16:01:38 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:8849 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268575AbUIGTzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 15:55:47 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R8
Date: Tue, 7 Sep 2004 21:56:02 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Alexander Nyberg <alexn@dsv.su.se>
References: <20040903120957.00665413@mango.fruits.de> <20040907092659.GA17677@elte.hu> <20040907115722.GA10373@elte.hu>
In-Reply-To: <20040907115722.GA10373@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_SJhPBv0AavR41Zr"
Message-Id: <200409072156.02570.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_SJhPBv0AavR41Zr
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 07 of September 2004 13:57, Ingo Molnar wrote:
> 
> test-booted the x64 kernel and found a number of bugs in the x64 port of
> the VP patch. I've uploaded -R8 that fixes them:
> 
>   
http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk12-R8
> 
> NOTE: i tested a (non-modular) 64-bit bzImage on a 32-bit OS (FC2) but
> havent booted it on a 64-bit userland yet. But i'd expect 64-bit
> userspace to work just fine too.

Heh, works for me like charm!  Thank you very much, Ingo, for the excellent 
job!

It has hanged once (the first time I tried to boot it), while starting either 
postfix or cron (AFAIR), but I haven't been able to get any trace and I can't 
reproduce this.  I'm using the serial console just in case right now.  I'll 
give it a run in production tomorrow.

I'm attaching the output of dmesg in case you want to know what the system is.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--Boundary-00=_SJhPBv0AavR41Zr
Content-Type: text/plain;
  charset="iso-8859-2";
  name="dmesg.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.out"

Bootdata ok (command line is root=/dev/hdc6 vga=792 resume=/dev/hdc3 console=ttyS0,57600)
Linux version 2.6.9-rc1-bk12-VP-R8 (rafael@albercik) (gcc version 3.3.3 (SuSE Linux)) #3 Tue Sep 7 15:51:51 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff40000 (usable)
 BIOS-e820: 000000001ff40000 - 000000001ff50000 (ACPI data)
 BIOS-e820: 000000001ff50000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
No mptable found.
On node 0 totalpages: 130880
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126784 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
PCI bridge 00:0a from 10de found. Setting "noapic". Overwrite with "apic"
ACPI: RSDP (v000 ACPIAM                                    ) @ 0x00000000000f76e0
ACPI: RSDT (v001 A M I  OEMRSDT  0x04000413 MSFT 0x00000097) @ 0x000000001ff40000
ACPI: FADT (v001 A M I  OEMFACP  0x04000413 MSFT 0x00000097) @ 0x000000001ff40200
ACPI: OEMB (v001 A M I  OEMBIOS  0x04000413 MSFT 0x00000097) @ 0x000000001ff50040
  >>> ERROR: Invalid checksum
ACPI: DSDT (v001  L5DK8 L5DK8013 0x00000013 INTL 0x02002026) @ 0x0000000000000000
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: ASUSTeK  <6>Product ID: L5D          <6>APIC at: 0xFEE00000
Processor #0 15:4 APIC version 16
I/O APIC #1 Version 17 at 0xFEC00000.
Processors: 1
Checking aperture...
CPU 0: aperture @ e8000000 size 128 MB
Built 1 zonelists
Kernel command line: root=/dev/hdc6 vga=792 resume=/dev/hdc3 console=ttyS0,57600
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 65536 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1795.407 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 509360k/523520k available (2847k kernel code, 13676k reserved, 1147k data, 172k init)
Calibrating delay loop... 3555.32 BogoMIPS (lpj=1777664)
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 0a
 tbxface-0117 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:........................................................................................................................................................................................................................................................................................................................................
Table [DSDT](id F004) - 1106 Objects with 63 Devices 328 Methods 32 Regions
ACPI Namespace successfully loaded at root ffffffff80547740
ACPI: IRQ9 SCI: Edge set to Level Trigger.
evxfevnt-0093 [03] acpi_enable           : Transition to ACPI mode successful
Using local APIC NMI watchdog using perfctr0
Using local APIC timer interrupts.
Detected 12.468 MHz APIC timer.
requesting new irq thread for IRQ0...
requesting new irq thread for IRQ2...
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040715
evgpeblk-0980 [07] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs at 0000000000004020 on int 0x9
evgpeblk-0989 [07] ev_create_gpe_block   : Found 6 Wake, Enabled 0 Runtime GPEs in this block
evgpeblk-0980 [07] ev_create_gpe_block   : GPE 20 to 5F [_GPE] 8 regs at 00000000000044A0 on int 0x9
evgpeblk-0989 [07] ev_create_gpe_block   : Found 0 Wake, Enabled 4 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:...............................................................................................................................
Initialized 31/32 Regions 26/26 Fields 43/43 Buffers 27/27 Packages (1115 nodes)
Executing all Device _STA and_INI methods:...................................................................
67 Devices found containing: 67 _STA, 5 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 37)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUS0] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUS1] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUS2] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LKLN] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LAUI] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LKMO] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LKSM] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LTID] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LATA] (IRQs 3 4 6 7 10 11 12 *14 15)
ACPI: Power Resource [GFAN] (off)
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LKSM] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:01.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LUS1] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LAUI] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LKMO] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:06.1[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI interrupt 0000:02:01.1[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI interrupt 0000:02:01.3[D] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:02:01.4[D] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
agpgart: Detected AGP bridge 0
agpgart: Setting up Nforce3 AGP.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xe8000000
PCI-DMA: Disabling IOMMU.
vesafb: framebuffer at 0xd0000000, mapped to 0xffffff0000100000, size 6144k
vesafb: mode is 1024x768x32, linelength=4096, pages=1
vesafb: scrolling: redraw
vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
fb0: VESA VGA frame buffer device
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1094586031.893:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
Console: switching to colour frame buffer device 128x48
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI interrupt 0000:00:06.1[B] -> GSI 10 (level, low) -> IRQ 10
RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-150: IDE controller at PCI slot 0000:00:08.0
NFORCE3-150: chipset revision 165
NFORCE3-150: not 100% native mode: will probe irqs later
NFORCE3-150: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-150: 0000:00:08.0 (rev a5) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hdb: TOSHIBA DVD-ROM SD-R2512, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: IC25N060ATMR04-0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hdc: max request size: 1024KiB
hdc: 117210240 sectors (60011 MB) w/7884KiB Cache, CHS=16383/255/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 hdc7 hdc8 hdc9 hdc10 >
hdb: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.9
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 28Kbytes
TCP: Hash tables configured (established 32768 bind 4681)
NET: Registered protocol family 1
Resume Machine: resuming from /dev/hdc3
Resuming from device unknown-block(22,3)
Resume Machine: This is normal swap space
ACPI: (supports S0 S1 S3 S4 S5)
ACPI wakeup devices: 
 MDM P0P1 LAN0 LAN1 USB0 USB1 USB2 SLPB 
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 172k freed
kjournald starting.  Commit interval 5 seconds
Adding 1534196k swap on /dev/hdc3.  Priority:42 extents:1
EXT3 FS on hdc6, internal journal
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: hdc9: found reiserfs format "3.6" with standard journal
ReiserFS: hdc9: using ordered data mode
ReiserFS: hdc9: journal params: device hdc9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdc9: checking transaction log (hdc9)
ReiserFS: hdc9: Using r5 hash to sort names
ReiserFS: hdc10: found reiserfs format "3.6" with standard journal
ReiserFS: hdc10: using ordered data mode
ReiserFS: hdc10: journal params: device hdc10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdc10: checking transaction log (hdc10)
ReiserFS: hdc10: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
usbcore: registered new driver usbfs
usbcore: registered new driver hub
NET: Registered protocol family 17
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    scatter-gather:  enabled
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:00:02.0: nVidia Corporation nForce3 USB 1.1
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 11, pci mem ffffff00000c2000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:02.1: nVidia Corporation nForce3 USB 1.1 (#2)
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 5, pci mem ffffff00000d4000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:02.2: nVidia Corporation nForce3 USB 2.0
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 10, pci mem ffffff00000c4c00
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 6 ports detected
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 9 (level, low) -> IRQ 9
Yenta: CardBus bridge found at 0000:02:01.0 [1043:1854]
spurious 8259A interrupt: IRQ7.
Yenta: ISA IRQ mask 0x0008, PCI irq 9
Socket status: 30000006
ACPI: PCI interrupt 0000:02:01.1[B] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:01.1 [1043:1854]
usb 1-2: new low speed USB device using address 2
Yenta: ISA IRQ mask 0x0008, PCI irq 11
Socket status: 30000006
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 11 (level, low) -> IRQ 11
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[feafd000-feafd7ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000319b175]
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:06.0 to 64
ACPI: AC Adapter [AC0] (on-line)
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff804a4420(lo)
IPv6 over IPv4 tunneling driver
Disabled Privacy Extensions on device 000001001bf9f800(sit0)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Fan [FN00] (off)
intel8x0_measure_ac97_clock: measured 49491 usecs
intel8x0: clocking to 48000
ALSA sound/pci/intel8x0.c:2844: joystick(s) found
acpi_processor-2264 [121] acpi_processor_get_inf: Invalid PBLK length [0]
ACPI: Processor [CPU1] (supports C1)
ACPI: Thermal Zone [THRM] (53 C)
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09b)
powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0x0 (800 MHz), vid 0x12 (1100 mV)
powernow-k8: cpu_init done, current fid 0xa, vid 0x2
usbcore: registered new driver hiddev
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:02.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
eth0: no IPv6 routers present
Non-volatile memory driver v1.2
SCSI subsystem initialized
st: Version 20040403, fixed bufsize 32768, s/g segs 256
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
lp0: using parport0 (polling).
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
usbcore: registered new driver usbserial_generic
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
mtrr: 0xd0000000,0x4000000 overlaps existing 0xd0000000,0x400000

--Boundary-00=_SJhPBv0AavR41Zr--
