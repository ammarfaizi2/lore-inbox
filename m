Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTFPHiY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 03:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTFPHiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 03:38:24 -0400
Received: from fep02.superonline.com ([212.252.122.41]:26499 "EHLO
	fep02.superonline.com") by vger.kernel.org with ESMTP
	id S263462AbTFPHiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 03:38:19 -0400
Message-ID: <3EED76F5.1040407@superonline.com>
Date: Mon, 16 Jun 2003 10:51:17 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alan@redhat.com
Subject: ide, via, unnecessary probe?
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan, all:

To the first channel of my onboard via ide controller
are attached no devices, only to the second channel.
During boot, the kernel keeps trying to probe the
first channel, as seen below, and delaying the boot
unnecessarily:

VP_IDE: IDE controller at PCI slot 00:04.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c596b (rev 23) IDE UDMA66 controller on pci00:04.1
     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:pio
     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
SiI680: IDE controller at PCI slot 00:0a.0
SiI680: chipset revision 2
SiI680: not 100% native mode: will probe irqs later
SiI680: BASE CLOCK == 100
     ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
     ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
hda: IRQ probe failed (0xfffffdf8)
hda: IRQ probe failed (0xfffffdf8)
hda: no response (status = 0x0a), resetting drive
hda: IRQ probe failed (0xfffffdf8)
hda: no response (status = 0x0a)
hdb: IRQ probe failed (0xfffffdf8)
hdb: IRQ probe failed (0xfffffdf8)
hdb: no response (status = 0x0a), resetting drive
hdb: IRQ probe failed (0xfffffdf8)
hdb: no response (status = 0x0a)
hdc: SONY CD-ROM CDU5221, ATAPI CD/DVD-ROM drive
hdd: RICOH CD-R/RW MP7200A, ATAPI CD/DVD-ROM drive

This is with 2.4.21-ac1 and 2.4.19-24mdk.

hda=noprobe hdb=noprobe  boot parameters solves the
issue, but there should be some automagic to handle
this more nicely. I can try any patches happily.

Best regards,
Ozkan Sezer

