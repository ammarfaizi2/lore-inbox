Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272587AbTHKOsm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272628AbTHKOrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 10:47:42 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:1735
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S272587AbTHKOre
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 10:47:34 -0400
Date: Mon, 11 Aug 2003 10:47:32 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: davej@redhat.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CCISS 64bit fixup.
Message-ID: <20030811144732.GB32180@gtf.org>
References: <E19mCuO-0003dU-00@tetrachloride>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19mCuO-0003dU-00@tetrachloride>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 02:40:24PM +0100, davej@redhat.com wrote:
> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/block/cciss.c linux-2.5/drivers/block/cciss.c
> --- bk-linus/drivers/block/cciss.c	2003-08-07 13:51:31.000000000 +0100
> +++ linux-2.5/drivers/block/cciss.c	2003-08-07 14:13:28.000000000 +0100
> @@ -2457,7 +2457,7 @@ static int __init cciss_init_one(struct 
>  	hba[i]->pdev = pdev;
>  
>  	/* configure PCI DMA stuff */
> -	if (!pci_set_dma_mask(pdev, (u64) 0xffffffffffffffff))
> +	if (!pci_set_dma_mask(pdev, (u64) 0xffffffffffffffffULL))

Remove the cast :)

	Jeff



