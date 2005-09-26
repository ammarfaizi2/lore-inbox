Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbVIZSox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbVIZSox (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 14:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVIZSox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 14:44:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:42944 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932469AbVIZSow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 14:44:52 -0400
Date: Mon, 26 Sep 2005 20:44:51 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: bogus VIA IRQ fixup in drivers/pci/quirks.c
Message-ID: <20050926184451.GB11752@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Why is the irq changed from 24 to 0, and why does uhci use irq 24
anyway? I dont have the /proc/interrupts output from this box, maybe no
interrupt is handled for the controller? None of the attached usb
devices is recognized with 2.6.13.


0000:00:0e.0 USB Controller: VIA Technologies, Inc. VT82xxxx UHCI USB 1.1 Controller (rev 04) (prog-if 00 [UHCI])
       Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
       Flags: bus master, stepping, medium devsel, latency 32, IRQ 24
       I/O ports at f2010040 [size=32]

The Mac has a Bandit PCI host bridge and a Grand Central I/O controller.

Here is the boot.msg stuff about the card:


<6>USB Universal Host Controller Interface driver v2.3
<4>PCI: Enabling device 0000:00:0e.0 (0094 ->0095)
<6>PCI:Via IRQ fixup for 0000:00:0e.0, from 24 to 0
<6>uhci_hcd 0000:00:0e.0: UHCI Controller
<6>uhci_hcd 0000:00:0e.0: new USB bus registered, assigned bus number 1
<6>uhci_hcd 0000:00:0e.0: irq 24, io base 0x00010040
<6>hub 1-0:1.0: USB hub found
<6>hun 1-0:1.0: 2 ports detected
<6>Initializing USB Mass Storage driver...
<6>usbcore:registered new driver usb-storage
<6>USB Mass Storage support registered



-- 
short story of a lazy sysadmin:
 alias appserv=wotan
