Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbUDDCOD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 21:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbUDDCOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 21:14:03 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:28083 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S262113AbUDDCNG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 21:13:06 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: 2.6.5-rc3-mm4 breaks xsane, hangs on device scan at launch
Date: Sat, 3 Apr 2004 21:13:01 -0500
User-Agent: KMail/1.6
Cc: Greg KH <greg@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_t82bAVn1A90PPb6"
Message-Id: <200404032113.01355.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.9.48] at Sat, 3 Apr 2004 20:13:01 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_t82bAVn1A90PPb6
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings;

You'll find a sysrq -t capture attached.  xsane is hung in the opening 
device scan, leaving that little window, and its totally unkillable 
by any means but a reboot, which brings up the you're running as root 
warning as it restarts xsane, and it can be canceled from there.

If, in this condition, I do a lsusb, that too will hang near the end 
of the mouse report section.  The usb mouse continues to function 
norrmally.

This is 100% repeatable, and everything works nominally if I reboot to 
2.6.5-rc3-mm3 or earlier.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

--Boundary-00=_t82bAVn1A90PPb6
Content-Type: text/plain;
  charset="us-ascii";
  name="sysrq-sane-hung2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sysrq-sane-hung2"

Linux version 2.6.5-rc3-mm4 (root@coyote.coyote.den) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 Sat Apr 3 05:02:18 EST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1cbfbff 00000000 00000020
CPU: Cache line size 32.
zapping low mappings.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 BIOSTA                                    ) @ 0x000f66a0
ACPI: RSDT (v001 BIOSTA AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 BIOSTA AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: DSDT (v001 BIOSTA AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Built 1 zonelists
Initializing CPU#0
Kernel command line: ro root=/dev/hda7 log_buf_len=2M
log_buf_len: 2097152
CPU 0 irqstacks, hard=c04c1000 soft=c04c0000
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1399.913 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 513160k/524224k available (2597k kernel code, 10304k reserved, 1044k data, 168k init, 0k highmem)
Calibrating delay loop... 2752.51 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: AMD Athlon(tm) XP 1600+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb4e0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbf40
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbf70, dseg 0xf0000
pnp: 00:0b: ioport range 0x3f0-0x3f1 has been reserved
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1106/3099] at 0000:00:00.0
rivafb: nVidia device/chipset 10DE0111
rivafb: Detected CRTC controller 0 being used
rivafb: RIVA MTRR set to ON
rivafb: PCI nVidia NV10 framebuffer ver 0.9.5b (nVidiaGeForce2-M, 32MB @ 0xD8000000)
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
ikconfig 0.7 with /proc/config*
udf: registering filesystem
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA KT266/KY266x/KT333 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xd0000000
ipmi message handler version v31
ipmi device interface version v31
Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
lp0: using parport0 (interrupt-driven).
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.27
eth0: RealTek RTL8139 at 0xe3828000, 00:50:ba:5d:eb:7d, IRQ 12
eth0:  Identified 8139 chip type 'RTL-8139C'
Linux video capture interface: v1.00
bttv: driver version 0.9.12 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 0000:00:09.0, irq: 5, latency: 32, mmio: 0xe3004000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: Hauppauge (bt878) [card=10,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffffdb [init]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
bttv0: Hauppauge eeprom: model=44811, tuner=Temic 4039FR5 (21), radio=yes
bttv0: using tuner=21
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL: 28636363 => 35468950 .. ok
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951),ta8874z
tuner: chip found at addr 0xc2 i2c-bus bt878 #0 [sw]
tuner: type set to 21 (Temic NTSC (4039 FR5)) by bt878 #0 [sw]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y120P0, ATA DISK drive
hdb: Maxtor 54610H6, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CREATIVE CD-RW RW1210E, ATAPI CD/DVD-ROM drive
hdd: Maxtor 6Y060L0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
hdb: max request size: 128KiB
hdb: 90045648 sectors (46103 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 hdb: hdb1 hdb2 hdb3 hdb4
hdd: max request size: 128KiB
hdd: 120103200 sectors (61492 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 hdd: hdd1 hdd2 hdd3 hdd4 < hdd5 hdd6 hdd7 hdd8 >
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
scsi0 : AdvanSys SCSI 3.3GJ: PCI Ultra: IO 0xD000-0xD00F, IRQ 0xB
  Vendor: ARCHIVE   Model: Python 28849-XXX  Rev: 4.CM
  Type:   Sequential-Access                  ANSI SCSI revision: 02
  Vendor: ARCHIVE   Model: Python 28849-XXX  Rev: 4.CM
  Type:   Medium Changer                     ANSI SCSI revision: 02
st: Version 20040318, fixed bufsize 32768, s/g segs 256
Attached scsi tape st0 at scsi0, channel 0, id 1, lun 0
st0: try direct i/o: yes (alignment 512 B), max page reachable by HBA 1048575
Attached scsi generic sg0 at scsi0, channel 0, id 1, lun 0,  type 1
Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 1,  type 8
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:11.2: VIA Technologies, Inc. USB
uhci_hcd 0000:00:11.2: irq 11, io base 0000dc00
uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:11.3: VIA Technologies, Inc. USB (#2)
uhci_hcd 0000:00:11.3: irq 11, io base 0000e000
uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:11.4: VIA Technologies, Inc. USB (#3)
uhci_hcd 0000:00:11.4: irq 11, io base 0000e400
uhci_hcd 0000:00:11.4: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
i2c /dev entries driver
Via 686a/8233/8235 audio driver 1.9.1-ac4-2.5
via82cxxx: Six channel audio available
PCI: Setting latency timer of device 0000:00:11.5 to 64
ac97_codec: AC97 Audio codec, id: ALG16 (ALC200/200P)
via82cxxx: board #1 at 0xE800, IRQ 12
btaudio: driver version 0.7 loaded [digital+analog]
btaudio: Bt878 (rev 17) at 00:09.1, irq: 5, latency: 32, mmio: 0xe3005000
btaudio: using card config "default"
btaudio: registered device dsp1 [digital]
btaudio: registered device dsp2 [analog]
btaudio: registered device mixer1
Advanced Linux Sound Architecture Driver Version 1.0.4rc2 (Tue Mar 30 08:19:30 2004 UTC).
can't register device seq
unable to register OSS mixer device 0:0
ALSA device list:
  #0: Virtual MIDI Card 1
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ipmi socket interface version v31
NET: Registered protocol family 32
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 168k freed
usb 2-2: new full speed USB device using address 2
usb 3-2: new full speed USB device using address 2
hub 3-2:1.0: USB hub found
hub 3-2:1.0: 4 ports detected
usb 3-2.1: new full speed USB device using address 3
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 0 proto 2 vid 0x04B8 pid 0x0005
usb 3-2.3: new full speed USB device using address 4
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for PL-2303
pl2303 3-2.3:1.0: PL-2303 converter detected
usb 3-2.3: PL-2303 converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
usbcore: registered new driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.10
usb 3-2.4: new full speed USB device using address 5
usb 1-1: new low speed USB device using address 2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:11.2-1
Adding 3857104k swap on /dev/hdb4.  Priority:-1 extents:1
usb 1-2: new full speed USB device using address 3
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 0 proto 2 vid 0x04B8 pid 0x0005
EXT3 FS on hda7, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
hdc: DMA disabled
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1172 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[e3007000-e30077ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0050625600001065]
ip1394: $Rev: 1175 $ Ben Collins <bcollins@debian.org>
ip1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
st0: Block limits 1 - 16777215 bytes.
st0: Default block size set to 32768 bytes.
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
via_audio: ignoring drain playback error -11
via_audio: ignoring drain playback error -11
via_audio: ignoring drain playback error -11
SysRq : Show State

                                               sibling
  task             PC      pid father child younger older
init          S C04C3800     0     1      0     2               (NOTLB)
dffdeea4 00000082 dff91670 c04c3800 c03ff9c4 00000000 00000000 00000000 
       dc4a68a0 0000a430 7d15e789 00000038 dff91818 fffea464 dffdeeb8 0000000b 
       00000000 c0122df3 dffdeeb8 fffea464 c01632b1 c03fe488 de856eb8 fffea464 
Call Trace:
 [<c0122df3>] schedule_timeout+0x63/0xc0
 [<c01632b1>] __pollwait+0x41/0xd0
 [<c0122d80>] process_timeout+0x0/0x10
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c038910b>] syscall_call+0x7/0xb

ksoftirqd/0   S C04C3800     0     2      1             3       (L-TLB)
dffd6fa4 00000046 dff910e0 c04c3800 dffd6f80 c0116f16 0000000e dffd6fa4 
       dc4a68a0 00000aa0 4ba283fe 0000002d dff91288 00000000 dffd6000 dffd6000 
       dffd6000 c011e9c6 dff910e0 00000013 dffd6000 dffdef7c 00000000 c011e920 
Call Trace:
 [<c0116f16>] preempt_schedule+0x36/0x60
 [<c011e9c6>] ksoftirqd+0xa6/0xd0
 [<c011e920>] ksoftirqd+0x0/0xd0
 [<c012d8e5>] kthread+0xa5/0xb0
 [<c012d840>] kthread+0x0/0xb0
 [<c0105011>] kernel_thread_helper+0x5/0x14

events/0      S C04C3CA8     0     3      1     4       5     2 (L-TLB)
dffcbf3c 00000046 d53cc680 c04c3ca8 00000038 dffcb000 00000544 00000000 
       d53cc680 000008fa dd7e14db 00000038 dff90cf8 dffce550 dffcb000 dffce548 
       dffcbf94 c012a08a 00000000 dffcbf74 00000000 dffce558 dffcb000 dffcb000 
Call Trace:
 [<c012a08a>] worker_thread+0x2aa/0x2c0
 [<c0204f20>] console_callback+0x0/0xf0
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0129de0>] worker_thread+0x0/0x2c0
 [<c012d8e5>] kthread+0xa5/0xb0
 [<c012d840>] kthread+0x0/0xb0
 [<c0105011>] kernel_thread_helper+0x5/0x14

kblockd/0     S C04C3800     0     4      3             7       (L-TLB)
dfe58f3c 00000046 dff905c0 c04c3800 c173eef0 dfe58000 00000086 dfe61b28 
       da99eeb0 00001386 0da38b72 00000024 dff90768 dfe61b30 dfe58000 dfe61b28 
       dfe58f94 c012a08a c173ee00 dfe58f74 00000000 dfe61b38 dfe58000 dfe58000 
Call Trace:
 [<c012a08a>] worker_thread+0x2aa/0x2c0
 [<c0229860>] blk_unplug_work+0x0/0x20
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0129de0>] worker_thread+0x0/0x2c0
 [<c012d8e5>] kthread+0xa5/0xb0
 [<c012d840>] kthread+0x0/0xb0
 [<c0105011>] kernel_thread_helper+0x5/0x14

pdflush       S C04C3800     0     7      3             8     4 (L-TLB)
c17e4f78 00000046 c17b7100 c04c3800 000003b9 3d56116d 00000009 c17b72ac 
       dff91670 000002e0 3d56144d 00000009 c17b72a8 c17e4000 c17e4fb0 c17e4fa4 
       c17e4000 c013a4d0 c04c3800 c17e4000 c17e4000 dffdef7c 00000000 c013a620 
Call Trace:
 [<c013a4d0>] __pdflush+0x90/0x1e0
 [<c013a620>] pdflush+0x0/0x30
 [<c013a648>] pdflush+0x28/0x30
 [<c013a620>] pdflush+0x0/0x30
 [<c012d8e5>] kthread+0xa5/0xb0
 [<c012d840>] kthread+0x0/0xb0
 [<c0105011>] kernel_thread_helper+0x5/0x14

khubd         S C04C3800     0     5      1             6     3 (L-TLB)
dfe2efb0 00000046 dff90030 c04c3800 00000202 dfdc7e20 dfe2ef9e dfe2ef9c 
       dfe2efa0 000040af 18b4d24f 0000000c dff901d8 dfe2e000 dfe2efc0 dfe2e000 
       dfe2e000 c02ac60c 00000009 c0388fee 00000000 dff90030 c0116f40 c044ec00 
Call Trace:
 [<c02ac60c>] hub_thread+0x8c/0xf0
 [<c0388fee>] ret_from_fork+0x6/0x14
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c02ac580>] hub_thread+0x0/0xf0
 [<c0105011>] kernel_thread_helper+0x5/0x14

kapmd         S C04C3CA8     0     6      1             9     5 (L-TLB)
c17e8f50 00000046 df510170 c04c3ca8 00000038 c17e8fb0 0002da5c 00000000 
       df510170 000048b5 a515a5ba 00000038 c17b7838 fffe9764 c17e8f64 00000000 
       00000000 c0122df3 c17e8f64 fffe9764 00008001 c03fde88 c03fde88 fffe9764 
Call Trace:
 [<c0122df3>] schedule_timeout+0x63/0xc0
 [<c0122d80>] process_timeout+0x0/0x10
 [<c011318a>] apm_mainloop+0x8a/0xc0
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c01138e0>] apm+0x0/0x2a0
 [<c0113997>] apm+0xb7/0x2a0
 [<c010500c>] kernel_thread_helper+0x0/0x14
 [<c0105011>] kernel_thread_helper+0x5/0x14

