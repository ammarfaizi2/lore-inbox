Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbTKDUl3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 15:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTKDUl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 15:41:29 -0500
Received: from [62.233.185.126] ([62.233.185.126]:260 "EHLO
	aclaptop.unregistered.futuro.pl") by vger.kernel.org with ESMTP
	id S262564AbTKDUl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 15:41:27 -0500
From: Szymon =?iso-8859-2?q?Aceda=F1ski?= <accek@poczta.gazeta.pl>
To: cijoml@volny.cz
Subject: Re: Some issues with Acer TravelMate 242
Date: Tue, 4 Nov 2003 21:41:03 +0100
User-Agent: KMail/1.5
References: <200311042020.26085.cijoml@volny.cz>
In-Reply-To: <200311042020.26085.cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311042141.03065.accek@poczta.gazeta.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 November 2003 20:20, Michal Semler (volny.cz) wrote:
> Hi,
>
> I have Acer TravelMate 242 serie and I have these problems with 2.4 kernel:

I also have one.

> 2) USB 2.0 - notebook has 4 USB 2.0 ports - modprobe usb-ehci causes
> loading USB and kernel finds USB ports, but when I plug in mouse or BT
> adapter or harddrive into usb ports, those are not recognized anymore.
> When I load usb-uhci all works fine, but communication is too slow with my
> usb 2.0 harddrive

Only the one of 4 USB ports is USB 2.0 - one farthest away from the RJ45 
socket (it's EHCI). The rest are plain USB 1.1 UHCI ports. On my machine the 
ehci-hcd module reports one controller with 6 ports hub, but only one of them 
is physically present on the backside of the machine (other are purely 
virtual). Uhci-hcd (usb-uhci in 2.4) says, that there are 3 UHCI controllers, 
each of them having 2 ports (and only one physically present per controller). 
So in total, Acer TM242 has 12 USB ports, 4 of them are physically available. 
I don't know, why it is done this way.

Greetings
Szymon


>From dmesg:

Linux version 2.6.0-test9-swsusp (root@aclaptop) (gcc version 3.3.1 20030930 
(Red Hat Linux 3.3.1-6)) #9 Tue Nov 4 20:29:08 CET 2003
[...]
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 10, pci mem cf87e000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: enabled 64bit PCI DMA
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver 
v2.1
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 5, io base 00001820
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 11, io base 00001840
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 4, io base 00001860
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
[here's my USB mouse plugged into 4th port is being detected]
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
hub 2-0:1.0: new USB device on port 2, assigned address 2
input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-0000:00:1d.0-2

