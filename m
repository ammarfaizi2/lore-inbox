Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261418AbSLAEdh>; Sat, 30 Nov 2002 23:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261433AbSLAEdh>; Sat, 30 Nov 2002 23:33:37 -0500
Received: from mail.wincom.net ([209.216.129.3]:54537 "EHLO wincom.net")
	by vger.kernel.org with ESMTP id <S261418AbSLAEdd>;
	Sat, 30 Nov 2002 23:33:33 -0500
From: "Dennis Grant" <trog@wincom.net>
Reply-to: trog@wincom.net
To: linux-kernel@vger.kernel.org
Date: Sat, 30 Nov 102 23:38:04 -0500
Subject: Followup on ATA modes on Asus A7V8X
X-Mailer: CWMail Web to Mail Gateway 2.4e, http://netwinsite.com/top_mail.htm
Message-id: <3de992cb.2c55.0@wincom.net>
X-User-Info: 24.57.83.120
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After reporting problems with hdparm speeds on an Asus A7V8X, it was suggested
that I change kernels to 2.4.20pre3 + the latest ac patch.

Seeing that 2.4.20rc4 was out, I grabbed that, and attempted to add the latest
ac patch against rc4. That patched OK, but would not compile, so I reverted
back to vanilla rc4 and tried that.

And the envelope please:

/sbin/hdparm -Tt /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.42 seconds =304.76 MB/sec
 Timing buffered disk reads:  64 MB in  1.29 seconds = 49.61 MB/sec

Much better.

And I note that the driver messages in dmesg state very clearly that the drive
is in an ATA133 state, which is sweet crunchy goodness.

Thanks to all so far. Colour me a happier camper.

Everything is not 100% OK just yet though. Attached is the output from dmsg
for your perusal. I note that my DC10+ video capture card, which worked just
fine on my 2.4.19 P233 system, does not seem to work in the new system....

I guess (failing anybody noticing anything else glaring in the dmesg output)
that's the next hurdle.

Thanks again to all who responded.

DG

------------------------------
Linux version 2.4.20-rc4 () (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7))
#5 Thu Nov 28 22:39:43 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131068
zone(0): 4096 pages.
zone(1): 126972 pages.
zone(2): 0 pages.
Kernel command line: ro root=LABEL=/ pci=biosirq agp_try_unsupported=1 parport=auto
js=chf
Found and enabled local APIC!
Initializing CPU#0
Detected 1733.438 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3460.30 BogoMIPS
Memory: 515684k/524272k available (1535k kernel code, 8200k reserved, 546k data,
116k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(TM) XP 2100+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1733.3222 MHz.
..... host bus clock speed is 266.6649 MHz.
cpu: 0, clocks: 2666649, slice: 1333324
CPU0<T0:2666640,T1:1333312,D:4,S:1333324,C:2666649>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf1730, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/3177] at 00:11.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
parport0: Printer, EPSON Stylus COLOR 740
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-algo-bit.o: i2c bit algorithm module
i2c-proc.o version 2.6.1 (20010825)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI
ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (interrupt-driven).
lp0: console ready
gameport0: NS558 ISA at 0x200 speed 1147 kHz
input0: Analog 3-axis 4-button 1-hat CHF joystick at gameport0.0 [TSC timer,
1730 MHz clock, 901 ns res]

DoubleTalk PC - not found
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx

VP_IDE: IDE controller on PCI bus 00 dev 89
PCI: No IRQ known for interrupt pin A of device 00:11.1.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx

VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 6E030L0, ATA DISK drive
hdc: 56X CD-ROM, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c035fd24, I/O limit 4095Mb (mask 0xffffffff)
hda: 60058656 sectors (30750 MB) w/2048KiB Cache, CHS=3738/255/63, UDMA(133)

hdc: ATAPI 52X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Linux video capture interface: v1.00
Zoran ZR36060 + ZR36057/67 MJPEG board driver version 0.7
PCI: Found IRQ 11 for device 00:0e.0
MJPEG[0]: Zoran ZR36067 (rev 2) irq: 11, memory: 0xdd800000
MJPEG[0]: subsystem vendor=0x1031 id=0x7efe
MJPEG[0]: Initializing i2c bus...
MJPEG[0]: Card not supported
No known MJPEG cards found.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Unsupported Via chipset (device id: 3189), you might want to try agp_try_unsupported=1.