pdflush       S C04C3830     0     8      3            10     7 (L-TLB)
c17e2f78 00000046 df510170 c04c3830 00000038 00000000 000051c7 00000000 
       df510170 00004c89 6457e151 00000038 c17b6d18 c17e2000 c17e2fb0 c17e2fa4 
       c17e2000 c013a4d0 00000000 c17e2000 c17e2000 dffdef7c 00000000 c013a620 
Call Trace:
 [<c013a4d0>] __pdflush+0x90/0x1e0
 [<c013a620>] pdflush+0x0/0x30
 [<c013a648>] pdflush+0x28/0x30
 [<c013a620>] pdflush+0x0/0x30
 [<c012d8e5>] kthread+0xa5/0xb0
 [<c012d840>] kthread+0x0/0xb0
 [<c0105011>] kernel_thread_helper+0x5/0x14

aio/0         S C04C3800     0    10      3                   8 (L-TLB)
c17def3c 00000046 c17b6050 c04c3800 00010000 00010000 c17b6050 c17de000 
       c17a56b0 00003093 52841a71 00000009 c17b61f8 c17fd150 c17de000 c17fd148 
       c17def94 c012a08a 00000011 c17def74 00000000 00000000 c17de000 00000092 
Call Trace:
 [<c012a08a>] worker_thread+0x2aa/0x2c0
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0129de0>] worker_thread+0x0/0x2c0
 [<c012d8e5>] kthread+0xa5/0xb0
 [<c012d840>] kthread+0x0/0xb0
 [<c0105011>] kernel_thread_helper+0x5/0x14

kswapd0       S C04C3800     0     9      1            12     6 (L-TLB)
c17e1ec8 00000046 c17b65e0 c04c3800 c03febac c03fac90 00000008 c17e1000 
       dff91670 00000b9c 3d56fe4d 00000009 c17b6788 c17e1000 c03ffc5c c17e1ee0 
       c17e1fc0 c0140197 c03a85d4 00000000 00000000 00000000 00000000 00000000 
Call Trace:
 [<c0140197>] kswapd+0x117/0x150
 [<c0116ade>] schedule+0x4e/0x450
 [<c0116f16>] preempt_schedule+0x36/0x60
 [<c01164f0>] finish_task_switch+0x80/0x90
 [<c0118650>] autoremove_wake_function+0x0/0x50
 [<c0388fee>] ret_from_fork+0x6/0x14
 [<c0118650>] autoremove_wake_function+0x0/0x50
 [<c0140080>] kswapd+0x0/0x150
 [<c0105011>] kernel_thread_helper+0x5/0x14

scsi_eh_0     S C04C3800     0    12      1            13     9 (L-TLB)
c172df74 00000046 c17a5120 c04c3800 c0116052 dff91670 c04c3830 0000000a 
       dff91670 00003120 469b390a 0000000a c17a52c8 c172dfd4 c172d000 00000282 
       c172d000 c01060dc c172d000 c172dfdc c17a5120 00000000 00000001 c17a5120 
Call Trace:
 [<c0116052>] activate_task+0x62/0x80
 [<c01060dc>] __down_interruptible+0xbc/0x180
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0106217>] __down_failed_interruptible+0x7/0xc
 [<c0276b3d>] .text.lock.scsi_error+0x41/0x84
 [<c0276800>] scsi_error_handler+0x0/0x110
 [<c0105011>] kernel_thread_helper+0x5/0x14

kseriod       S C04C3830     0    13      1            14    12 (L-TLB)
dfd91fb0 00000046 dff90030 c04c3830 0000000b c03fac90 0515629b 00000000 
       dff90030 000043aa 6b4c507e 0000000b c17a4218 dfd91000 dfd91fc0 dfd91000 
       dfd91000 c02cd7c6 0000000f c0388fee 00000000 c17a4070 c0116f40 c0451a48 
Call Trace:
 [<c02cd7c6>] serio_thread+0xa6/0x140
 [<c0388fee>] ret_from_fork+0x6/0x14
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c02cd720>] serio_thread+0x0/0x140
 [<c0105011>] kernel_thread_helper+0x5/0x14

kjournald     S C04C3800     0    14      1           526    13 (L-TLB)
dfd3af64 00000046 c17a4600 c04c3800 00000032 dfd3a000 00000292 dfd2f960 
       dc4a68a0 000002ed 4292fd34 00000038 c17a47a8 dfd3a000 00000001 dfd2f960 
       00000000 c019cae3 dfd2f960 00000005 dfd2f9a4 dfd2f9b4 00000000 00000000 
