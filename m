Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270067AbTGMHVx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 03:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270146AbTGMHVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 03:21:31 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.30]:57217 "EHLO
	mwinf0101.wanadoo.fr") by vger.kernel.org with ESMTP
	id S270144AbTGMHTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 03:19:33 -0400
Date: Sun, 13 Jul 2003 09:33:29 +0200
From: Jean-Luc <jean-luc.coulon@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: 2.5.75 : cannot set dma mode on ide disks
Message-ID: <20030713073329.GA5595@tangerine>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is part of dmesg :
...
Journalled Block Device driver loaded
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
hda: QUANTUM FIREBALLP LM30, ATA DISK drive
hdb: WDC WD400BB-00DEA0, ATA DISK drive
hdc: GoldStar CD-RW CED-8083B, ATAPI CD/DVD-ROM drive
hdd: CREATIVECD3621E, ATAPI CD/DVD-ROM drive
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 58633344 sectors (30020 MB) w/1900KiB Cache, CHS=58168/16/63
  hda: hda1 hda2 hda3 hda4
hdb: max request size: 128KiB
hdb: host protected area => 1
hdb: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63
  hdb: hdb1
...

When I try to set dma on on either of the disks, I get the following:
[root@debian-f5ibh] ~ # hdparm -d1  /dev/hda

/dev/hda:
  setting using_dma to 1 (on)
  HDIO_SET_DMA failed: Operation not permitted
  using_dma    =  0 (off)


[I'm not on the list, please cc to me]

---
Regards
	Jean-Luc
