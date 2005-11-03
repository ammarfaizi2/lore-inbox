Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVKCOYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVKCOYe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 09:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVKCOYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 09:24:33 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:64181 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750877AbVKCOYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 09:24:33 -0500
Subject: Parallel ATA with libata status with the patches I'm working on
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Nov 2005 14:54:46 +0000
Message-Id: <1131029686.18848.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Core Features Fixed
- Per drive tuning
- Filter quirk lists
- Single channel support

And To Add
- Specify PCI bus speed
- HPA
- IRQ mask
- PIO only LBA48
- Serialize
- CRC downspeed
- Mixed legacy/native mode (most work done)

Drivers so far written for the libata parallel work I'm doing

ALI
Driver written with equivalent support to the drivers/ide one. Needs
core changes for LBA48 PIO only

AMD
Driver written, given basic testing and equivalent to current
drivers/ide

CS5520
Driver written, some debug work to do. Works unlike the drivers/ide one

CS5530
Works single channel needs core changes for dual

CS5535
Written but untested

HPT34X
Driver written, functionality same as drivers/ide. Needs more testing.

HPT36x
Support done for chips up to 302. No 372N/302N or PLL support yet

IT821x
Written but needs further driver and core work yet

RZ1000
Written, simulation tested

SC1200
Written, needs core changes for dual channel

Serverworks
Written, equivalent functionality to drivers/ide plus some bugs fixed

SIL680
Written, tested, running. 

Triflex
Written tested, running

VIA
Written, tested on some controllers. Does not yet support the 6410 (TODO
item) and very early VIA (needs core changes)

'Generic'
Written, tested, needs polishing and some core changes ideally for irq
mask and for simplex

ISA Legacy
Work in progress

---------------

Unsupported Hardware

ACPI
TODO item - it's possible to drive unknown motherboard chipsets through
ACPI. Not supported by drivers/ide either

AEC62xx
ATIIXP
CMD64x
CY82C693
IT8172
NS87415
OPTI621
PDC202xx
SGI IOC4
SIS5513
SL82C105
SLC90E66
TRM290
PCMCIA (needs hotplug merge first)


