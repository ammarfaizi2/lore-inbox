Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbTJUSuk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 14:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263254AbTJUSuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 14:50:40 -0400
Received: from ncircle.nullnet.fi ([62.236.96.207]:25739 "EHLO
	ncircle.nullnet.fi") by vger.kernel.org with ESMTP id S263228AbTJUSuh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 14:50:37 -0400
Message-ID: <35640.192.168.9.10.1066762232.squirrel@ncircle.nullnet.fi>
In-Reply-To: <200310202325.05384.bzolnier@elka.pw.edu.pl>
References: <001901c39734$8a2c2bb0$0514a8c0@HUSH>
    <31727.1066684060@www30.gmx.net>
    <200310202325.05384.bzolnier@elka.pw.edu.pl>
Date: Tue, 21 Oct 2003 21:50:32 +0300 (EEST)
Subject: Re: HighPoint 374
From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
To: "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: "Svetoslav Slavtchev" <svetljo@gmx.de>,
       "Carlos Fernandez Sanz" <cfs-lk@nisupu.com>,
       linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ups, hit enter while still writing the message, sorry about that.

Anyway, I just wanted to know if the following error messages
tell you anything new.

The test was done by copying almost 40GB data simultaneously
from one RAID1-mirror (disks 1&2 on hpt374) to disks 3&4 on
hpt374 as well _and_ to disks 1&2 on an external Sil680 PCI-card.
Kernel version was 2.4.23-pre7.

In my tests the hdparm -m doesn't solve anything.
The hardware was Epox 8K9A3+ with integrated hpt374-chip.
Processor is AMD 1.4TB, no overclocking of any kind.

Regards,
Tomi Orava
---------------------------------------------------------------
Oct 21 20:15:05 alderan kernel: hdk: drive_cmd: status=0x51 { DriveReady
SeekComplete Error }
Oct 21 20:15:05 alderan kernel: hdk: drive_cmd: error=0x04 {
DriveStatusError }
Oct 21 20:15:05 alderan kernel: hdk: drive_cmd: status=0x51 { DriveReady
SeekComplete Error }
Oct 21 20:15:05 alderan kernel: hdk: drive_cmd: error=0x04 {
DriveStatusError }
Oct 21 20:15:17 alderan kernel: hdk: drive_cmd: status=0x51 { DriveReady
SeekComplete Error }
Oct 21 20:15:17 alderan kernel: hdk: drive_cmd: error=0x04 {
DriveStatusError }
Oct 21 20:22:36 alderan kernel: hdg: set_drive_speed_status: status=0xff {
Busy }
Oct 21 20:30:57 alderan kernel: hdi: dma_timer_expiry: dma status == 0x20
Oct 21 20:30:57 alderan kernel: hdi: timeout waiting for DMA
Oct 21 20:30:57 alderan kernel: hdi: timeout waiting for DMA
Oct 21 20:30:57 alderan kernel: hdi: (__ide_dma_test_irq) called while not
waiting
Oct 21 20:30:57 alderan kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Oct 21 20:30:57 alderan kernel:
Oct 21 20:30:57 alderan kernel: hdi: drive not ready for command
Oct 21 20:30:57 alderan kernel: hdi: status timeout: status=0xd0 { Busy }
Oct 21 20:30:57 alderan kernel:
Oct 21 20:30:57 alderan kernel: hdi: drive not ready for command
Oct 21 20:30:57 alderan kernel: ide4: reset: success
Oct 21 20:30:57 alderan kernel: blk: queue c0498a50, I/O limit 4095Mb
(mask 0xffffffff)
Oct 21 20:30:57 alderan kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Oct 21 20:31:01 alderan kernel:
Oct 21 20:31:10 alderan kernel: hdi: drive not ready for command
Oct 21 20:31:17 alderan kernel: hdi: dma_timer_expiry: dma status == 0x20
Oct 21 20:31:20 alderan kernel: hdi: timeout waiting for DMA
Oct 21 20:31:20 alderan kernel: hdi: timeout waiting for DMA
Oct 21 20:31:20 alderan kernel: hdi: (__ide_dma_test_irq) called while not
waiting
Oct 21 20:31:20 alderan kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Oct 21 20:31:20 alderan kernel:
Oct 21 20:31:20 alderan kernel: hdi: drive not ready for command
Oct 21 20:31:20 alderan kernel: hdi: status timeout: status=0xd0 { Busy }
Oct 21 20:31:20 alderan kernel:
Oct 21 20:31:20 alderan kernel: hdi: drive not ready for command
Oct 21 20:31:20 alderan kernel: ide4: reset: success
Oct 21 20:32:36 alderan kernel: hdi: lost interrupt



-- 
Tomi.Orava@ncircle.nullnet.fi
