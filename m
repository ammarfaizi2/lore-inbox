Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264223AbTEOT5d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264226AbTEOT5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:57:32 -0400
Received: from garnet.acns.fsu.edu ([146.201.2.25]:26766 "EHLO
	garnet.acns.fsu.edu") by vger.kernel.org with ESMTP id S264223AbTEOT5G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:57:06 -0400
Message-ID: <3EC3F401.80507@cox.net>
Date: Thu, 15 May 2003 16:09:37 -0400
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: USB not accepting addresses in bk9
References: <3EC310C3.9060606@cox.net> <20030515070800.GA6497@kroah.com> <3EC3F02E.1010604@cox.net> <20030515200446.GA10318@kroah.com>
In-Reply-To: <20030515200446.GA10318@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------030606030500080508000603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030606030500080508000603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Thu, May 15, 2003 at 03:53:18PM -0400, David van Hoose wrote:
> 
>>Greg KH wrote:
>>
>>>On Thu, May 15, 2003 at 12:00:03AM -0400, David van Hoose wrote:
>>>
>>>
>>>>Sometime between 2.5.69-bk4 and 2.5.69-bk8, something with related to 
>>>>the USB was messed up. I get the below lines in my dmesg.
>>>>hub 2-0:0: new USB device on port 1, assigned address 2
>>>>usb 2-1: USB device not accepting new address=2 (error=-110)
>>>>hub 2-0:0: new USB device on port 1, assigned address 3
>>>>usb 2-1: USB device not accepting new address=3 (error=-110)
>>>>
>>>>The first device is my Logitech Cordless Optical Trackball.
>>>>The second device is my TI USB Graphlink.
>>>>
>>>>The Trackball still works. Not sure about the graphlink as I don't have 
>>>>the software installed yet. :-/
>>>
>>>How can the device work if the USB bus rejected it?  Also, does
>>>/proc/interrupts increment for the USB controller when you plug a device
>>>in?
>>
>>No idea. It seems to increment the usb line in /proc/interrupts.
>>I've attached a dmesg with verbose debugging.
> 
> -ENOATTACHMENT :)

Ack. Must have accidently hit cancel rather than okay. Here it is.]
By the way, this is from bk10. Same config except for usb and alsa 
debugging options.

>>>>I used the same config for bk4 as I did for bk8. It've attached my 
>>>>config for bk9 since it is the same anyway.
>>>
>>>Care to do a binary search of bk4 to bk8 to try to find the problem?
>>>Should only take you 2 reboots at most :)
>>
>>What do you want me to do? I don't know if I have the skills yet to code 
>>for the kernel, so the least I can do is test it. :-)
> 
> 
> Ok, bk4 works for you and bk8 doesn't.  So try the following:
> 	- test bk6
> 	- if bk6 fails test bk5
> 		- if bk5 fails, the problem happened between bk4 and bk5
> 		- if bk5 works, the problem happened bewtwen bk5 and bk6
> 	- if bk6 works test bk7
> 		- if bk7 fails, the problem happened between bk6 and bk7
> 		- if bk7 works, the problem happened between bk7 and bk8
> 
> And let us know what the result is, please.

Will do that tonight.

Thanks,
David

--------------030606030500080508000603
Content-Type: text/plain;
 name="dmesg-2.5.69-bk10"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.5.69-bk10"

