Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbVHaTom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbVHaTom (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 15:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVHaTol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 15:44:41 -0400
Received: from smarthost01.eng.net ([213.130.146.173]:60090 "EHLO
	smarthost01.eng.net") by vger.kernel.org with ESMTP
	id S1751012AbVHaTok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 15:44:40 -0400
From: Chris Clayton <chris_clayton@f1internet.com>
To: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: 2.6.13 - strange usb keyboard behaviour
Date: Wed, 31 Aug 2005 20:47:56 +0000
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8dhFD8S3G2SUjrI"
Message-Id: <200508312047.56656.chris_clayton@f1internet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_8dhFD8S3G2SUjrI
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I've built and installed 2.6.13 from unpatched kernel.org sources and my USB
keyboard has started to behave very strangely when I boot my system.

When I get to the login prompt, I only get to type a few key presses before the
characters stop appearing on the screen. If I unplug the keyboard and plug it in
again, the keyboard springs back into life and works perfectly until I reboot,
when the problem always occurs again. This same keyboard worked fine with
2.6.12.5 and still does.

One perhaps important fact is that the keyboard also contains two USB ports. It
is labelled Gateway and has a model ID of SK-9926. There are no devices plugged
into the ports. I don't have another USB keyboard, so I can't check whether the
presence of these ports is material.

I've rebuilt both kernels with USB debugging turned on and attach dmesg dumps
taken immediately after login. I also attach the output from lsusb -v from each
kernel. The dump from 2.6.12.5 ends immediately after a message about my
ieee1394 card, but the one from 2.6.13 continues with a USB error message
(line 276 of the dump). As far as I can see, this message is coming from hub_irq()
of drivers/usb/core/hub.c (line 314), but I have no idea why.

I'm more than happy to provide additional diagnostics and try any patches, but
please cc me as I'm not subscribed to either list.

Thanks

Chris

--Boundary-00=_8dhFD8S3G2SUjrI
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg-2.6.12.5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-2.6.12.5.txt"

 hardware (bus 00)
Boot video device is 0000:01:00.0
PCI: Using IRQ router default [1106/3099] at 0000:00:00.0
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Initializing Cryptographic API
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA KT266/KY266x/KT333 chipset
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] Initialized drm 1.0.0 20040925
[drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
lp0: using parport0 (polling).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
8139too Fast Ethernet driver 0.9.27
eth0: RealTek RTL8139 at 0xe0816000, 00:10:a7:16:aa:36, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
PCI: Via IRQ fixup for 0000:00:11.1, from 255 to 0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: ExcelStor Technology J360, ATA DISK drive
hdb: ExcelStor Technology J360, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-ST RW/DVD GCC-4521B, ATAPI CD/DVD-ROM drive
hdd: AOPEN DUW1608/ARR, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 1024KiB
hda: 120103200 sectors (61492 MB) w/1821KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
hdb: max request size: 1024KiB
hdb: 120103200 sectors (61492 MB) w/1821KiB Cache, CHS=16383/255/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 >
hdc: ATAPI 52X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
ehci_hcd 0000:00:09.2: NEC Corporation USB 2.0
ehci_hcd 0000:00:09.2: reset hcs_params 0x2395 dbg=0 cc=2 pcc=3 ports=5
ehci_hcd 0000:00:09.2: reset portroute 1 0 1 0 0 
ehci_hcd 0000:00:09.2: reset hcc_params 0002 thresh 0 uframes 256/512/1024
ehci_hcd 0000:00:09.2: ...powerdown ports...
ehci_hcd 0000:00:09.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:09.2: irq 10, io mem 0xee002000
ehci_hcd 0000:00:09.2: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
ehci_hcd 0000:00:09.2: init command 010009 (park)=0 ithresh=1 period=256 RUN
ehci_hcd 0000:00:09.2: USB 2.0 initialized, EHCI 0.95, driver 10 Dec 2004
ehci_hcd 0000:00:09.2: supports USB remote wakeup
usb usb1: default language 0x0409
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: NEC Corporation USB 2.0
usb usb1: Manufacturer: Linux 2.6.12.5 ehci_hcd
usb usb1: SerialNumber: 0000:00:09.2
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: individual port power switching
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: enabling power on all ports
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
hub 1-0:1.0: state 5 ports 5 chg 0000 evt 0000
ohci_hcd 0000:00:09.0: NEC Corporation USB
ohci_hcd 0000:00:09.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:09.0: irq 11, io mem 0xee000000
ohci_hcd 0000:00:09.0: resetting from state 'reset', control = 0x0
ohci_hcd 0000:00:09.0: OHCI controller state
ohci_hcd 0000:00:09.0: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:09.0: control 0x083 HCFS=operational CBSR=3
ohci_hcd 0000:00:09.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:09.0: intrstatus 0x00000004 SF
ohci_hcd 0000:00:09.0: intrenable 0x8000001a MIE UE RD WDH
ohci_hcd 0000:00:09.0: fminterval a7782edf
ohci_hcd 0000:00:09.0: hcca frame #01f7
ohci_hcd 0000:00:09.0: roothub.a ff000203 POTPGT=255 NPS NDP=3
ohci_hcd 0000:00:09.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:09.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:09.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:09.0: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:09.0: roothub.portstatus [2] 0x00000100 PPS
usb usb2: default language 0x0409
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: NEC Corporation USB
usb usb2: Manufacturer: Linux 2.6.12.5 ohci_hcd
usb usb2: SerialNumber: 0000:00:09.0
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: power on to power good time: 510ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
ohci_hcd 0000:00:09.0: created debug files
ohci_hcd 0000:00:09.1: NEC Corporation USB (#2)
ohci_hcd 0000:00:09.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:09.1: irq 5, io mem 0xee001000
ohci_hcd 0000:00:09.1: resetting from state 'reset', control = 0x0
hub 2-0:1.0: state 5 ports 3 chg 0000 evt 0000
ohci_hcd 0000:00:09.1: OHCI controller state
ohci_hcd 0000:00:09.1: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:09.1: control 0x083 HCFS=operational CBSR=3
ohci_hcd 0000:00:09.1: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:09.1: intrstatus 0x00000004 SF
ohci_hcd 0000:00:09.1: intrenable 0x8000001a MIE UE RD WDH
ohci_hcd 0000:00:09.1: fminterval a7782edf
ohci_hcd 0000:00:09.1: hcca frame #01f8
ohci_hcd 0000:00:09.1: roothub.a ff000202 POTPGT=255 NPS NDP=2
ohci_hcd 0000:00:09.1: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:09.1: roothub.status 00008000 DRWE
ohci_hcd 0000:00:09.1: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:09.1: roothub.portstatus [1] 0x00000100 PPS
usb usb3: default language 0x0409
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: NEC Corporation USB (#2)
usb usb3: Manufacturer: Linux 2.6.12.5 ohci_hcd
usb usb3: SerialNumber: 0000:00:09.1
usb usb3: hotplug
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: global over-current protection
hub 3-0:1.0: power on to power good time: 510ms
hub 3-0:1.0: local power source is good
hub 3-0:1.0: no over-current condition exists
ohci_hcd 0000:00:09.1: created debug files
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:11.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
hub 3-0:1.0: state 5 ports 2 chg 0000 evt 0000
uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:11.2: irq 10, io base 0x0000dc00
uhci_hcd 0000:00:11.2: detected 2 ports
usb usb4: default language 0x0409
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
usb usb4: Manufacturer: Linux 2.6.12.5 uhci_hcd
usb usb4: SerialNumber: 0000:00:11.2
usb usb4: hotplug
usb usb4: adding 4-0:1.0 (config #1, interface 0)
usb 4-0:1.0: hotplug
hub 4-0:1.0: usb_probe_interface
hub 4-0:1.0: usb_probe_interface - got id
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
hub 4-0:1.0: standalone hub
hub 4-0:1.0: no power switching (usb 1.0)
hub 4-0:1.0: individual port over-current protection
hub 4-0:1.0: power on to power good time: 2ms
hub 4-0:1.0: local power source is good
uhci_hcd 0000:00:11.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
hub 4-0:1.0: state 5 ports 2 chg 0000 evt 0000
uhci_hcd 0000:00:11.2: port 1 portsc 009b,00
hub 4-0:1.0: port 1, status 0101, change 0003, 12 Mb/s
uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:11.3: irq 10, io base 0x0000e000
uhci_hcd 0000:00:11.3: detected 2 ports
usb usb5: default language 0x0409
usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
usb usb5: Manufacturer: Linux 2.6.12.5 uhci_hcd
usb usb5: SerialNumber: 0000:00:11.3
usb usb5: hotplug
usb usb5: adding 5-0:1.0 (config #1, interface 0)
usb 5-0:1.0: hotplug
hub 5-0:1.0: usb_probe_interface
hub 5-0:1.0: usb_probe_interface - got id
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
hub 5-0:1.0: standalone hub
hub 5-0:1.0: no power switching (usb 1.0)
hub 5-0:1.0: individual port over-current protection
hub 5-0:1.0: power on to power good time: 2ms
hub 5-0:1.0: local power source is good
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.9 (Sun May 29 07:31:02 2005 UTC).
PCI: Setting latency timer of device 0000:00:11.5 to 64
hub 4-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
usb 4-1: new full speed USB device using uhci_hcd and address 2
usb 4-1: ep0 maxpacket = 8
usb 4-1: default language 0x0409
usb 4-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 4-1: Product: SNAPSCAN
usb 4-1: Manufacturer: AGFA 
usb 4-1: hotplug
usb 4-1: adding 4-1:1.0 (config #1, interface 0)
usb 4-1:1.0: hotplug
uhci_hcd 0000:00:11.2: port 2 portsc 008a,00
hub 4-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
hub 4-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
hub 5-0:1.0: state 5 ports 2 chg 0000 evt 0006
uhci_hcd 0000:00:11.3: port 1 portsc 009b,00
hub 5-0:1.0: port 1, status 0101, change 0003, 12 Mb/s
hub 5-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
usb 5-1: new full speed USB device using uhci_hcd and address 2
ALSA device list:
  #0: VIA 8233A with CMI9738 at 0xe400, irq 5
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 15
usb 5-1: ep0 maxpacket = 8
usb 5-1: default language 0x0409
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 172k freed
kjournald starting.  Commit interval 5 seconds
usb 5-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 5-1: Product: Gateway Generic USB Hub
usb 5-1: Manufacturer: Silitek
usb 5-1: hotplug
usb 5-1: adding 5-1:1.0 (config #1, interface 0)
usb 5-1:1.0: hotplug
hub 5-1:1.0: usb_probe_interface
hub 5-1:1.0: usb_probe_interface - got id
hub 5-1:1.0: USB hub found
hub 5-1:1.0: 3 ports detected
hub 5-1:1.0: compound device; port removable status: FRR
hub 5-1:1.0: individual port power switching
hub 5-1:1.0: individual port over-current protection
hub 5-1:1.0: power on to power good time: 100ms
hub 5-1:1.0: hub controller current requirement: 90mA
hub 5-1:1.0: 410mA bus power budget for children
hub 5-1:1.0: enabling power on all ports
uhci_hcd 0000:00:11.3: port 2 portsc 008a,00
hub 5-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
hub 5-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
hub 4-0:1.0: state 5 ports 2 chg 0000 evt 0000
hub 5-0:1.0: state 5 ports 2 chg 0000 evt 0000
hub 5-1:1.0: state 5 ports 3 chg 0000 evt 0002
hub 5-1:1.0: port 1, status 0101, change 0001, 12 Mb/s
hub 5-1:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
usb 5-1.1: new full speed USB device using uhci_hcd and address 3
usb 5-1.1: ep0 maxpacket = 8
usb 5-1.1: skipped 1 descriptor after interface
usb 5-1.1: default language 0x0409
usb 5-1.1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 5-1.1: Product: Gateway Generic USB Hub
usb 5-1.1: Manufacturer: Silitek
usb 5-1.1: hotplug
usb 5-1.1: adding 5-1.1:1.0 (config #1, interface 0)
usb 5-1.1:1.0: hotplug
hub 5-1:1.0: 410mA power budget left
EXT3 FS on hda6, internal journal
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1052248k swap on /dev/hdb3.  Priority:-1 extents:1
usbhid 5-1.1:1.0: usb_probe_interface
usbhid 5-1.1:1.0: usb_probe_interface - got id
input: USB HID v1.10 Keyboard [Silitek Gateway Generic USB Hub] on usb-0000:00:11.3-1.1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
ip_tables: (C) 2000-2002 Netfilter core team
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 212 bytes per conntrack
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[5]  MMIO=[ee003000-ee0037ff]  Max Packet=[2048]
Linux video capture interface: v1.00
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 0000:00:0b.0, irq: 10, latency: 32, mmio: 0xee004000
bttv0: detected: Pinnacle PCTV [card=39], PCI subsystem ID is 11bd:0012
bttv0: using: Pinnacle PCTV Studio/Rave [card=39,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00fffbdf [init]
bttv0: i2c: checking for MSP34xx @ 0x80... found
bttv0: pinnacle/mt: id=2 info="PAL+SECAM / stereo" radio=yes
bttv0: using tuner=33
bttv0: i2c: checking for MSP34xx @ 0x80... found
msp34xx: init: chip=MSP3410G-B11 +nicam +simple +simpler +radio mode=simpler
msp34xxg: daemon started
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tda9885/6/7: chip found @ 0x86
tuner 0-0060: chip found @ 0xc0 (bt878 #0 [sw])
tuner 0-0060: microtune: companycode=4d54 part=04 rev=04
tuner 0-0060: microtune MT2032 found, OK
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL: 28636363 => 35468950 .. ok
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00110666000013cc]

--Boundary-00=_8dhFD8S3G2SUjrI
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg-2.6.13.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-2.6.13.txt"

00:00:09.2: ...powerdown ports...
ehci_hcd 0000:00:09.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:09.2: irq 10, io mem 0xee002000
ehci_hcd 0000:00:09.2: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
ehci_hcd 0000:00:09.2: init command 010009 (park)=0 ithresh=1 period=256 RUN
ehci_hcd 0000:00:09.2: USB 2.0 initialized, EHCI 0.95, driver 10 Dec 2004
ehci_hcd 0000:00:09.2: supports USB remote wakeup
usb usb1: default language 0x0409
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: NEC Corporation USB 2.0
usb usb1: Manufacturer: Linux 2.6.13 ehci_hcd
usb usb1: SerialNumber: 0000:00:09.2
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: individual port power switching
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: enabling power on all ports
hub 1-0:1.0: state 5 ports 5 chg 0000 evt 0000
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:09.0: NEC Corporation USB
ohci_hcd 0000:00:09.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:09.0: irq 11, io mem 0xee000000
ohci_hcd 0000:00:09.0: resetting from state 'reset', control = 0x0
ohci_hcd 0000:00:09.0: OHCI controller state
ohci_hcd 0000:00:09.0: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:09.0: control 0x083 HCFS=operational CBSR=3
ohci_hcd 0000:00:09.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:09.0: intrstatus 0x00000004 SF
ohci_hcd 0000:00:09.0: intrenable 0x8000001a MIE UE RD WDH
ohci_hcd 0000:00:09.0: fminterval a7782edf
ohci_hcd 0000:00:09.0: hcca frame #01ff
ohci_hcd 0000:00:09.0: roothub.a ff000203 POTPGT=255 NPS NDP=3
ohci_hcd 0000:00:09.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:09.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:09.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:09.0: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:09.0: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:09.0: created debug files
usb usb2: default language 0x0409
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: NEC Corporation USB
usb usb2: Manufacturer: Linux 2.6.13 ohci_hcd
usb usb2: SerialNumber: 0000:00:09.0
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: power on to power good time: 510ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: state 5 ports 3 chg 0000 evt 0000
ohci_hcd 0000:00:09.1: NEC Corporation USB (#2)
ohci_hcd 0000:00:09.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:09.1: irq 5, io mem 0xee001000
ohci_hcd 0000:00:09.1: resetting from state 'reset', control = 0x0
ohci_hcd 0000:00:09.1: OHCI controller state
ohci_hcd 0000:00:09.1: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:09.1: control 0x083 HCFS=operational CBSR=3
ohci_hcd 0000:00:09.1: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:09.1: intrstatus 0x00000004 SF
ohci_hcd 0000:00:09.1: intrenable 0x8000001a MIE UE RD WDH
ohci_hcd 0000:00:09.1: fminterval a7782edf
ohci_hcd 0000:00:09.1: hcca frame #01ff
ohci_hcd 0000:00:09.1: roothub.a ff000202 POTPGT=255 NPS NDP=2
ohci_hcd 0000:00:09.1: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:09.1: roothub.status 00008000 DRWE
ohci_hcd 0000:00:09.1: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:09.1: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:09.1: created debug files
usb usb3: default language 0x0409
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: NEC Corporation USB (#2)
usb usb3: Manufacturer: Linux 2.6.13 ohci_hcd
usb usb3: SerialNumber: 0000:00:09.1
usb usb3: hotplug
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: global over-current protection
hub 3-0:1.0: power on to power good time: 510ms
hub 3-0:1.0: local power source is good
hub 3-0:1.0: no over-current condition exists
hub 3-0:1.0: state 5 ports 2 chg 0000 evt 0000
USB Universal Host Controller Interface driver v2.3
uhci_hcd 0000:00:11.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:11.2: detected 2 ports
uhci_hcd 0000:00:11.2: check_and_reset_hc: legsup = 0x0010
uhci_hcd 0000:00:11.2: Performing full reset
uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:11.2: irq 10, io base 0x0000dc00
uhci_hcd 0000:00:11.2: supports USB remote wakeup
usb usb4: default language 0x0409
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
usb usb4: Manufacturer: Linux 2.6.13 uhci_hcd
usb usb4: SerialNumber: 0000:00:11.2
usb usb4: hotplug
usb usb4: adding 4-0:1.0 (config #1, interface 0)
usb 4-0:1.0: hotplug
hub 4-0:1.0: usb_probe_interface
hub 4-0:1.0: usb_probe_interface - got id
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
hub 4-0:1.0: standalone hub
hub 4-0:1.0: no power switching (usb 1.0)
hub 4-0:1.0: individual port over-current protection
hub 4-0:1.0: power on to power good time: 2ms
hub 4-0:1.0: local power source is good
hub 4-0:1.0: state 5 ports 2 chg 0000 evt 0000
uhci_hcd 0000:00:11.2: port 1 portsc 009b,00
hub 4-0:1.0: port 1, status 0101, change 0003, 12 Mb/s
uhci_hcd 0000:00:11.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:11.3: detected 2 ports
uhci_hcd 0000:00:11.3: check_and_reset_hc: legsup = 0x0010
uhci_hcd 0000:00:11.3: Performing full reset
uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:11.3: irq 10, io base 0x0000e000
uhci_hcd 0000:00:11.3: supports USB remote wakeup
usb usb5: default language 0x0409
usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
usb usb5: Manufacturer: Linux 2.6.13 uhci_hcd
usb usb5: SerialNumber: 0000:00:11.3
usb usb5: hotplug
usb usb5: adding 5-0:1.0 (config #1, interface 0)
usb 5-0:1.0: hotplug
hub 5-0:1.0: usb_probe_interface
hub 5-0:1.0: usb_probe_interface - got id
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
hub 5-0:1.0: standalone hub
hub 5-0:1.0: no power switching (usb 1.0)
hub 5-0:1.0: individual port over-current protection
hub 5-0:1.0: power on to power good time: 2ms
hub 5-0:1.0: local power source is good
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 1.0.9b (Thu Jul 28 12:20:13 2005 UTC).
PCI: Setting latency timer of device 0000:00:11.5 to 64
hub 4-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
usb 4-1: new full speed USB device using uhci_hcd and address 2
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
usb 4-1: ep0 maxpacket = 8
usb 4-1: default language 0x0409
usb 4-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 4-1: Product: SNAPSCAN
usb 4-1: Manufacturer: AGFA 
usb 4-1: hotplug
usb 4-1: adding 4-1:1.0 (config #1, interface 0)
usb 4-1:1.0: hotplug
uhci_hcd 0000:00:11.2: port 2 portsc 008a,00
hub 4-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
hub 4-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
hub 4-0:1.0: state 5 ports 2 chg 0000 evt 0000
hub 5-0:1.0: state 5 ports 2 chg 0000 evt 0006
uhci_hcd 0000:00:11.3: port 1 portsc 009b,00
hub 5-0:1.0: port 1, status 0101, change 0003, 12 Mb/s
hub 5-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
ALSA device list:
  #0: VIA 8233A with CMI9738 at 0xe400, irq 5
NET: Registered protocol family 2
usb 5-1: new full speed USB device using uhci_hcd and address 2
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 15
Using IPI Shortcut mode
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 164k freed
kjournald starting.  Commit interval 5 seconds
usb 5-1: ep0 maxpacket = 8
usb 5-1: default language 0x0409
usb 5-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 5-1: Product: Gateway Generic USB Hub
usb 5-1: Manufacturer: Silitek
usb 5-1: hotplug
usb 5-1: adding 5-1:1.0 (config #1, interface 0)
usb 5-1:1.0: hotplug
hub 5-1:1.0: usb_probe_interface
hub 5-1:1.0: usb_probe_interface - got id
hub 5-1:1.0: USB hub found
hub 5-1:1.0: 3 ports detected
hub 5-1:1.0: compound device; port removable status: FRR
hub 5-1:1.0: individual port power switching
hub 5-1:1.0: individual port over-current protection
hub 5-1:1.0: power on to power good time: 100ms
hub 5-1:1.0: hub controller current requirement: 90mA
hub 5-1:1.0: 410mA bus power budget for children
hub 5-1:1.0: enabling power on all ports
uhci_hcd 0000:00:11.3: port 2 portsc 008a,00
hub 5-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
hub 5-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
hub 5-0:1.0: state 5 ports 2 chg 0000 evt 0000
hub 5-1:1.0: state 5 ports 3 chg 0000 evt 0002
hub 5-1:1.0: port 1, status 0101, change 0001, 12 Mb/s
hub 5-1:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
usb 5-1.1: new full speed USB device using uhci_hcd and address 3
usb 5-1.1: ep0 maxpacket = 8
usb 5-1.1: skipped 1 descriptor after interface
usb 5-1.1: default language 0x0409
usb 5-1.1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 5-1.1: Product: Gateway Generic USB Hub
usb 5-1.1: Manufacturer: Silitek
usb 5-1.1: hotplug
usb 5-1.1: adding 5-1.1:1.0 (config #1, interface 0)
usb 5-1.1:1.0: hotplug
hub 5-1:1.0: 410mA power budget left
EXT3 FS on hda6, internal journal
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usbhid 5-1.1:1.0: usb_probe_interface
usbhid 5-1.1:1.0: usb_probe_interface - got id
input: USB HID v1.10 Keyboard [Silitek Gateway Generic USB Hub] on usb-0000:00:11.3-1.1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
Adding 1052248k swap on /dev/hdb3.  Priority:-1 extents:1
ip_tables: (C) 2000-2002 Netfilter core team
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 212 bytes per conntrack
ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[5]  MMIO=[ee003000-ee0037ff]  Max Packet=[2048]
Linux video capture interface: v1.00
bttv: driver version 0.9.16 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 0000:00:0b.0, irq: 10, latency: 32, mmio: 0xee004000
bttv0: detected: Pinnacle PCTV [card=39], PCI subsystem ID is 11bd:0012
bttv0: using: Pinnacle PCTV Studio/Rave [card=39,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00fffbdf [init]
bttv0: i2c: checking for MSP34xx @ 0x80... found
bttv0: pinnacle/mt: id=2 info="PAL+SECAM / stereo" radio=yes
bttv0: using tuner=33
bttv0: i2c: checking for MSP34xx @ 0x80... found
msp34xx: init: chip=MSP3410G-B11 +nicam +simple +simpler +radio mode=simpler
msp34xxg: daemon started
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tda9885/6/7: chip found @ 0x86
 : chip found @ 0xc0 (bt878 #0 [sw])
 : Returned more than 5 bytes. It is not a TEA5767
tuner 0-0060: microtune: companycode=4d54 part=04 rev=04
tuner 0-0060: microtune MT2032 found, OK
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL: 28636363 => 35468950 .. ok
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00110666000013cc]
hub 5-1:1.0: transfer --> -75
hub 5-0:1.0: state 5 ports 2 chg 0000 evt 0002
uhci_hcd 0000:00:11.3: port 1 portsc 008a,00
hub 5-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
usb 5-1: USB disconnect, address 2
usb 5-1.1: USB disconnect, address 3
usb 5-1.1: usb_disable_device nuking all URBs
usb 5-1.1: unregistering interface 5-1.1:1.0
usb 5-1.1:1.0: hotplug
usb 5-1.1: unregistering device
usb 5-1.1: hotplug
usb 5-1: usb_disable_device nuking all URBs
uhci_hcd 0000:00:11.3: shutdown urb dfc2a560 pipe 40408280 ep1in-intr
usb 5-1: unregistering interface 5-1:1.0
usb 5-1:1.0: hotplug
usb 5-1: unregistering device
usb 5-1: hotplug
hub 5-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
uhci_hcd 0000:00:11.3: suspend_rh (auto-stop)
uhci_hcd 0000:00:11.3: wakeup_rh (auto-start)
hub 5-0:1.0: state 5 ports 2 chg 0000 evt 0002
uhci_hcd 0000:00:11.3: port 1 portsc 0093,00
hub 5-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
hub 5-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
usb 5-1: new full speed USB device using uhci_hcd and address 4
usb 5-1: ep0 maxpacket = 8
usb 5-1: default language 0x0409
usb 5-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 5-1: Product: Gateway Generic USB Hub
usb 5-1: Manufacturer: Silitek
usb 5-1: hotplug
usb 5-1: adding 5-1:1.0 (config #1, interface 0)
usb 5-1:1.0: hotplug
hub 5-1:1.0: usb_probe_interface
hub 5-1:1.0: usb_probe_interface - got id
hub 5-1:1.0: USB hub found
hub 5-1:1.0: 3 ports detected
hub 5-1:1.0: compound device; port removable status: FRR
hub 5-1:1.0: individual port power switching
hub 5-1:1.0: individual port over-current protection
hub 5-1:1.0: power on to power good time: 100ms
hub 5-1:1.0: hub controller current requirement: 90mA
hub 5-1:1.0: 410mA bus power budget for children
hub 5-1:1.0: enabling power on all ports
hub 5-1:1.0: state 5 ports 3 chg 0000 evt 0000
hub 5-1:1.0: port 1, status 0101, change 0001, 12 Mb/s
hub 5-1:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
usb 5-1.1: new full speed USB device using uhci_hcd and address 5
usb 5-1.1: ep0 maxpacket = 8
usb 5-1.1: skipped 1 descriptor after interface
usb 5-1.1: default language 0x0409
usb 5-1.1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 5-1.1: Product: Gateway Generic USB Hub
usb 5-1.1: Manufacturer: Silitek
usb 5-1.1: hotplug
usb 5-1.1: adding 5-1.1:1.0 (config #1, interface 0)
usb 5-1.1:1.0: hotplug
usbhid 5-1.1:1.0: usb_probe_interface
usbhid 5-1.1:1.0: usb_probe_interface - got id
input: USB HID v1.10 Keyboard [Silitek Gateway Generic USB Hub] on usb-0000:00:11.3-1.1
hub 5-1:1.0: 410mA power budget left

--Boundary-00=_8dhFD8S3G2SUjrI
Content-Type: text/plain;
  charset="us-ascii";
  name="lsusb-v-2.6.12.5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lsusb-v-2.6.12.5.txt"


Bus 005 Device 003: ID 0443:001c Gateway, Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0443 Gateway, Inc.
  idProduct          0x001c 
  bcdDevice            1.00
  iManufacturer           1 Silitek
  iProduct                2 Gateway Generic USB Hub
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          2 Gateway Generic USB Hub
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      1 Keyboard
      iInterface              2 Gateway Generic USB Hub
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      65
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              24

Bus 005 Device 002: ID 0443:001d Gateway, Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0443 Gateway, Inc.
  idProduct          0x001d 
  bcdDevice            1.00
  iManufacturer           1 Silitek
  iProduct                2 Gateway Generic USB Hub
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          2 Gateway Generic USB Hub
    bmAttributes         0xa0
      Remote Wakeup
    MaxPower               90mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              2 Gateway Generic USB Hub
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0001  1x 1 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             3
  wHubCharacteristic 0x000d
    Per-port power switching
    Compound device
    Per-port overcurrent protection
  bPwrOn2PwrGood       50 * 2 milli seconds
  bHubContrCurrent     90 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0x00 
 Hub Port Status:
   Port 1: 0000.0103 power enable connect
   Port 2: 0000.0100 power
   Port 3: 0000.0100 power

Bus 005 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.12.5 uhci_hcd
  iProduct                2 VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
  iSerial                 1 0000:00:11.3
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0x00 
 Hub Port Status:
   Port 1: 0000.0103 power enable connect
   Port 2: 0000.0100 power

Bus 004 Device 002: ID 06bd:2061 AGFA-Gevaert NV SnapScan 1212U (?)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass       255 Vendor Specific Subclass
  bDeviceProtocol       255 Vendor Specific Protocol
  bMaxPacketSize0         8
  idVendor           0x06bd AGFA-Gevaert NV
  idProduct          0x2061 SnapScan 1212U (?)
  bcdDevice            1.00
  iManufacturer           1 AGFA 
  iProduct                2 SNAPSCAN
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x40
      Self Powered
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              16

Bus 004 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.12.5 uhci_hcd
  iProduct                2 VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
  iSerial                 1 0000:00:11.2
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0x00 
 Hub Port Status:
   Port 1: 0000.0103 power enable connect
   Port 2: 0000.0100 power

Bus 003 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.12.5 ohci_hcd
  iProduct                2 NEC Corporation USB (#2)
  iSerial                 1 0000:00:09.1
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x0002
    No power switching (usb 1.0)
    Ganged overcurrent protection
  bPwrOn2PwrGood      255 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0x00 
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0100 power

Bus 002 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.12.5 ohci_hcd
  iProduct                2 NEC Corporation USB
  iSerial                 1 0000:00:09.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             3
  wHubCharacteristic 0x0002
    No power switching (usb 1.0)
    Ganged overcurrent protection
  bPwrOn2PwrGood      255 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0x00 
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0100 power
   Port 3: 0000.0100 power

Bus 001 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.12.5 ehci_hcd
  iProduct                2 NEC Corporation USB 2.0
  iSerial                 1 0000:00:09.2
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval              12
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             5
  wHubCharacteristic 0x0009
    Per-port power switching
    Per-port overcurrent protection
    TT think time 8 FS bits
  bPwrOn2PwrGood       10 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0x00 
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0100 power
   Port 3: 0000.0100 power
   Port 4: 0000.0100 power
   Port 5: 0000.0100 power

--Boundary-00=_8dhFD8S3G2SUjrI
Content-Type: text/plain;
  charset="us-ascii";
  name="lsusb-v-2.6.13.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lsusb-v-2.6.13.txt"


Bus 005 Device 005: ID 0443:001c Gateway, Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0443 Gateway, Inc.
  idProduct          0x001c 
  bcdDevice            1.00
  iManufacturer           1 Silitek
  iProduct                2 Gateway Generic USB Hub
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          2 Gateway Generic USB Hub
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      1 Keyboard
      iInterface              2 Gateway Generic USB Hub
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      65
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              24

Bus 005 Device 004: ID 0443:001d Gateway, Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0443 Gateway, Inc.
  idProduct          0x001d 
  bcdDevice            1.00
  iManufacturer           1 Silitek
  iProduct                2 Gateway Generic USB Hub
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          2 Gateway Generic USB Hub
    bmAttributes         0xa0
      Remote Wakeup
    MaxPower               90mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              2 Gateway Generic USB Hub
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0001  1x 1 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             3
  wHubCharacteristic 0x000d
    Per-port power switching
    Compound device
    Per-port overcurrent protection
  bPwrOn2PwrGood       50 * 2 milli seconds
  bHubContrCurrent     90 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0x00 
 Hub Port Status:
   Port 1: 0000.0103 power enable connect
   Port 2: 0000.0100 power
   Port 3: 0000.0100 power

Bus 005 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.13 uhci_hcd
  iProduct                2 VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
  iSerial                 1 0000:00:11.3
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0x00 
 Hub Port Status:
   Port 1: 0000.0103 power enable connect
   Port 2: 0000.0100 power

Bus 004 Device 002: ID 06bd:2061 AGFA-Gevaert NV SnapScan 1212U (?)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass       255 Vendor Specific Subclass
  bDeviceProtocol       255 Vendor Specific Protocol
  bMaxPacketSize0         8
  idVendor           0x06bd AGFA-Gevaert NV
  idProduct          0x2061 SnapScan 1212U (?)
  bcdDevice            1.00
  iManufacturer           1 AGFA 
  iProduct                2 SNAPSCAN
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x40
      Self Powered
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              16

Bus 004 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.13 uhci_hcd
  iProduct                2 VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
  iSerial                 1 0000:00:11.2
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0x00 
 Hub Port Status:
   Port 1: 0000.0103 power enable connect
   Port 2: 0000.0100 power

Bus 003 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.13 ohci_hcd
  iProduct                2 NEC Corporation USB (#2)
  iSerial                 1 0000:00:09.1
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x0002
    No power switching (usb 1.0)
    Ganged overcurrent protection
  bPwrOn2PwrGood      255 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0x00 
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0100 power

Bus 002 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.13 ohci_hcd
  iProduct                2 NEC Corporation USB
  iSerial                 1 0000:00:09.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             3
  wHubCharacteristic 0x0002
    No power switching (usb 1.0)
    Ganged overcurrent protection
  bPwrOn2PwrGood      255 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0x00 
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0100 power
   Port 3: 0000.0100 power

Bus 001 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.13 ehci_hcd
  iProduct                2 NEC Corporation USB 2.0
  iSerial                 1 0000:00:09.2
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval              12
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             5
  wHubCharacteristic 0x0009
    Per-port power switching
    Per-port overcurrent protection
    TT think time 8 FS bits
  bPwrOn2PwrGood       10 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0x00 
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0100 power
   Port 3: 0000.0100 power
   Port 4: 0000.0100 power
   Port 5: 0000.0100 power

--Boundary-00=_8dhFD8S3G2SUjrI--