Call Trace:
 [<c019cae3>] kjournald+0x243/0x260
 [<c0118650>] autoremove_wake_function+0x0/0x50
 [<c0118650>] autoremove_wake_function+0x0/0x50
 [<c0388fee>] ret_from_fork+0x6/0x14
 [<c019c880>] commit_timeout+0x0/0x10
 [<c019c8a0>] kjournald+0x0/0x260
 [<c0105011>] kernel_thread_helper+0x5/0x14

kjournald     S C04C3800     0   526      1           527    14 (L-TLB)
df340f64 00000046 df3ac1b0 c04c3800 00000000 df340000 00000292 df978580 
       df340f64 000011da 9c0c23fc 0000000f df3ac358 df340000 00000001 df978580 
       00000000 c019cae3 df978580 00000005 df9785c4 df9785d4 0000000e 00000000 
Call Trace:
 [<c019cae3>] kjournald+0x243/0x260
 [<c0118650>] autoremove_wake_function+0x0/0x50
 [<c011cc71>] do_exit+0x321/0x3f0
 [<c0118650>] autoremove_wake_function+0x0/0x50
 [<c0388fee>] ret_from_fork+0x6/0x14
 [<c019c880>] commit_timeout+0x0/0x10
 [<c019c8a0>] kjournald+0x0/0x260
 [<c0105011>] kernel_thread_helper+0x5/0x14

kjournald     S C04C3800     0   527      1           528   526 (L-TLB)
c17dbf64 00000046 df5e2c70 c04c3800 00000000 c17db000 00000292 df978680 
       c17a56b0 00003157 0bde76d4 0000000e df5e2e18 c17db000 00000001 df978680 
       00000000 c019cae3 c03af940 00000005 df9786c4 df9786d4 0000000e 00000000 
Call Trace:
 [<c019cae3>] kjournald+0x243/0x260
 [<c0118650>] autoremove_wake_function+0x0/0x50
 [<c011cc71>] do_exit+0x321/0x3f0
 [<c0118650>] autoremove_wake_function+0x0/0x50
 [<c0388fee>] ret_from_fork+0x6/0x14
 [<c019c8a0>] kjournald+0x0/0x260
 [<c019c880>] commit_timeout+0x0/0x10
 [<c019c8a0>] kjournald+0x0/0x260
 [<c0105011>] kernel_thread_helper+0x5/0x14

kjournald     S C04C3800     0   528      1           529   527 (L-TLB)
df5a2f64 00000046 df510c90 c04c3800 d9889fa0 df5a2000 00000292 dfd2f860 
       dc4a73c0 000003c9 e7265fff 00000034 df510e38 df5a2000 00000001 dfd2f860 
       00000000 c019cae3 dfd2f860 00000005 dfd2f8a4 dfd2f8b4 0000000c 00000000 
Call Trace:
 [<c019cae3>] kjournald+0x243/0x260
 [<c0118650>] autoremove_wake_function+0x0/0x50
 [<c011cc71>] do_exit+0x321/0x3f0
 [<c0118650>] autoremove_wake_function+0x0/0x50
 [<c0388fee>] ret_from_fork+0x6/0x14
 [<c019c880>] commit_timeout+0x0/0x10
 [<c019c8a0>] kjournald+0x0/0x260
 [<c0105011>] kernel_thread_helper+0x5/0x14

kjournald     S C04C3800     0   529      1           530   528 (L-TLB)
df581f64 00000046 df8280f0 c04c3800 dbf98b20 df581000 00000292 dfd2f660 
       df510c90 00001467 e7265c36 00000034 df828298 df581000 00000001 dfd2f660 
       00000000 c019cae3 dfd2f660 00000005 dfd2f6a4 dfd2f6b4 0000000c 00000000 
Call Trace:
 [<c019cae3>] kjournald+0x243/0x260
 [<c0118650>] autoremove_wake_function+0x0/0x50
 [<c011cc71>] do_exit+0x321/0x3f0
 [<c0118650>] autoremove_wake_function+0x0/0x50
 [<c0388fee>] ret_from_fork+0x6/0x14
 [<c019c880>] commit_timeout+0x0/0x10
 [<c019c8a0>] kjournald+0x0/0x260
 [<c0105011>] kernel_thread_helper+0x5/0x14

kjournald     S C04C3800     0   530      1           936   529 (L-TLB)
df9d6f64 00000046 df828680 c04c3800 00000000 df9d6000 00000292 df978480 
       c17a56b0 00001eca 0f29b172 0000000e df828828 df9d6000 00000001 df978480 
       00000000 c019cae3 c03af940 00000005 df9784c4 df9784d4 0000000c 00000000 
Call Trace:
 [<c019cae3>] kjournald+0x243/0x260
 [<c0118650>] autoremove_wake_function+0x0/0x50
 [<c011cc71>] do_exit+0x321/0x3f0
 [<c0118650>] autoremove_wake_function+0x0/0x50
 [<c0388fee>] ret_from_fork+0x6/0x14
 [<c019c8a0>] kjournald+0x0/0x260
 [<c019c880>] commit_timeout+0x0/0x10
 [<c019c8a0>] kjournald+0x0/0x260
 [<c0105011>] kernel_thread_helper+0x5/0x14

khpsbpkt      S C04C3800     0   936      1           962   530 (L-TLB)
df4bbf78 00000046 df828c10 c04c3800 c0116052 df829730 c04c3ca8 00000011 
       df829730 00000eb5 243ea2ba 00000011 df828db8 e3ac9394 df4bb000 00000282 
       df4bb000 c01060dc df4bb000 e3ac939c df828c10 00000000 00000001 df828c10 
Call Trace:
 [<c0116052>] activate_task+0x62/0x80
 [<c01060dc>] __down_interruptible+0xbc/0x180
 [<c0116f40>] default_wake_function+0x0/0x20
 [<e3a89d70>] complete_packet+0x0/0x10 [ieee1394]
 [<e3a89d70>] complete_packet+0x0/0x10 [ieee1394]
 [<c0106217>] __down_failed_interruptible+0x7/0xc
 [<e3a8ad43>] .text.lock.ieee1394_core+0x19/0x56 [ieee1394]
 [<e3a8ac00>] hpsbpkt_thread+0x0/0x110 [ieee1394]
 [<c0105011>] kernel_thread_helper+0x5/0x14

knodemgrd_0   S C04C3CA8     0   962      1          1213   936 (L-TLB)
df2d4f74 00000046 dff910e0 c04c3ca8 00000011 00000000 006101b0 00000000 
       dff910e0 0001903e 26042ec2 00000011 df8298d8 df639a90 df2d4000 00000282 
       df2d4000 c01060dc df2d4000 df639a98 df829730 00000000 00000001 df829730 
Call Trace:
 [<c01060dc>] __down_interruptible+0xbc/0x180
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0106217>] __down_failed_interruptible+0x7/0xc
 [<e3a91f5c>] .text.lock.nodemgr+0x141/0x1e5 [ieee1394]
 [<e3a91800>] nodemgr_host_thread+0x0/0x1a0 [ieee1394]
 [<c0105011>] kernel_thread_helper+0x5/0x14

syslogd       S C04C3800     0  1213      1          1217   962 (NOTLB)
deff1ea4 00000082 df5e2150 c04c3800 bffff8c0 00000000 df5e2150 00000010 
       dc4a68a0 00007f94 c85f138c 00000034 df5e22f8 00000000 7fffffff 00000001 
       00000000 c0122e45 00000246 df9a61c0 00000001 00000000 c033ad6b df4ac6c0 
Call Trace:
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c033ad6b>] datagram_poll+0x2b/0x100
 [<c03351c5>] sock_poll+0x25/0x30
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c038910b>] syscall_call+0x7/0xb

klogd         R running     0  1217      1          1228  1213 (NOTLB)
portmap       S C04C3830     0  1228      1          1327  1217 (NOTLB)
df1d7f04 00000082 dab428e0 c04c3830 0000001c dfd271c0 00010493 00000000 
       dab428e0 0000938c fb52c865 0000001c df99c7e8 00000000 7fffffff df1d7f60 
       7fffffff c0122e45 df5414a0 00000001 c03351c5 df5414a0 df9a38c0 df1d7fa0 
Call Trace:
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c03351c5>] sock_poll+0x25/0x30
 [<c0163c9f>] do_pollfd+0x4f/0x90
 [<c0163d8e>] do_poll+0xae/0xd0
 [<c0163f85>] sys_poll+0x1d5/0x310
 [<c0163270>] __pollwait+0x0/0xd0
 [<c014f462>] sys_close+0x62/0xa0
 [<c038910b>] syscall_call+0x7/0xb

sshd          S C04C3800     0  1327      1          1343  1228 (NOTLB)
df196ea4 00000086 df99d6f0 c04c3800 00000010 00000000 000000d0 00000246 
       df5e2150 02bbe7ed 2b6ad185 00000012 df99d898 00000000 7fffffff 00000004 
       00000000 c0122e45 00000003 c03563a4 df5c0160 df9a3cf8 df196f38 df5c0160 
Call Trace:
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c03563a4>] tcp_poll+0x34/0x180
 [<c03351c5>] sock_poll+0x25/0x30
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c0145994>] sys_munmap+0x44/0x70
 [<c038910b>] syscall_call+0x7/0xb

