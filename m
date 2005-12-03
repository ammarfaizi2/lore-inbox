Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbVLCRpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVLCRpc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 12:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbVLCRpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 12:45:31 -0500
Received: from mail.gmx.de ([213.165.64.20]:1494 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932108AbVLCRpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 12:45:31 -0500
X-Authenticated: #14561429
Message-ID: <00b801c5f831$5e2ab3f0$1001a8c0@fibonacci>
From: "Gottfried Haider" <gohai@gmx.net>
To: <linux-kernel@vger.kernel.org>
Subject: [2.6.15-rc2] 8139too probe fails (pci related?)
Date: Sat, 3 Dec 2005 18:45:34 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2670
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have troubles getting my Surecom EP-320 X-R1 (8139B) network adapter 
to work under 2.6.15-rc2 (will try other version asap, first time 
installing linux on this particular machine).


8139too Fast Ethernet driver 0.9.27
PCI: Device 0000:01:0c.0 not available because of resource collisions
Trying to free nonexistent resource <0000d000-0000d003>
Trying to free nonexistent resource <fa800800-fa80080f>
8139too: probe of 0000:01:0c.0 failed with error -22


This also happens when using pci=routeirq or pci=noacpi. The driver in 
question is build as module. Machine is a (quite common) ASUS CUSL2 
(i815) running a PIII 800 MHz.

Full kern.log(s) and other files can be found at 
http://sukzessiv.net/8139/ (to large to include them as attachment, it 
seems). Below are some lines that might be interesting..


PCI quirk: region e400-e47f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region ec00-ec3f claimed by ICH4 GPIO
PCI: Unable to handle 64-bit address for device 0000:01:0c.0
PCI: Transparent bridge - 0000:00:1e.0
(..)
PCI: Cannot allocate resource region 0 of device 0000:01:0c.0
PCI: Cannot allocate resource region 3 of device 0000:01:0c.0
pnp: 00:03: ioport range 0xe400-0xe47f could not be reserved
pnp: 00:03: ioport range 0xec00-0xec3f has been reserved
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Error while updating region 0000:01:0c.0/3 (fa800800 != 00000810)
PCI: Error while updating region 0000:01:0c.0/0 (0000d001 != 813910fc)
PCI: Bridge: 0000:00:1e.0


oh, and btw: 'lspci -vvvv' outputs "Capabilities: [10] #fc [8139]" in an 
endless loop to the console when displaying the info about 01:0c.0 
(RTL-8139).

any hints?

thanks and have a nice day
Gottfried Haider 

