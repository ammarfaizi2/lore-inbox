Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWGNW6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWGNW6X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 18:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030379AbWGNW6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 18:58:22 -0400
Received: from smtp6.libero.it ([193.70.192.59]:38129 "EHLO smtp6.libero.it")
	by vger.kernel.org with ESMTP id S1030215AbWGNW6W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 18:58:22 -0400
Date: Sat, 15 Jul 2006 00:58:19 +0200
Message-Id: <J2F157$15229623685EEACF62B37CFE3EDA5997@libero.it>
Subject: unusual messages with kernel 2.6.18-rc1-git6
MIME-Version: 1.0
X-Sensitivity: 3
X-Priority: 1 (Highest)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
From: "ricciare\@libero\.it" <ricciare@libero.it>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
X-XaM3-API-Version: 4.3 (R1) (B3pl17)
X-notifreq: 123
X-SenderIP: 87.17.207.3
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using FC4 and an updated kernel version (I've both 2.6.17-1.2141_FC4 and the most recent 2.6.18-rc1-git6 (I've compiled it).
While using Kde in both occasions appeared the following simple window (it had just the classical close button) named "KWrited - listening device /dev/pts/1" and it contained the following messages:


Message from syslogd@localhost at Fri Jul 14 17:00:12 2006 ...
localhost kernel: Oops: 0000 [#1]

Message from syslogd@localhost at Fri Jul 14 17:00:12 2006 ...
localhost kernel: CPU: 0

Message from syslogd@localhost at Fri Jul 14 17:00:14 2006 ...
localhost kernel: EIP is at find_get_pages+0x1f/0x3a

Message from syslogd@localhost at Fri Jul 14 17:00:14 2006 ...
localhost kernel: eax: 80010028 ebx: 00000004 ecx: db959ee4 edx: 00000400

Message from syslogd@localhost at Fri Jul 14 17:00:14 2006 ...
localhost kernel: esi: 00000005 edi: 00000051 ebp: 00000000 esp: db959ea4

Message from syslogd@localhost at Fri Jul 14 17:00:15 2006 ...
localhost kernel: ds: 007b es: 007b ss: 0068

Message from syslogd@localhost at Fri Jul 14 17:00:15 2006 ...
localhost kernel: Process kswapd0 (pid: 128, ti=db958000 task=db92fab0 task.ti=db958000)
Message from syslogd@localhost at Fri Jul 14 17:00:17 2006 ...
localhost kernel: 00000400 c10cfe80 c10e39e0 c126be20 c11ad860 c10c5600 c1202ba0 c103e280

Message from syslogd@localhost at Fri Jul 14 17:00:17 2006 ...
localhost kernel: Call Trace:

Message from syslogd@localhost at Fri Jul 14 17:00:17 2006 ...
localhost kernel: Code: 74 03 8b 51 0c ff 42 04 fb 89 c8 c3 56 53 8b 5c 24 0c fa 51 83 c0 04 89 d1 89 da e8 50 da 07 00 89 d9 31 db 89 c6 58 eb 13 8b 11 <8b> 02 f6 c4 40 74 03 8b 52 0c ff 42 04 43 83 c1 04 39 f3 72 e9

Message from syslogd@localhost at Fri Jul 14 17:00:17 2006 ...
localhost kernel: EIP: [<c0136bfa>] find_get_pages+0x1f/0x3a SS:ESP 0068:db959ea4


Message from syslogd@localhost at Fri Jul 14 17:00:16 2006 ...
localhost kernel: Stack: 00000000 db959ecc c013be56 db959ed4 da7269dc 00000000 c013c7a8 0000000e

Message from syslogd@localhost at Fri Jul 14 17:00:16 2006 ...
localhost kernel: ffffffff da726a7c 00000000 00000000 c1072ee0 c10b5280 c10b52a0 c1076980



.. any ideas on the possible cause of such messages?
Thanks,

Nicola


.. this is my dmesg output: 


Linux version 2.6.18-rc1-git6 (root@localhost.localdomain) (gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) #2 Thu Jul 13 17:35:55
CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001c000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
448MB LOWMEM available.
On node 0 totalpages: 114688
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 110592 pages, LIFO batch:31
DMI 2.2 present.
ACPI: Unable to locate RSDP
Allocating PCI resources starting at 20000000 (gap: 1c000000:e3ff0000)
Detected 997.503 MHz processor.
Built 1 zonelists.  Total pages: 114688
Kernel command line: ro root=LABEL=/ rhgb quiet
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01382000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 449924k/458752k available (1832k kernel code, 8312k reserved, 774k data, 192k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1996.32 BogoMIPS (lpj=998162)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0387f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0387f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: Intel Pentium III (Coppermine) stepping 0a
Checking 'hlt' instruction... OK.
checking if image is initramfs... it is
Freeing initrd memory: 1183k freed
PM: Adding info for No Bus:platform
NET: Registered protocol family 16
ACPI Exception (utmutex-0262): AE_BAD_PARAMETER, Thread C13FCAB0 could not acquire Mutex [2] [20060707]
PCI: PCI BIOS revision 2.10 entry at 0xfb1b0, last bus=1
Setting up standard PCI resources
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
PCI quirk: region 4000-40ff claimed by vt82c586 ACPI
PCI quirk: region 6000-607f claimed by vt82c686 HW-mon
PCI quirk: region 5000-500f claimed by vt82c686 SMB
Boot video device is 0000:01:00.0
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:07.0
PM: Adding info for pci:0000:00:07.1
PM: Adding info for pci:0000:00:07.2
PM: Adding info for pci:0000:00:07.4
PM: Adding info for pci:0000:00:08.0
PM: Adding info for pci:0000:00:09.0
PM: Adding info for pci:0000:00:0a.0
PM: Adding info for pci:0000:00:0a.1
PM: Adding info for pci:0000:00:0b.0
PM: Adding info for pci:0000:00:0c.0
PM: Adding info for pci:0000:01:00.0
PM: Adding info for pci:0000:01:00.1
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
PCI: Bridge: 0000:00:01.0
  IO window: 9000-9fff
  MEM window: e8000000-e9ffffff
  PREFETCH window: d0000000-dfffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
PM: Adding info for platform:pcspkr
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
audit: initializing netlink socket (disabled)
audit(1152897054.716:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Disabling Via external APIC routing
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
PM: Adding info for platform:vesafb.0
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: AGP aperture is 128M @ 0xe0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
PM: Adding info for platform:serial8250
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
PCI: VIA IRQ fixup for 0000:00:07.1, from 255 to 0
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 6L120P0, ATA DISK drive
PM: Adding info for No Bus:ide0
hdb: ST315323A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
PM: Adding info for ide:0.1
Probing IDE interface ide1...
hdc: HL-DT-STDVD-ROM GDR8163B, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide1
hdd: _NEC DVD_RW ND-3520A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PM: Adding info for ide:1.0
PM: Adding info for ide:1.1
hda: max request size: 128KiB
hda: 240121728 sectors (122942 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(66)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 >
hdb: max request size: 128KiB
hdb: 30008475 sectors (15364 MB) w/512KiB Cache, CHS=29770/16/63, UDMA(66)
hdb: cache flushes not supported
 hdb: hdb1 hdb2
hdc: ATAPI 52X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
ide-floppy driver 0.99.newide
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: No PS/2 controller found. Probing ports directly.
PM: Adding info for platform:i8042
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
PM: Adding info for serio:serio0
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
Freeing unused kernel memory: 192k freed
Time: tsc clocksource has been installed.
PM: Adding info for serio:serio1
SCSI subsystem initialized
PCI: setting IRQ 11 as level-triggered
PCI: Found IRQ 11 for device 0000:00:0b.0
PCI: Sharing IRQ 11 with 0000:00:07.2
input: AT Translated Set 2 keyboard as /class/input/input0
logips2pp: Detected unknown logitech mouse model 90
input: ImExPS/2 Logitech Explorer Mouse as /class/input/input1
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

PM: Adding info for No Bus:host0
PM: Adding info for No Bus:target0:0:0
PM: Removing info for No Bus:target0:0:0
PM: Adding info for No Bus:target0:0:1
PM: Removing info for No Bus:target0:0:1
PM: Adding info for No Bus:target0:0:2
PM: Removing info for No Bus:target0:0:2
PM: Adding info for No Bus:target0:0:3
PM: Removing info for No Bus:target0:0:3
PM: Adding info for No Bus:target0:0:4
PM: Removing info for No Bus:target0:0:4
PM: Adding info for No Bus:target0:0:5
  Vendor: EPSON     Model: SCANNER GT-5500   Rev: 1.01
  Type:   Processor                          ANSI SCSI revision: 02
 target0:0:5: Beginning Domain Validation
 target0:0:5: Ending Domain Validation
PM: Adding info for scsi:0:0:5:0
PM: Adding info for No Bus:target0:0:6
PM: Removing info for No Bus:target0:0:6
PM: Adding info for No Bus:target0:0:8
PM: Removing info for No Bus:target0:0:8
PM: Adding info for No Bus:target0:0:9
PM: Removing info for No Bus:target0:0:9
PM: Adding info for No Bus:target0:0:10
PM: Removing info for No Bus:target0:0:10
PM: Adding info for No Bus:target0:0:11
PM: Removing info for No Bus:target0:0:11
PM: Adding info for No Bus:target0:0:12
PM: Removing info for No Bus:target0:0:12
PM: Adding info for No Bus:target0:0:13
PM: Removing info for No Bus:target0:0:13
PM: Adding info for No Bus:target0:0:14
PM: Removing info for No Bus:target0:0:14
PM: Adding info for No Bus:target0:0:15
PM: Removing info for No Bus:target0:0:15
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1152897081.469:2): selinux=0 auid=4294967295
scsi 0:0:5:0: Attached scsi generic sg0 type 3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PM: Adding info for platform:floppy.0
dmfe: Davicom DM9xxx net driver, version 1.36.4 (2002-01-17)
PCI: setting IRQ 10 as level-triggered
PCI: Found IRQ 10 for device 0000:00:09.0
eth0: Davicom DM9102 at pci0000:00:09.0, 00:60:6e:75:b7:c2, irq 10.
Linux Tulip driver version 1.1.13 (May 11, 2002)
8139too Fast Ethernet driver 0.9.27
PCI: setting IRQ 5 as level-triggered
PCI: Found IRQ 5 for device 0000:00:08.0
eth1: RealTek RTL8139 at 0xdc88e000, 00:06:7b:08:e6:bb, IRQ 5
eth1:  Identified 8139 chip type 'RTL-8100B/8139D'
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
eth1: link up, 10Mbps, half-duplex, lpa 0x0000
PCI: setting IRQ 9 as level-triggered
PCI: Found IRQ 9 for device 0000:00:0a.0
PCI: Sharing IRQ 9 with 0000:00:0c.0
PM: Adding info for ac97:0-0:STAC9721,23
gameport: EMU10K1 is pci0000:00:0a.1/gameport0, io 0xb800, speed 1242kHz
PM: Adding info for gameport:gameport0
PM: Adding info for No Bus:i2c-9191
PM: Adding info for i2c:9191-6000
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378, irq 7 [PCSPP,EPP]
parport_pc: VIA parallel port: io=0x378, irq=7
USB Universal Host Controller Interface driver v3.0
PCI: Found IRQ 11 for device 0000:00:07.2
PCI: Sharing IRQ 11 with 0000:00:0b.0
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
eth1: link up, 10Mbps, half-duplex, lpa 0x0000
PCI: setting IRQ 9 as level-triggered
PCI: Found IRQ 9 for device 0000:00:0a.0
PCI: Sharing IRQ 9 with 0000:00:0c.0
PM: Adding info for ac97:0-0:STAC9721,23
gameport: EMU10K1 is pci0000:00:0a.1/gameport0, io 0xb800, speed 1242kHz
PM: Adding info for gameport:gameport0
PM: Adding info for No Bus:i2c-9191
PM: Adding info for i2c:9191-6000
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378, irq 7 [PCSPP,EPP]
parport_pc: VIA parallel port: io=0x378, irq=7
USB Universal Host Controller Interface driver v3.0
PCI: Found IRQ 11 for device 0000:00:07.2
PCI: Sharing IRQ 11 with 0000:00:0b.0
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 11, io base 0x0000a400
PM: Adding info for usb:usb1
PM: Adding info for No Bus:usbdev1.1_ep00
usb usb1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev1.1_ep81
PM: Adding info for No Bus:usbdev1.1
ieee1394: Initialized config rom entry `ip1394'
PCI: Found IRQ 9 for device 0000:00:0c.0
PCI: Sharing IRQ 9 with 0000:00:0a.0
PM: Adding info for ieee1394:fw-host0
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[9]  MMIO=[eb003000-eb0037ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
PM: Adding info for ieee1394:2000000004002f6d
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[2000000004002f6d]
PM: Adding info for ieee1394:2000000004002f6d-0
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
eth0: no IPv6 routers present
eth1: no IPv6 routers present
EXT3 FS on hdb1, internal journal
Adding 915696k swap on /dev/hdb2.  Priority:-1 extents:1 across:915696k
audit(1152889914.618:3): audit_pid=1990 old=0 by auid=4294967295
lp0: using parport0 (interrupt-driven).
lp0: console ready
[drm] Initialized drm 1.0.1 20051102
[drm] Initialized radeon 1.25.0 20060524 on minor 0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[drm] Setting GART location based on old memory map
[drm] Loading R200 Microcode
[drm] writeback test succeeded in 1 usecs
atkbd.c: Unknown key pressed (translated set 2, code 0xbb on isa0060/serio0).
atkbd.c: Use 'setkeycodes e03b <keycode>' to make it known.
atkbd.c: Unknown key released (translated set 2, code 0xbb on isa0060/serio0).
atkbd.c: Use 'setkeycodes e03b <keycode>' to make it known.
NET: Registered protocol family 4
NET: Registered protocol family 5

