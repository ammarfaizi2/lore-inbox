Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbUCGDzR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 22:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbUCGDzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 22:55:17 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:55528 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S261618AbUCGDzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 22:55:13 -0500
Message-ID: <404A9D14.5030107@matchmail.com>
Date: Sat, 06 Mar 2004 19:55:00 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rumi Szabolcs <rumi_ml@rtfm.hu>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Marvell PATA-SATA bridge meets 2.4.x
References: <20040305231642.708841dd.rumi_ml@rtfm.hu>
In-Reply-To: <20040305231642.708841dd.rumi_ml@rtfm.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rumi Szabolcs wrote:
> Hello!
> 
> A while ago I reported a problem with the 2.4.22 kernel and the
> tiny Marvell PATA to SATA bridge chip that is used on many of
> the now-not-so-recent motherboards which don't have native
> SATA ports in their southbridges.
> 
> As it can be seen below, a native SATA150 drive is connected
> to a SATA port implemented using that Marvell chip hooked up
> to the ICH4's parallel ATA133 port and this way the drive is
> only recognized (and used) as UDMA33:
> 
> ICH4: IDE controller at PCI slot 00:1f.1
> ICH4: chipset revision 2
> ICH4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
> hdc: ST3160023AS, ATA DISK drive
> blk: queue c04a1ff4, I/O limit 4095Mb (mask 0xffffffff)
> ide1 at 0x170-0x177,0x376 on irq 15
> hdc: attached ide-disk driver.
> hdc: host protected area => 1
> hdc: 312581808 sectors (160042 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(33)
> 
> As far as I can remember someone (Jeff Garzik?) suspected the
> SATA cable not being recognized as a 80-conductor thus >=UDMA66
> capable cable. Then it was told that there is a fix underway that
> will be included in the 2.4.23 kernel. The above snippet shows
> that the 2.4.25 kernel still has this problem. Any comments?

You want to use a 2.6 kernel and talk to Bart, and Jeff about this...