2
NET 4.0 IEEE 802.2 extended support
NET4.0 IEEE 802.2 BSD sockets, Jay Schulist, 2001, Arnaldo C. Melo, 2002-2003
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
Initializing IPsec netlink socket
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 221k freed
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 144k freed
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
ohci-hcd 00:03.0: Silicon Integrated S 7001
ohci-hcd 00:03.0: irq 9, pci mem e082d000
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
ohci-hcd 00:03.0: new USB bus registered, assigned bus number 1
ohci-hcd 00:03.0: USB HC reset_hc 00:03.0: ctrl = 0x0 ;
ohci-hcd 00:03.0: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: Silicon Integrated S 7001
usb usb1: Manufacturer: Linux 2.5.69-bk10 ohci-hcd
usb usb1: SerialNumber: 00:03.0
drivers/usb/core/usb.c: usb_hotplug
usb usb1: usb_new_device - registering interface 1-0:0
drivers/usb/core/usb.c: usb_hotplug
hub 1-0:0: usb_device_probe
hub 1-0:0: usb_device_probe - got id
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
hub 1-0:0: standalone hub
hub 1-0:0: ganged power switching
hub 1-0:0: global over-current protection
hub 1-0:0: Port indicators are not supported
hub 1-0:0: power on to power good time: 2ms
hub 1-0:0: hub controller current requirement: 0mA
hub 1-0:0: local power source is good
hub 1-0:0: no over-current condition exists
hub 1-0:0: enabling power on all ports
ohci-hcd 00:03.0: created debug files
ohci-hcd 00:03.0: OHCI controller state
ohci-hcd 00:03.0: OHCI 1.0, with legacy support registers
ohci-hcd 00:03.0: control 0x08f HCFS=operational IE PLE CBSR=3
ohci-hcd 00:03.0: cmdstatus 0x00000 SOC=0
ohci-hcd 00:03.0: intrstatus 0x00000044 RHSC SF
ohci-hcd 00:03.0: intrenable 0x80000002 MIE WDH
ohci-hcd 00:03.0: hcca frame #002b
ohci-hcd 00:03.0: roothub.a 01000202 POTPGT=1 NPS NDP=2
ohci-hcd 00:03.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci-hcd 00:03.0: roothub.status 00000000
ohci-hcd 00:03.0: roothub.portstatus [0] 0x00010301 CSC LSDA PPS CCS
ohci-hcd 00:03.0: roothub.portstatus [1] 0x00000100 PPS
ohci-hcd 00:03.1: Silicon Integrated S 7001 (#2)
ohci-hcd 00:03.1: irq 9, pci mem e082f000
ohci-hcd 00:03.1: new USB bus registered, assigned bus number 2
ohci-hcd 00:03.1: USB HC reset_hc 00:03.1: ctrl = 0x0 ;
ohci-hcd 00:03.1: root hub device address 1
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: Silicon Integrated S 7001 (#2)
usb usb2: Manufacturer: Linux 2.5.69-bk10 ohci-hcd
usb usb2: SerialNumber: 00:03.1
drivers/usb/core/usb.c: usb_hotplug
usb usb2: usb_new_device - registering interface 2-0:0
drivers/usb/core/usb.c: usb_hotplug
hub 2-0:0: usb_device_probe
hub 2-0:0: usb_device_probe - got id
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
hub 2-0:0: standalone hub
hub 2-0:0: ganged power switching
hub 2-0:0: global over-current protection
hub 2-0:0: Port indicators are not supported
hub 2-0:0: power on to power good time: 2ms
hub 2-0:0: hub controller current requirement: 0mA
hub 2-0:0: local power source is good
hub 2-0:0: no over-current condition exists
hub 2-0:0: enabling power on all ports
ohci-hcd 00:03.1: created debug files
ohci-hcd 00:03.1: OHCI controller state
ohci-hcd 00:03.1: OHCI 1.0, with legacy support registers
ohci-hcd 00:03.1: control 0x08f HCFS=operational IE PLE CBSR=3
ohci-hcd 00:03.1: cmdstatus 0x00000 SOC=0
ohci-hcd 00:03.1: intrstatus 0x00000044 RHSC SF
ohci-hcd 00:03.1: intrenable 0x80000002 MIE WDH
ohci-hcd 00:03.1: hcca frame #0034
ohci-hcd 00:03.1: roothub.a 01000202 POTPGT=1 NPS NDP=2
ohci-hcd 00:03.1: roothub.b 00000000 PPCM=0000 DR=0000
ohci-hcd 00:03.1: roothub.status 00000000
ohci-hcd 00:03.1: roothub.portstatus [0] 0x00010101 CSC PPS CCS
ohci-hcd 00:03.1: roothub.portstatus [1] 0x00000100 PPS
ohci-hcd 00:03.2: Silicon Integrated S 7001 (#3)
ohci-hcd 00:03.2: irq 9, pci mem e0831000
ohci-hcd 00:03.2: new USB bus registered, assigned bus number 3
ohci-hcd 00:03.2: USB HC reset_hc 00:03.2: ctrl = 0x0 ;
ohci-hcd 00:03.2: root hub device address 1
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: Silicon Integrated S 7001 (#3)
usb usb3: Manufacturer: Linux 2.5.69-bk10 ohci-hcd
usb usb3: SerialNumber: 00:03.2
drivers/usb/core/usb.c: usb_hotplug
usb usb3: usb_new_device - registering interface 3-0:0
drivers/usb/core/usb.c: usb_hotplug
hub 3-0:0: usb_device_probe
hub 3-0:0: usb_device_probe - got id
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
hub 3-0:0: standalone hub
hub 3-0:0: ganged power switching
hub 3-0:0: global over-current protection
hub 3-0:0: Port indicators are not supported
hub 3-0:0: power on to power good time: 2ms
hub 3-0:0: hub controller current requirement: 0mA
hub 3-0:0: local power source is good
hub 3-0:0: no over-current condition exists
hub 3-0:0: enabling power on all ports
ohci-hcd 00:03.2: created debug files
ohci-hcd 00:03.2: OHCI controller state
ohci-hcd 00:03.2: OHCI 1.0, with legacy support registers
ohci-hcd 00:03.2: control 0x08f HCFS=operational IE PLE CBSR=3
ohci-hcd 00:03.2: cmdstatus 0x00000 SOC=0
ohci-hcd 00:03.2: intrstatus 0x00000004 SF
ohci-hcd 00:03.2: intrenable 0x80000002 MIE WDH
ohci-hcd 00:03.2: hcca frame #0025
ohci-hcd 00:03.2: roothub.a 01000202 POTPGT=1 NPS NDP=2
ohci-hcd 00:03.2: roothub.b 00000000 PPCM=0000 DR=0000
ohci-hcd 00:03.2: roothub.status 00000000
ohci-hcd 00:03.2: roothub.portstatus [0] 0x00000100 PPS
ohci-hcd 00:03.2: roothub.portstatus [1] 0x00000100 PPS
drivers/usb/host/ehci-hcd.c: block sizes: qh 128 qtd 96 itd 160 sitd 64
ehci-hcd 00:03.3: Silicon Integrated S SiS7002 USB 2.0
ehci-hcd 00:03.3: irq 9, pci mem e0835000
ehci-hcd 00:03.3: new USB bus registered, assigned bus number 4
ehci-hcd 00:03.3: ehci_start hcs_params 0x103206 dbg=1 cc=3 pcc=2 ordered !ppc ports=6
ehci-hcd 00:03.3: ehci_start hcc_params 7070 thresh 7 uframes 1024
ehci-hcd 00:03.3: capability 0001 at 70
ehci-hcd 00:03.3: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
PCI: cache line size of 128 is not supported by device 00:03.3
ehci-hcd 00:03.3: init command 010001 (park)=0 ithresh=1 period=1024 RUN
ehci-hcd 00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
ehci-hcd 00:03.3: root hub device address 1
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: Silicon Integrated S SiS7002 USB 2.0
usb usb4: Manufacturer: Linux 2.5.69-bk10 ehci-hcd
usb usb4: SerialNumber: 00:03.3
drivers/usb/core/usb.c: usb_hotplug
usb usb4: usb_new_device - registering interface 4-0:0
drivers/usb/core/usb.c: usb_hotplug
hub 4-0:0: usb_device_probe
hub 4-0:0: usb_device_probe - got id
hub 4-0:0: USB hub found
hub 4-0:0: 6 ports detected
hub 4-0:0: standalone hub
hub 4-0:0: ganged power switching
hub 4-0:0: individual port over-current protection
hub 4-0:0: Single TT
hub 4-0:0: TT requires at most 8 FS bit times
hub 4-0:0: Port indicators are not supported
hub 4-0:0: power on to power good time: 0ms
hub 4-0:0: hub controller current requirement: 0mA
hub 4-0:0: local power source is good
hub 4-0:0: no over-current condition exists
hub 4-0:0: enabling power on all ports
ohci-hcd 00:03.0: GetStatus roothub.portstatus [1] = 0x00010300 CSC LSDA PPS
hub 1-0:0: port 1, status 300, change 1, 1.5 Mb/s
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
ohci-hcd 00:03.1: GetStatus roothub.portstatus [1] = 0x00010100 CSC PPS
hub 2-0:0: port 1, status 100, change 1, 12 Mb/s
ehci-hcd 00:03.3: GetStatus port 1 status 001403 POWER sig=k  CSC CONNECT
hub 4-0:0: port 1, status 501, change 1, 480 Mb/s
hub 4-0:0: debounce: port 1: delay 100ms stable 4 status 0x501
ehci-hcd 00:03.3: port 1 low speed --> companion
ehci-hcd 00:03.3: GetStatus port 1 status 003002 POWER OWNER sig=se0  CSC
ehci-hcd 00:03.3: GetStatus port 2 status 001803 POWER sig=j  CSC CONNECT
hub 4-0:0: port 2, status 501, change 1, 480 Mb/s
hub 4-0:0: debounce: port 2: delay 100ms stable 4 status 0x501
hub 4-0:0: port 2 not reset yet, waiting 10ms
hub 4-0:0: port 2 not reset yet, waiting 10ms
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda2, internal journal
hub 4-0:0: port 2 not reset yet, waiting 200ms
Adding 1004020k swap on /dev/hda5.  Priority:-1 extents:1
ehci-hcd 00:03.3: port 2 full speed --> companion
ehci-hcd 00:03.3: GetStatus port 2 status 003001 POWER OWNER sig=se0  CONNECT
ohci-hcd 00:03.0: GetStatus roothub.portstatus [1] = 0x00010301 CSC LSDA PPS CCS
hub 1-0:0: port 1, status 301, change 1, 1.5 Mb/s
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
ohci-hcd 00:03.0: GetStatus roothub.portstatus [1] = 0x00100303 PRSC LSDA PPS PES CCS
hub 1-0:0: new USB device on port 1, assigned address 2
usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1: Product: USB Receiver
usb 1-1: Manufacturer: Logitech
drivers/usb/core/usb.c: usb_hotplug
usb 1-1: usb_new_device - registering interface 1-1:0
drivers/usb/core/usb.c: usb_hotplug
hid 1-1:0: usb_device_probe
hid 1-1:0: usb_device_probe - got id
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-00:03.0-1
ohci-hcd 00:03.1: GetStatus roothub.portstatus [1] = 0x00010101 CSC PPS CCS
hub 2-0:0: port 1, status 101, change 1, 12 Mb/s
hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
ohci-hcd 00:03.1: GetStatus roothub.portstatus [1] = 0x00100103 PRSC PPS PES CCS
hub 2-0:0: new USB device on port 1, assigned address 2
ohci-hcd 00:03.1: urb df236708 path 1 ep0out 5ec20000 cc 5 --> status -110
ohci-hcd 00:03.1: urb df4aa21c path 1 ep0out 5f120000 cc 5 --> status -110
intel8x0: clocking to 48000
ALSA sound/pci/intel8x0.c:2563: joystick(s) found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Trying generic SiS routines for device id: 0648
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xe0000000
usb 2-1: USB device not accepting new address=2 (error=-110)
ohci-hcd 00:03.1: GetStatus roothub.portstatus [1] = 0x00100103 PRSC PPS PES CCS
hub 2-0:0: new USB device on port 1, assigned address 3
ohci-hcd 00:03.1: urb def5d334 path 1 ep0out 5f120000 cc 5 --> status -110
ohci-hcd 00:03.1: urb def5d334 path 1 ep0out 5ec20000 cc 5 --> status -110
usb 2-1: USB device not accepting new address=3 (error=-110)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 921 $ Ben Collins <bcollins@debian.org>
ohci1394_0: Unexpected PCI resource length of 1000!
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[de800000-de8007ff]  Max Packet=[2048]
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00160 ffc00000 00000000 becd0404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00560 ffc00000 00000000 becd0404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00960 ffc00000 00000000 becd0404
ieee1394: ConfigROM quadlet transaction error for node 00:1023
Disabled Privacy Extensions on device c036be20(lo)
sis900.c: v1.08.06 9/24/2002
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0x9800, IRQ 9, 00:e0:18:9d:4f:d0.
eth0: Media Link On 100mbps full-duplex 
Linux Tulip driver version 1.1.13 (May 11, 2002)
eth1: ADMtek Comet rev 17 at 0xe0833000, 00:20:78:04:68:6F, IRQ 9.
eth0: no IPv6 routers present
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4363  Sat Apr 19 17:46:46 PDT 2003
agpgart: Found an AGP 2.0 compliant device at 00:00.0.
agpgart: Putting AGP V2 device at 00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 01:00.0 into 4x mode
ehci-hcd 00:03.3: GetStatus port 1 status 003002 POWER OWNER sig=se0  CSC
hub 4-0:0: port 1, status 0, change 1, 12 Mb/s
ehci-hcd 00:03.3: GetStatus port 2 status 001002 POWER sig=se0  CSC
hub 4-0:0: port 2, status 100, change 1, 12 Mb/s
ohci-hcd 00:03.1: GetStatus roothub.portstatus [1] = 0x00010100 CSC PPS
hub 2-0:0: port 1, status 100, change 1, 12 Mb/s
ohci-hcd 00:03.0: urb c179ac80 path 1 ep1in 5f160000 cc 5 --> status -110
ohci-hcd 00:03.0: urb c179ac80 path 1 ep1in 5f160000 cc 5 --> status -110
ohci-hcd 00:03.0: urb c179ac80 path 1 ep1in 5f160000 cc 5 --> status -110
ohci-hcd 00:03.0: urb c179ac80 path 1 ep1in 5f160000 cc 5 --> status -110
ohci-hcd 00:03.0: urb c179ac80 path 1 ep1in 5f160000 cc 5 --> status -110
ohci-hcd 00:03.0: urb c179ac80 path 1 ep1in 5f160000 cc 5 --> status -110
ohci-hcd 00:03.0: urb c179ac80 path 1 ep1in 5f160000 cc 5 --> status -110
ohci-hcd 00:03.0: urb c179ac80 path 1 ep1in 5f160000 cc 5 --> status -110
ohci-hcd 00:03.0: GetStatus roothub.portstatus [1] = 0x00030300 PESC CSC LSDA PPS
hub 1-0:0: port 1, status 300, change 3, 1.5 Mb/s
usb 1-1: USB disconnect, address 2
usb 1-1: unregistering interfaces
usb 1-1: hcd_unlink_urb df2368ac fail -22
usb 1-1: hcd_unlink_urb c179ac80 fail -22
drivers/usb/core/usb.c: usb_hotplug
usb 1-1: unregistering device
drivers/usb/core/usb.c: usb_hotplug
ehci-hcd 00:03.3: GetStatus port 1 status 001002 POWER sig=se0  CSC
hub 4-0:0: port 1, status 100, change 1, 12 Mb/s
ohci-hcd 00:03.0: GetStatus roothub.portstatus [1] = 0x00020300 PESC LSDA PPS
hub 1-0:0: port 1 enable change, status 300
ehci-hcd 00:03.3: GetStatus port 1 status 001403 POWER sig=k  CSC CONNECT
hub 4-0:0: port 1, status 501, change 1, 480 Mb/s
hub 4-0:0: debounce: port 1: delay 100ms stable 4 status 0x501
ehci-hcd 00:03.3: port 1 low speed --> companion
ehci-hcd 00:03.3: GetStatus port 1 status 003002 POWER OWNER sig=se0  CSC
ohci-hcd 00:03.0: GetStatus roothub.portstatus [1] = 0x00010301 CSC LSDA PPS CCS
hub 1-0:0: port 1, status 301, change 1, 1.5 Mb/s
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
ohci-hcd 00:03.0: GetStatus roothub.portstatus [1] = 0x00100303 PRSC LSDA PPS PES CCS
hub 1-0:0: new USB device on port 1, assigned address 3
usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1: Product: USB Receiver
usb 1-1: Manufacturer: Logitech
drivers/usb/core/usb.c: usb_hotplug
usb 1-1: usb_new_device - registering interface 1-1:0
drivers/usb/core/usb.c: usb_hotplug
hid 1-1:0: usb_device_probe
hid 1-1:0: usb_device_probe - got id
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-00:03.0-1

--------------030606030500080508000603--

