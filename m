Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbVLXV4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVLXV4f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 16:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbVLXV4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 16:56:35 -0500
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:35851
	"EHLO cynthia.pants.nu") by vger.kernel.org with ESMTP
	id S1750739AbVLXV4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 16:56:35 -0500
Date: Sat, 24 Dec 2005 13:56:33 -0800
From: Brad Boyer <flar@allandria.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 33/36] m68k: drivers/scsi/mac53c94.c __iomem annotations
Message-ID: <20051224215633.GA17645@pants.nu>
References: <E1EpIQf-0004tx-Oh@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EpIQf-0004tx-Oh@ZenIV.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a ppc only driver at the moment. The m68k mac version is mac_esp.
I've been thinking about retrofitting this driver to use on the models
that can do DMA, but that will require me to finish some of the work I
have pending on the macio layer to get it working for nubus models.

	Brad Boyer
	flar@allandria.com

On Thu, Dec 22, 2005 at 04:51:49AM +0000, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> Date: 1133866874 -0500
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> ---
> 
>  drivers/scsi/mac53c94.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> c142eb4b3a51224952b8760cff73051398dac312
> diff --git a/drivers/scsi/mac53c94.c b/drivers/scsi/mac53c94.c
> index 932dcf0..a853fb4 100644
> --- a/drivers/scsi/mac53c94.c
> +++ b/drivers/scsi/mac53c94.c
> @@ -531,9 +531,9 @@ static int mac53c94_remove(struct macio_
>  	free_irq(fp->intr, fp);
>  
>  	if (fp->regs)
> -		iounmap((void *) fp->regs);
> +		iounmap(fp->regs);
>  	if (fp->dma)
> -		iounmap((void *) fp->dma);
> +		iounmap(fp->dma);
>  	kfree(fp->dma_cmd_space);
>  
>  	scsi_host_put(host);
> -- 
> 0.99.9.GIT
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
