Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265913AbTF3WBX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 18:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265915AbTF3WBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 18:01:23 -0400
Received: from pa91.banino.sdi.tpnet.pl ([213.76.211.91]:49925 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP id S265913AbTF3WBW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 18:01:22 -0400
Date: Tue, 1 Jul 2003 00:15:42 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.4.21 IDE problems (lost interrupt, bad DMA status)
Message-ID: <20030630221542.GA17416@alf.amelek.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After upgrading the kernel from 2.4.20 to 2.4.21, sometimes I see
the following messages:

hda: dma_timer_expiry: dma status == 0x24
hda: lost interrupt
hda: dma_intr: bad DMA status (dma_stat=30)
hda: dma_intr: status=0x50 { DriveReady SeekComplete }

It happens especially when there is a lot of disk I/O (which stops
for a few seconds when these messages appear), with three different
disks (very unlikely they all decided to die at the same time...),
one old ATA33 (QUANTUM FIREBALL SE8.4A) and two newer ATA100 disks
(WDC WD300BB-32CCB0, ST340015A).  IDE controller: VIA VT82C686B
on a MSI MS-6368L motherboard.

I don't remember seeing anything like that in any earlier 2.4.x
kernels.  Is this a known problem?  Is this anything dangerous -
should I disable UDMA for now to play it safe?

Thanks,
Marek

