Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263236AbTIVRGx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 13:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263237AbTIVRGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 13:06:53 -0400
Received: from head.linpro.no ([80.232.36.1]:33450 "EHLO head.linpro.no")
	by vger.kernel.org with ESMTP id S263236AbTIVRGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 13:06:51 -0400
To: linux-kernel@vger.kernel.org
Subject: SiI3112: problemes with shared interrupt line?
From: Per Andreas Buer <perbu@linpro.no>
Organization: Linpro AS
Date: Mon, 22 Sep 2003 19:06:45 +0200
Message-ID: <PERBUMSGID-ul6pthskb16.fsf@ipchains.linpro.no>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Score: -5.9 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1A1U97-0003Yn-Td*6buLVbZgc0M*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we got a machine with a Nforce2 chipset and a SiI3112 SATA controller.
Two Maxtor disks are configured in software raid, level 1. 

The machine is quite stable as long as I keep the raid degraded. If try
to syncronize the array the machines dies within 20 minutes. No message
given.

This has lead med to believe there is a problem with the two drives
sharing interrupt line 11. I guess it is impossible to force ide2 and
ide3 to use different interrupts as both devices are on the same chip.

I am running Linux 2.4.22-ac3.

Has anyone else seen this?

>From dmesg:

SiI3112 Serial ATA: IDE controller at PCI slot 01:0b.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
    ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
hda: ASUS CD-S400, ATAPI CD/DVD-ROM drive
hde: Maxtor 6Y080M0, ATA DISK drive
blk: queue c046a7c8, I/O limit 4095Mb (mask 0xffffffff)
hdg: Maxtor 6Y080M0, ATA DISK drive
blk: queue c046ac3c, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xf885e080-0xf885e087,0xf885e08a on irq 11
ide3 at 0xf885e0c0-0xf885e0c7,0xf885e0ca on irq 11
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=158816/16/63
hdg: attached ide-disk driver.
hdg: host protected area => 1
hdg: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=158816/16/63


-- 
Per Andreas Buer
