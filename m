Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130701AbRBKXOi>; Sun, 11 Feb 2001 18:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130703AbRBKXO2>; Sun, 11 Feb 2001 18:14:28 -0500
Received: from faui45.informatik.uni-erlangen.de ([131.188.34.45]:17857 "EHLO
	faui45.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S130701AbRBKXOT>; Sun, 11 Feb 2001 18:14:19 -0500
Date: Mon, 12 Feb 2001 00:14:16 +0100
From: Frank Mattern <frank@rommelwood.de>
To: linux-kernel@vger.kernel.org
Cc: igor@meta.math.spbu.ru
Subject: Re: 2.4.1: DMA gets disabled due to irq timeout
Message-ID: <20010212001416.A854@rommelwood.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

From: Igor Nekrestyanov (igor@meta.math.spbu.ru)
>I was trying 2.4.1 kernel but under some IO load (bonnie++) 

Me too, same messages...

>DMA gets disabled with following messages: 

hda: timeout waiting for DMA 
ide_dmaproc: chipset supported ide_dma_timeout func only: 14 

my dmesg: 

ide: Assuming 33MHz system bus speed for PIO modes
ALI15X3: IDE controller on PCI bus 00 dev 80
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x6050-0x6057, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x6058-0x605f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DJSA-210, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 11733120 sectors (6007 MB) w/384KiB Cache, CHS=730/255/63, UDMA(33)

an other chipset but the same problem...
There are more ide_dma_timeout problems known with other chipsets. 
It seems to be an chipset independent problem, it exits also in 2.4.0,
(see http://boudicca.tux.org/hypermail/linux-kernel/2001week02/1429.html)
and in 2.4.1-ac9.

Are any fixes known?

p.s. 
  Please cc: me explicitly, because i am not on the list. 

thanks 
    Frank
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
