Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVKUVVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVKUVVc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVKUVVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:21:32 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:28507 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1750711AbVKUVVb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:21:31 -0500
Subject: Bug in promise_new ide conteroller (was: Re: [BUG] PDC20268
	crashing during DMA setup on stock Debian 2.6.12-1-powerpc)
From: Kasper Sandberg <lkml@metanurb.dk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       LKML Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1132520441.6052.41.camel@gaston>
References: <20051017005855.132266ac.akpm@osdl.org>
	 <1129536482.7620.76.camel@gaston>
	 <6DFB5723-0042-46FE-811F-BF372B068014@mac.com>
	 <204AB9A8-7701-402F-A6B9-DF455DAA2A3F@mac.com>
	 <1129760024.7620.219.camel@gaston>
	 <75FE9776-B88F-453E-9616-850097DB0138@mac.com>
	 <1129772205.7620.226.camel@gaston>
	 <59EA4A9E-0F86-4D53-8DDD-56F6DDC6E726@mac.com>
	 <1132520441.6052.41.camel@gaston>
Content-Type: text/plain
Date: Mon, 21 Nov 2005 22:21:25 +0100
Message-Id: <1132608085.15938.36.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have a promise controller and it fails too, but only some times (never
during startup).. i get the following errors:
hdf: dma_intr: bad DMA status (dma_stat=75)
hdf: dma_intr: status=0x50 { DriveReady SeekComplete }
ide: failed opcode was: unknown
hdf: dma_timer_expiry: dma status == 0x60
hdf: DMA timeout retry
PDC202XX: Primary channel reset.
hdf: timeout waiting for DMA

and i know for a fact it isnt the indidual controller, as i tried with 2
other brand new ones, and i know it isnt the drives/cables/computer,
since i tried switching it all around, and it keeps happening.

if it does this while reading/writing the system hardlocks..


i wrote promise technical support, which said it could be caused by
sharing interrupts, so i checked, and it did share with my NIC, so i
switched to another pci slot, and now it has its own interrupt, YET it
still keeps doing this..

i would greatly apreciate any help

On Mon, 2005-11-21 at 08:00 +1100, Benjamin Herrenschmidt wrote:
> > This is the only possibility that I can think of, but I'm having a  
> > hard time getting enough lines of pre-BUG output.  Is there any way  
> > to turn off the BUG() lines and just show the printks before that point?
> 
> There is a patch from Thibault that fixes it, it should be in 2.6.15-rc2
> 
> Ben.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

