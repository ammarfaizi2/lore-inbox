Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265063AbUBIWCN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 17:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbUBIWCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 17:02:13 -0500
Received: from dynast.gaugusch.at ([195.202.144.152]:43144 "EHLO
	dynast.gaugusch.at") by vger.kernel.org with ESMTP id S265063AbUBIWCM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 17:02:12 -0500
Date: Mon, 9 Feb 2004 23:02:08 +0100 (CET)
From: Markus Gaugusch <markus@gaugusch.at>
X-X-Sender: markus@phoenix.kerstin.at
To: LKML <linux-kernel@vger.kernel.org>
Subject: Problem with ide-scsi and DMA
Message-ID: <Pine.LNX.4.58.0402092247530.3473@phoenix.kerstin.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm using 2.4.24 on two different machines (laptop, via kt133a and desktop 
with nforce2 chipset). Both have IDE cd writers and I use hdc=scsi as boot 
parameter. The laptop works fine, but the desktop not:
# modprobe ide-scsi
hdc: attached ide-scsi driver.
hdc: DMA disabled

If I want to enable DMA with hdparm, I get this error:

/dev/hdc:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)

Only if I remove the ide-scsi module, I can set DMA again, reloading 
ide-scsi disables dma.
I also tried echo using_dma:1 > /proc/ide/hdc/settings
It works fine without ide-scsi, but is stuck at 0 with ide-scsi (no 
errors in syslog).

All above things (hdparm, ...) work on the other machine, so it seems to 
be a problem with the nforce2 ide controller (brand-new Asus A7N8X-X 
board) and ide-scsi.
I don't use any GPL-conflicting modules (disabled onboard network and 
added a realtek card). Kernel compiler is gcc 3.3.1 from SuSE 9.0.

kind regards
Markus Gaugusch

-- 
__________________    /"\ 
Markus Gaugusch       \ /    ASCII Ribbon Campaign
markus(at)gaugusch.at  X     Against HTML Mail
                      / \
