Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270742AbUJUPxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270742AbUJUPxy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 11:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270698AbUJUPv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 11:51:59 -0400
Received: from math.ut.ee ([193.40.5.125]:13812 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S270736AbUJUPrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 11:47:24 -0400
Date: Thu, 21 Oct 2004 18:47:13 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: readcd hangs in blk_execute_rq
In-Reply-To: <20041021154122.GC32465@suse.de>
Message-ID: <Pine.GSO.4.44.0410211844540.29471-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > And here it hangs. ps shows readcd is in D state, in blk_execute_rq.
> > dmesg shows lines of
> >
> > hdc: lost interrupt

Meanwhile I found out that if I eject the CD by pressing button, it
resumes its work and reports error to the user process.

> > ide-cd: cmd 0x28 timed out
> > hdc: DMA interrupt recovery
> > hdc: lost interrupt
> > hdc: status timeout: status=0xd0 { Busy }
> > hdc: status timeout: error=0x00
> > hdc: DMA disabled
> > hdc: drive not ready for command
> > hdc: ATAPI reset complete
>
> Did it previously work reliably with dma (which kernel)? Does it now
> work reliably without dma now? Do send your entire dmesg after a boot
> too, btw.

It worked in earlier 2.4 kernels (2.4.18?) with DMA - I don't remember
if it had some reliability problems. Since then, it's no dma. We have 3
such computers here (Intel D816EEA2 mainboard, this specific Sony CDrom)
and they all behave the same.

-- 
Meelis Roos (mroos@linux.ee)

