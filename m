Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264903AbUIPCG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUIPCG3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 22:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbUIPCG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 22:06:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:22942 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264903AbUIPCGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 22:06:11 -0400
Subject: [BUG] ub.c badness in current bk
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pete Zaitcev <zaitcev@yahoo.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095300360.5105.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 16 Sep 2004 12:06:01 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Plugging my USB key, I get this: (note that it still appear to work)

Total memory = 1024MB; using 2048kB for hash table (at 80600000)
Linux version 2.6.9-rc2 (benh@gaston) (gcc version 3.3.4 (Debian
1:3.3.4-11)) #9 Thu Sep 16 11:32:15 EST 2004
Found UniNorth memory controller & host bridge, revision: 17
Mapped at 0xfdeb5000
Found a Keylargo mac-io controller, rev: 3, mapped at 0xfde35000
Processor NAP mode on idle enabled.
PowerMac motherboard: PowerBook Titanium IV
via-pmu: Server Mode is disabled
PMU driver 2 initialized for Core99, firmware: 0c
Found UniNorth PCI host bridge at 0xf0000000. Firmware bus number: 0->1
Found UniNorth PCI host bridge at 0xf2000000. Firmware bus number: 0->1
Found UniNorth PCI host bridge at 0xf4000000. Firmware bus number: 0->1
nvram: Checking bank 0...
nvram: gen0=694, gen1=693
nvram: Active bank is: 0
nvram: OF partition at 0x410
nvram: XP partition at 0x1020
nvram: NR partition at 0x1120
On node 0 totalpages: 262144
  DMA zone: 262144 pages, LIFO batch:16
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: root=/dev/hda5 ro  pmdisk=/dev/hda6 
PowerMac using OpenPIC irq controller at 0x80040000
OpenPIC Version 1.2 (4 CPUs and 64 IRQ sources) at fc5e3000
OpenPIC timer frequency is 4.166666 MHz
PID hash table entries: 4096 (order: 12, 65536 bytes)
GMT Delta read from XPRAM: 0 minutes, DST: off
time_init: decrementer frequency = 33.331610 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Memory: 1030592k available (2680k kernel code, 1468k data, 148k init, 0k
highmem)
System.map loaded at 0x81a00000 for debugger, size: 897025 bytes
AGP special page: 0xbffff000
Calibrating delay loop... 665.60 BogoMIPS (lpj=332800)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
NET: Registered protocol family 16
PCI: Probing PCI hardware
Can't get bus-range for /pci@f2000000/cardbus@1a, assuming it starts at
0
Registering openpic with sysfs...
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Thermal assist unit not available
Registering PowerMac CPU frequency driver
Low: 667 Mhz, High: 1000 Mhz, Boot: 667 Mhz
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
PCI: Enabling device 0000:00:10.0 (0086 -> 0087)
radeonfb: Invalid ROM signature 0 should be 0xaa55
radeonfb: Retreived PLL infos from Open Firmware
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=200.00 Mhz,
System=200.00 MHz
radeonfb: Monitor 1 type LCD found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
radeonfb: Power Management enabled for Mobility chipsets
Console: switching to colour frame buffer device 160x53
Registered "ati" backlight controller, level: 15/15
radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Apple UniNorth 1.5 chipset
agpgart: Maximum main memory to use for agp memory: 942M
agpgart: configuring for size idx: 4
agpgart: AGP aperture is 16M @ 0x0
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:0a:95:78:2c:9a 
PHY ID: 2060e1, addr: 0
eth0: Found BCM5421 PHY
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
MacIO PCI driver attached to Keylargo chipset
input: Macintosh mouse button emulation
apm_emu: APM Emulation 0.5 initialized.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
adb: starting probe task...
adb devices: [2]: 2 c4 [3]: 3 1 [7]: 7 1f
ADB keyboard at 2, handler 1
Detected ADB keyboard, type ISO, swapping keys.
input: ADB keyboard on adb2:2.c4/input
input: ADB Powerbook buttons on adb7:7.1f/input
ADB mouse at 3, handler set to 4 (trackpad)
input: ADB mouse on adb3:3.01/input
adb: finished probe task...
ide0: Found Apple KeyLargo ATA-4 controller, bus ID 2, irq 19
Probing IDE interface ide0...
hda: HTS726060M9AT00, ATA DISK drive
ide_pmac: Set UDMA timing for mode 4, reg: 0x0c50038c
hda: Enabling Ultra DMA 4
Using anticipatory io scheduler
ide0 at 0xc1026000-0xc1026007,0xc1026160 on irq 19
ide1: Found Apple KeyLargo ATA-3 controller, bus ID 0, irq 20
Probing IDE interface ide1...
hdc: MATSHITACD-RW CW-8121, ATAPI CD/DVD-ROM drive
hdc: MDMA, cycleTime: 120, accessTime: 90, recTime: 30
hdc: Set MDMA timing for mode 2, reg: 0x00011d26
hdc: Enabling MultiWord DMA 2
ide1 at 0xc102c000-0xc102c007,0xc102c160 on irq 20
hda: max request size: 1024KiB
hda: 117210240 sectors (60011 MB) w/7877KiB Cache, CHS=16383/255/63,
UDMA(66)
hda: cache flushes supported
 hda: [mac] hda1 hda2 hda3 hda4 hda5 hda6 hda7 hda8 hda9
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
st: Version 20040403, fixed bufsize 32768, s/g segs 256
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
PCI: Enabling device 0001:01:18.0 (0000 -> 0002)
ohci_hcd 0001:01:18.0: Apple Computer Inc. KeyLargo USB
ohci_hcd 0001:01:18.0: irq 27, pci mem c102e000
ohci_hcd 0001:01:18.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Enabling device 0001:01:19.0 (0000 -> 0002)
ohci_hcd 0001:01:19.0: Apple Computer Inc. KeyLargo USB (#2)
ohci_hcd 0001:01:19.0: irq 28, pci mem c1034000
ohci_hcd 0001:01:19.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
Found KeyWest i2c on "uni-n", 2 channels, stepping: 4 bits
Found KeyWest i2c on "mac-io", 1 channel, stepping: 4 bits
oprofile: using timer interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
IPv4 over IPv4 tunneling driver
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 148k init 4k chrp 8k prep
Adding 1048568k swap on /dev/hda6.  Priority:-1 extents:1
EXT3 FS on hda5, internal journal
tas driver [TAS3004 driver V 0.3])
using i2c address: 0x35 from device-tree
Audio jack unplugged, enabling speakers.
AE-Init snapper mixer
PowerMac Snapper  DMA sound driver rev 016 installed
Core driver edition 01.06 : PowerMac Built-in Sound driver edition 00.07
Write will use    4 fragments of   32768 bytes as default
Read  will use    4 fragments of   32768 bytes as default
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0001:01:1a.0 [0000:0000]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0001:01:1a.0, mfunc 0x00000002, devctl 0x60
Yenta: ISA IRQ mask 0x0000, PCI irq 58
Socket status: 30000006
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[40] 
MMIO=[f5000000-f50007ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000a95fffe782c9a]
ip1394: $Rev: 1224 $ Ben Collins <bcollins@debian.org>
ip1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
hda: Set PIO timing for mode 0, reg: 0x0c50032b
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies
Inc Radeon R250 Lf [Radeon Mobility 9000 M9]
agpgart: Putting AGP V2 device at 0000:00:0b.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:00:10.0 into 4x mode
[drm] Loading R200 Microcode
agpgart: Putting AGP V2 device at 0000:00:0b.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:00:10.0 into 4x mode
[drm] Loading R200 Microcode
PHY ID: 2060e1, addr: 0
eth0: Link is up at 100 Mbps, full-duplex.
eth0: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632)
agpgart: Putting AGP V2 device at 0000:00:0b.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:00:10.0 into 4x mode
[drm] Loading R200 Microcode
agpgart: Putting AGP V2 device at 0000:00:0b.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:00:10.0 into 4x mode
[drm] Loading R200 Microcode
ohci_hcd 0001:01:18.0: wakeup
usb 1-1: new full speed USB device using address 2
ub: sizeof ub_scsi_cmd 60 ub_dev 924
uba: device 2 capacity nsec 50 bsize 512
uba: made changed
uba: device 2 capacity nsec 126720 bsize 512
uba: device 2 capacity nsec 126720 bsize 512
 uba: uba1
 uba: uba1
kobject_register failed for uba1 (-17)
Call trace:
 [8000ba5c] dump_stack+0x18/0x28
 [80132a04] kobject_register+0x68/0x6c
 [80094e34] add_partition+0xdc/0x100
 [80094ff8] register_disk+0x134/0x13c
 [801866d4] add_disk+0x58/0x74
 [c211a070] ub_probe+0x250/0x2c0 [ub]
 [801e406c] usb_probe_interface+0x6c/0x8c
 [8017c784] bus_match+0x50/0x8c
 [8017c904] driver_attach+0x88/0xc8
 [8017ced4] bus_add_driver+0x98/0xf8
 [8017d4d8] driver_register+0x30/0x40
 [801e4174] usb_register+0x5c/0xc0
 [c210804c] ub_init+0x4c/0xf8 [ub]
 [8003be68] sys_init_module+0x224/0x324
 [80007d40] ret_from_syscall+0x0/0x44
usbcore: registered new driver ub
uba: was not changed
uba: was not changed
kjournald starting.  Commit interval 5 seconds
EXT3 FS on uba1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.

-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

