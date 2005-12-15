Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbVLOBdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbVLOBdd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 20:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbVLOBdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 20:33:33 -0500
Received: from mail.gmx.de ([213.165.64.21]:33688 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030204AbVLOBdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 20:33:31 -0500
Date: Thu, 15 Dec 2005 02:33:30 +0100 (MET)
From: "Lukas Postupa" <postupa@gmx.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: HPT374 RAID bus controller SATA, only UDMA 33
X-Priority: 3 (Normal)
X-Authenticated: #21388368
Message-ID: <7553.1134610410@www88.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my SAMSUNG 250GB drive connected to HPT374 RAID bus controller (SATA) is
only working at UDMA 33.

I am using
HPT36X/37X chipset support (*).

And here is what dmesg says:

ide5: BM-DMA at 0xc008-0xc00f, BIOS settings: hdk:DMA, hdl:pio
hdk: SAMSUNG SP2504C, ATA DISK drive
hdk: max request size: 1024KiB
hdk: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63,
UDMA(33)
hdk: cache flushes supported
 hdk:

lspci:

02:05.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
Subsystem: Triones Technologies, Inc.: Unknown device 0001
Flags: bus master, 66Mhz, medium devsel, latency 120, IRQ 17
I/O ports at 9c00 [size=8]
I/O ports at a000 [size=4]
I/O ports at a400 [size=8]
I/O ports at a800 [size=4]
I/O ports at ac00 [size=256]
Expansion ROM at e0020000 [disabled] [size=128K]
Capabilities: [60] Power Management version 2

02:05.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
Subsystem: Triones Technologies, Inc.: Unknown device 0001
Flags: bus master, 66Mhz, medium devsel, latency 120, IRQ 17
I/O ports at b000 [size=8]
I/O ports at b400 [size=4]
I/O ports at b800 [size=8]
I/O ports at bc00 [size=4]
I/O ports at c000 [size=256]
Capabilities: [60] Power Management version 2


Trying to set UDMA 3-5 directly doesn't work:

dmesg:

hdk: Speed warnings UDMA 3/4/5 is not functional.


hdparm -t /dev/hdk

/dev/hdk:
 Timing buffered disk reads:   42 MB in  3.06 seconds =  13.74 MB/sec

Does anyone have a solution to fix this bottleneck?

regards,

Lukas

-- 
10 GB Mailbox, 100 FreeSMS/Monat http://www.gmx.net/de/go/topmail
+++ GMX - die erste Adresse für Mail, Message, More +++
