Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVACPH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVACPH1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 10:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVACPH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 10:07:26 -0500
Received: from jubilee.implode.net ([64.40.108.188]:40321 "EHLO
	jubilee.implode.net") by vger.kernel.org with ESMTP id S261464AbVACPHG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 10:07:06 -0500
Date: Sun, 2 Jan 2005 09:37:04 -0800
From: John Wong <kernel@implode.net>
To: linux-kernel@vger.kernel.org
Subject: Promise IDE DMA issue
Message-ID: <20050102173704.GA14056@gambit.implode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently upgraded fron a nVidia nForce2 MCP-T based A7NX-DX
motherboard to an A8V DX, Via K8T800 Pro.  Now occassionally, I get 
DMA issues on a drive attached to a Promise 133 TX2 controller (20269).

Jan  1 11:14:51 gambit kernel: hde: dma_timer_expiry: dma status == 0x64
Jan  1 11:16:01 gambit kernel: hdh: dma_timer_expiry: dma status == 0x64
Jan  1 11:16:01 gambit kernel: PDC202XX: Primary channel reset.
Jan  1 11:16:01 gambit kernel: hde: DMA interrupt recovery
Jan  1 11:16:01 gambit kernel: hde: lost interrupt
Jan  1 11:16:01 gambit kernel: PDC202XX: Secondary channel reset.
Jan  1 11:16:01 gambit kernel: hdh: DMA interrupt recovery
Jan  1 11:16:01 gambit kernel: hdh: lost interrupt
Jan  1 11:16:01 gambit kernel: hde: dma_timer_expiry: dma status == 0x64
Jan  1 11:16:01 gambit kernel: PDC202XX: Primary channel reset.
Jan  1 11:16:01 gambit kernel: hde: DMA interrupt recovery
Jan  1 11:16:01 gambit kernel: hde: lost interrupt
Jan  1 11:16:01 gambit kernel: hde: dma_timer_expiry: dma status == 0x64
Jan  1 11:16:01 gambit kernel: PDC202XX: Primary channel reset.
Jan  1 11:18:31 gambit kernel: hde: DMA interrupt recovery
Jan  1 11:18:31 gambit kernel: hde: lost interrupt
Jan  1 11:18:31 gambit kernel: hde: dma_timer_expiry: dma status == 0x64
Jan  1 11:18:31 gambit kernel: PDC202XX: Primary channel reset.
Jan  1 11:18:31 gambit kernel: hde: DMA interrupt recovery
Jan  1 11:18:31 gambit kernel: hde: lost interrupt
Jan  1 11:18:31 gambit kernel: hde: dma_timer_expiry: dma status == 0x64
Jan  1 11:18:31 gambit kernel: PDC202XX: Primary channel reset.
Jan  1 11:18:31 gambit kernel: hde: DMA interrupt recovery
Jan  1 11:18:31 gambit kernel: hde: lost interrupt
Jan  1 11:18:31 gambit kernel: hde: dma_timer_expiry: dma status == 0x64
Jan  1 11:18:31 gambit kernel: PDC202XX: Primary channel reset.
Jan  1 11:18:31 gambit kernel: hde: DMA interrupt recovery
Jan  1 11:18:31 gambit kernel: hde: lost interrupt
Jan  1 11:18:31 gambit kernel: hde: dma_timer_expiry: dma status == 0x64
Jan  1 11:19:31 gambit kernel: PDC202XX: Primary channel reset.
Jan  1 11:19:31 gambit kernel: hde: DMA interrupt recovery
Jan  1 11:19:31 gambit kernel: hde: lost interrupt
Jan  1 11:19:31 gambit kernel: hde: dma_timer_expiry: dma status == 0x64
Jan  1 11:19:31 gambit kernel: PDC202XX: Primary channel reset.
Jan  1 11:19:31 gambit kernel: hde: DMA interrupt recovery
Jan  1 11:19:31 gambit kernel: hde: lost interrupt
Jan  1 11:19:31 gambit kernel: hde: dma_timer_expiry: dma status == 0x64
Jan  1 11:19:31 gambit kernel: PDC202XX: Primary channel reset.
Jan  1 11:19:31 gambit kernel: hde: DMA interrupt recovery
Jan  1 11:19:31 gambit kernel: hde: lost interrupt
Jan  1 11:19:31 gambit kernel: hde: dma_timer_expiry: dma status == 0x64
Jan  1 11:19:31 gambit kernel: PDC202XX: Primary channel reset.
Jan  1 11:19:31 gambit kernel: hde: DMA interrupt recovery
Jan  1 11:19:31 gambit kernel: hde: lost interrupt
Jan  1 11:19:51 gambit kernel: hde: dma_timer_expiry: dma status == 0x64
Jan  1 11:20:01 gambit kernel: PDC202XX: Primary channel reset.
Jan  1 11:20:01 gambit kernel: hde: DMA interrupt recovery
Jan  1 11:20:01 gambit kernel: hde: lost interrupt
Jan  1 11:20:21 gambit kernel: hde: dma_timer_expiry: dma status == 0x64
Jan  1 11:20:31 gambit kernel: PDC202XX: Primary channel reset.
Jan  1 11:20:31 gambit kernel: hde: DMA interrupt recovery
Jan  1 11:20:31 gambit kernel: hde: lost interrupt
Jan  1 11:20:51 gambit kernel: hde: dma_timer_expiry: dma status == 0x64
Jan  1 11:21:01 gambit kernel: PDC202XX: Primary channel reset.
Jan  1 11:21:01 gambit kernel: hde: DMA interrupt recovery
Jan  1 11:21:01 gambit kernel: hde: lost interrupt
Jan  1 11:21:21 gambit kernel: hde: dma_timer_expiry: dma status == 0x64
Jan  1 11:21:31 gambit kernel: PDC202XX: Primary channel reset.
Jan  1 11:21:31 gambit kernel: hde: DMA interrupt recovery
Jan  1 11:21:31 gambit kernel: hde: lost interrupt
Jan  1 11:21:51 gambit kernel: hde: dma_timer_expiry: dma status == 0x64
Jan  1 11:22:01 gambit kernel: PDC202XX: Primary channel reset.
Jan  1 11:22:01 gambit kernel: hde: DMA interrupt recovery
Jan  1 11:22:01 gambit kernel: hde: lost interrupt

hde and hdh are identical Seagate ST3200822A
hdf and hdg are Maxtor 6Y120P0 and 6Y120L0, however, they weren't
mounted and are manually mounted as needed as they are FAT32 and NTFS.

Jan  2 06:25:35 gambit kernel: hde: dma_intr: status=0x50 { DriveReady
SeekCompl
ete }
Jan  2 06:25:35 gambit kernel: 
Jan  2 06:25:35 gambit kernel: ide: failed opcode was: unknown

The above happened at 6:25 which coincides with Debian's cron.daily
runs (most likely the updating of the locate database).


I've seen http://seclists.org/lists/linux-kernel/2003/Oct/4754.html
where someone suggests disabling autotune to work around the problem.
Without DMA, the DMA problem shouldn't happen, but this would slow
things down.

http://www.uwsg.iu.edu/hypermail/linux/kernel/0412.2/1569.html
mentions about needing multiple independent PCI buses for more than 2
DMA transfers at a time.

My lspci output from the old A7NX (nVidia nForce2) does appear to have 
more PCI buses.  It looks to have a 0, 1, 2, 3 with 3 looking to be the 
AGP bus.  The A8V (Via K8T800 Pro) on the other hand looks to have just 
0, and 1 with 1 being the AGP bus.


John
