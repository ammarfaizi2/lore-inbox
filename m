Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbUK1RT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbUK1RT2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 12:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbUK1RT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 12:19:27 -0500
Received: from smtp1.suscom.net ([64.78.119.248]:6579 "EHLO smtp1.suscom.net")
	by vger.kernel.org with ESMTP id S261529AbUK1RJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 12:09:46 -0500
Date: Sun, 28 Nov 2004 12:07:56 -0500
From: Eric Brundick <kernel@spirilis.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [IDE] Need assistance on a Silicon Image 680-based board
Message-ID: <20041128170756.GA3358@riker.lan>
References: <20041128150914.GA2556@riker.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041128150914.GA2556@riker.lan>
User-Agent: Mutt/1.4.2i
X-Mailer-Agent: Mutt (1.2.5i for UNIX)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been resolved; Petr suggested I make sure the PCI card is snug, and it wasn't.
The card reported its proper Vendor ID of 1095 after I reinstalled it.
Eventually I discovered you need to install this card in a Windows machine and get it working
with at least 1 drive connected for the card to become accessible.  I'm assuming the Windows driver
does some sort of initialization on the card.  After this, Linux detects it perfectly:

SiI680: IDE controller at PCI slot 0000:00:08.0
SiI680: chipset revision 2
SiI680: BASE CLOCK == 133
SiI680: 100% native mode on irq 10
    ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
hde: WDC WD136AA, ATA DISK drive
ide2 at 0xd1816c80-0xd1816c87,0xd1816c8a on irq 10
...
hde: max request size: 64KiB
hde: 26564832 sectors (13601 MB) w/2048KiB Cache, CHS=26354/16/63, UDMA(66)
 hde: hde1 hde2 hde3 < hde5 hde6 hde7 >

Thanks again
-Eric

On Sun, Nov 28, 2004 at 10:09:14AM -0500, Eric Brundick put into existance:
] Hi-
] I have recently purchased an IDE Host Adapter card based on the Silicon Image 680 chipset.
] The board is a Creative I/O UW-A133RPCI-A01.  User manual says "ULTRA ATA/133 IDE RAID CONTROLLER
] CARD SIL680-RAID."
] The board's chipset itself says:
] "Silicon Image
]  Sil0680 ACL144
]  4E0032
]  0411"
... junk trimmed