xinetd        S C04C3CA8     0  1343      1  2153    1365  1327 (NOTLB)
df3afea4 00000082 df5e2150 c04c3ca8 0000001a 00000000 000012da 00000000 
       df5e2150 000045f7 d49eafec 0000001a c17a4d38 00000000 7fffffff 0000000f 
       00000000 c0122e45 0000000e c03563a4 df7c7de0 df9a34b8 df3aff38 df7c7de0 
Call Trace:
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c03563a4>] tcp_poll+0x34/0x180
 [<c03351c5>] sock_poll+0x25/0x30
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c03367ae>] sys_socketcall+0x17e/0x2c0
 [<c038910b>] syscall_call+0x7/0xb

sendmail      S C04C3CA8     0  1365      1          1375  1343 (NOTLB)
de856ea4 00000086 dff91670 c04c3ca8 00000038 00000000 00071033 00000000 
       dff91670 0002ee7c 7d154359 00000038 df99cd78 fffea464 de856eb8 00000005 
       00000000 c0122df3 de856eb8 fffea464 df5c0b60 dffdeeb8 c03fe488 fffea464 
Call Trace:
 [<c0122df3>] schedule_timeout+0x63/0xc0
 [<c0122d80>] process_timeout+0x0/0x10
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c0125a60>] sigprocmask+0x40/0xc0
 [<c038910b>] syscall_call+0x7/0xb

sendmail      S C04C3800     0  1375      1          1385  1365 (NOTLB)
de380fb8 00000086 df5e3790 c04c3800 00000000 df195620 de380000 c014f3c9 
       df5e3200 0006b634 10936341 00000013 df5e3938 00000000 bfffd7e0 00000000 
       de380000 c0126c94 c038910b 00000000 403aab10 0000003b bfffd7e0 00000000 
Call Trace:
 [<c014f3c9>] filp_close+0x59/0x90
 [<c0126c94>] sys_pause+0x14/0x40
 [<c038910b>] syscall_call+0x7/0xb

gpm           S C04C3800     0  1385      1          1397  1375 (NOTLB)
df680ea4 00000086 df99d160 c04c3800 c01386e2 c03ff9c4 00000000 00000000 
       dc4a68a0 00001b6c 4405ac4b 00000033 df99d308 05249527 df680eb8 00000004 
       00000000 c0122df3 df680eb8 05249527 00000008 c03fe970 c03fe970 05249527 
Call Trace:
 [<c01386e2>] __alloc_pages+0xb2/0x310
 [<c0122df3>] schedule_timeout+0x63/0xc0
 [<c0122d80>] process_timeout+0x0/0x10
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c038910b>] syscall_call+0x7/0xb

httpd         S C04C3830     0  1397      1  1504    1406  1385 (NOTLB)
de049ea4 00000082 df5e3200 c04c3830 00000038 00000001 00028a92 00000000 
       df5e3200 00000c58 b972ecca 00000038 df3ace78 fffe98ba de049eb8 00000000 
       00000000 c0122df3 de049eb8 fffe98ba c1398ba0 dc407eb8 c04d5f10 fffe98ba 
Call Trace:
 [<c0122df3>] schedule_timeout+0x63/0xc0
 [<c0122d80>] process_timeout+0x0/0x10
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0115152>] do_page_fault+0x312/0x4ff
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c038910b>] syscall_call+0x7/0xb

crond         S C04C3800     0  1406      1          1495  1397 (NOTLB)
dd63af50 00000086 df8291a0 c04c3800 bffff8d8 00000058 00000000 00000000 
       dc4a68a0 00008f53 491a9824 0000002c df829348 fffeae5b dd63af64 0000ea6b 
       0000003c c0122df3 dd63af64 fffeae5b c0126ba6 c03fe4d8 c03fe4d8 fffeae5b 
Call Trace:
 [<c0122df3>] schedule_timeout+0x63/0xc0
 [<c0126ba6>] sys_rt_sigaction+0xf6/0x120
 [<c0122d80>] process_timeout+0x0/0x10
 [<c0123022>] sys_nanosleep+0x102/0x1c0
 [<c038910b>] syscall_call+0x7/0xb

xfs           S C04C3800     0  1495      1          1512  1406 (NOTLB)
dda9aea4 00000086 df3ad7f0 c04c3800 00000000 00000000 df3ad7f0 00000000 
       d6514660 000025b6 29f850f0 00000024 df3ad998 0005558b dda9aeb8 00000007 
       00000000 c0122df3 dda9aeb8 0005558b 00000040 c03fe610 df3ac8bc 0005558b 
Call Trace:
 [<c0122df3>] schedule_timeout+0x63/0xc0
 [<c0122d80>] process_timeout+0x0/0x10
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c014fcb9>] vfs_read+0xf9/0x150
 [<c038910b>] syscall_call+0x7/0xb

httpd         S C04C3800     0  1504   1397          1505       (NOTLB)
de138f04 00000086 c17a56b0 c04c3800 de869a58 c013895f 00000000 c01632b1 
       df3accd0 000e86fb 28f952de 00000014 c17a5858 00000000 7fffffff de138f60 
       7fffffff c0122e45 df36e0e0 00000001 c03351c5 df36e0e0 de869ba0 de138fa0 
Call Trace:
 [<c013895f>] __get_free_pages+0x1f/0x40
 [<c01632b1>] __pollwait+0x41/0xd0
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c03351c5>] sock_poll+0x25/0x30
 [<c0163c9f>] do_pollfd+0x4f/0x90
 [<c0163d8e>] do_poll+0xae/0xd0
 [<c0163f85>] sys_poll+0x1d5/0x310
 [<c0163270>] __pollwait+0x0/0xd0
 [<c038910b>] syscall_call+0x7/0xb

httpd         S C04C3800     0  1505   1397          1506  1504 (NOTLB)
de6ead6c 00000082 df5e26e0 c04c3800 00000001 00000000 def83260 ffffffff 
       df3accd0 0009655a 2926a2d9 00000014 df5e2888 de6eadbc de6eadec de0ca8b0 
       00000001 c01d8458 de0ca8b0 de6eadec 00000001 def83280 000005e1 de6ea000 
Call Trace:
 [<c01d8458>] sys_semtimedop+0x4b8/0x590
 [<c01386e2>] __alloc_pages+0xb2/0x310
 [<c013854c>] buffered_rmqueue+0xec/0x1d0
 [<c01386e2>] __alloc_pages+0xb2/0x310
 [<c0143026>] do_anonymous_page+0x106/0x1f0
 [<c0143171>] do_no_page+0x61/0x310
 [<c0143633>] handle_mm_fault+0xf3/0x1d0
 [<c0115152>] do_page_fault+0x312/0x4ff
 [<c0145b1e>] do_brk+0x15e/0x230
 [<c010d481>] sys_ipc+0x61/0x2c0
 [<c038910b>] syscall_call+0x7/0xb

httpd         S C04C3800     0  1506   1397          1507  1505 (NOTLB)
de936d6c 00000082 df3ad260 c04c3800 00000001 00000000 def832a0 00000000 
       df3accd0 001b18e5 29519453 00000014 df3ad408 de936dbc de936dec de0ca8b0 
       00000001 c01d8458 de0ca8b0 de936dec 00000001 def832c0 000005e2 de936000 
Call Trace:
 [<c01d8458>] sys_semtimedop+0x4b8/0x590
 [<c0134af1>] do_generic_mapping_read+0x1d1/0x410
 [<c01380c3>] __rmqueue+0xd3/0x140
 [<c013854c>] buffered_rmqueue+0xec/0x1d0
 [<c01386e2>] __alloc_pages+0xb2/0x310
 [<c0143026>] do_anonymous_page+0x106/0x1f0
 [<c0143171>] do_no_page+0x61/0x310
 [<c0143633>] handle_mm_fault+0xf3/0x1d0
 [<c0115152>] do_page_fault+0x312/0x4ff
 [<c0145b1e>] do_brk+0x15e/0x230
 [<c010d481>] sys_ipc+0x61/0x2c0
 [<c038910b>] syscall_call+0x7/0xb

httpd         S C04C3800     0  1507   1397          1508  1506 (NOTLB)
de6c6d6c 00000086 df8ca660 c04c3800 00000001 00000000 def832e0 00000000 
       df3accd0 001b6601 297d4c21 00000014 df8ca808 de6c6dbc de6c6dec de0ca8b0 
       00000001 c01d8458 de0ca8b0 de6c6dec 00000001 def83300 000005e3 de6c6000 
Call Trace:
 [<c01d8458>] sys_semtimedop+0x4b8/0x590
 [<c0134af1>] do_generic_mapping_read+0x1d1/0x410
 [<c01380c3>] __rmqueue+0xd3/0x140
 [<c013854c>] buffered_rmqueue+0xec/0x1d0
 [<c01386e2>] __alloc_pages+0xb2/0x310
 [<c0143026>] do_anonymous_page+0x106/0x1f0
 [<c0143171>] do_no_page+0x61/0x310
 [<c0143633>] handle_mm_fault+0xf3/0x1d0
 [<c0115152>] do_page_fault+0x312/0x4ff
 [<c0145b1e>] do_brk+0x15e/0x230
 [<c010d481>] sys_ipc+0x61/0x2c0
 [<c038910b>] syscall_call+0x7/0xb

