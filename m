Return-Path: <linux-kernel-owner+w=401wt.eu-S1750984AbXALOTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbXALOTQ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 09:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbXALOTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 09:19:16 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59862 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750928AbXALOTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 09:19:15 -0500
Date: Fri, 12 Jan 2007 14:30:37 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/19] ide: add ide_use_fast_pio() helper
Message-ID: <20070112143037.7d5bf10f@localhost.localdomain>
In-Reply-To: <58cb370e0701120600pc65b237w4865c9637fc1b6e6@mail.gmail.com>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
	<20070112042800.28794.95095.sendpatchset@localhost.localdomain>
	<20070112100836.58738dbc@localhost.localdomain>
	<58cb370e0701120600pc65b237w4865c9637fc1b6e6@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 		if(strstr(id->model, "Integrated Technology Express")) {
> 			/* In raid mode the ident block is slightly buggy
> 			   We need to set the bits so that the IDE layer knows
> 			   LBA28. LBA48 and DMA ar valid */
> 			id->capability |= 3;		/* LBA28, DMA */
> 
> and we are better off using generic helper if we can
> (which may later allow us to use generic tuning code).

IT8212 in smart mode has no tuning at all, the real modes are hidden by
the controller. Some firmware versions don't seem to be like being fed
set features commands either hence the total lack of tuning.

> 
> Before my patch hwif->autodma was only checked in the chipset specific
> hwif->ide_dma_check implementations.  For ide-cris it is
> cris_dma_check()
> function so there no behavior change here.

Ok
