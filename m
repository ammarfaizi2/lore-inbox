Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270567AbTGNOEe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270609AbTGNMbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:31:05 -0400
Received: from main.gmane.org ([80.91.224.249]:11167 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270567AbTGNMKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:10:44 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Happe <andreashappe@gmx.net>
Subject: 2.5.75-mm1 orinoco_cs doesn't work
Date: Sun, 13 Jul 2003 22:16:12 +0200
Message-ID: <slrnbh3fgc.4of.andreashappe@flatline.ath.cx>
Reply-To: Andreas Happe <andreashappe@gmx.net>
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PCMCIA card is detected by the kernel, but the orinoco_cs driver
won't be loaded. If the driver is insmod'ed manually no device is found.

cardctl info:
| PRODID_1="NETGEAR MA401RA Wireless PC"
| PRODID_2="Card"
| PRODID_3="ISL37300P"
| PRODID_4="Eval-RevA"
| MANFID=000b,7300
| FUNCID=6
| PRODID_1=""
| PRODID_2=""
| PRODID_3=""
| PRODID_4=""
| MANFID=0000,0000
| FUNCID=255

dmesg output:
| Linux Kernel Card Services 3.1.22
| options:  [pci] [cardbus] [pm]
| PCI: Found IRQ 10 for device 0000:02:05.0
| PCI: Sharing IRQ 10 with 0000:00:1d.0
| ti113x: Routing card interrupts to PCI
| Yenta IRQ list 0000, PCI irq10
| Socket status: 30000010
| PCI: Found IRQ 10 for device 0000:02:05.1
| PCI: Sharing IRQ 10 with 0000:00:1f.3
| PCI: Sharing IRQ 10 with 0000:01:00.0
| PCI: Sharing IRQ 10 with 0000:02:02.0
| ti113x: Routing card interrupts to PCI
| Yenta IRQ list 0000, PCI irq10
| Socket status: 30000006
| cs: IO port probe 0x0c00-0x0cff: clean.
| cs: IO port probe 0x0820-0x08ff: clean.
| cs: IO port probe 0x0800-0x080f: clean.
| cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df 0x4d0-0x4d7
| cs: IO port probe 0x0a00-0x0aff: clean.
| cs: memory probe 0xa0000000-0xa0ffffff: clean.

dmesg after 'insmod orinoco_cs' (e.g. nothing found):
| orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
| orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)

	--Andreas

