Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUAJQCR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 11:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265227AbUAJQCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 11:02:16 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:43943 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S265224AbUAJQAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 11:00:45 -0500
Date: Sat, 10 Jan 2004 08:00:08 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: frederic.bages@laposte.net
Subject: [Bug 1826] New: Hang under medium network traffic	(unexpected IRQ trap at vector c1 & NETDEV WATCHDOG: eth0:	transmit timed out)
Message-ID: <65880000.1073750408@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1826

           Summary: Hang under medium network traffic (unexpected IRQ trap
                    at vector c1 & NETDEV WATCHDOG: eth0: transmit timed
                    out)
    Kernel Version: 2.6.1-gentoo
            Status: NEW
          Severity: high
             Owner: jgarzik@pobox.com
         Submitter: frederic.bages@laposte.net


Distribution: Gentoo Linux 
Hardware Environment: PC, AMD Athlon(tm) XP 1500+, Net card 8139 
Software Environment: Gentoo Linux 1.4 
 
Problem Description: 
Under medium network traffic the who computer hang. The only remaining working 
piece is the mouse pointer. X is frozen, ping and SSH don't work. This 
happened more than once (with previous kernel version 2.6.0-testX). I were 
transfering 2Mo/s of large files between to computers. 
 
Steps to reproduce: Not easily reproducable. 
 
Kernel log : 
============ 
 
