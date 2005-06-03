Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVFCRnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVFCRnO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 13:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVFCRnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 13:43:14 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:16574 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261419AbVFCRlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 13:41:16 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: 2.6.12-rc5 : repeatable modprobe usb-storage hang
Date: Fri, 3 Jun 2005 13:41:17 -0400
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9YJoCpV+by0qAwa"
Message-Id: <200506031341.17749.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_9YJoCpV+by0qAwa
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 2.6.12-rc5 modprobe usb-storage hangs forever - it is reproducible most of 
the times.

The last line in dmesg is -
[  155.995171] Initializing USB Mass Storage driver...

Also interesting is this line -
[   40.586298] ohci_hcd 0000:00:02.0: Unlink after no-IRQ?  Controller is 
probably using the wrong IRQ.

Above happens intermittently. 

dmesg output (out) and SysRQ+T attached.

Parag

--Boundary-00=_9YJoCpV+by0qAwa
Content-Type: text/plain;
  charset="us-ascii";
  name="out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="out"

6>[    0.000000] Allocating PCI resources starting at 30000000 (gap: 30000000:cff80000)
[    0.000000] Checking aperture...
[    0.000000] CPU 0: aperture @ e8000000 size 128 MB
[    0.000000] Built 1 zonelists
[    0.000000] Kernel command line: root=/dev/hda2 vga=0x317 video=vesafb:ywrap,mtrr clock=tsc
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 131072 bytes)
[    0.000000] time.c: Using 3.579545 MHz PM timer.
[    0.000000] time.c: Detected 1994.896 MHz processor.
[   11.968590] time.c: Using PIT/TSC based timekeeping.
[   11.968616] Console: colour dummy device 80x25
[   11.969796] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   11.970624] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[   11.988076] Memory: 767860k/785856k available (3049k kernel code, 17292k reserved, 1267k data, 184k init)
[   11.988129] Calibrating delay loop... 3948.54 BogoMIPS (lpj=1974272)
[   12.009573] Mount-cache hash table entries: 256
[   12.009651] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   12.009656] CPU: L2 Cache: 1024K (64 bytes/line)
[   12.009661] CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 08
[   12.058106] Using local APIC timer interrupts.
[   12.108208] Detected 12.468 MHz APIC timer.
[   12.108217] testing NMI watchdog ... OK.
[   12.118353] NET: Registered protocol family 16
[   12.118379] PCI: Using configuration type 1
[   12.118383] mtrr: v2.0 (20020519)
[   12.118671] ACPI: Subsystem revision 20050309
[   12.144719] ACPI: Interpreter enabled
[   12.144724] ACPI: Using IOAPIC for interrupt routing
[   12.145026] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   12.145030] PCI: Probing PCI hardware (bus 00)
[   12.145689] Boot video device is 0000:01:00.0
[   12.146200] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   12.147058] ACPI: Embedded Controller [EC0] (gpe 33)
[   12.189838] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P0._PRT]
[   12.190032] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP0._PRT]
[   12.190539] ACPI: PCI Interrupt Link [LNK1] (IRQs 16 18 19) *0
[   12.190818] ACPI: PCI Interrupt Link [LNK2] (IRQs 16 18 19) *0
[   12.191098] ACPI: PCI Interrupt Link [LNK3] (IRQs 17) *0
[   12.191377] ACPI: PCI Interrupt Link [LNK4] (IRQs 16 18 19) *0, disabled.
[   12.191665] ACPI: PCI Interrupt Link [LNK5] (IRQs 16 18 19) *0
[   12.191939] ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22) *0
[   12.192213] ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22) *0
[   12.192490] ACPI: PCI Interrupt Link [LUS1] (IRQs 20 21 22) *0
[   12.192762] ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22) *0
[   12.193036] ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22) *0, disabled.
[   12.193311] ACPI: PCI Interrupt Link [LACI] (IRQs 20 21 22) *0
[   12.193588] ACPI: PCI Interrupt Link [LMCI] (IRQs 20 21 22) *0
[   12.193862] ACPI: PCI Interrupt Link [LPID] (IRQs 20 21 22) *0, disabled.
[   12.194141] ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22) *0, disabled.
[   12.194336] SCSI subsystem initialized
[   12.194372] usbcore: registered new driver usbfs
[   12.194391] usbcore: registered new driver hub
[   12.194442] PCI: Using ACPI for IRQ routing
[   12.194447] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   12.194501] TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
[   12.194526] agpgart: Detected AGP bridge 0
[   12.194533] agpgart: Setting up Nforce3 AGP.
[   12.198881] agpgart: AGP aperture is 128M @ 0xe8000000
[   12.198906] PCI-DMA: Disabling IOMMU.
[   12.199584] Simple Boot Flag at 0x37 set to 0x1
[   12.199672] IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
[   12.200260] SGI XFS with ACLs, large block/inode numbers, no debug enabled
[   12.200349] Initializing Cryptographic API
[   12.200434] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   12.200438] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.4
[   12.200553] vesafb: framebuffer at 0xf0000000, mapped to 0xffffc20000100000, using 3072k, total 65536k
[   12.200560] vesafb: mode is 1024x768x16, linelength=2048, pages=1
[   12.200563] vesafb: scrolling: redraw
[   12.200567] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[   12.214075] Console: switching to colour frame buffer device 128x48
[   12.214162] fb0: VESA VGA frame buffer device
[   12.215186] ACPI: AC Adapter [ACAD] (on-line)
[   12.329007] ACPI: Battery Slot [BAT1] (battery present)
[   12.329090] ACPI: Power Button (FF) [PWRF]
[   12.329147] ACPI: Lid Switch [LID]
[   12.329423] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[   12.330450] ACPI: CPU0 (power states: C1[C1] C2[C2])
[   12.341360] ACPI: Thermal Zone [THRM] (68 C)
[   12.351445] Real Time Clock Driver v1.12
[   12.351542] Non-volatile memory driver v1.2
[   12.351603] Linux agpgart interface v0.101 (c) Dave Jones
[   12.351678] [drm] Initialized drm 1.0.0 20040925
[   12.358484] i8042.c: Detected active multiplexing controller, rev 1.1.
[   12.364770] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[   12.365705] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[   12.366689] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[   12.367422] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[   12.368306] serio: i8042 KBD port at 0x60,0x64 irq 1
[   12.370631] Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
[   12.373748] ACPI: PCI Interrupt Link [LMCI] enabled at IRQ 22
[   12.376200] ACPI: PCI Interrupt 0000:00:06.1[B] -> Link [LMCI] -> GSI 22 (level, low) -> IRQ 22
[   12.378731] io scheduler noop registered
[   12.381222] io scheduler anticipatory registered
[   12.383665] io scheduler deadline registered
[   12.386053] io scheduler cfq registered
[   12.388615] RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
[   12.391131] loop: loaded (max 8 devices)
[   12.393570] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   12.396023] Losing some ticks... checking if CPU frequency changed.
[   12.396032] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   12.398581] NFORCE3-150: IDE controller at PCI slot 0000:00:08.0
[   12.401125] NFORCE3-150: chipset revision 165
[   12.403613] NFORCE3-150: not 100% native mode: will probe irqs later
[   12.406098] NFORCE3-150: BIOS didn't set cable bits correctly. Enabling workaround.
[   12.408592] NFORCE3-150: 0000:00:08.0 (rev a5) UDMA133 controller
[   12.411065]     ide0: BM-DMA at 0x2080-0x2087, BIOS settings: hda:DMA, hdb:pio
[   12.413583]     ide1: BM-DMA at 0x2088-0x208f, BIOS settings: hdc:DMA, hdd:pio
[   12.416049] Probing IDE interface ide0...
[   12.679108] hda: FUJITSU MHT2060AT PL, ATA DISK drive
[   13.297055] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   13.299483] Probing IDE interface ide1...
[   13.970104] hdc: HL-DT-ST DVD+RW GCA-4040N, ATAPI CD/DVD-ROM drive
[   14.278055] ide1 at 0x170-0x177,0x376 on irq 15
[   14.280551] Probing IDE interface ide2...
[   14.792379] Probing IDE interface ide3...
[   15.303981] Probing IDE interface ide4...
[   15.815583] Probing IDE interface ide5...
[   16.327197] hda: max request size: 128KiB
[   16.401823] hda: 117210240 sectors (60011 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
[   16.407334] hda: cache flushes supported
[   16.409806]  hda: hda1 hda2 hda3 hda4
[   16.456148] hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
[   16.458648] Uniform CD-ROM driver Revision: 3.20
[   16.462929] mice: PS/2 mouse device common for all mice
[   16.465450] Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24 10:33:39 2005 UTC).
[   16.469146] ALSA device list:
[   16.471695]   No soundcards found.
[   16.474254] NET: Registered protocol family 2
[   16.487616] IP: routing cache hash table of 8192 buckets, 64Kbytes
[   16.490408] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[   16.493929] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[   16.497173] TCP: Hash tables configured (established 131072 bind 65536)
[   16.499872] NET: Registered protocol family 1
[   16.502508] NET: Registered protocol family 10
[   16.505221] Disabled Privacy Extensions on device ffffffff804e75c0(lo)
[   16.508000] IPv6 over IPv4 tunneling driver
[   16.512003] NET: Registered protocol family 17
[   16.514765] NET: Registered protocol family 15
[   16.517491] powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09e)
[   16.521933] powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
[   16.524696] powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0xa (1300 mV)
[   16.527333] powernow-k8:    2 : fid 0x0 (800 MHz), vid 0x12 (1100 mV)
[   16.529975] cpu_init done, current fid 0xc, vid 0x2
[   16.532662] ACPI wakeup devices: 
[   16.535314] USB0 USB1 USB2 PS2K PS2M MAC0 
[   16.537950] ACPI: (supports S0 S3 S4 S5)
[   16.540570] BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
[   16.556297] input: AT Translated Set 2 keyboard on isa0060/serio0
[   16.566739] ReiserFS: hda2: found reiserfs format "3.6" with standard journal
[   18.485257] ReiserFS: hda2: using ordered data mode
[   18.502935] ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   18.510373] ReiserFS: hda2: checking transaction log (hda2)
[   18.589334] ReiserFS: hda2: Using r5 hash to sort names
[   18.592007] VFS: Mounted root (reiserfs filesystem) readonly.
[   18.594914] Freeing unused kernel memory: 184k freed
[   21.883034] Adding 2241056k swap on /dev/hda4.  Priority:-1 extents:1
[   29.615995] 8139too Fast Ethernet driver 0.9.27
[   29.621989] ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 19
[   29.621998] ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNK2] -> GSI 19 (level, low) -> IRQ 19
[   29.624842] eth0: RealTek RTL8139 at 0xffffc2000004e800, 00:0f:b0:01:01:65, IRQ 19
[   29.624846] eth0:  Identified 8139 chip type 'RTL-8101'
[   29.754096] input: PS/2 Generic Mouse on isa0060/serio4
[   33.146486] NTFS driver 2.1.22 [Flags: R/O MODULE].
[   33.271486] NTFS volume version 3.1.
[   33.282712] ReiserFS: hda3: found reiserfs format "3.6" with standard journal
[   33.283481] ReiserFS: hda3: using ordered data mode
[   33.283770] ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   33.285396] ReiserFS: hda3: checking transaction log (hda3)
[   33.611163] ReiserFS: hda3: Using r5 hash to sort names
[   34.504573] eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[   38.796272] i2c_adapter i2c-0: nForce2 SMBus adapter at 0x2040
[   38.806900] i2c_adapter i2c-1: nForce2 SMBus adapter at 0x2000
[   38.917211] ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
[   38.927467] PCI: Enabling device 0000:00:02.0 (0004 -> 0006)
[   38.927690] ACPI: PCI Interrupt 0000:00:02.0[P]: no GSI - using IRQ 11
[   38.927766] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   38.927816] ohci_hcd 0000:00:02.0: nVidia Corporation nForce3 USB 1.1
[   39.140886] ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
[   39.141041] ohci_hcd 0000:00:02.0: irq 11, io mem 0xe0000000
[   39.199020] hub 1-0:1.0: USB hub found
[   39.199164] hub 1-0:1.0: 3 ports detected
[   39.201408] PCI: Enabling device 0000:00:02.1 (0004 -> 0006)
[   39.201803] ACPI: PCI Interrupt Link [LUS1] enabled at IRQ 21
[   39.201858] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUS1] -> GSI 21 (level, low) -> IRQ 21
[   39.201931] PCI: Setting latency timer of device 0000:00:02.1 to 64
[   39.201980] ohci_hcd 0000:00:02.1: nVidia Corporation nForce3 USB 1.1 (#2)
[   39.429777] ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
[   39.429930] ohci_hcd 0000:00:02.1: irq 21, io mem 0xe0001000
[   39.492657] hub 2-0:1.0: USB hub found
[   39.492800] hub 2-0:1.0: 3 ports detected
[   39.587075] usb 1-1: new full speed USB device using ohci_hcd and address 2
[   40.129589] ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 20
[   40.129732] ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [LUS2] -> GSI 20 (level, low) -> IRQ 20
[   40.129808] PCI: Setting latency timer of device 0000:00:02.2 to 64
[   40.129858] ehci_hcd 0000:00:02.2: nVidia Corporation nForce3 USB 2.0
[   40.140778] ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
[   40.140930] ehci_hcd 0000:00:02.2: irq 20, io mem 0xe0004000
[   40.141006] PCI: cache line size of 64 is not supported by device 0000:00:02.2
[   40.141056] ehci_hcd 0000:00:02.2: park 0
[   40.141099] ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
[   40.146724] hub 3-0:1.0: USB hub found
[   40.146868] hub 3-0:1.0: 6 ports detected
[   40.367126] ACPI: PCI Interrupt Link [LACI] enabled at IRQ 22
[   40.367271] ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LACI] -> GSI 22 (level, low) -> IRQ 22
[   40.367356] PCI: Setting latency timer of device 0000:00:06.0 to 64
[   40.574331] AC'97 0 analog subsections not ready
[   40.586298] ohci_hcd 0000:00:02.0: Unlink after no-IRQ?  Controller is probably using the wrong IRQ.
[   41.133872] intel8x0_measure_ac97_clock: measured 49404 usecs
[   41.133926] intel8x0: clocking to 47427
[   41.422498] ACPI: PCI Interrupt 0000:00:06.1[B] -> Link [LMCI] -> GSI 22 (level, low) -> IRQ 22
[   41.422739] PCI: Setting latency timer of device 0000:00:06.1 to 64
[   41.612712] libata version 1.10 loaded.
[   42.657291] nvidia: module license 'NVIDIA' taints kernel.
[   42.682024] ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 18
[   42.682177] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNK5] -> GSI 18 (level, low) -> IRQ 18
[   42.682261] NVRM: loading NVIDIA Linux x86_64 NVIDIA Kernel Module  1.0-6629  Wed Nov  3 11:43:48 PST 2004
[   42.763181] ieee1394: Initialized config rom entry `ip1394'
[   42.785217] ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
[   42.785745] ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 16
[   42.785803] ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNK1] -> GSI 16 (level, low) -> IRQ 16
[   42.847850] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[16]  MMIO=[e0108000-e01087ff]  Max Packet=[2048]
[   42.975985] 8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
[   43.580288] USB Universal Host Controller Interface driver v2.2
[   44.115090] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[463f0200463f0200]
[   44.149687] eth1394: $Rev: 1247 $ Ben Collins <bcollins@debian.org>
[   44.152449] eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
[   46.577992] codec_semaphore: semaphore is not ready [0x1][0x301300]
[   46.578042] codec_write 1: semaphore is not ready for register 0x54
[   49.779811] eth0: link up, 10Mbps, half-duplex, lpa 0x0000
[   55.600415] agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
[   55.600566] agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
[   55.600607] agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[   56.201548] agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
[   56.201700] agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
[   56.201741] agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[   60.498808] eth0: no IPv6 routers present
[   76.762073] codec_semaphore: semaphore is not ready [0x1][0x301300]
[   76.762274] codec_read 0: semaphore is not ready for register 0x76
[   76.763441] codec_semaphore: semaphore is not ready [0x1][0x301300]
[   76.763544] codec_read 1: semaphore is not ready for register 0x54
[  155.995171] Initializing USB Mass Storage driver...

--Boundary-00=_9YJoCpV+by0qAwa
Content-Type: text/plain;
  charset="us-ascii";
  name="sysrq-t"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sysrq-t"


Jun  3 13:38:41 tux-gentoo _fd+372} <ffffffff803c0ed5>{unix_create+117}
Jun  3 13:38:41 tux-gentoo [  299.624739]        <ffffffff8010e896>{system_call+126} 
Jun  3 13:38:41 tux-gentoo [  299.624749] 10-hal.dev    S ffff81002f528a80     0 10766      1         10768 10764 (NOTLB)
Jun  3 13:38:41 tux-gentoo [  299.624755] ffff81001b713b68 0000000000000086 0000000000000000 ffff81001b6cfff8 
Jun  3 13:38:41 tux-gentoo [  299.624759]        00000070aabc0828 ffff81002ae77560 ffff81002ae76ed0 ffff81002ae77770 
Jun  3 13:38:41 tux-gentoo [  299.624765]        ffff81001be41200 0000000000000001 
Jun  3 13:38:41 tux-gentoo [  299.624768] Call Trace:<ffffffff803f767e>{schedule_timeout+30} <ffffffff8025c165>{__up_read+149}
Jun  3 13:38:41 tux-gentoo [  299.624778]        <ffffffff80149f51>{prepare_to_wait_exclusive+113} <ffffffff803c18de>{unix_wait_for_peer+238}
Jun  3 13:38:41 tux-gentoo [  299.624787]        <ffffffff8014a030>{autoremove_wake_function+0} <ffffffff8029fcda>{extract_buf+266}
Jun  3 13:38:41 tux-gentoo [  299.624794]        <ffffffff8014a030>{autoremove_wake_function+0} <ffffffff803c259c>{unix_dgram_sendmsg+1020}
Jun  3 13:38:41 tux-gentoo [  299.624804]        <ffffffff803612be>{sock_sendmsg+238} <ffffffff8029fcda>{extract_buf+266}
Jun  3 13:38:41 tux-gentoo [  299.624813]        <ffffffff80155b4d>{find_get_page+61} <ffffffff80156bea>{filemap_nopage+394}
Jun  3 13:38:41 tux-gentoo [  299.624822]        <ffffffff801660e0>{handle_mm_fault+400} <ffffffff8014a030>{autoremove_wake_function+0}
Jun  3 13:38:41 tux-gentoo [  299.624834]        <ffffffff80360fca>{sockfd_lookup+26} <ffffffff80360cb7>{move_addr_to_kernel+39}
Jun  3 13:38:41 tux-gentoo [  299.624842]        <ffffffff803628c9>{sys_sendto+233} <ffffffff80360f84>{sock_map_fd+372}
Jun  3 13:38:41 tux-gentoo [  299.624852]        <ffffffff803c0ed5>{unix_create+117} <ffffffff8010e896>{system_call+126}
Jun  3 13:38:41 tux-gentoo [  299.624861]        
Jun  3 13:38:41 tux-gentoo [  299.624866] 10-hal.dev    S ffff81002f528a80     0 10768      1         10770 10766 (NOTLB)
Jun  3 13:38:41 tux-gentoo [  299.624872] ffff81001b7b3b68 0000000000000082 ffff81002b4e4800 000000101b762fe0 
Jun  3 13:38:41 tux-gentoo [  299.624876]        00000070aabc0828 ffff81002b4e4800 ffff81002b20d010 ffff81002b4e4a10 
Jun  3 13:38:41 tux-gentoo [  299.624882]        ffff81002ff6fb10 0000000000000292 
Jun  3 13:38:41 tux-gentoo [  299.624885] Call Trace:<ffffffff803f767e>{schedule_timeout+30} <ffffffff80149f51>{prepare_to_wait_exclusive+113}
Jun  3 13:38:41 tux-gentoo [  299.624897]        <ffffffff803c18de>{unix_wait_for_peer+238} <ffffffff8014a030>{autoremove_wake_function+0}
Jun  3 13:38:41 tux-gentoo [  299.624906]        <ffffffff8029fcda>{extract_buf+266} <ffffffff8014a030>{autoremove_wake_function+0}
Jun  3 13:38:41 tux-gentoo [  299.624913]        <ffffffff803c259c>{unix_dgram_sendmsg+1020} <ffffffff803612be>{sock_sendmsg+238}
Jun  3 13:38:41 tux-gentoo [  299.624925]        <ffffffff8029fcda>{extract_buf+266} <ffffffff80155b4d>{find_get_page+61}
Jun  3 13:38:41 tux-gentoo [  299.624933]        <ffffffff80156bea>{filemap_nopage+394} <ffffffff801660e0>{handle_mm_fault+400}
Jun  3 13:38:41 tux-gentoo [  299.624944]        <ffffffff8014a030>{autoremove_wake_function+0} <ffffffff80360fca>{sockfd_lookup+26}
Jun  3 13:38:41 tux-gentoo [  299.624953]        <ffffffff80360cb7>{move_addr_to_kernel+39} <ffffffff803628c9>{sys_sendto+233}
Jun  3 13:38:41 tux-gentoo [  299.624960]        <ffffffff80360f84>{sock_map_fd+372} <ffffffff803c0ed5>{unix_create+117}
Jun  3 13:38:41 tux-gentoo [  299.624971]        <ffffffff8010e896>{system_call+126} 
Jun  3 13:38:41 tux-gentoo [  299.624980] 10-hal.dev    S ffff81002f528a80     0 10770      1         10772 10768 (NOTLB)
Jun  3 13:38:41 tux-gentoo [  299.624987] ffff81001b035b68 0000000000000086 0000000000000000 ffff81001b7faff8 
Jun  3 13:38:41 tux-gentoo [  299.624990]        00000070aabc0828 ffff81001b638980 ffff81002bbf0e90 ffff81001b638b90 
Jun  3 13:38:41 tux-gentoo [  299.624996]        ffff81001b7b5300 0000000000000001 
Jun  3 13:38:41 tux-gentoo [  299.624999] Call Trace:<ffffffff803f767e>{schedule_timeout+30} <ffffffff8025c165>{__up_read+149}
Jun  3 13:38:41 tux-gentoo [  299.625009]        <ffffffff80149f51>{prepare_to_wait_exclusive+113} <ffffffff803c18de>{unix_wait_for_peer+238}
Jun  3 13:38:41 tux-gentoo [  299.625018]        <ffffffff8014a030>{autoremove_wake_function+0} <ffffffff8029fcda>{extract_buf+266}
Jun  3 13:38:41 tux-gentoo [  299.625026]        <ffffffff8014a030>{autoremove_wake_function+0} <ffffffff803c259c>{unix_dgram_sendmsg+1020}
Jun  3 13:38:41 tux-gentoo [  299.625035]        <ffffffff803612be>{sock_sendmsg+238} <ffffffff8029fcda>{extract_buf+266}
Jun  3 13:38:41 tux-gentoo [  299.625044]        <ffffffff80155b4d>{find_get_page+61} <ffffffff80156bea>{filemap_nopage+394}
Jun  3 13:38:41 tux-gentoo [  299.625053]        <ffffffff801660e0>{handle_mm_fault+400} <ffffffff8014a030>{autoremove_wake_function+0}
Jun  3 13:38:41 tux-gentoo [  299.625065]        <ffffffff80360fca>{sockfd_lookup+26} <ffffffff80360cb7>{move_addr_to_kernel+39}
Jun  3 13:38:41 tux-gentoo [  299.625073]        <ffffffff803628c9>{sys_sendto+233} <ffffffff80360f84>{sock_map_fd+372}
Jun  3 13:38:41 tux-gentoo [  299.625083]        <ffffffff803c0ed5>{unix_create+117} <ffffffff8010e896>{system_call+126}
Jun  3 13:38:41 tux-gentoo [  299.625092]        
Jun  3 13:38:41 tux-gentoo [  299.625097] 10-hal.dev    S ffff81002f528a80     0 10772      1         10774 10770 (NOTLB)
Jun  3 13:38:41 tux-gentoo [  299.625104] ffff81002baf1b68 0000000000000082 ffff81002b632330 000000108025c165 
Jun  3 13:38:41 tux-gentoo [  299.625108]        00000072aabc0828 ffff81002b632330 ffff81002ab21760 ffff81002b632540 
Jun  3 13:38:41 tux-gentoo [  299.625113]        ffff81002ff6fb10 0000000000000292 
Jun  3 13:38:41 tux-gentoo [  299.625117] Call Trace:<ffffffff803f767e>{schedule_timeout+30} <ffffffff80149f51>{prepare_to_wait_exclusive+113}
Jun  3 13:38:41 tux-gentoo [  299.625128]        <ffffffff803c18de>{unix_wait_for_peer+238} <ffffffff8014a030>{autoremove_wake_function+0}
Jun  3 13:38:41 tux-gentoo [  299.625137]        <ffffffff8029fcda>{extract_buf+266} <ffffffff8014a030>{autoremove_wake_function+0}
Jun  3 13:38:41 tux-gentoo [  299.625145]        <ffffffff803c259c>{unix_dgram_sendmsg+1020} <ffffffff803612be>{sock_sendmsg+238}
Jun  3 13:38:41 tux-gentoo [  299.625156]        <ffffffff8029fcda>{extract_buf+266} <ffffffff80155b4d>{find_get_page+61}
Jun  3 13:38:41 tux-gentoo [  299.625164]        <ffffffff80156bea>{filemap_nopage+394} <ffffffff801660e0>{handle_mm_fault+400}
Jun  3 13:38:41 tux-gentoo [  299.625176]        <ffffffff8014a030>{autoremove_wake_function+0} <ffffffff80360fca>{sockfd_lookup+26}
Jun  3 13:38:41 tux-gentoo [  299.625184]        <ffffffff80360cb7>{move_addr_to_kernel+39} <ffffffff803628c9>{sys_sendto+233}
Jun  3 13:38:41 tux-gentoo [  299.625191]        <ffffffff80360f84>{sock_map_fd+372} <ffffffff803c0ed5>{unix_create+117}
Jun  3 13:38:41 tux-gentoo [  299.625202]        <ffffffff8010e896>{system_call+126} 
Jun  3 13:38:41 tux-gentoo [  299.625211] 10-hal.dev    S ffff81002f528a80     0 10774      1         10780 10772 (NOTLB)
Jun  3 13:38:41 tux-gentoo [  299.625218] ffff81002aa95b68 0000000000000086 0000000000000000 ffff81002aabcff8 
Jun  3 13:38:41 tux-gentoo [  299.625222]        00000072aabc0828 ffff81001b6382f0 ffff81002ab210d0 ffff81001b638500 
Jun  3 13:38:41 tux-gentoo [  299.625228]        ffff81001b7b4ec0 0000000000000001 
Jun  3 13:38:41 tux-gentoo [  299.625231] Call Trace:<ffffffff803f767e>{schedule_timeout+30} <ffffffff8025c165>{__up_read+149}
Jun  3 13:38:41 tux-gentoo [  299.625241]        <ffffffff80149f51>{prepare_to_wait_exclusive+113} <ffffffff803c18de>{unix_wait_for_peer+238}
Jun  3 13:38:41 tux-gentoo [  299.625250]        <ffffffff8014a030>{autoremove_wake_function+0} <ffffffff8029fcda>{extract_buf+266}
Jun  3 13:38:41 tux-gentoo [  299.625257]        <ffffffff8014a030>{autoremove_wake_function+0} <ffffffff803c259c>{unix_dgram_sendmsg+1020}
Jun  3 13:38:41 tux-gentoo [  299.625266]        <ffffffff803612be>{sock_sendmsg+238} <ffffffff8029fcda>{extract_buf+266}
Jun  3 13:38:41 tux-gentoo [  299.625276]        <ffffffff80155b4d>{find_get_page+61} <ffffffff80156bea>{filemap_nopage+394}
Jun  3 13:38:41 tux-gentoo [  299.625285]        <ffffffff801660e0>{handle_mm_fault+400} <ffffffff8014a030>{autoremove_wake_function+0}
Jun  3 13:38:41 tux-gentoo [  299.625297]        <ffffffff80360fca>{sockfd_lookup+26} <ffffffff80360cb7>{move_addr_to_kernel+39}
Jun  3 13:38:41 tux-gentoo [  299.625304]        <ffffffff803628c9>{sys_sendto+233} <ffffffff80360f84>{sock_map_fd+372}
Jun  3 13:38:41 tux-gentoo [  299.625315]        <ffffffff803c0ed5>{unix_create+117} <ffffffff8010e896>{system_call+126}
Jun  3 13:38:41 tux-gentoo [  299.625324]        
Jun  3 13:38:41 tux-gentoo [  299.625329] kio_pop3      S ffff810020cf70c0     0 10775  10590               10656 (NOTLB)
Jun  3 13:38:41 tux-gentoo [  299.625335] ffff81002ab59d88 0000000000000086 0000000000000000 ffff810026e5b8a0 
Jun  3 13:38:41 tux-gentoo [  299.625339]        0000007400000000 ffff810023748030 ffffffff80468300 ffff810023748240 
Jun  3 13:38:41 tux-gentoo [  299.625345]        00002aaaaaac1000 0000000100000000 
Jun  3 13:38:41 tux-gentoo [  299.625348] Call Trace:<ffffffff803f767e>{schedule_timeout+30} <ffffffff8015a81f>{__get_free_pages+31}
Jun  3 13:38:41 tux-gentoo [  299.625358]        <ffffffff8018a2ba>{__pollwait+74} <ffffffff80149d15>{add_wait_queue+69}
Jun  3 13:38:41 tux-gentoo [  299.625365]        <ffffffff80177134>{fget+84} <ffffffff8018a757>{do_select+1015}
Jun  3 13:38:41 tux-gentoo [  299.625372]        <ffffffff8018a270>{__pollwait+0} <ffffffff8018aa8f>{sys_select+735}
Jun  3 13:38:41 tux-gentoo [  299.625383]        <ffffffff8010e896>{system_call+126} 
Jun  3 13:38:41 tux-gentoo [  299.625394] 10-hal.dev    S ffff81002f528a80     0 10780      1         10782 10774 (NOTLB)
Jun  3 13:38:41 tux-gentoo [  299.625400] ffff81001b6ffb68 0000000000000082 0000000000000000 ffff81001b7b0fe8 
Jun  3 13:38:41 tux-gentoo [  299.625404]        0000006faabc0828 ffff81002bbf0e90 ffff81002ab21760 ffff81002bbf10a0 
Jun  3 13:38:41 tux-gentoo [  299.625410]        ffff81001be40540 0000000000000001 
Jun  3 13:38:41 tux-gentoo [  299.625413] Call Trace:<ffffffff803f767e>{schedule_timeout+30} <ffffffff8025c165>{__up_read+149}
Jun  3 13:38:41 tux-gentoo [  299.625423]        <ffffffff80149f51>{prepare_to_wait_exclusive+113} <ffffffff803c18de>{unix_wait_for_peer+238}
Jun  3 13:38:41 tux-gentoo [  299.625432]        <ffffffff8014a030>{autoremove_wake_function+0} <ffffffff8029fcda>{extract_buf+266}
Jun  3 13:38:41 tux-gentoo [  299.625439]        <ffffffff8014a030>{autoremove_wake_function+0} <ffffffff803c259c>{unix_dgram_sendmsg+1020}
Jun  3 13:38:41 tux-gentoo [  299.625449]        <ffffffff803612be>{sock_sendmsg+238} <ffffffff8029fcda>{extract_buf+266}
Jun  3 13:38:41 tux-gentoo [  299.625458]        <ffffffff80155b4d>{find_get_page+61} <ffffffff80156bea>{filemap_nopage+394}
Jun  3 13:38:41 tux-gentoo [  299.625467]        <ffffffff801660e0>{handle_mm_fault+400} <ffffffff8014a030>{autoremove_wake_function+0}
Jun  3 13:38:41 tux-gentoo [  299.625479]        <ffffffff80360fca>{sockfd_lookup+26} <ffffffff80360cb7>{move_addr_to_kernel+39}
Jun  3 13:38:41 tux-gentoo [  299.625487]        <ffffffff803628c9>{sys_sendto+233} <ffffffff80360f84>{sock_map_fd+372}
Jun  3 13:38:41 tux-gentoo [  299.625497]        <ffffffff803c0ed5>{unix_create+117} <ffffffff8010e896>{system_call+126}
Jun  3 13:38:41 tux-gentoo [  299.625506]        
Jun  3 13:38:41 tux-gentoo [  299.625511] 10-hal.dev    S ffff81002f528a80     0 10782      1         10792 10780 (NOTLB)
Jun  3 13:38:41 tux-gentoo [  299.625518] ffff81001b6fbb68 0000000000000082 0000000000000000 ffff81002aef1fe0 
Jun  3 13:38:41 tux-gentoo [  299.625521]        0000006faabc0828 ffff81002ae76ed0 ffff81002b20d010 ffff81002ae770e0 
Jun  3 13:38:41 tux-gentoo [  299.625527]        ffff81002b568940 0000000000000001 
Jun  3 13:38:41 tux-gentoo [  299.625530] Call Trace:<ffffffff803f767e>{schedule_timeout+30} <ffffffff8025c165>{__up_read+149}
Jun  3 13:38:41 tux-gentoo [  299.625540]        <ffffffff80149f51>{prepare_to_wait_exclusive+113} <ffffffff803c18de>{unix_wait_for_peer+238}
Jun  3 13:38:41 tux-gentoo [  299.625549]        <ffffffff8014a030>{autoremove_wake_function+0} <ffffffff8029fcda>{extract_buf+266}
Jun  3 13:38:41 tux-gentoo [  299.625557]        <ffffffff8014a030>{autoremove_wake_function+0} <ffffffff803c259c>{unix_dgram_sendmsg+1020}
Jun  3 13:38:41 tux-gentoo [  299.625566]        <ffffffff803612be>{sock_sendmsg+238} <ffffffff8029fcda>{extract_buf+266}
Jun  3 13:38:41 tux-gentoo [  299.625575]        <ffffffff80155b4d>{find_get_page+61} <ffffffff80156bea>{filemap_nopage+394}
Jun  3 13:38:41 tux-gentoo [  299.625584]        <ffffffff801660e0>{handle_mm_fault+400} <ffffffff8014a030>{autoremove_wake_function+0}
Jun  3 13:38:41 tux-gentoo [  299.625596]        <ffffffff80360fca>{sockfd_lookup+26} <ffffffff80360cb7>{move_addr_to_kernel+39}
Jun  3 13:38:41 tux-gentoo [  299.625604]        <ffffffff803628c9>{sys_sendto+233} <ffffffff80360f84>{sock_map_fd+372}
Jun  3 13:38:41 tux-gentoo [  299.625614]        <ffffffff803c0ed5>{unix_create+117} <ffffffff8010e896>{system_call+126}
Jun  3 13:38:41 tux-gentoo [  299.625623]        
Jun  3 13:38:41 tux-gentoo [  299.625628] udev          S ffff81002ab21878     0 10786    903 10787   10788       (NOTLB)
Jun  3 13:38:41 tux-gentoo [  299.625635] ffff81002ab23e88 0000000000000086 ffff81002ad187c0 ffff81001b7e4e58 
Jun  3 13:38:41 tux-gentoo [  299.625639]        0000006f20191210 ffff81002ab21760 ffff81002eebf7e0 ffff81002ab21970 
Jun  3 13:38:41 tux-gentoo [  299.625645]        ffff81001b7e4e58 ffffffff80121607 
Jun  3 13:38:41 tux-gentoo [  299.625648] Call Trace:<ffffffff80121607>{do_page_fault+1079} <ffffffff80137a6b>{do_wait+3035}
Jun  3 13:38:41 tux-gentoo [  299.625658]        <ffffffff8012fc20>{default_wake_function+0} <ffffffff8012fc20>{default_wake_function+0}
Jun  3 13:38:41 tux-gentoo [  299.625668]        <ffffffff8010e896>{system_call+126} 
Jun  3 13:38:41 tux-gentoo [  299.625677] 10-hal.dev    S ffff81002f528a80     0 10787  10786                     (NOTLB)
Jun  3 13:38:41 tux-gentoo [  299.625683] ffff81001fbf3b68 0000000000000082 ffff810020190990 ffffffff8025c165 
Jun  3 13:38:41 tux-gentoo [  299.625688]        0000006faabc0828 ffff81002ad187c0 ffff81002ab21760 ffff81002ad189d0 
Jun  3 13:38:41 tux-gentoo [  299.625693]        ffff81002ab3cc08 ffff81001fbf3cd0 
Jun  3 13:38:41 tux-gentoo [  299.625697] Call Trace:<ffffffff8025c165>{__up_read+149} <ffffffff803f767e>{schedule_timeout+30}
Jun  3 13:38:41 tux-gentoo [  299.625706]        <ffffffff80149f51>{prepare_to_wait_exclusive+113} <ffffffff803c18de>{unix_wait_for_peer+238}
Jun  3 13:38:41 tux-gentoo [  299.625716]        <ffffffff8014a030>{autoremove_wake_function+0} <ffffffff8029fcda>{extract_buf+266}
Jun  3 13:38:41 tux-gentoo [  299.625723]        <ffffffff8014a030>{autoremove_wake_function+0} <ffffffff803c259c>{unix_dgram_sendmsg+1020}
Jun  3 13:38:41 tux-gentoo [  299.625733]        <ffffffff803612be>{sock_sendmsg+238} <ffffffff8029fcda>{extract_buf+266}
Jun  3 13:38:41 tux-gentoo [  299.625742]        <ffffffff80155b4d>{find_get_page+61} <ffffffff80156bea>{filemap_nopage+394}
Jun  3 13:38:41 tux-gentoo [  299.625751]        <ffffffff801660e0>{handle_mm_fault+400} <ffffffff8014a030>{autoremove_wake_function+0}
Jun  3 13:38:41 tux-gentoo [  299.625763]        <ffffffff80360fca>{sockfd_lookup+26} <ffffffff80360cb7>{move_addr_to_kernel+39}
Jun  3 13:38:41 tux-gentoo [  299.625771]        <ffffffff803628c9>{sys_sendto+233} <ffffffff80360f84>{sock_map_fd+372}
Jun  3 13:38:41 tux-gentoo [  299.625781]        <ffffffff803c0ed5>{unix_create+117} <ffffffff8010e896>{system_call+126}
Jun  3 13:38:41 tux-gentoo [  299.625790]        
Jun  3 13:38:41 tux-gentoo [  299.625795] udev          S ffff81002b20d128     0 10788    903 10789         10786 (NOTLB)
Jun  3 13:38:41 tux-gentoo [  299.625802] ffff81001b6f1e88 0000000000000082 ffff81002b540270 ffff81001b74c6c8 
Jun  3 13:38:41 tux-gentoo [  299.625806]        000000701b7b5790 ffff81002b20d010 ffff81002eebf7e0 ffff81002b20d220 
Jun  3 13:38:41 tux-gentoo [  299.625812]        ffff81001b74c6c8 ffffffff80121607 
Jun  3 13:38:41 tux-gentoo [  299.625815] Call Trace:<ffffffff80121607>{do_page_fault+1079} <ffffffff80137a6b>{do_wait+3035}
Jun  3 13:38:41 tux-gentoo [  299.625825]        <ffffffff8012fc20>{default_wake_function+0} <ffffffff8012fc20>{default_wake_function+0}
Jun  3 13:38:41 tux-gentoo [  299.625835]        <ffffffff8010e896>{system_call+126} 
Jun  3 13:38:41 tux-gentoo [  299.625844] 10-hal.dev    S ffff81002f528a80     0 10789  10788                     (NOTLB)
Jun  3 13:38:41 tux-gentoo [  299.625850] ffff81001fbf1b68 0000000000000086 ffff81002ab1ca50 ffffffff8025c165 
Jun  3 13:38:41 tux-gentoo [  299.625855]        00000070aabc0828 ffff81002b540270 ffff81002b20d010 ffff81002b540480 
Jun  3 13:38:41 tux-gentoo [  299.625860]        ffff81002abf8148 ffff81001fbf1cd0 
Jun  3 13:38:41 tux-gentoo [  299.625864] Call Trace:<ffffffff8025c165>{__up_read+149} <ffffffff803f767e>{schedule_timeout+30}
Jun  3 13:38:41 tux-gentoo [  299.625874]        <ffffffff80149f51>{prepare_to_wait_exclusive+113} <ffffffff803c18de>{unix_wait_for_peer+238}
Jun  3 13:38:41 tux-gentoo [  299.625883]        <ffffffff8014a030>{autoremove_wake_function+0} <ffffffff8029fcda>{extract_buf+266}
Jun  3 13:38:41 tux-gentoo [  299.625891]        <ffffffff8014a030>{autoremove_wake_function+0} <ffffffff803c259c>{unix_dgram_sendmsg+1020}
Jun  3 13:38:41 tux-gentoo [  299.625900]        <ffffffff803612be>{sock_sendmsg+238} <ffffffff8029fcda>{extract_buf+266}
Jun  3 13:38:41 tux-gentoo [  299.625909]        <ffffffff80155b4d>{find_get_page+61} <ffffffff80156bea>{filemap_nopage+394}
Jun  3 13:38:41 tux-gentoo [  299.625918]        <ffffffff801660e0>{handle_mm_fault+400} <ffffffff8014a030>{autoremove_wake_function+0}
Jun  3 13:38:41 tux-gentoo [  299.625930]        <ffffffff80360fca>{sockfd_lookup+26} <ffffffff80360cb7>{move_addr_to_kernel+39}
Jun  3 13:38:41 tux-gentoo [  299.625938]        <ffffffff803628c9>{sys_sendto+233} <ffffffff80360f84>{sock_map_fd+372}
Jun  3 13:38:41 tux-gentoo [  299.625948]        <ffffffff803c0ed5>{unix_create+117} <ffffffff8010e896>{system_call+126}
Jun  3 13:38:41 tux-gentoo [  299.625957]        
Jun  3 13:38:41 tux-gentoo [  299.625962] kio_uiserver  S 000000010004a0b1     0 10792      1               10782 (NOTLB)
Jun  3 13:38:41 tux-gentoo [  299.625968] ffff81002ad3dd88 0000000000000086 0000000000000000 ffff81002ad3de88 
Jun  3 13:38:41 tux-gentoo [  299.625972]        0000000000000000 ffff81002ba4f560 ffffffff80468300 ffff81002ba4f770 
Jun  3 13:38:41 tux-gentoo [  299.625977]        ffff81002ad3dd98 ffffffff8013cbe9 
Jun  3 13:38:41 tux-gentoo [  299.625981] Call Trace:<ffffffff8013cbe9>{__mod_timer+425} <ffffffff803f76fe>{schedule_timeout+158}
Jun  3 13:38:41 tux-gentoo [  299.625991]        <ffffffff8013d650>{process_timeout+0} <ffffffff80183522>{pipe_poll+66}
Jun  3 13:38:41 tux-gentoo [  299.625999]        <ffffffff8018a757>{do_select+1015} <ffffffff8018a270>{__pollwait+0}
Jun  3 13:38:41 tux-gentoo [  299.626009]        <ffffffff80361b72>{sock_ioctl+562} <ffffffff8018aa8f>{sys_select+735}
Jun  3 13:38:41 tux-gentoo [  299.626017]        <ffffffff8010e896>{system_call+126} 
Jun  3 13:38:41 tux-gentoo [  299.626027] su            S ffff81001ba603c8     0 10794  10741 10797               (NOTLB)
Jun  3 13:38:41 tux-gentoo [  299.626034] ffff81001ef2be88 0000000000000082 ffff81001fec6e10 ffff810021a671f8 
Jun  3 13:38:41 tux-gentoo [  299.626038]        ffff81001b7b4690 ffff81001ba602b0 ffffffff80468300 ffff81001ba604c0 
Jun  3 13:38:41 tux-gentoo [  299.626044]        ffff810021a671f8 ffffffff80121607 
Jun  3 13:38:41 tux-gentoo [  299.626048] Call Trace:<ffffffff80121607>{do_page_fault+1079} <ffffffff80137a6b>{do_wait+3035}
Jun  3 13:38:41 tux-gentoo [  299.626057]        <ffffffff80141707>{do_sigaction+599} <ffffffff8012fc20>{default_wake_function+0}
Jun  3 13:38:41 tux-gentoo [  299.626066]        <ffffffff80141aa1>{sys_rt_sigaction+113} <ffffffff8012fc20>{default_wake_function+0}
Jun  3 13:38:41 tux-gentoo [  299.626073]        <ffffffff8010e896>{system_call+126} 
Jun  3 13:38:41 tux-gentoo [  299.626082] bash          R  running task       0 10797  10794                     (NOTLB)

--Boundary-00=_9YJoCpV+by0qAwa--
