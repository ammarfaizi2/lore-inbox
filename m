Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTK1PSB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 10:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbTK1PSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 10:18:01 -0500
Received: from smtp.uol.com.br ([200.221.11.52]:59097 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S262386AbTK1PRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 10:17:34 -0500
Subject: [PROBLEM] 2.6.0-test11: USB freezes after gnome-pilot
From: Daniel Serodio <dserodio@mandic.com.br>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-0GbXi4cCZnVKFtVlRbHu"
Message-Id: <1070032671.602.116.camel@fugazi>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 28 Nov 2003 13:17:51 -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0GbXi4cCZnVKFtVlRbHu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi! This is my first bug report to this list, so please excuse me if I
omit important information, or make the message too big.

I'm running 2.6.0-test11, and I have a Palm M515 connected thru the USB
cradle. I can sync from/to the Palm with pilot-link, but if I try to run
gnome-pilot, the USB subsystem "freezes": gnome-pilot stays in
"uninterruptible sleep" and can't be killed, my USB mouse stops working,
and cat /proc/bus/usb/devices freezes forever. I have to reboot so that
it will work again.

I'm attaching the output of dmesg, of 'scripts/ver_linux', of 'cat
/proc/bus/usb/devices' and of 'strace gnome-pilot'. BTW, I passed the
"noapic" option to the kernel. If you need more info, please CC: me as I
don't subscribe to lkml.

TIA,
Daniel Serodio


--=-0GbXi4cCZnVKFtVlRbHu
Content-Description: 
Content-Disposition: attachment; filename=dmesg-noapic.test11
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Linux version 2.6.0-test11 (daniel@fugazi) (gcc version 3.3.2 (Debian)) #1 Thu Nov 27 14:56:43 BRST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 761686                                    ) @ 0x000f6a70
ACPI: RSDT (v001 761686 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3000
ACPI: FADT (v001 761686 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3040
ACPI: DSDT (v001 761686 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Building zonelist for node : 0
Kernel command line: root=/dev/hda6 ro vga=9 noapic
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1334.914 MHz processor.
Console: colour VGA+ 132x50
Memory: 255836k/262080k available (1891k kernel code, 5528k reserved, 720k data, 132k init, 0k highmem)
Calibrating delay loop... 2629.63 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:     After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0183f9ff c1c7f9ff 00000000 00000020
CPU: AMD Athlon(tm) processor stepping 04
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb690, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 12
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
ikconfig 0.7 with /proc/config*
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected AMD 761 chipset
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xf0000000
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xc400-0xc407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xc408-0xc40f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLP AS30.0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Hewlett-Packard CD-Writer Plus 9100, ATAPI CD/DVD-ROM drive
hdd: ATAPI CDROM, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 58633344 sectors (30020 MB) w/1902KiB Cache, CHS=58168/16/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 >
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 5, io base 0000c800
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci_hcd 0000:00:07.2: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.0-test11 uhci_hcd
usb usb1: SerialNumber: 0000:00:07.2
drivers/usb/core/usb.c: usb_hotplug
usb usb1: registering 1-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: Port indicators are not supported
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: hub controller current requirement: 0mA
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports
uhci_hcd 0000:00:07.3: UHCI Host Controller
uhci_hcd 0000:00:07.3: irq 5, io base 0000cc00
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci_hcd 0000:00:07.3: root hub device address 1
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.0-test11 uhci_hcd
usb usb2: SerialNumber: 0000:00:07.3
drivers/usb/core/usb.c: usb_hotplug
usb usb2: registering 2-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: ganged power switching
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: Port indicators are not supported
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: hub controller current requirement: 0mA
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: enabling power on all ports
uhci_hcd 0000:00:11.0: UHCI Host Controller
uhci_hcd 0000:00:11.0: irq 10, io base 0000dc00
uhci_hcd 0000:00:11.0: new USB bus registered, assigned bus number 3
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci_hcd 0000:00:11.0: root hub device address 1
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.0-test11 uhci_hcd
usb usb3: SerialNumber: 0000:00:11.0
drivers/usb/core/usb.c: usb_hotplug
usb usb3: registering 3-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: ganged power switching
hub 3-0:1.0: global over-current protection
hub 3-0:1.0: Port indicators are not supported
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: hub controller current requirement: 0mA
hub 3-0:1.0: local power source is good
hub 3-0:1.0: no over-current condition exists
hub 3-0:1.0: enabling power on all ports
uhci_hcd 0000:00:11.1: UHCI Host Controller
uhci_hcd 0000:00:11.1: irq 11, io base 0000e000
uhci_hcd 0000:00:11.1: new USB bus registered, assigned bus number 4
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci_hcd 0000:00:11.1: root hub device address 1
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.0-test11 uhci_hcd
usb usb4: SerialNumber: 0000:00:11.1
drivers/usb/core/usb.c: usb_hotplug
usb usb4: registering 4-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 4-0:1.0: usb_probe_interface
hub 4-0:1.0: usb_probe_interface - got id
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
hub 4-0:1.0: standalone hub
hub 4-0:1.0: ganged power switching
hub 4-0:1.0: global over-current protection
hub 4-0:1.0: Port indicators are not supported
hub 4-0:1.0: power on to power good time: 2ms
hub 4-0:1.0: hub controller current requirement: 0mA
hub 4-0:1.0: local power source is good
hub 4-0:1.0: no over-current condition exists
hub 4-0:1.0: enabling power on all ports
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for Handspring Visor / Palm OS
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Clie 3.5
drivers/usb/core/usb.c: registered new driver visor
drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver v2.1
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
hub 4-0:1.0: port 1, status 100, change 3, 12 Mb/s
hub 4-0:1.0: port 2, status 100, change 3, 12 Mb/s
hub 3-0:1.0: port 1, status 301, change 3, 1.5 Mb/s
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
ACPI: (supports S0 S1 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 132k freed
hub 3-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 3-0:1.0: new USB device on port 1, assigned address 2
usb 3-1: new device strings: Mfr=1, Product=3, SerialNumber=0
drivers/usb/core/message.c: USB device number 2 default language ID 0x409
usb 3-1: Product: Microsoft 5-Button Mouse with IntelliEye(TM)
usb 3-1: Manufacturer: Microsoft
drivers/usb/core/usb.c: usb_hotplug
usb 3-1: registering 3-1:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hid 3-1:1.0: usb_probe_interface
hid 3-1:1.0: usb_probe_interface - got id
input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with IntelliEye(TM)] on usb-0000:00:11.0-1
hub 3-0:1.0: port 2, status 101, change 3, 12 Mb/s
hub 3-0:1.0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 3-0:1.0: new USB device on port 2, assigned address 3
usb 3-2: new device strings: Mfr=1, Product=2, SerialNumber=3
drivers/usb/core/message.c: USB device number 3 default language ID 0x409
usb 3-2: Product: deskjet 3420
usb 3-2: Manufacturer: hp
usb 3-2: SerialNumber: BR27U1F0NR1J
drivers/usb/core/usb.c: usb_hotplug
usb 3-2: registering 3-2:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
usbserial 3-2:1.0: usb_probe_interface
usbserial 3-2:1.0: usb_probe_interface - got id
hub 4-0:1.0: port 1 enable change, status 100
hub 4-0:1.0: port 2 enable change, status 100
hub 2-0:1.0: port 1, status 100, change 3, 12 Mb/s
hub 2-0:1.0: port 2, status 100, change 3, 12 Mb/s
hub 1-0:1.0: port 1, status 100, change 3, 12 Mb/s
hub 1-0:1.0: port 2, status 100, change 3, 12 Mb/s
hub 1-0:1.0: port 1 enable change, status 100
hub 1-0:1.0: port 2 enable change, status 100
hub 2-0:1.0: port 1 enable change, status 100
hub 2-0:1.0: port 2 enable change, status 100
Adding 506036k swap on /dev/hda8.  Priority:-1 extents:1
drivers/usb/host/uhci-hcd.c: c800: suspend_hc
EXT3 FS on hda6, internal journal
drivers/usb/host/uhci-hcd.c: cc00: suspend_hc
drivers/usb/host/uhci-hcd.c: e000: suspend_hc
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0d.0: 3Com PCI 3c905C Tornado at 0xd800. Vers LK1.1.19
nvidia: no version magic, tainting kernel.
nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496  Wed Jul 16 19:03:09 PDT 2003
sensors: numerical sysctl 7 2 1 is obsolete.
sensord: numerical sysctl 7 2 1 is obsolete.
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:05.0 into 4x mode
drivers/usb/host/uhci-hcd.c: e000: wakeup_hc
hub 4-0:1.0: port 1, status 101, change 1, 12 Mb/s
hub 4-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 4-0:1.0: new USB device on port 1, assigned address 2
usb 4-1: new device strings: Mfr=1, Product=2, SerialNumber=5
drivers/usb/core/message.c: USB device number 2 default language ID 0x409
usb 4-1: Product: Palm Handheld 
usb 4-1: Manufacturer: Palm, Inc.
usb 4-1: SerialNumber: 00RP34626X8R
drivers/usb/core/usb.c: usb_hotplug
usb 4-1: registering 4-1:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
usbserial 4-1:1.0: usb_probe_interface
usbserial 4-1:1.0: usb_probe_interface - got id
usbserial 4-1:1.0: Handspring Visor / Palm OS converter detected
usb 4-1: Handspring Visor / Palm OS converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
usb 4-1: Handspring Visor / Palm OS converter now attached to ttyUSB1 (or usb/tts/1 for devfs)
drivers/usb/host/uhci-hcd.c: uhci_result_control() failed with status 500000
[c1361270] link (013611b2) element (01362200)
 Element != First TD
  0: [c1362100] link (01362180) e3 LS Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=0d174bc0)
  1: [c1362180] link (013621c0) e3 LS Length=7 MaxLen=7 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=0b82aa80)
  2: [c13621c0] link (01362200) e3 LS Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=69(IN) (buf=0b82aa88)
  3: [c1362200] link (01362240) e3 LS Stalled Babble Length=3 MaxLen=3 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=0b82aa90)
  4: [c1362240] link (00000001) e3 LS IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)