Jan 10 11:00:06 [kernel] Pin 2-19 already programmed 
Jan 10 11:00:06 [kernel] Pin 2-17 already programmed 
Jan 10 11:00:06 [kernel] VP_IDE: not 100% native mode: will probe irqs later 
Jan 10 11:00:06 [kernel] ide: Assuming 33MHz system bus speed for PIO modes; 
override with idebus=xx 
Jan 10 11:00:07 [kernel] ehci_hcd: block sizes: qh 128 qtd 96 itd 128 sitd 64 
Jan 10 11:00:07 [kernel] ehci_hcd 0000:02:08.2: EHCI Host Controller 
Jan 10 11:00:07 [kernel] ehci_hcd 0000:02:08.2: reset hcs_params 0x2395 dbg=0 
cc=2 pcc=3 ports=5 
Jan 10 11:00:07 [kernel] ehci_hcd 0000:02:08.2: reset portroute 1 0 1 0 0 
Jan 10 11:00:07 [kernel] ehci_hcd 0000:02:08.2: reset hcc_params 0002 thresh 0 
uframes 256/512/1024 
Jan 10 11:00:07 [kernel] ehci_hcd 0000:02:08.2: irq 16, pci mem f89e4f00 
Jan 10 11:00:07 [kernel] ehci_hcd 0000:02:08.2: new USB bus registered, 
assigned bus number 3 
Jan 10 11:00:07 [kernel] ehci_hcd 0000:02:08.2: reset command 080002 (park)=0 
ithresh=8 period=1024 Reset HALT 
Jan 10 11:00:07 [kernel] ehci_hcd 0000:02:08.2: init command 010009 (park)=0 
ithresh=1 period=256 RUN 
Jan 10 11:00:07 [kernel] ehci_hcd 0000:02:08.2: USB 2.0 enabled, EHCI 0.95, 
driver 2003-Jun-13 
Jan 10 11:00:07 [kernel] ehci_hcd 0000:02:08.2: root hub device address 1 
Jan 10 11:00:07 [kernel] usb usb3: new device strings: Mfr=3, Product=2, 
SerialNumber=1 
Jan 10 11:00:07 [kernel] drivers/usb/core/message.c: USB device number 1 
default language ID 0x409 
Jan 10 11:00:07 [kernel] usb usb3: Product: EHCI Host Controller 
Jan 10 11:00:07 [kernel] usb usb3: Manufacturer: Linux 2.6.1-gentoo ehci_hcd 
Jan 10 11:00:07 [kernel] usb usb3: SerialNumber: 0000:02:08.2 
Jan 10 11:00:07 [kernel] drivers/usb/core/usb.c: usb_hotplug 
Jan 10 11:00:07 [kernel] usb usb3: registering 3-0:1.0 (config #1, interface 
0) 
Jan 10 11:00:07 [kernel] drivers/usb/core/usb.c: usb_hotplug 
Jan 10 11:00:07 [kernel] hub 3-0:1.0: usb_probe_interface 
Jan 10 11:00:07 [kernel] hub 3-0:1.0: usb_probe_interface - got id 
Jan 10 11:00:07 [kernel] hub 3-0:1.0: USB hub found 
Jan 10 11:00:07 [kernel] hub 3-0:1.0: 5 ports detected 
Jan 10 11:00:07 [kernel] hub 3-0:1.0: standalone hub 
Jan 10 11:00:07 [kernel] hub 3-0:1.0: individual port power switching 
Jan 10 11:00:07 [kernel] hub 3-0:1.0: individual port over-current protection 
Jan 10 11:00:07 [kernel] hub 3-0:1.0: Single TT 
Jan 10 11:00:07 [kernel] hub 3-0:1.0: TT requires at most 8 FS bit times 
Jan 10 11:00:07 [kernel] hub 3-0:1.0: Port indicators are not supported 
Jan 10 11:00:07 [kernel] hub 3-0:1.0: power on to power good time: 0ms 
Jan 10 11:00:07 [kernel] hub 3-0:1.0: hub controller current requirement: 0mA 
Jan 10 11:00:07 [kernel] hub 3-0:1.0: local power source is good 
Jan 10 11:00:07 [kernel] hub 3-0:1.0: no over-current condition exists 
Jan 10 11:00:07 [kernel] hub 3-0:1.0: enabling power on all ports 
Jan 10 11:00:07 [kernel] ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller 
(OHCI) Driver (PCI) 
Jan 10 11:00:07 [kernel] ohci_hcd 0000:02:08.0: irq 18, pci mem f89e6000 
Jan 10 11:00:07 [kernel] ohci_hcd 0000:02:08.0: new USB bus registered, 
assigned bus number 4 
Jan 10 11:00:08 [kernel] ohci_hcd 0000:02:08.0: root hub device address 1 
Jan 10 11:00:08 [kernel] usb usb4: new device strings: Mfr=3, Product=2, 
SerialNumber=1 
Jan 10 11:00:08 [kernel] drivers/usb/core/message.c: USB device number 1 
default language ID 0x409 
Jan 10 11:00:08 [kernel] usb usb4: Product: OHCI Host Controller 
Jan 10 11:00:08 [kernel] usb usb4: Manufacturer: Linux 2.6.1-gentoo ohci_hcd 
Jan 10 11:00:08 [kernel] usb usb4: SerialNumber: 0000:02:08.0 
Jan 10 11:00:08 [kernel] drivers/usb/core/usb.c: usb_hotplug 
Jan 10 11:00:08 [kernel] usb usb4: registering 4-0:1.0 (config #1, interface 
0) 
Jan 10 11:00:08 [kernel] drivers/usb/core/usb.c: usb_hotplug 
Jan 10 11:00:08 [kernel] hub 4-0:1.0: usb_probe_interface 
Jan 10 11:00:08 [kernel] hub 4-0:1.0: usb_probe_interface - got id 
Jan 10 11:00:08 [kernel] hub 4-0:1.0: USB hub found 
Jan 10 11:00:08 [kernel] hub 4-0:1.0: 3 ports detected 
Jan 10 11:00:08 [kernel] hub 4-0:1.0: standalone hub 
Jan 10 11:00:08 [kernel] hub 4-0:1.0: ganged power switching 
Jan 10 11:00:08 [kernel] hub 4-0:1.0: global over-current protection 
Jan 10 11:00:08 [kernel] hub 4-0:1.0: Port indicators are not supported 
Jan 10 11:00:08 [kernel] hub 4-0:1.0: power on to power good time: 510ms 
Jan 10 11:00:08 [kernel] hub 4-0:1.0: hub controller current requirement: 0mA 
Jan 10 11:00:08 [kernel] hub 4-0:1.0: local power source is good 
Jan 10 11:00:08 [kernel] hub 4-0:1.0: no over-current condition exists 
Jan 10 11:00:08 [kernel] hub 4-0:1.0: enabling power on all ports 
Jan 10 11:00:08 [kernel] ohci_hcd 0000:02:08.0: created debug files 
Jan 10 11:00:08 [kernel] ohci_hcd 0000:02:08.0: OHCI controller state 
Jan 10 11:00:08 [kernel] ohci_hcd 0000:02:08.0: OHCI 1.0, with legacy support 
registers 
Jan 10 11:00:08 [kernel] ohci_hcd 0000:02:08.0: control 0x08f HCFS=operational 
IE PLE CBSR=3 
Jan 10 11:00:08 [kernel] ohci_hcd 0000:02:08.0: cmdstatus 0x00000 SOC=0 
Jan 10 11:00:08 [kernel] ohci_hcd 0000:02:08.0: intrstatus 0x00000004 SF 
Jan 10 11:00:08 [kernel] ohci_hcd 0000:02:08.0: intrenable 0x80000012 MIE UE 
WDH 
Jan 10 11:00:08 [kernel] ohci_hcd 0000:02:08.0: hcca frame #0474 
Jan 10 11:00:08 [kernel] ohci_hcd 0000:02:08.0: roothub.a ff000203 POTPGT=255 
NPS NDP=3 
Jan 10 11:00:08 [kernel] ohci_hcd 0000:02:08.0: roothub.b 00000000 PPCM=0000 
DR=0000 
Jan 10 11:00:08 [kernel] ohci_hcd 0000:02:08.0: roothub.status 00000000 
Jan 10 11:00:08 [kernel] ohci_hcd 0000:02:08.0: roothub.portstatus [0] 
0x00000100 PPS 
Jan 10 11:00:08 [kernel] ohci_hcd 0000:02:08.0: roothub.portstatus [1] 
0x00000100 PPS 
Jan 10 11:00:08 [kernel] ohci_hcd 0000:02:08.0: roothub.portstatus [2] 
0x00000100 PPS 
Jan 10 11:00:08 [kernel] ohci_hcd 0000:02:08.1: OHCI Host Controller 
Jan 10 11:00:08 [kernel] ohci_hcd 0000:02:08.1: reset, control = 0x0 
Jan 10 11:00:08 [kernel] ohci_hcd 0000:02:08.1: irq 19, pci mem f89f7000 
Jan 10 11:00:08 [kernel] ohci_hcd 0000:02:08.1: new USB bus registered, 
assigned bus number 5 
Jan 10 11:00:09 [kernel] ohci_hcd 0000:02:08.1: root hub device address 1 
Jan 10 11:00:09 [kernel] usb usb5: new device strings: Mfr=3, Product=2, 
SerialNumber=1 
Jan 10 11:00:09 [kernel] drivers/usb/core/message.c: USB device number 1 
default language ID 0x409 
Jan 10 11:00:09 [kernel] usb usb5: Product: OHCI Host Controller 
Jan 10 11:00:09 [kernel] usb usb5: Manufacturer: Linux 2.6.1-gentoo ohci_hcd 
Jan 10 11:00:09 [kernel] usb usb5: SerialNumber: 0000:02:08.1 
Jan 10 11:00:09 [kernel] drivers/usb/core/usb.c: usb_hotplug 
Jan 10 11:00:09 [kernel] usb usb5: registering 5-0:1.0 (config #1, interface 
0) 
Jan 10 11:00:09 [kernel] drivers/usb/core/usb.c: usb_hotplug 
Jan 10 11:00:09 [kernel] hub 5-0:1.0: usb_probe_interface 
Jan 10 11:00:09 [kernel] hub 5-0:1.0: usb_probe_interface - got id 
Jan 10 11:00:09 [kernel] hub 5-0:1.0: USB hub found 
Jan 10 11:00:09 [kernel] hub 5-0:1.0: 2 ports detected 
Jan 10 11:00:09 [kernel] hub 5-0:1.0: standalone hub 
Jan 10 11:00:09 [kernel] hub 5-0:1.0: ganged power switching 
Jan 10 11:00:09 [kernel] hub 5-0:1.0: global over-current protection 
Jan 10 11:00:09 [kernel] hub 5-0:1.0: Port indicators are not supported 
Jan 10 11:00:09 [kernel] hub 5-0:1.0: power on to power good time: 510ms 
Jan 10 11:00:09 [kernel] hub 5-0:1.0: hub controller current requirement: 0mA 
Jan 10 11:00:09 [kernel] hub 5-0:1.0: local power source is good 
Jan 10 11:00:09 [kernel] hub 5-0:1.0: no over-current condition exists 
Jan 10 11:00:09 [kernel] hub 5-0:1.0: enabling power on all ports 
Jan 10 11:00:09 [kernel] ohci_hcd 0000:02:08.1: created debug files 
Jan 10 11:00:09 [kernel] ohci_hcd 0000:02:08.1: OHCI controller state 
Jan 10 11:00:09 [kernel] ohci_hcd 0000:02:08.1: OHCI 1.0, with legacy support 
registers 
Jan 10 11:00:09 [kernel] ohci_hcd 0000:02:08.1: control 0x08f HCFS=operational 
IE PLE CBSR=3 
Jan 10 11:00:09 [kernel] ohci_hcd 0000:02:08.1: cmdstatus 0x00000 SOC=0 
Jan 10 11:00:09 [kernel] ohci_hcd 0000:02:08.1: intrstatus 0x00000004 SF 
Jan 10 11:00:09 [kernel] ohci_hcd 0000:02:08.1: intrenable 0x80000012 MIE UE 
WDH 
Jan 10 11:00:09 [kernel] ohci_hcd 0000:02:08.1: hcca frame #043f 
Jan 10 11:00:09 [kernel] ohci_hcd 0000:02:08.1: roothub.a ff000202 POTPGT=255 
NPS NDP=2 
Jan 10 11:00:09 [kernel] ohci_hcd 0000:02:08.1: roothub.b 00000000 PPCM=0000 
DR=0000 
Jan 10 11:00:09 [kernel] ohci_hcd 0000:02:08.1: roothub.status 00000000 
Jan 10 11:00:09 [kernel] ohci_hcd 0000:02:08.1: roothub.portstatus [0] 
0x00000100 PPS 
Jan 10 11:00:09 [kernel] ohci_hcd 0000:02:08.1: roothub.portstatus [1] 
0x00000100 PPS 
Jan 10 11:00:09 [kernel] 8139cp: 10/100 PCI Ethernet driver v1.1 (Aug 30, 
2003) 
Jan 10 11:04:50 [kernel] Pin 2-19 already programmed 
Jan 10 11:04:50 [kernel] Pin 2-17 already programmed 
Jan 10 11:04:51 [kernel] ehci_hcd: block sizes: qh 128 qtd 96 itd 128 sitd 64 
Jan 10 11:04:51 [kernel] ehci_hcd 0000:02:08.2: EHCI Host Controller 
Jan 10 11:04:51 [kernel] ehci_hcd 0000:02:08.2: reset hcs_params 0x2395 dbg=0 
cc=2 pcc=3 ports=5 
Jan 10 11:04:51 [kernel] usb usb3: registering 3-0:1.0 (config #1, interface 
0) 
Jan 10 11:04:51 [kernel] drivers/usb/core/usb.c: usb_hotplug 
Jan 10 11:04:51 [kernel] hub 3-0:1.0: usb_probe_interface 
Jan 10 11:04:51 [kernel] hub 3-0:1.0: usb_probe_interface - got id 
Jan 10 11:04:51 [kernel] hub 3-0:1.0: USB hub found 
Jan 10 11:04:51 [kernel] hub 3-0:1.0: 5 ports detected 
Jan 10 11:04:51 [kernel] hub 3-0:1.0: standalone hub 
Jan 10 11:04:51 [kernel] hub 3-0:1.0: individual port power switching 
Jan 10 11:04:51 [kernel] hub 3-0:1.0: individual port over-current protection 
Jan 10 11:04:51 [kernel] hub 3-0:1.0: Single TT 
Jan 10 11:04:51 [kernel] hub 3-0:1.0: TT requires at most 8 FS bit times 
Jan 10 11:04:51 [kernel] hub 3-0:1.0: Port indicators are not supported 
Jan 10 11:04:51 [kernel] hub 3-0:1.0: power on to power good time: 0ms 
Jan 10 11:04:51 [kernel] hub 3-0:1.0: hub controller current requirement: 0mA 
Jan 10 11:04:51 [kernel] hub 3-0:1.0: local power source is good 
Jan 10 11:04:51 [kernel] hub 3-0:1.0: no over-current condition exists 
Jan 10 11:04:51 [kernel] hub 3-0:1.0: enabling power on all ports 
Jan 10 11:04:51 [kernel] ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller 
(OHCI) Driver (PCI) 
Jan 10 11:04:51 [kernel] ohci_hcd 0000:02:08.0: irq 18, pci mem f89e6000 
Jan 10 11:04:51 [kernel] ohci_hcd 0000:02:08.0: new USB bus registered, 
assigned bus number 4 
Jan 10 11:04:52 [kernel] ohci_hcd 0000:02:08.0: root hub device address 1 
Jan 10 11:04:52 [kernel] usb usb4: new device strings: Mfr=3, Product=2, 
SerialNumber=1 
Jan 10 11:04:52 [kernel] drivers/usb/core/message.c: USB device number 1 
default language ID 0x409 
Jan 10 11:04:52 [kernel] usb usb4: Product: OHCI Host Controller 
Jan 10 11:04:52 [kernel] usb usb4: Manufacturer: Linux 2.6.1-gentoo ohci_hcd 
Jan 10 11:04:52 [kernel] usb usb4: SerialNumber: 0000:02:08.0 
Jan 10 11:04:52 [kernel] drivers/usb/core/usb.c: usb_hotplug 
Jan 10 11:04:52 [kernel] usb usb4: registering 4-0:1.0 (config #1, interface 
0) 
Jan 10 11:04:52 [kernel] drivers/usb/core/usb.c: usb_hotplug 
Jan 10 11:04:52 [kernel] hub 4-0:1.0: usb_probe_interface 
Jan 10 11:04:52 [kernel] hub 4-0:1.0: usb_probe_interface - got id 
Jan 10 11:04:52 [kernel] hub 4-0:1.0: USB hub found 
Jan 10 11:04:52 [kernel] hub 4-0:1.0: 3 ports detected 
Jan 10 11:04:52 [kernel] hub 4-0:1.0: standalone hub 
Jan 10 11:04:52 [kernel] hub 4-0:1.0: ganged power switching 
Jan 10 11:04:52 [kernel] hub 4-0:1.0: global over-current protection 
Jan 10 11:04:52 [kernel] hub 4-0:1.0: Port indicators are not supported 
Jan 10 11:04:52 [kernel] hub 4-0:1.0: power on to power good time: 510ms 
Jan 10 11:04:52 [kernel] hub 4-0:1.0: hub controller current requirement: 0mA 
Jan 10 11:04:52 [kernel] hub 4-0:1.0: local power source is good 
Jan 10 11:04:52 [kernel] hub 4-0:1.0: no over-current condition exists 
Jan 10 11:04:52 [kernel] hub 4-0:1.0: enabling power on all ports 
Jan 10 11:04:52 [kernel] ohci_hcd 0000:02:08.0: created debug files 
Jan 10 11:04:52 [kernel] ohci_hcd 0000:02:08.0: OHCI controller state 
Jan 10 11:04:52 [kernel] ohci_hcd 0000:02:08.0: OHCI 1.0, with legacy support 
registers 
Jan 10 11:04:52 [kernel] ohci_hcd 0000:02:08.0: control 0x08f HCFS=operational 
IE PLE CBSR=3 
Jan 10 11:04:52 [kernel] ohci_hcd 0000:02:08.0: cmdstatus 0x00000 SOC=0 
Jan 10 11:04:52 [kernel] ohci_hcd 0000:02:08.0: intrstatus 0x00000004 SF 
Jan 10 11:04:52 [kernel] ohci_hcd 0000:02:08.0: intrenable 0x80000012 MIE UE 
WDH 
Jan 10 11:04:52 [kernel] ohci_hcd 0000:02:08.0: hcca frame #0474 
Jan 10 11:04:52 [kernel] ohci_hcd 0000:02:08.0: roothub.a ff000203 POTPGT=255 
NPS NDP=3 
Jan 10 11:04:52 [kernel] ohci_hcd 0000:02:08.0: roothub.b 00000000 PPCM=0000 
DR=0000 
Jan 10 11:04:52 [kernel] ohci_hcd 0000:02:08.0: roothub.status 00000000 
Jan 10 11:04:52 [kernel] ohci_hcd 0000:02:08.0: roothub.portstatus [0] 
0x00000100 PPS 
Jan 10 11:04:52 [kernel] ohci_hcd 0000:02:08.0: roothub.portstatus [1] 
0x00000100 PPS 
Jan 10 11:04:52 [kernel] ohci_hcd 0000:02:08.0: roothub.portstatus [2] 
0x00000100 PPS 
Jan 10 11:04:52 [kernel] ohci_hcd 0000:02:08.1: OHCI Host Controller 
Jan 10 11:04:52 [kernel] ohci_hcd 0000:02:08.1: reset, control = 0x0 
Jan 10 11:04:52 [kernel] ohci_hcd 0000:02:08.1: irq 19, pci mem f89f7000 
Jan 10 11:04:52 [kernel] ohci_hcd 0000:02:08.1: new USB bus registered, 
assigned bus number 5 
Jan 10 11:04:53 [kernel] ohci_hcd 0000:02:08.1: root hub device address 1 
Jan 10 11:04:53 [kernel] usb usb5: new device strings: Mfr=3, Product=2, 
SerialNumber=1 
Jan 10 11:04:53 [kernel] drivers/usb/core/message.c: USB device number 1 
default language ID 0x409 
Jan 10 11:04:53 [kernel] usb usb5: Product: OHCI Host Controller 
Jan 10 11:04:53 [kernel] usb usb5: Manufacturer: Linux 2.6.1-gentoo ohci_hcd 
Jan 10 11:04:53 [kernel] usb usb5: SerialNumber: 0000:02:08.1 
Jan 10 11:04:53 [kernel] drivers/usb/core/usb.c: usb_hotplug 
Jan 10 11:04:53 [kernel] usb usb5: registering 5-0:1.0 (config #1, interface 
0) 
Jan 10 11:04:53 [kernel] drivers/usb/core/usb.c: usb_hotplug 
Jan 10 11:04:53 [kernel] hub 5-0:1.0: usb_probe_interface 
Jan 10 11:04:53 [kernel] hub 5-0:1.0: usb_probe_interface - got id 
Jan 10 11:04:53 [kernel] hub 5-0:1.0: USB hub found 
Jan 10 11:04:53 [kernel] hub 5-0:1.0: 2 ports detected 
Jan 10 11:04:53 [kernel] hub 5-0:1.0: standalone hub 
Jan 10 11:04:53 [kernel] hub 5-0:1.0: ganged power switching 
Jan 10 11:04:53 [kernel] hub 5-0:1.0: global over-current protection 
Jan 10 11:04:53 [kernel] hub 5-0:1.0: Port indicators are not supported 
Jan 10 11:04:53 [kernel] hub 5-0:1.0: power on to power good time: 510ms 
Jan 10 11:04:53 [kernel] hub 5-0:1.0: hub controller current requirement: 0mA 
Jan 10 11:04:53 [kernel] hub 5-0:1.0: local power source is good 
Jan 10 11:04:53 [kernel] hub 5-0:1.0: no over-current condition exists 
Jan 10 11:04:53 [kernel] hub 5-0:1.0: enabling power on all ports 
Jan 10 11:04:53 [kernel] ohci_hcd 0000:02:08.1: created debug files 
Jan 10 11:04:53 [kernel] ohci_hcd 0000:02:08.1: OHCI controller state 
Jan 10 11:04:53 [kernel] ohci_hcd 0000:02:08.1: OHCI 1.0, with legacy support 
registers 
Jan 10 11:04:53 [kernel] ohci_hcd 0000:02:08.1: control 0x08f HCFS=operational 
IE PLE CBSR=3 
Jan 10 11:04:53 [kernel] ohci_hcd 0000:02:08.1: cmdstatus 0x00000 SOC=0 
Jan 10 11:04:53 [kernel] ohci_hcd 0000:02:08.1: intrstatus 0x00000004 SF 
Jan 10 11:04:53 [kernel] ohci_hcd 0000:02:08.1: intrenable 0x80000012 MIE UE 
WDH 
Jan 10 11:04:53 [kernel] ohci_hcd 0000:02:08.1: hcca frame #043f 
Jan 10 11:04:53 [kernel] ohci_hcd 0000:02:08.1: roothub.a ff000202 POTPGT=255 
NPS NDP=2 
Jan 10 11:04:53 [kernel] ohci_hcd 0000:02:08.1: roothub.b 00000000 PPCM=0000 
DR=0000 
Jan 10 11:04:53 [kernel] ohci_hcd 0000:02:08.1: roothub.status 00000000 
Jan 10 11:04:53 [kernel] ohci_hcd 0000:02:08.1: roothub.portstatus [0] 
0x00000100 PPS 
Jan 10 11:04:53 [kernel] ohci_hcd 0000:02:08.1: roothub.portstatus [1] 
0x00000100 PPS 
Jan 10 11:04:53 [kernel] 8139cp: 10/100 PCI Ethernet driver v1.1 (Aug 30, 
2003) 
Jan 10 11:18:31 [kernel] nvidia: no version for "struct_module" found: kernel 
tainted. 
Jan 10 11:18:31 [kernel] nvidia: no version magic, tainting kernel. 
Jan 10 11:18:31 [kernel] nvidia: module license 'NVIDIA' taints kernel. 
Jan 10 11:18:31 [kernel] 0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel 
Module  1.0-4496  Wed Jul 16 19:03:09 PDT 2003 
Jan 10 11:18:32 [kernel] Debug: sleeping function called from invalid context 
at mm/slab.c:1856 
                - Last output repeated twice - 