httpd         S C04C3800     0  1508   1397          1509  1507 (NOTLB)
dee67d6c 00000082 df8cabf0 c04c3800 00000001 00000000 def83320 00000000 
       df3accd0 000542b7 29c2bfb1 00000014 df8cad98 dee67dbc dee67dec de0ca8b0 
       00000001 c01d8458 de0ca8b0 dee67dec 00000001 def83340 000005e4 dee67000 
Call Trace:
 [<c01d8458>] sys_semtimedop+0x4b8/0x590
 [<c0134af1>] do_generic_mapping_read+0x1d1/0x410
 [<c01380c3>] __rmqueue+0xd3/0x140
 [<c013854c>] buffered_rmqueue+0xec/0x1d0
 [<c01386e2>] __alloc_pages+0xb2/0x310
 [<c0143026>] do_anonymous_page+0x106/0x1f0
 [<c0143171>] do_no_page+0x61/0x310
 [<c0143633>] handle_mm_fault+0xf3/0x1d0
 [<c0115152>] do_page_fault+0x312/0x4ff
 [<c0145b1e>] do_brk+0x15e/0x230
 [<c010d481>] sys_ipc+0x61/0x2c0
 [<c038910b>] syscall_call+0x7/0xb

httpd         S C04C3800     0  1509   1397          1510  1508 (NOTLB)
de951d6c 00000082 df8cb710 c04c3800 00000001 00000000 def83360 00000000 
       df3accd0 0019b72e 29deae86 00000014 df8cb8b8 de951dbc de951dec de0ca8b0 
       00000001 c01d8458 de0ca8b0 de951dec 00000001 def83380 000005e5 de951000 
Call Trace:
 [<c01d8458>] sys_semtimedop+0x4b8/0x590
 [<c0131000>] load_module+0x530/0xb20
 [<c01380c3>] __rmqueue+0xd3/0x140
 [<c013854c>] buffered_rmqueue+0xec/0x1d0
 [<c01386e2>] __alloc_pages+0xb2/0x310
 [<c0143026>] do_anonymous_page+0x106/0x1f0
 [<c0143171>] do_no_page+0x61/0x310
 [<c0143633>] handle_mm_fault+0xf3/0x1d0
 [<c0115152>] do_page_fault+0x312/0x4ff
 [<c0145b1e>] do_brk+0x15e/0x230
 [<c010d481>] sys_ipc+0x61/0x2c0
 [<c038910b>] syscall_call+0x7/0xb

httpd         S C04C3800     0  1510   1397          1511  1509 (NOTLB)
dee63d6c 00000082 df8cb180 c04c3800 00000001 00000000 def833a0 00000000 
       df3accd0 001abe3c 2a09c65c 00000014 df8cb328 dee63dbc dee63dec de0ca8b0 
       00000001 c01d8458 de0ca8b0 dee63dec 00000001 def833c0 000005e6 dee63000 
Call Trace:
 [<c01d8458>] sys_semtimedop+0x4b8/0x590
 [<c0134af1>] do_generic_mapping_read+0x1d1/0x410
 [<c01380c3>] __rmqueue+0xd3/0x140
 [<c013854c>] buffered_rmqueue+0xec/0x1d0
 [<c01386e2>] __alloc_pages+0xb2/0x310
 [<c0143026>] do_anonymous_page+0x106/0x1f0
 [<c0143171>] do_no_page+0x61/0x310
 [<c0143633>] handle_mm_fault+0xf3/0x1d0
 [<c0115152>] do_page_fault+0x312/0x4ff
 [<c0145b1e>] do_brk+0x15e/0x230
 [<c010d481>] sys_ipc+0x61/0x2c0
 [<c038910b>] syscall_call+0x7/0xb

httpd         S C04C3800     0  1511   1397                1510 (NOTLB)
ddfe5d6c 00000086 df5117b0 c04c3800 00000001 00000000 def833e0 00000000 
       df3accd0 001b59bb 2a3589ea 00000014 df511958 ddfe5dbc ddfe5dec de0ca8b0 
       00000001 c01d8458 de0ca8b0 ddfe5dec 00000001 def83400 000005e7 ddfe5000 
Call Trace:
 [<c01d8458>] sys_semtimedop+0x4b8/0x590
 [<c0134af1>] do_generic_mapping_read+0x1d1/0x410
 [<c01380c3>] __rmqueue+0xd3/0x140
 [<c013854c>] buffered_rmqueue+0xec/0x1d0
 [<c01386e2>] __alloc_pages+0xb2/0x310
 [<c0143026>] do_anonymous_page+0x106/0x1f0
 [<c0143171>] do_no_page+0x61/0x310
 [<c0143633>] handle_mm_fault+0xf3/0x1d0
 [<c0115152>] do_page_fault+0x312/0x4ff
 [<c0145b1e>] do_brk+0x15e/0x230
 [<c010d481>] sys_ipc+0x61/0x2c0
 [<c038910b>] syscall_call+0x7/0xb

smbd          S C04C3800     0  1512      1          1516  1495 (NOTLB)
de954ea4 00000086 df511220 c04c3800 00000010 00000000 000000d0 dfc48ec0 
       000000d0 000bffda 46a8f5b1 00000014 df5113c8 00000000 7fffffff 0000000b 
       00000000 c0122e45 00000009 c03563a4 df4ac800 00000246 de60c0e0 df4acd00 
Call Trace:
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c03563a4>] tcp_poll+0x34/0x180
 [<c015cf14>] pipe_poll+0x34/0x80
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c0336727>] sys_socketcall+0xf7/0x2c0
 [<c038910b>] syscall_call+0x7/0xb

nmbd          S C04C3800     0  1516      1          1534  1512 (NOTLB)
dc771ea4 00000086 df510700 c04c3800 00000023 00000000 df510700 00000000 
       dc4a68a0 000541e6 22083b26 00000038 df5108a8 fffeb1f3 dc771eb8 0000000b 
       00000000 c0122df3 dc771eb8 fffeb1f3 00000200 c03fe4f0 c03fe4f0 fffeb1f3 
Call Trace:
 [<c0122df3>] schedule_timeout+0x63/0xc0
 [<c0122d80>] process_timeout+0x0/0x10
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c0125a60>] sigprocmask+0x40/0xc0
 [<c038910b>] syscall_call+0x7/0xb

mount.smbfs   S C04C3800     0  1532      1          1537  1534 (NOTLB)
dd787fb8 00000082 dc7493a0 c04c3800 00000087 c04c1ff4 0804b150 14000000 
       dc749930 00028c0d 6f5546ba 00000014 dc749548 00000000 00000000 00000003 
       dd787000 c0126c94 c038910b 00000000 402aab10 00000000 00000000 00000003 
Call Trace:
 [<c0126c94>] sys_pause+0x14/0x40
 [<c038910b>] syscall_call+0x7/0xb

smbiod        S C04C3800     0  1534      1          1532  1516 (L-TLB)
ddf97fa0 00000046 dc748880 c04c3800 c04067d8 c01bbfd1 dc8abd20 0000541b 
       dc748e10 000026cb 7fec3b2e 00000014 dc748a28 ddf97000 ddf97fc0 ddf97000 
       df978a80 c01be7e4 defcaca0 dc748e10 ddf97000 ddf97000 ddf97000 ddf97000 
Call Trace:
 [<c01bbfd1>] smb_recv_available+0x41/0x60
 [<c01be7e4>] smbiod+0xa4/0x1ac
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c01be740>] smbiod+0x0/0x1ac
 [<c0105011>] kernel_thread_helper+0x5/0x14

mount.smbfs   S C04C3830     0  1537      1          1555  1532 (NOTLB)
ddafafb8 00000086 dc749930 c04c3830 00000014 00000000 00036a4c 00000000 
       dc749930 000bd9f9 7ff81527 00000014 dc748fb8 00000000 00000000 00000003 
       ddafa000 c0126c94 c038910b 00000000 402aab10 00000000 00000000 00000003 
Call Trace:
 [<c0126c94>] sys_pause+0x14/0x40
 [<c038910b>] syscall_call+0x7/0xb

atd           S C04C3800     0  1555      1          1575  1537 (NOTLB)
de955f50 00000082 dc7482f0 c04c3800 00000000 dcc537a0 dfd22e00 00000000 
       dc749930 0000d402 88fe698f 00000014 dc748498 0000c92b de955f64 0004940f 
       0000012c c0122df3 de955f64 0000c92b c0126ba6 c03fe580 c03fe580 0000c92b 
Call Trace:
 [<c0122df3>] schedule_timeout+0x63/0xc0
 [<c0126ba6>] sys_rt_sigaction+0xf6/0x120
 [<c0122d80>] process_timeout+0x0/0x10
 [<c0123022>] sys_nanosleep+0x102/0x1c0
 [<c038910b>] syscall_call+0x7/0xb