agpgart: no supported devices found.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 3 for device 00:10.0
IRQ routing conflict for 00:10.0, have irq 9, want irq 3
IRQ routing conflict for 00:10.1, have irq 9, want irq 3
IRQ routing conflict for 00:10.2, have irq 9, want irq 3
IRQ routing conflict for 00:10.3, have irq 9, want irq 3
uhci.c: USB UHCI at I/O 0xd800, IRQ 9
usb.c: new USB bus registered, assigned bus number 1
uhci.c: detected 2 ports
usb.c: kmalloc IF dfe7a200, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI-alt Root Hub
SerialNumber: d800
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface dfe7a200
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
PCI: Found IRQ 3 for device 00:10.1
IRQ routing conflict for 00:10.0, have irq 9, want irq 3
IRQ routing conflict for 00:10.1, have irq 9, want irq 3
IRQ routing conflict for 00:10.2, have irq 9, want irq 3
IRQ routing conflict for 00:10.3, have irq 9, want irq 3
uhci.c: USB UHCI at I/O 0xd400, IRQ 9
usb.c: new USB bus registered, assigned bus number 2
uhci.c: detected 2 ports
usb.c: kmalloc IF dfe7a400, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI-alt Root Hub
SerialNumber: d400
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface dfe7a400
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
PCI: Found IRQ 3 for device 00:10.2
IRQ routing conflict for 00:10.0, have irq 9, want irq 3
IRQ routing conflict for 00:10.1, have irq 9, want irq 3
IRQ routing conflict for 00:10.2, have irq 9, want irq 3
IRQ routing conflict for 00:10.3, have irq 9, want irq 3
uhci.c: USB UHCI at I/O 0xd000, IRQ 9
usb.c: new USB bus registered, assigned bus number 3
uhci.c: detected 2 ports
usb.c: kmalloc IF dfe7a600, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI-alt Root Hub
SerialNumber: d000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface dfe7a600
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
uhci.c: root-hub INT complete: port1: 48a port2: 48a data: 6
uhci.c: d800: suspend_hc
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 2, portstatus 100, change 3, 12 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 100, change 3, 12 Mb/s
Freeing initrd memory: 63k freed
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
uhci.c: root-hub INT complete: port1: 48a port2: 48a data: 6
uhci.c: d400: suspend_hc
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 2, portstatus 100, change 3, 12 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 100, change 3, 12 Mb/s
Freeing unused kernel memory: 116k freed
uhci.c: root-hub INT complete: port1: 48a port2: 48a data: 6
uhci.c: d000: suspend_hc
uhci.c: d000: suspend_hc
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 100, change 3, 12 Mb/s
hub.c: port 2, portstatus 100, change 3, 12 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 100, change 3, 12 Mb/s
uhci.c: root-hub INT complete: port1: 488 port2: 488 data: 6
hub.c: port 1, portstatus 100, change 2, 12 Mb/s
hub.c: port 1 enable change, status 100
hub.c: port 2, portstatus 100, change 2, 12 Mb/s
hub.c: port 2 enable change, status 100
uhci.c: root-hub INT complete: port1: 488 port2: 488 data: 6
hub.c: port 1, portstatus 100, change 2, 12 Mb/s
hub.c: port 1 enable change, status 100
hub.c: port 2, portstatus 100, change 2, 12 Mb/s
hub.c: port 2 enable change, status 100
uhci.c: root-hub INT complete: port1: 488 port2: 488 data: 6
hub.c: port 1, portstatus 100, change 2, 12 Mb/s
hub.c: port 1 enable change, status 100
hub.c: port 2, portstatus 100, change 2, 12 Mb/s
hub.c: port 2 enable change, status 100
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
Adding Swap: 1044184k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Broadcom 4401 Ethernet Driver bcm4400 ver. 1.0.1 (08/26/02)
PCI: Found IRQ 10 for device 00:09.0
eth0: Broadcom BCM4401 100Base-T found at mem df000000, IRQ 10, node addr 00e018abf76b

bcm4400: eth0 NIC Link is Down
bcm4400: eth0 NIC Link is Up, 10 Mbps half duplex
NETDEV WATCHDOG: eth0: transmit timed out