Jan 10 11:18:34 [kernel] agpgart: Found an AGP 2.0 compliant device at 
0000:00:00.0. 
Jan 10 11:18:35 [kernel] atkbd.c: Unknown key released (translated set 2, code 
0x7a on isa0060/serio0). 
                - Last output repeated twice - 
Jan 10 11:19:08 [kernel] APIC error on CPU0: 00(02) 
Jan 10 11:27:07 [kernel] APIC error on CPU0: 02(08) 
Jan 10 11:29:38 [kernel] APIC error on CPU0: 08(08) 
Jan 10 11:30:06 [kernel] APIC error on CPU0: 08(02) 
Jan 10 11:33:57 [kernel] APIC error on CPU0: 02(08) 
Jan 10 11:44:29 [kernel] irq 11: nobody cared! 
Jan 10 11:45:31 [kernel] APIC error on CPU0: 08(02) 
Jan 10 11:46:09 [kernel] APIC error on CPU0: 02(02) 
                - Last output repeated twice - 
Jan 10 11:47:04 [kernel] APIC error on CPU0: 02(08) 
Jan 10 11:50:30 [kernel] APIC error on CPU0: 08(02) 
Jan 10 11:50:40 [kernel] APIC error on CPU0: 02(02) 
                - Last output repeated 7 times - 