upsd          R running     0  1575      1          1593  1555 (NOTLB)
cupsd         S C04C3800     0  1593      1          1669  1575 (NOTLB)
dc407ea4 00000082 df5e3200 c04c3800 00000010 00000000 000000d0 00000000 
       dc4a68a0 000020f7 b9741579 00000038 df5e33a8 fffe98ba dc407eb8 00000004 
       00000000 c0122df3 dc407eb8 fffe98ba 00000004 c03fe138 de049eb8 fffe98ba 
Call Trace:
 [<c0122df3>] schedule_timeout+0x63/0xc0
 [<c0122d80>] process_timeout+0x0/0x10
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c038910b>] syscall_call+0x7/0xb

heyu          S C04C3800     0  1669      1          1674  1593 (NOTLB)
de853e68 00000082 df3ac740 c04c3800 dc4a0870 c165b634 de853000 de853000 
       dc4a7950 00004c0e 35272d95 00000016 df3ac8e8 00000008 7fffffff 00000000 
       dbf12924 c0122e45 c0167822 de3173a0 c0400bf4 00000000 dc4a0800 dc432980 
Call Trace:
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c0167822>] dput+0x22/0x270
 [<c015e613>] link_path_walk+0x673/0x9b0
 [<c01f8c2e>] read_chan+0x2be/0x8f0
 [<c014fd9c>] do_sync_write+0x8c/0xc0
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c01f3a04>] tty_read+0x134/0x160
 [<c014fca0>] vfs_read+0xe0/0x150
 [<c014ff62>] sys_read+0x42/0x70
 [<c038910b>] syscall_call+0x7/0xb

heyu          R running     0  1670      1          1675  1674 (NOTLB)
xtend         S C04C3800     0  1674      1          1670  1669 (NOTLB)
dc3ffea4 00000082 dc4a6310 c04c3800 00000000 00000000 00000000 00000000 
       dc4a68a0 00001304 b99ec9d9 00000038 dc4a64b8 fffe98bd dc3ffeb8 00000000 
       00000000 c0122df3 dc3ffeb8 fffe98bd dc3ffec8 c03fe150 c03fe150 fffe98bd 
Call Trace:
 [<c0122df3>] schedule_timeout+0x63/0xc0
 [<c0122d80>] process_timeout+0x0/0x10
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c014fca0>] vfs_read+0xe0/0x150
 [<c038910b>] syscall_call+0x7/0xb

setibatch     S C04C3800     0  1675      1  1690    1699  1670 (NOTLB)
dc404f50 00000082 dc4a6e30 c04c3800 00000001 dc5efca0 dc4a68a0 dc404f48 
       00030002 0000b3a3 43d79862 00000016 dc4a6fd8 dc404000 fffffe00 dc4a6e30 
       dc4a6ec8 c011d4b3 ffffffff 00000000 dc4a68a0 bfffee90 dc404000 00000001 
Call Trace:
 [<c011d4b3>] sys_wait4+0x1d3/0x290
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c038910b>] syscall_call+0x7/0xb

setiathome    R running     0  1690   1675                     (NOTLB)
login         S C04C3800     0  1699      1  2007    1700  1675 (NOTLB)
dbf10f50 00000082 dbad5970 c04c3800 00000001 df3276e0 dab43990 00000002 
       dc4a68a0 00004792 8d67f40b 00000018 dbad5b18 dbf10000 fffffe00 dbad5970 
       dbad5a08 c011d4b3 ffffffff 00000000 dab43990 00000002 dbf10000 00000001 
Call Trace:
 [<c011d4b3>] sys_wait4+0x1d3/0x290
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c038910b>] syscall_call+0x7/0xb

login         S C04C3830     0  1700      1  2268    1701  1699 (NOTLB)
dc052f50 00000086 df5e2150 c04c3830 0000002d daac7ee0 00131dcc 00000000 
       df5e2150 00009594 911ea509 0000002d dc4a7af8 dc052000 fffffe00 dc4a7950 
       dc4a79e8 c011d4b3 ffffffff 00000000 d53cc680 00000002 dc052000 00000001 
Call Trace:
 [<c011d4b3>] sys_wait4+0x1d3/0x290
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c038910b>] syscall_call+0x7/0xb

mingetty      S C04C3800     0  1701      1          1702  1700 (NOTLB)
dce35e68 00000082 dbad53e0 c04c3800 00000008 c0205509 dce34000 00000000 
       dbad48c0 00036b8f 433e4c04 00000017 dbad5588 00000008 7fffffff dab0c980 
       00000000 c0122e45 203a6e69 00000000 00000001 00000000 dfc48ec0 df8420e8 
Call Trace:
 [<c0205509>] con_write+0x39/0x50
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c01f8c2e>] read_chan+0x2be/0x8f0
 [<c0143633>] handle_mm_fault+0xf3/0x1d0
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c01f3bca>] tty_write+0x19a/0x2a0
 [<c01f3a04>] tty_read+0x134/0x160
 [<c014fca0>] vfs_read+0xe0/0x150
 [<c014ff62>] sys_read+0x42/0x70
 [<c038910b>] syscall_call+0x7/0xb

mingetty      S C04C3800     0  1702      1          1703  1701 (NOTLB)
de05be68 00000082 dbad4e50 c04c3800 00000008 c0205509 daa6b000 00000000 
       dbad53e0 000016de 3671c476 00000017 dbad4ff8 00000008 7fffffff dab0c7c0 
       00000000 c0122e45 203a6e69 00000000 00000001 00000000 dfc48ec0 dbac0d08 
Call Trace:
 [<c0205509>] con_write+0x39/0x50
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c01f8c2e>] read_chan+0x2be/0x8f0
 [<c0143633>] handle_mm_fault+0xf3/0x1d0
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c01f3bca>] tty_write+0x19a/0x2a0
 [<c01f3a04>] tty_read+0x134/0x160
 [<c014fca0>] vfs_read+0xe0/0x150
 [<c014ff62>] sys_read+0x42/0x70
 [<c038910b>] syscall_call+0x7/0xb

mingetty      S C04C3800     0  1703      1          1704  1702 (NOTLB)
dbafee68 00000082 dbad48c0 c04c3800 00000008 c0205509 da82e000 00000000 
       dbad4330 00003263 433e7e67 00000017 dbad4a68 00000008 7fffffff dab0c600 
       00000000 c0122e45 203a6e69 00000000 00000001 00000000 dfc48ec0 df1c2488 
Call Trace:
 [<c0205509>] con_write+0x39/0x50
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c01f8c2e>] read_chan+0x2be/0x8f0
 [<c011b112>] release_console_sem+0xd2/0xe0
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c01f3bca>] tty_write+0x19a/0x2a0
 [<c01f3a04>] tty_read+0x134/0x160
 [<c014fca0>] vfs_read+0xe0/0x150
 [<c014ff62>] sys_read+0x42/0x70
 [<c038910b>] syscall_call+0x7/0xb

mingetty      S C04C3CA8     0  1704      1          2147  1703 (NOTLB)
dbaffe68 00000086 dff910e0 c04c3ca8 00000017 c0205509 02d52942 00000000 
       dff910e0 00007de6 48a3e70d 00000017 dbad44d8 00000008 7fffffff dab0c440 
       00000000 c0122e45 203a6e69 00000000 00000001 00000000 dfc48ec0 dbac0b28 
Call Trace:
 [<c0205509>] con_write+0x39/0x50
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c01f8c2e>] read_chan+0x2be/0x8f0
 [<c0143633>] handle_mm_fault+0xf3/0x1d0
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c01f3bca>] tty_write+0x19a/0x2a0
 [<c01f3a04>] tty_read+0x134/0x160
 [<c014fca0>] vfs_read+0xe0/0x150
 [<c014ff62>] sys_read+0x42/0x70
 [<c038910b>] syscall_call+0x7/0xb

bash          S C04C3830     0  2007   1699  2053               (NOTLB)
da711f50 00000086 dc4a73c0 c04c3830 00000019 da89fda0 0000372c 00000000 
       dc4a73c0 000270dc 5a454dfa 00000019 dab43b38 da711000 fffffe00 dab43990 
       dab43a28 c011d4b3 ffffffff 00000002 da736f30 c0400bf4 da711000 00000001 
Call Trace:
 [<c011d4b3>] sys_wait4+0x1d3/0x290
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c038910b>] syscall_call+0x7/0xb

startx        S C04C3800     0  2053   2007  2064               (NOTLB)
da6fff50 00000086 da736f30 c04c3800 00000001 da992e20 da736410 da6fff48 
       dc4a68a0 0000df16 656d8636 00000019 da7370d8 da6ff000 fffffe00 da736f30 
       da736fc8 c011d4b3 ffffffff 00000000 da736410 bffff450 da6ff000 00000001 
Call Trace:
 [<c011d4b3>] sys_wait4+0x1d3/0x290
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c038910b>] syscall_call+0x7/0xb

