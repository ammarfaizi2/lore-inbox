Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbUAUGkw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 01:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbUAUGkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 01:40:52 -0500
Received: from CPE-65-30-34-80.kc.rr.com ([65.30.34.80]:46547 "EHLO
	cognition.home.hanaden.com") by vger.kernel.org with ESMTP
	id S261877AbUAUGk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 01:40:26 -0500
Message-ID: <400E1EC5.5090809@hanaden.com>
Date: Wed, 21 Jan 2004 00:40:05 -0600
From: hanasaki <hanasaki@hanaden.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031204 Thunderbird/0.4RC1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LIST - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: kernel 2.6 - wrong identifcation of kt600 and usb 2.0 as 1.1 - kernel
 issue? wrong mobo in the box? .....
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I just bought the Soyo KT600 Dragon Ultra Platinum Edition
	http://www.soyousa.com/products/proddesc.php?id=280
The below lspci and dmesg output appears to be telling me that the 
motherboard has:
	REPORTED
	========
	KT400
	8 usb 1.1 ports
	2 usb 2.0 ports

	IN THE MOTHERBOARD SPEC
	=======================
	KT600
	8 usb 2.0 ports
	0 usb 1.1 ports

I am not much of a kernel guru and know zero about USB.  Can someone 
explain this to me?  Is it a kernel issue of misidentifying hardware? 
Did someone put the wrong motherboard in the box?  I tried looking at 
the kt600/kt400 chips under the fan/heatsink but the darn thing seems to 
be glued onto the motherboard.

Also worth noting is that video, and X, seem to work fine with the 
ATI9000 without loading the via-agp kernel module.  If the module is 
loaded, it seems to correctly identify the agp; however, running X locks 
the video in a black screen.  ^ALT<backspace> does not restart X and GDM 
but the system is not locked.  I can ssh into the box and kill X/GDM but 
the screen is still locked black.  I can ^ALT<delete> and the system 
does reboot.  The screen is black the entire time (until the reboot).

Thank you!

======================
== output of lspci  ==
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP]
	Host Bridge (rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
00:07.0 Ethernet controller: Broadcom Corporation NetXtreme
	BCM5705 Gigabit Ethernet (rev 03)
00:0d.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394
	Host Controller (rev 46)
00:0e.0 Multimedia audio controller: C-Media Electronics Inc
	CM8738 (rev 10)
00:0f.0 RAID bus controller: VIA Technologies, Inc.: Unknown
	device 3149 (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc.
	VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC
	Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. USB (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3227
00:13.0 RAID bus controller: CMD Technology Inc Silicon Image
	SiI 3112 SATARaid Controller (rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc
	Radeon R250 If [Radeon 9000] (rev 01)
01:00.1 Display controller: ATI Technologies Inc Radeon R250
	[Radeon 9000] (Secondary) (rev 01)

=======================
== output from dmesg ==
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller
	(OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ehci_hcd: block sizes: qh 128 qtd 96 itd 128 sitd 64
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: reset hcs_params 0x4208 dbg=0 cc=4
	pcc=2 ordered !ppc ports=8
ehci_hcd 0000:00:10.4: reset hcc_params 6872 thresh
	7 uframes 256/512/1024
ehci_hcd 0000:00:10.4: capability 0001 at 68
ehci_hcd 0000:00:10.4: irq 21, pci mem f89e9000
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: reset command 080002 (park)=0 ithresh=8
	period=1024 Reset HALT
ehci_hcd 0000:00:10.4: init command 010009 (park)=0
	ithresh=1 period=256 RUN
ehci_hcd 0000:00:10.4: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
ehci_hcd 0000:00:10.4: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1
	default language ID 0x409
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.0 ehci_hcd
usb usb1: SerialNumber: 0000:00:10.4
usb usb1: registering 1-0:1.0 (config #1, interface 0)
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times
hub 1-0:1.0: Port indicators are not supported
hub 1-0:1.0: power on to power good time: 0ms
hub 1-0:1.0: hub controller current requirement: 0mA
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports
drivers/usb/host/uhci-hcd.c: USB Universal Host
	Controller Interface driver v2.1
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: irq 21, io base 0000c400
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci_hcd 0000:00:10.0: root hub device address 1
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default
	language ID 0x409
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.0 uhci_hcd
usb usb2: SerialNumber: 0000:00:10.0
usb usb2: registering 2-0:1.0 (config #1, interface 0)
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
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: irq 21, io base 0000c800
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci_hcd 0000:00:10.1: root hub device address 1
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.0 uhci_hcd
usb usb3: SerialNumber: 0000:00:10.1
usb usb3: registering 3-0:1.0 (config #1, interface 0)
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
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: irq 21, io base 0000cc00
uhci_hcd 0000:00:10.2: new USB bus registered, assigned
	bus number 4
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci_hcd 0000:00:10.2: root hub device address 1
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default
	language ID 0x409
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.0 uhci_hcd
usb usb4: SerialNumber: 0000:00:10.2
usb usb4: registering 4-0:1.0 (config #1, interface 0)
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
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: irq 21, io base 0000d000
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci_hcd 0000:00:10.3: root hub device address 1
usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default
	language ID 0x409
usb usb5: Product: UHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.0 uhci_hcd
usb usb5: SerialNumber: 0000:00:10.3
usb usb5: registering 5-0:1.0 (config #1, interface 0)
hub 5-0:1.0: usb_probe_interface
hub 5-0:1.0: usb_probe_interface - got id
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
hub 5-0:1.0: standalone hub
hub 5-0:1.0: ganged power switching
hub 5-0:1.0: global over-current protection
hub 5-0:1.0: Port indicators are not supported
hub 5-0:1.0: power on to power good time: 2ms
hub 5-0:1.0: hub controller current requirement: 0mA
hub 5-0:1.0: local power source is good
hub 5-0:1.0: no over-current condition exists
hub 5-0:1.0: enabling power on all ports

