Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264428AbUASXYv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 18:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264445AbUASXYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 18:24:51 -0500
Received: from netfinity2.mailbox.hu ([195.70.35.152]:46505 "HELO
	web1.mailbox.hu") by vger.kernel.org with SMTP id S264428AbUASXYo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 18:24:44 -0500
Message-ID: <20040119232440.15676.qmail@web2.mailbox.hu>
From: "Perverz Tata" <perverztata@mailbox.hu>
Date: Tue, 20 Jan 2004 00:24:40 +0100
To: linux-kernel@vger.kernel.org
X-Mailer: Mailbox Webmail
MIME-Version: 1.0
Subject: kg7-RAID: DMA timeout error
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have attached a new hdd to my integrated raid controller, but i have
the following message from the kernel:
HPT370A: IDE controller at PCI slot 0000:00:13.0
HPT370A: chipset revision 4
HPT37X: using 33MHz PCI clock
HPT370A: 100% native mode on irq 11
    ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:pio, hdf:DMA
    ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:pio, hdh:pio
hdf: Maxtor 6Y080P0, ATA DISK drive
...

hdf: max request size: 128KiB
hdf: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63,
UDMA(100)
 hdf:<4>hdf: dma_timer_expiry: dma status == 0x41
hdf: DMA timeout error
hdf: 0 bytes in FIFO
hdf: timeout waiting for DMA
hdf: dma timeout error: status=0x58 { DriveReady SeekComplete
DataRequest }
                                                                        
       
 hdf1

The hdd is unusable slow under linux, but it works fine with win2000. I
googled for a solution a lot, but i found nothing.

I use 2.6.1 kernel and Debian unstable.
Here is some important part of my kernel's conf:
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y

PerverzTata

_____________________________________________________________________
Most megnyerheted a Palm Zire 71 kéziszámítógépet, ami digitáli
s
fényképezõ és MP3 lejátszó is egyben. Kattints ide:
http://www.edmax.hu/kerdoiv_2003.php

