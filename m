Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268013AbTAIUfJ>; Thu, 9 Jan 2003 15:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268014AbTAIUfJ>; Thu, 9 Jan 2003 15:35:09 -0500
Received: from adsl-66-112-90-25-rb.spt.centurytel.net ([66.112.90.25]:2688
	"EHLO carthage") by vger.kernel.org with ESMTP id <S268013AbTAIUfI>;
	Thu, 9 Jan 2003 15:35:08 -0500
Date: Thu, 9 Jan 2003 14:43:50 -0600
From: James Curbo <phoenix@sandwich.net>
To: linux-kernel@vger.kernel.org
Subject: DMA timeouts on Promise 20267 IDE card
Message-ID: <20030109204350.GA413@carthage>
Reply-To: James Curbo <phoenix@sandwich.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[please cc: me as I am not subscribed to lkml]

I've recently started getting errors like this (this example is from
2.4.20-pre3-ac2):

Jan  9 14:20:48 carthage kernel: hda: dma_timer_expiry: dma status ==
0x61
Jan  9 14:20:48 carthage kernel: hdc: dma_timer_expiry: dma status ==
0x21
Jan  9 14:20:58 carthage kernel: hda: timeout waiting for DMA
Jan  9 14:20:58 carthage kernel: PDC202XX: Primary channel reset.
Jan  9 14:20:58 carthage kernel: PDC202XX: Secondary channel reset.
Jan  9 14:20:58 carthage kernel: hda: DMA disabled
Jan  9 14:20:58 carthage kernel: hda: timeout waiting for DMA
Jan  9 14:20:58 carthage kernel: blk: queue c03c2860, I/O limit 4095Mb
(mask 0xffffffff)
Jan  9 14:20:58 carthage kernel: hdc: timeout waiting for DMA
Jan  9 14:20:58 carthage kernel: PDC202XX: Secondary channel reset.
Jan  9 14:20:58 carthage kernel: PDC202XX: Primary channel reset.
Jan  9 14:20:58 carthage kernel: hdc: DMA disabled
Jan  9 14:20:58 carthage kernel: hdc: timeout waiting for DMA
Jan  9 14:20:58 carthage kernel: blk: queue c03c2cac, I/O limit 4095Mb
(mask 0xffffffff)

I have a Promise 20267 PCI IDE controller card on an Epox 8RDA motherboard.
The motherboard is brand new and I never got these kinds of errors with
my previous MSI K7T Turbo board. There are two drives on the card:

hda: WDC WD400BB-00AUA1, ATA DISK drive
hdc: WDC WD400BB-00DEA0, ATA DISK drive

which are both alone on the seperate controllers. I've tried both 2.4
and 2.5 kernels (2.4.20, 2.4.20-ac2, 2.4.20-pre3-ac2, 2.5.[53-55] and
get the same errors.

Does anyone have idea what is causing this? I can offer more information
(.config etc) if necessary.

-- 
James Curbo <hannibal@adtrw.org> <phoenix@sandwich.net>
http://www.adtrw.org/blogs/hannibal/
