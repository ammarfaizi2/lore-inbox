Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268353AbSISOC0>; Thu, 19 Sep 2002 10:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269645AbSISOC0>; Thu, 19 Sep 2002 10:02:26 -0400
Received: from math.ut.ee ([193.40.5.125]:53155 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id <S268353AbSISOCZ>;
	Thu, 19 Sep 2002 10:02:25 -0400
Date: Thu, 19 Sep 2002 17:07:27 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: PIIX4 IDE still broken in pre7-ac2
Message-ID: <Pine.GSO.4.44.0209191702330.24450-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm the one who reported that PIIX4 ide in 430TX works no more since
2.4.19 (2.4.18 is OK). I tested 2.4.20-pre7 and 2.4.20-pre7-ac2, it
still hangs with heavy ide load (bitkeeper or background kernel
compile with active foreground work). The disk is Seagate Medalist 2.5G,
using MWDMA2 (pre-UDMA).

With 2.4.19 and different 2.4.20-pre's it just hangs.

With 2.4.20-pre7-ac2 I get some kernel output before the hang (hdd is
the problematic disk):

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

-- 
Meelis Roos <mroos@linux.ee>