xinit         S C04C3800     0  2064   2053  2065               (NOTLB)
da79af50 00000082 da736410 c04c3800 da79af58 00000286 da7369a0 00000001 
       da7369a0 00007f72 fcb75dac 00000019 da7365b8 da79a000 fffffe00 da736410 
       da7364a8 c011d4b3 ffffffff 00000000 da7369a0 bffff7c0 da79a000 00000001 
Call Trace:
 [<c011d4b3>] sys_wait4+0x1d3/0x290
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c01059d7>] sys_vfork+0x37/0x40
 [<c038910b>] syscall_call+0x7/0xb

X             S C04C3830     0  2065   2064          2090       (NOTLB)
da65dea4 00000082 dc4a73c0 c04c3830 00000038 00000000 00018c73 00000000 
       dc4a73c0 00002781 db72e917 00000038 da99f058 00000000 7fffffff 00000021 
       00000000 c0122e45 00000246 d33baa20 00000001 00000020 c03830ab d2258340 
Call Trace:
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c03830ab>] unix_poll+0x2b/0xb0
 [<c03351c5>] sock_poll+0x25/0x30
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c038910b>] syscall_call+0x7/0xb

startkde      S C04C3800     0  2090   2064  2107          2065 (NOTLB)
da935f50 00000082 da7369a0 c04c3800 00000001 df069ce0 da99e390 da935f48 
       dc4a68a0 0000c131 88d03399 0000001c da736b48 da935000 fffffe00 da7369a0 
       da736a38 c011d4b3 ffffffff 00000000 da99e390 bffff360 da935000 00000001 
Call Trace:
 [<c011d4b3>] sys_wait4+0x1d3/0x290
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c038910b>] syscall_call+0x7/0xb

ssh-agent     S C04C3800     0  2107   2090          2190       (NOTLB)
da9f6ea4 00000086 da99e920 c04c3800 00000000 00000000 da99e920 00000010 
       dc4a68a0 0000b111 54929e19 00000038 da99eac8 00000000 7fffffff 00000004 
       00000000 c0122e45 00000246 df9a4e40 00000008 00000003 c03830ab daa77bc0 
Call Trace:
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c03830ab>] unix_poll+0x2b/0xb0
 [<c03351c5>] sock_poll+0x25/0x30
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c038910b>] syscall_call+0x7/0xb

kdeinit       S C04C3800     0  2144      1  2149    2194  2188 (NOTLB)
da9e6ea4 00200082 da87aef0 c04c3800 c03ff9c4 00000000 00000000 00000000 
       d6514660 00000468 d725dfbc 00000023 da87b098 00000000 7fffffff 0000000a 
       00000000 c0122e45 00200246 df9a4340 00000200 00000009 c03830ab da983160 
Call Trace:
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c03830ab>] unix_poll+0x2b/0xb0
 [<c03351c5>] sock_poll+0x25/0x30
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c038910b>] syscall_call+0x7/0xb

kdeinit       S C04C3800     0  2147      1          2152  1704 (NOTLB)
d8cf6ea4 00200082 dab43400 c04c3800 00000023 00000000 000325d1 00000000 
       d6514660 000002e0 d703d6a9 00000023 dab435a8 00000000 7fffffff 0000001a 
       00000000 c0122e45 00200246 d4cdc7a0 02000000 00000019 c03830ab d4b4a700 
Call Trace:
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c03830ab>] unix_poll+0x2b/0xb0
 [<c03351c5>] sock_poll+0x25/0x30
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c0150e80>] __fput+0xd0/0x130
 [<c014f462>] sys_close+0x62/0xa0
 [<c038910b>] syscall_call+0x7/0xb

kdeinit       S C04C3CA8     0  2149   2144          2170       (NOTLB)
da7c6ea4 00200086 da87a960 c04c3ca8 00000023 00000000 00010934 00000000 
       da87a960 00002fe6 d700831d 00000023 dab43018 00000000 7fffffff 0000002b 
       00000000 c0122e45 00200246 df9a6e20 00000400 0000002a c03830ab da409440 
Call Trace:
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c03830ab>] unix_poll+0x2b/0xb0
 [<c03351c5>] sock_poll+0x25/0x30
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c014fcb9>] vfs_read+0xf9/0x150
 [<c038910b>] syscall_call+0x7/0xb

kdeinit       R running     0  2152      1          2161  2147 (NOTLB)
fam           S C04C3800     0  2153   1343                     (NOTLB)
d8513ea4 00000086 dab428e0 c04c3800 00000010 00000000 000000d0 d658a600 
       d6515180 00000763 6d923761 0000001d dab42a88 00000000 7fffffff 00000081 
       00000000 c0122e45 00000246 d640d640 00000001 00000080 c03830ab df1c2260 
Call Trace:
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c03830ab>] unix_poll+0x2b/0xb0
 [<c03351c5>] sock_poll+0x25/0x30
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c03367ae>] sys_socketcall+0x17e/0x2c0
 [<c038910b>] syscall_call+0x7/0xb

kdeinit       S C04C3800     0  2161      1          2188  2152 (NOTLB)
da7fdea4 00200082 da99f440 c04c3800 00000023 00000000 da99f440 00000010 
       dc4a68a0 00016624 f8cb2f29 0000002b da99f5e8 00000000 7fffffff 00000008 
       00000000 c0122e45 00200246 d796ca00 00000010 00200246 d96c5340 d7a67300 
Call Trace:
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c015cf14>] pipe_poll+0x34/0x80
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c0334ff5>] sock_ioctl+0xe5/0x290
 [<c038910b>] syscall_call+0x7/0xb

artsd         R running     0  2170   2144          2191  2149 (NOTLB)
kdeinit       R running     0  2188      1          2144  2161 (NOTLB)
ksmserver     S C04C3800     0  2190   2090                2107 (NOTLB)
da8a2ea4 00200086 da99e390 c04c3800 00000023 00000000 da99e390 00000010 
       da87a3d0 00001f07 266d2fa0 00000029 da99e538 00000000 7fffffff 00000019 
       00000000 c0122e45 00200246 d33ba4a0 01000000 00000018 c03830ab d1afee00 
Call Trace:
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c03830ab>] unix_poll+0x2b/0xb0
 [<c03351c5>] sock_poll+0x25/0x30
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c0334ff5>] sock_ioctl+0xe5/0x290
 [<c038910b>] syscall_call+0x7/0xb

kdeinit       S C04C3800     0  2191   2144          2201  2170 (NOTLB)
d8517ea4 00200082 dab42350 c04c3800 00000031 00000000 dab42350 00000010 
       dc4a68a0 000007f5 ba15b6fb 00000038 dab424f8 00000000 7fffffff 0000000b 
       00000000 c0122e45 00200246 d6b68600 00000400 0000000a c03830ab d690c320 
Call Trace:
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c03830ab>] unix_poll+0x2b/0xb0
 [<c03351c5>] sock_poll+0x25/0x30
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c0334ff5>] sock_ioctl+0xe5/0x290
 [<c038910b>] syscall_call+0x7/0xb

kdeinit       S C04C3800     0  2194      1          2195  2144 (NOTLB)
da6b1ea4 00200082 da87a3d0 c04c3800 00000028 00000000 da87a3d0 00000010 
       d6515180 00000fd5 95c884aa 00000031 da87a578 00000000 7fffffff 00000009 
       00000000 c0122e45 00200246 d65ccd00 00000020 00200246 d7c22860 d677d0c0 
Call Trace:
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c015cf14>] pipe_poll+0x34/0x80
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c0334ff5>] sock_ioctl+0xe5/0x290
 [<c038910b>] syscall_call+0x7/0xb

kdeinit       S C04C3800     0  2195      1          2197  2194 (NOTLB)
d7956ea4 00200082 da87ba10 c04c3800 00000020 00000000 da87ba10 00000010 
       d6515180 000095a7 266eb171 00000029 da87bbb8 00000000 7fffffff 0000000a 
       00000000 c0122e45 d83ba91c d7956f38 d83ba000 d63d4800 00000009 00000009 
Call Trace:
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c01f5000>] tty_poll+0x80/0xa0
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c0334ff5>] sock_ioctl+0xe5/0x290
 [<c038910b>] syscall_call+0x7/0xb

kdeinit       R running     0  2197      1          2200  2195 (NOTLB)
kdeinit       S C04C3800     0  2200      1          2208  2197 (NOTLB)
d83b9ea4 00200082 da7374c0 c04c3800 00000038 00000000 da7374c0 00000000 
       dc4a68a0 000078c8 dc4d9d76 00000038 da737668 fffe990e d83b9eb8 00000009 
       00000000 c0122df3 d83b9eb8 fffe990e 00000020 c03fe430 dc749aac fffe990e 
Call Trace:
 [<c0122df3>] schedule_timeout+0x63/0xc0
 [<c0122d80>] process_timeout+0x0/0x10
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c0334ff5>] sock_ioctl+0xe5/0x290
 [<c038910b>] syscall_call+0x7/0xb