Jan 10 11:56:58 [kernel] APIC error on CPU0: 02(08) 
Jan 10 11:57:00 [kernel] APIC error on CPU0: 08(02) 
Jan 10 11:57:04 [kernel] APIC error on CPU0: 02(02) 
Jan 10 11:57:07 [kernel] APIC error on CPU0: 02(08) 
Jan 10 11:57:42 [kernel] APIC error on CPU0: 08(02) 
Jan 10 11:57:54 [kernel] APIC error on CPU0: 02(02) 
                - Last output repeated 7 times - 
Jan 10 11:59:39 [kernel] APIC error on CPU0: 02(08) 
Jan 10 11:59:49 [kernel] APIC error on CPU0: 08(02) 
Jan 10 11:59:59 [kernel] APIC error on CPU0: 02(02) 
Jan 10 12:00:00 [kernel] APIC error on CPU0: 02(08) 
Jan 10 12:00:09 [kernel] APIC error on CPU0: 08(02) 
Jan 10 12:00:56 [kernel] APIC error on CPU0: 02(08) 
Jan 10 12:01:14 [kernel] APIC error on CPU0: 08(08) 
                - Last output repeated twice - 
Jan 10 12:01:42 [kernel] APIC error on CPU0: 08(02) 
Jan 10 12:01:54 [kernel] APIC error on CPU0: 02(02) 
                - Last output repeated 2 times - 
