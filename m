Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVAYIIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVAYIIg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 03:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVAYIIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 03:08:36 -0500
Received: from quark.didntduck.org ([69.55.226.66]:45540 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261866AbVAYII0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 03:08:26 -0500
Message-ID: <41F5FE79.8020307@didntduck.org>
Date: Tue, 25 Jan 2005 03:08:25 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: nForce4 USB not working
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just put in a Gigabyte GA-K8NF-9 motherboards (nforce4 chipset), and 
the USB ports are not working.  It recoginizes the ports but no devices 
attached to them (mouse, external hub).  These devices worked properly 
with my previous motherboard.  This happens with both 2.6.10 vanilla and 
2.6.10-1.1109_FC4 (2.6.10-rc2 based).

lspci -n:
00:02.0 Class 0c03: 10de:005a (rev a2) (prog-if 10)
         Subsystem: 1458:5004
         Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 5
         Memory at f0104000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: <available only to root>

00:02.1 Class 0c03: 10de:005b (rev a2) (prog-if 20)
         Subsystem: 1458:5004
         Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 10
         Memory at f0106000 (32-bit, non-prefetchable) [size=256]
         Capabilities: <available only to root>

lsusb:
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000

dmesg:
ehci_hcd 0000:00:02.1: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: irq 10, pci mem 0xf0106000
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd 0000:00:02.0: OHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 5, pci mem 0xf0104000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected


I have tried booting with acpi=off and pci=noacpi with no change.  Any 
help would be appreciated.

--
				Brian Gerst
