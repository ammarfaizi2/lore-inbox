Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbTDIJI2 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 05:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbTDIJI2 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 05:08:28 -0400
Received: from mail.mediaways.net ([193.189.224.113]:24013 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S262931AbTDIJI1 (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 05:08:27 -0400
Subject: 2.4.21pre6 (__ide_dma_test_irq) called while not waiting
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1049879881.2774.40.camel@fortknox>
Mime-Version: 1.0
Date: 09 Apr 2003 11:18:01 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a hpt370 based controller which shares an irq with a broadcom
bcm4401 network adaptor.

when transferring stuff over the network the ide controller drops the
dma for all disks on the controller repeatedly... so it is not a
cable/disk problem but a problem in the nic's driver/the hpt driver.

however this stuff only happens when I put high load on the nic. the
drives form a software raid and reconstructing it does not cause any
trouble...

here is my setup:
7:   28328328          XT-PIC  ide4, ide5, eth0


hdi: 4 bytes in FIFO
hdi: timeout waiting for DMA
hdi: (__ide_dma_test_irq) called while not waiting
hdi: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }

hdk: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }

hdk: status timeout: status=0xd0 { Busy }

hdk: DMA disabled
hdk: drive not ready for command
ide4: reset: success
ide5: reset: success

Thanks,
Soeren.