kdeinit       S C04C3800     0  2201   2144          2236  2191 (NOTLB)
d7cc2ea4 00200082 da99f9d0 c04c3800 00000001 00000000 da99f9d0 00000010 
       d6515180 0000124d ca88e1ad 0000001d da99fb78 00000000 7fffffff 00000004 
       00000000 c0122e45 00200246 d565cb60 00000008 00000003 c03830ab d552fb60 
Call Trace:
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c03830ab>] unix_poll+0x2b/0xb0
 [<c03351c5>] sock_poll+0x25/0x30
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c014fec9>] vfs_write+0xf9/0x150
 [<c038910b>] syscall_call+0x7/0xb

kdeinit       R running     0  2204      1          2210  2208 (NOTLB)
kdeinit       S C04C3800     0  2208      1          2204  2200 (NOTLB)
d54f5ea4 00200082 d53cd1a0 c04c3800 00000023 00000000 d53cd1a0 00000010 
       d6515710 0000b454 2675c176 00000029 d53cd348 00000000 7fffffff 00000009 
       00000000 c0122e45 00200246 d5a38b80 00000020 00200246 d62f3560 d5db6de0 
Call Trace:
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c015cf14>] pipe_poll+0x34/0x80
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c0334ff5>] sock_ioctl+0xe5/0x290
 [<c038910b>] syscall_call+0x7/0xb

korgac        S C04C3800     0  2210      1          2216  2204 (NOTLB)
d7957ea4 00000086 d6515710 c04c3800 0000002c 00000000 d6515710 00000000 
       dc4a68a0 00019aca 7052c419 0000002e d65158b8 fffeacf8 d7957eb8 00000009 
       00000000 c0122df3 d7957eb8 fffeacf8 00000020 c03fe4c8 c03fe4c8 fffeacf8 
Call Trace:
 [<c0122df3>] schedule_timeout+0x63/0xc0
 [<c0122d80>] process_timeout+0x0/0x10
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c0334ff5>] sock_ioctl+0xe5/0x290
 [<c038910b>] syscall_call+0x7/0xb

kgpg          S C04C3800     0  2211      1          2235  2216 (NOTLB)
d5fddea4 00000082 d53cd730 c04c3800 00000023 00000000 d53cd730 00000010 
       dc4a68a0 00015649 81e1bfad 00000035 d53cd8d8 00000000 7fffffff 00000009 
       00000000 c0122e45 00000246 d5a8a4c0 00000020 00000246 d62f31a0 d5e55840 
Call Trace:
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c015cf14>] pipe_poll+0x34/0x80
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c0334ff5>] sock_ioctl+0xe5/0x290
 [<c038910b>] syscall_call+0x7/0xb

kdeinit       R running     0  2216      1          2211  2210 (NOTLB)
knotes        S C04C3800     0  2235      1          2243  2211 (NOTLB)
d55b3ea4 00000082 d4d3a110 c04c3800 00000023 00000000 d4d3a110 00000010 
       dc4a68a0 00014e37 ad48fb30 0000002c d4d3a2b8 00000000 7fffffff 00000009 
       00000000 c0122e45 00000246 d4cdc0c0 00000020 00000246 d4d7a6c0 d4811c20 
Call Trace:
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c015cf14>] pipe_poll+0x34/0x80
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c0334ff5>] sock_ioctl+0xe5/0x290
 [<c038910b>] syscall_call+0x7/0xb

artscontrol   R running     0  2236   2144          2238  2201 (NOTLB)
gkrellm       R running     0  2238   2144  2244    2242  2236 (NOTLB)
xsane         D C04C3800     0  2242   2144                2238 (NOTLB)
da7d7e74 00200082 d4d3b750 c04c3800 da7d7ea4 00000000 c015dbc3 dfe308e0 
       dc4a68a0 000118a8 0a369cf5 00000021 d4d3b8f8 de0ca228 d4d3b750 da7d7e80 
       de0ca220 c01dec1d de0ca22c de0ca22c de0ca22c d4d3b750 00000002 de0ca228 
Call Trace:
 [<c015dbc3>] cached_lookup+0x23/0x90
 [<c01dec1d>] rwsem_down_write_failed+0x8d/0x150
 [<c02b506a>] .text.lock.devio+0x28/0x17e
 [<c02a94ba>] usb_unbind_interface+0x7a/0x80
 [<c0224dd4>] device_release_driver+0x64/0x70
 [<c02a9750>] usb_driver_release_interface+0x50/0x60
 [<c02b2c1e>] releaseintf+0xae/0xc0
 [<c02b4912>] proc_releaseinterface+0x52/0x70
 [<c02b4e7c>] usbdev_ioctl+0x21c/0x370
 [<c01627f7>] file_ioctl+0x77/0x1b0
 [<c0162a57>] sys_ioctl+0x127/0x2d0
 [<c0114e40>] do_page_fault+0x0/0x4ff
 [<c038910b>] syscall_call+0x7/0xb

kalarmd       S C04C3800     0  2243      1          2256  2235 (NOTLB)
d8445ea4 00000086 d53ccc10 c04c3800 00000023 00000000 d53ccc10 00000010 
       dc4a68a0 000223dc 26837ba8 00000029 d53ccdb8 00000000 7fffffff 00000009 
       00000000 c0122e45 00000246 d48121c0 00000020 00000246 d4d7a1c0 d3397e60 
Call Trace:
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c015cf14>] pipe_poll+0x34/0x80
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c0334ff5>] sock_ioctl+0xe5/0x290
 [<c038910b>] syscall_call+0x7/0xb

gkrellm       S C04C3800     0  2244   2238  2245               (NOTLB)
d54f0f04 00000082 da87b480 c04c3800 00000000 000000d0 bf500000 00000000 
       dc4a68a0 00003e63 b2b5f83e 00000038 da87b628 fffe9c32 d54f0f18 d54f0f60 
       000007d1 c0122df3 d54f0f18 fffe9c32 dc2bb5a0 c03fe448 c03fe448 fffe9c32 
Call Trace:
 [<c0122df3>] schedule_timeout+0x63/0xc0
 [<c0122d80>] process_timeout+0x0/0x10
 [<c0163d8e>] do_poll+0xae/0xd0
 [<c0163f85>] sys_poll+0x1d5/0x310
 [<c0163270>] __pollwait+0x0/0xd0
 [<c038910b>] syscall_call+0x7/0xb

gkrellm       S C04C3800     0  2245   2244                     (NOTLB)
d55b8d80 00000082 d53cc0f0 c04c3800 d244c080 c03629ba d7fa9900 00000000 
       dc4a68a0 00001d95 af931220 00000038 d53cc298 dc15f7c0 7fffffff d55b8de4 
       00000000 c0122e45 00000001 c0338634 dffe75c0 d7fad5c0 dea97d60 c033869a 
Call Trace:
 [<c03629ba>] tcp_transmit_skb+0x3da/0x5f0
 [<c0122e45>] schedule_timeout+0xb5/0xc0
 [<c0338634>] kfree_skbmem+0x24/0x30
 [<c033869a>] __kfree_skb+0x5a/0xc0
 [<c03591a2>] tcp_data_wait+0xd2/0xe0
 [<c0118650>] autoremove_wake_function+0x0/0x50
 [<c036a0ff>] tcp_v4_do_rcv+0x11f/0x130
 [<c0118650>] autoremove_wake_function+0x0/0x50
 [<c0359227>] tcp_prequeue_process+0x77/0x90
 [<c035979c>] tcp_recvmsg+0x3ac/0x790
 [<c0204acf>] do_con_write+0x31f/0x770
 [<c037969a>] inet_recvmsg+0x5a/0x80
 [<c0334b8a>] sock_aio_read+0xca/0xe0
 [<c014fb8c>] do_sync_read+0x8c/0xc0
 [<c01f93dc>] write_chan+0x17c/0x240
 [<c0116f40>] default_wake_function+0x0/0x20
 [<c01f9260>] write_chan+0x0/0x240
 [<c014fcdb>] vfs_read+0x11b/0x150
 [<c014ff62>] sys_read+0x42/0x70
 [<c038910b>] syscall_call+0x7/0xb

kmail         S C04C3800     0  2256      1                2243 (NOTLB)
d5faeea4 00000086 d6514660 c04c3800 00000038 00000000 d6514660 00000000 
       dc4a68a0 00004672 d71d575d 00000038 d6514808 fffe9aac d5faeeb8 00000009 
       00000000 c0122df3 d5faeeb8 fffe9aac 00000020 c03fe438 c03fe438 fffe9aac 
Call Trace:
 [<c0122df3>] schedule_timeout+0x63/0xc0
 [<c0122d80>] process_timeout+0x0/0x10
 [<c01635b5>] do_select+0x195/0x2d0
 [<c0163270>] __pollwait+0x0/0xd0
 [<c0163a12>] sys_select+0x2f2/0x530
 [<c0334ff5>] sock_ioctl+0xe5/0x290
 [<c038910b>] syscall_call+0x7/0xb

bash          R running     0  2268   1700                     (NOTLB)

--Boundary-00=_t82bAVn1A90PPb6--
