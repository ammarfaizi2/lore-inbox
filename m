Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbTLBTXt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 14:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264327AbTLBTXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 14:23:02 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:46588 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264323AbTLBTWU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 14:22:20 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: shal <shal@free.fr>
Subject: Re: via82cxxx, DMA and performance problem
Date: Tue, 2 Dec 2003 20:23:57 +0100
User-Agent: KMail/1.5.4
References: <3FCCB0F4.9010907@free.fr>
In-Reply-To: <3FCCB0F4.9010907@free.fr>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312022023.57528.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

You trying to load VIA IDE chipset driver but your IDE devices
are already handled by generic IDE driver, thus you can't enable DMA.

Changing host drivers on the fly is unsupported.

If you want to use IDE chipset modules you should use IDE as module.

--bart

> kernel message:
> VP_IDE: IDE controller at PCI slot 0000:00:11.1
> ACPI: No IRQ known for interrupt pin A of device 0000:00:11.1 - using
> IRQ 255
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
>      ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
>      ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
> ide0: I/O resource 0x3F6-0x3F6 not free.
> hda: ERROR, PORTS ALREADY IN USE
> hdb: ERROR, PORTS ALREADY IN USE
> register_blkdev: cannot get major 3 for ide0
> ide1: I/O resource 0x376-0x376 not free.
> hdc: ERROR, PORTS ALREADY IN USE
> register_blkdev: cannot get major 22 for ide1
> Module via82cxxx cannot be unloaded due to unsafe usage in
> include/linux/module.h:483