Jan 10 12:02:59 [kernel] APIC error on CPU0: 02(08) 
Jan 10 12:03:02 [kernel] APIC error on CPU0: 08(02) 
Jan 10 12:03:02 [kernel] APIC error on CPU0: 02(02) 
                - Last output repeated 3 times - 
Jan 10 12:03:22 [kernel] APIC error on CPU0: 02(08) 
Jan 10 12:03:38 [kernel] APIC error on CPU0: 08(02) 
Jan 10 12:03:42 [kernel] APIC error on CPU0: 02(08) 
Jan 10 12:03:59 [kernel] APIC error on CPU0: 08(02) 
Jan 10 12:04:04 [kernel] APIC error on CPU0: 02(08) 
Jan 10 12:04:12 [kernel] APIC error on CPU0: 08(02) 
Jan 10 12:04:15 [kernel] APIC error on CPU0: 02(02) 
                - Last output repeated twice - 
Jan 10 12:05:15 [kernel] APIC error on CPU0: 02(08) 
Jan 10 12:06:08 [kernel] APIC error on CPU0: 08(08) 
Jan 10 12:06:22 [kernel] APIC error on CPU0: 08(02) 
Jan 10 12:06:58 [kernel] APIC error on CPU0: 02(08) 
Jan 10 12:07:23 [kernel] APIC error on CPU0: 08(02) 
Jan 10 12:07:23 [kernel] APIC error on CPU0: 02(08) 
Jan 10 12:07:24 [kernel] unexpected IRQ trap at vector c1 
Jan 10 12:07:33 [kernel] NETDEV WATCHDOG: eth0: transmit timed out 
Jan 10 12:07:35 [kernel] Badness in pci_find_subsys at 
drivers/pci/search.c:132 
                - Last output repeated twice - 
