Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbUCCOYU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 09:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbUCCOYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 09:24:20 -0500
Received: from ddc.ilcddc.com ([12.35.229.4]:1548 "EHLO ddcnyntd.ddc-ny.com")
	by vger.kernel.org with ESMTP id S262458AbUCCOYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 09:24:18 -0500
Message-ID: <89760D3F308BD41183B000508BAFAC4104B16FC0@DDCNYNTD>
From: RANDAZZO@ddc-web.com
To: linux-kernel@vger.kernel.org
Subject: custom Pci netdevice using DMA
Date: Wed, 3 Mar 2004 09:13:27 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All:

I have a PCI device (uses DMA), that was originally designed for an RTOS...

The device takes physical host address pointers (written to the card via bar
space).

When data is received from the network, the pci card will DMA the data
directly to the
host asynchronously....

after a certain amt of data is received, an interrupt is gen'd and the host
goes and looks at the data..

For transmitting, the host gives the pci device a physical host address
value and the pci device will DMA the
data, from the host, that is pointed to......

...............................
This above design does not work in Linux 2.4.  I understand that I must use
the dma functions (pci_alloc_*,
virt_to_bus, etc), but can't figure out what is the best way???

Any help?
Feel free to ask more details if needed.....

-Mike

 
"This message may contain company proprietary information. If you are not
the intended recipient, any disclosure, copying, distribution or reliance on
the contents of this message is prohibited. If you received this message in
error, please delete and notify me."

