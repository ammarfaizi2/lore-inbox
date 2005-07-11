Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262647AbVGKUv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbVGKUv1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 16:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbVGKUtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 16:49:03 -0400
Received: from totor.bouissou.net ([82.67.27.165]:1742 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S262647AbVGKUq4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 16:46:56 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [SOLVED ??] Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Date: Mon, 11 Jul 2005 22:46:47 +0200
User-Agent: KMail/1.7.2
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0507111611470.6399-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0507111611470.6399-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200507112246.48069@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Lundi 11 Juillet 2005 22:16, Alan Stern a écrit :
> > Aha. And what would be your advice ? Rather leave the BIOS mouse option
> > ON and use "usb-handoff", or remove both ?
>
> Well, some people don't have a choice.  They need to leave BIOS USB
> keyboard/mouse support turned on in order to use their USB keyboard/mouse
> before the Linux kernel has loaded (within Grub, for instance).
>
> If you don't care about that, then it's cleaner to turn off the BIOS
> support.  Of course, you may find that you still need to use
> "usb-handoff" anyway!

Well, I'm afraid I spoke too fast :-(

I rebooted my system with "usb-handoff" again, but still the USB mouse enabled 
in BIOS, and this time got the punishent again :-(

usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
PCI: Via IRQ fixup for 0000:00:10.0, from 10 to 5
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:10.0: irq 21, io base 0x0000cc00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Via IRQ fixup for 0000:00:10.1, from 10 to 5
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (#2)
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.1: irq 21, io base 0x0000d000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 5
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (#3)
usb 1-1: new low speed USB device using uhci_hcd and address 2
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.2: irq 21, io base 0x0000d400
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PCI: Via IRQ fixup for 0000:00:10.3, from 11 to 3
ehci_hcd 0000:00:10.3: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:10.3: irq 19, io mem 0xe3009000
ehci_hcd 0000:00:10.3: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
usbcore: registered new driver hiddev
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
usbhid: probe of 1-1:1.0 failed with error -5
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
irq 21: nobody cared!

...etc :-(

Well, this time, I deactivated the mouse in BIOS, rebooted again, also with 
"usb-handoff", and "again it works"...

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