usb 3-1: control timeout on ep0in
hub 4-0:1.0: port 1, status 100, change 3, 12 Mb/s
usb 4-1: USB disconnect, address 2
usb 4-1: usb_disable_device nuking all URBs
usb 4-1: unregistering interface 4-1:1.0
usbserial 4-1:1.0: device disconnected
drivers/usb/core/usb.c: usb_hotplug
usb 4-1: unregistering device
drivers/usb/core/usb.c: usb_hotplug
hub 4-0:1.0: port 1 enable change, status 100
drivers/usb/host/uhci-hcd.c: e000: suspend_hc

--=-0GbXi4cCZnVKFtVlRbHu
Content-Disposition: attachment; filename=proc.bus.usb.devices
Content-Type: text/plain; name=proc.bus.usb.devices; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-test11 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:11.1
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc= 93/900 us (10%), #Int=  1, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-test11 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:11.0
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=045e ProdID=0039 Rev= 3.00
S:  Manufacturer=Microsoft
S:  Product=Microsoft 5-Button Mouse with IntelliEye(TM)
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms

T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=03f0 ProdID=7104 Rev= 1.00
S:  Manufacturer=hp
S:  Product=deskjet 3420
S:  SerialNumber=BR27U1F0NR1J
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  2mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=07(print) Sub=01 Prot=02 Driver=(none)
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-test11 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:07.3
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.0-test11 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:07.2
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

--=-0GbXi4cCZnVKFtVlRbHu
Content-Disposition: attachment; filename=ver.linux
Content-Type: text/plain; name=ver.linux; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux fugazi 2.6.0-test11 #1 Thu Nov 27 14:56:43 BRST 2003 i686 GNU/Linux
 
Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre3
e2fsprogs              1.35-WIP
pcmcia-cs              3.2.5
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.14
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         smbfs snd_pcm_oss snd_mixer_oss snd_emu10k1 snd_rawmidi snd_pcm snd_timer snd_ac97_codec snd_page_alloc snd_util_mem snd_hwdep snd nls_iso8859_1 nls_cp437 vfat nvidia 3c59x

--=-0GbXi4cCZnVKFtVlRbHu
Content-Disposition: attachment; filename=gpilotd.strace.bz2
Content-Type: application/x-bzip; name=gpilotd.strace.bz2
Content-Transfer-Encoding: base64

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

--=-0GbXi4cCZnVKFtVlRbHu--

