Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131633AbRCQOQm>; Sat, 17 Mar 2001 09:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131638AbRCQOQd>; Sat, 17 Mar 2001 09:16:33 -0500
Received: from [139.134.6.23] ([139.134.6.23]:40184 "EHLO
	mailin2.email.bigpond.com") by vger.kernel.org with ESMTP
	id <S131633AbRCQOQY>; Sat, 17 Mar 2001 09:16:24 -0500
Subject: USB Mouse Problem in 2.4 Kernels - 2.2.18 Works Fine
From: Andree Leidenfrost <aleidenf@bigpond.net.au>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
X-Mailer: Evolution (0.9/+cvs.2001.03.16.09.00 - Preview Release)
Date: 18 Mar 2001 01:14:45 +1100
Mime-Version: 1.0
Message-Id: <20010317141624Z131633-406+1187@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel hackers,

I am experiencing problems with a USB mouse: The machine boots, X
starts, I log on, everything works as expected. When I restart X or just
change to an alpha terminal and back to x the mouse does not work any
more. It does not necessarily happen the first time I do this but it
eventually will. The device is still there, ie. I can do a 'cat
/dev/input/mice' with out error but it does not do anything, there are
no characters when I move the mouse.

This does at least happen with 2.4.2, 2.4.3pre4, 2.4.2-ac17, 2.4.2-ac18,
and 2.4.2-ac20 on both Debian stable and unstable. It does not happen
with 2.2.18. So I assume that it is neither a hardware issue nor an
environment one (as in compiler version and so forth), but a problem
with the USB code itself. I think the problem might perhaps be that the
USB subsystem initialises the mouse correctly on boot with 1.5 MB/s but
tries to use 12 MB/s on
later attempts which fails. But I do not really know what I am talking
about here...

Hardware is an ASUS K7V motherboard (VIA chip set), BIOS versions
1008.01c/1008.01d/1007. It happens with both USB compiled into the
kernel and compiled as modules. A USB scanner works fine.

Please let me know if I can be of further assistance or more information
is needed.

Thanks very much,

    Andree

PS: I send a message with similar contents to the linux-usb list.
Unfortunately, I got no reply so far. However, that message mentioned
only 2.4.2-ac18 and -ac17, maybe that is why. Since then I tested some
more kernels (see above).

PPS: I am not subscribed to this list, I just follow it via GeoCrawler,
so it would be great if replies could be cc'ed to me directly. Thanks a
lot.

--- T H E   D E T A I L S ---

/proc/bus/usb/devices looks like this:

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  3 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=d000
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=104/900 us (12%), #Int=  2, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=d400
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 4
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0451 ProdID=2046 Rev= 1.25
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms
T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=ff(vend.) Sub=00 Prot=ff MxPS= 8 #Cfgs=  1
P:  Vendor=04b8 ProdID=0103 Rev= 0.01
S:  Manufacturer=EPSON
S:  Product=Perfection610  
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  2mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=usbscanner
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
T:  Bus=01 Lev=02 Prnt=02 Port=02 Cnt=02 Dev#=  5 Spd=1.5 MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0458 ProdID=0003 Rev= 0.00
S:  Manufacturer=KYE
S:  Product=Genius USB Wheel Mouse
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usb_mouse
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl= 10ms


Story Board
=================================================================================================
The machine boots and everything seems fine:

Linux version 2.4.2 (root@aurich) (gcc version 2.95.2 20000220 (Debian
GNU/Linux)) #3 Sat Mar 17 23:56:57 EST 2001
BIOS-provided physical RAM map:
BIOS-e820: 00000000000a0000 @ 0000000000000000 (usable)
BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
BIOS-e820: 000000000feec000 @ 0000000000100000 (usable)
BIOS-e820: 0000000000003000 @ 000000000ffec000 (ACPI data)
BIOS-e820: 0000000000010000 @ 000000000ffef000 (reserved)
BIOS-e820: 0000000000001000 @ 000000000ffff000 (ACPI NVS)
BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
On node 0 totalpages: 65516
zone(0): 4096 pages.
zone(1): 61420 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=302
BOOT_FILE=/vmlinuz idebus=33 video=matrox:vesa:0x193 hdc=ide-scsi
hdd=ide-scsi
ide_setup: idebus=33
ide_setup: hdc=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 700.050 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1395.91 BogoMIPS
Memory: 255956k/262064k available (731k kernel code, 5724k reserved,
248k data, 168k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0081f9ff c0c1f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After vendor init, caps: 0081f9ff c0c1f9ff 00000000 00000000
CPU: After generic, caps: 0081f9ff c0c1f9ff 00000000 00000000
CPU: Common caps: 0081f9ff c0c1f9ff 00000000 00000000
CPU: AMD-K7(tm) Processor stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0fa0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 170080kB/56693kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
hda: ST320423A, ATA DISK drive
hdc: RICOH CD-R/RW MP7120A, ATAPI CD/DVD-ROM drive
hdd: Pioneer DVD-ROM ATAPIModel DVD-115 0122, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 40011300 sectors (20486 MB) w/512KiB Cache, CHS=2490/255/63
Partition check:
hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
 http://www.scyld.com/network/ne2k-pci.html
PCI: Found IRQ 5 for device 00:0d.0
PCI: The same IRQ used for device 00:04.2
PCI: The same IRQ used for device 00:04.3
eth0: RealTek RTL-8029 found at 0x9800, IRQ 5, 52:54:05:F7:38:7E.
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.251 $ time 14:17:22 Mar 17 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 5 for device 00:04.2
PCI: The same IRQ used for device 00:04.3
PCI: The same IRQ used for device 00:0d.0
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF cff1d340, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: d400
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface cff1d340
PCI: Found IRQ 5 for device 00:04.3
PCI: The same IRQ used for device 00:04.2
PCI: The same IRQ used for device 00:0d.0
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 5
usb-uhci.c: Detected 2 ports
hub.c: port 1 connection change
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 101, change 3, 12 Mb/s
hub.c: port 2, portstatus 103, change 0, 12 Mb/s
hub.c: USB new device connect on bus1/2, assigned device number 2
usb.c: new USB bus registered, assigned bus number 2
usb.c: kmalloc IF cff1d500, numif 1
usb.c: new device strings: Mfr=0, Product=0, SerialNumber=0
hub.c: USB hub found
usb.c: kmalloc IF cff1d680, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 3 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: d000
hub.c: 4 ports detected
hub.c: standalone hub
hub.c: individual port power switching
hub.c: individual port over-current protection
hub.c: power on to power good time: 100ms
hub.c: hub controller current requirement: 100mA
hub.c: port removable status: RRRR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface cff1d500
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface cff1d680
usb.c: registered new driver usb_mouse
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
hub.c: port 1 enable change, status 300
hub.c: port 1 connection change
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 168k freed
hub.c: port 1 enable change, status 300
hub.c: port 2 enable change, status 300
hub.c: port 1 connection change
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
hub.c: port 1, portstatus 103, change 10, 12 Mb/s
hub.c: USB new device connect on bus1/2/1, assigned device number 4
usb.c: kmalloc IF cff1d980, numif 1
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
usb.c: USB device number 4 default language ID 0x409
Manufacturer: EPSON
Product: Perfection610  
usb.c: unhandled interfaces on device
usb.c: USB device 4 (vend/prod 0x4b8/0x103) is not claimed by any active
driver.
 Length              = 18
 DescriptorType      = 01
 USB version         = 1.00
 Vendor:Product      = 04b8:0103
 MaxPacketSize0      = 8
 NumConfigurations   = 1
 Device version      = 0.01
 Device Class:SubClass:Protocol = ff:00:ff
   Vendor class
Configuration:
 bLength             =    9
 bDescriptorType     =   02
 wTotalLength        = 0020
 bNumInterfaces      =   01
 bConfigurationValue =   01
 iConfiguration      =   00
 bmAttributes        =   40
 MaxPower            =    2mA

 Interface: 0
 Alternate Setting:  0
   bLength             =    9
   bDescriptorType     =   04
   bInterfaceNumber    =   00
   bAlternateSetting   =   00
   bNumEndpoints       =   02
   bInterface Class:SubClass:Protocol =   ff:ff:ff
   iInterface          =   00
   Endpoint:
     bLength             =    7
     bDescriptorType     =   05
     bEndpointAddress    =   81 (in)
     bmAttributes        =   02 (Bulk)
     wMaxPacketSize      = 0040
     bInterval           =   00
   Endpoint:
     bLength             =    7
     bDescriptorType     =   05
     bEndpointAddress    =   02 (out)
     bmAttributes        =   02 (Bulk)
     wMaxPacketSize      = 0040
     bInterval           =   00
hub.c: port 3 connection change
hub.c: port 3, portstatus 301, change 1, 1.5 Mb/s
hub.c: port 3, portstatus 303, change 10, 1.5 Mb/s
hub.c: USB new device connect on bus1/2/3, assigned device number 5
usb.c: kmalloc IF cff1da00, numif 1
usb.c: skipped 1 class/vendor specific interface descriptors
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
usb.c: USB device number 5 default language ID 0x409
Manufacturer: KYE
Product: Genius USB Wheel Mouse
mouse0: PS/2 mouse device for input0
input0: KYE Genius USB Wheel Mouse on usb1:5.0
usb.c: usb_mouse driver claimed interface cff1da00
Adding Swap: 610428k swap-space (priority -1)
hdc: driver not present
hdd: driver not present


=================================================================================================
When logging off from X or switching to a text console the following
happens and the mouse stops working:

Mar 18 00:21:03 aurich kernel: hub.c: port 3 connection change
Mar 18 00:21:03 aurich kernel: hub.c: port 3, portstatus 301, change 1,
1.5 Mb/s
Mar 18 00:21:03 aurich kernel: usb.c: USB disconnect on device 11
Mar 18 00:21:03 aurich kernel: hub.c: port 3, portstatus 100, change 11,
12 Mb/s
Mar 18 00:21:03 aurich kernel: hub.c: port 3 of hub 2 not enabled,
trying reset again...
Mar 18 00:21:03 aurich kernel: hub.c: port 3, portstatus 100, change 11,
12 Mb/s
Mar 18 00:21:03 aurich kernel: hub.c: port 3 of hub 2 not enabled,
trying reset again...
Mar 18 00:21:04 aurich kernel: hub.c: port 3, portstatus 100, change 11,
12 Mb/s
Mar 18 00:21:04 aurich kernel: hub.c: port 3 of hub 2 not enabled,
trying reset again...
Mar 18 00:21:04 aurich kernel: hub.c: port 3, portstatus 100, change 11,
12 Mb/s
Mar 18 00:21:04 aurich kernel: hub.c: port 3 of hub 2 not enabled,
trying reset again...
Mar 18 00:21:04 aurich kernel: hub.c: port 3, portstatus 100, change 11,
12 Mb/s
Mar 18 00:21:04 aurich kernel: hub.c: port 3 of hub 2 not enabled,
trying reset again...
Mar 18 00:21:04 aurich kernel: hub.c: Cannot enable port 3 of hub 2,
disabling port.
Mar 18 00:21:04 aurich kernel: hub.c: Maybe the USB cable is bad?
Mar 18 00:21:04 aurich kernel: hub.c: port 3 connection change
Mar 18 00:21:04 aurich kernel: hub.c: port 3, portstatus 100, change 11,
12 Mb/s
Mar 18 00:21:04 aurich kernel: hub.c: port 3 reset change