Jan 10 12:07:43 [kernel]  [<f8e0cf18>] __nvsym04875+0xf8/0x170 [nvidia] 
Jan 10 12:07:45 [kernel] NETDEV WATCHDOG: eth0: transmit timed out 
Jan 10 12:07:51 [kernel] Badness in pci_find_subsys at 
drivers/pci/search.c:132 
Jan 10 12:07:57 [kernel] NETDEV WATCHDOG: eth0: transmit timed out 
Jan 10 12:07:59 [kernel] Badness in pci_find_subsys at 
drivers/pci/search.c:132 
                - Last output repeated 3 times - 
Jan 10 12:08:27 [kernel] NETDEV WATCHDOG: eth0: transmit timed out 
Jan 10 12:08:31 [kernel] Badness in pci_find_subsys at 
drivers/pci/search.c:132 
                - Last output repeated 5 times - 
Jan 10 12:09:15 [kernel] NETDEV WATCHDOG: eth0: transmit timed out 
Jan 10 12:09:19 [kernel] Badness in pci_find_subsys at 
drivers/pci/search.c:132 
                - Last output repeated 2 times - 
Jan 10 12:10:57 [kernel] NETDEV WATCHDOG: eth0: transmit timed out 
Jan 10 12:13:20 [kernel]  00 000 00  1    0    0   0   0    0    0    00 
Jan 10 12:13:21 [kernel]  01 001 01  0    0    0   0   0    1    1    39 
 
 
lspci : 
======= 
 
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03) 
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] 
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40) 
00:07.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) 
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a) 
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a) 
00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40) 
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 
Audio Controller (rev 50) 
00:0a.0 PCI bridge: Hint Corp HB6 Universal PCI-PCI bridge (non-transparent 
mode) (rev 13) 
00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10) 
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 
400] (rev b2) 
02:08.0 USB Controller: NEC Corporation USB (rev 41) 
02:08.1 USB Controller: NEC Corporation USB (rev 41) 
02:08.2 USB Controller: NEC Corporation USB 2.0 (rev 02) 
02:0b.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394 Controller 
(Link) 
 
 
lsmod : 
======= 
 
Module                  Size  Used by 
nvidia               1701932  10 
8139cp                 19904  0 
ohci_hcd               31040  0 
ehci_hcd               35904  0 
rtc                    13288  0 
ohci1394               36544  0 
ieee1394              293004  1 ohci1394 
usblp                  13376  0 
usb_storage           104208  0 
uhci_hcd               33416  0 
usbcore               121044  7 ohci_hcd,ehci_hcd,usblp,usb_storage,uhci_hcd 
8139too                23360  0 
mii                     5184  2 8139cp,8139too 
sg                     34828  0 
sr_mod                 16928  0 
sd_mod                 15584  0 
scsi_mod               79844  4 usb_storage,sg,sr_mod,sd_mod


