Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267602AbSLSL1Z>; Thu, 19 Dec 2002 06:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267605AbSLSL1Z>; Thu, 19 Dec 2002 06:27:25 -0500
Received: from tartu.cyber.ee ([193.40.6.68]:58897 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id <S267602AbSLSL1Y>;
	Thu, 19 Dec 2002 06:27:24 -0500
Date: Thu, 19 Dec 2002 13:35:26 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: piix4 ide error still present in 2.4.21-pre1
Message-ID: <Pine.LNX.4.44.0212191329220.19463-100000@ondatra.tartu-labor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem with mwdma2 drive attached to piix4 (430tx chipset) is still 
present in 2.4.21-pre1. It no more hangs like 2.4.19 and 2.4.20 did but it 
behaves like 2.4.19-ac - lots of error messages, machine stops during ide 
errors or reinitialization for several seconds but recovers and error is 
given to userspace. The drive works well in 2.4.18.

dmesg:

hdd: dma_timer_expiry: dma status == 0x61
hda: dma_timer_expiry: dma status == 0x61
hdd: timeout waiting for DMA
hdd: timeout waiting for DMA
hdd: (__ide_dma_test_irq) called while not waiting
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hdd: drive not ready for command
hdd: status timeout: status=0xd0 { Busy }

hdc: DMA disabled
hdd: drive not ready for command
ide1: reset timed-out, status=0xff
hdd: dma_timer_expiry: dma status == 0x41
hdd: timeout waiting for DMA
hdd: timeout waiting for DMA
hdd: (__ide_dma_test_irq) called while not waiting
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hdd: drive not ready for command
hdd: status timeout: status=0xd0 { Busy }

hdd: drive not ready for command

After this line, hdd is offline an no sector is readable, read gest IO 
error.

--- 
Meelis Roos (mroos@linux.ee)

