Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161120AbWAHBLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161120AbWAHBLm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 20:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161123AbWAHBLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 20:11:42 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:12604 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161120AbWAHBLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 20:11:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=KAq5gs21jq19ArxCcmqSaD3OD4bY9dGGJvLDavVawfSo/V8k9wgnBbHuBIyLJDu7fDHk41QxstdzVHivkP/NsdLcgno3Zy7aFSUoJPxQszWDnh4+iOLxBh92/Lw2Zl7mpvhRNTbQvATBvAKM3x7TrYmmf+h0zSeIR1+PB6fm6AY=
Date: Sun, 8 Jan 2006 04:28:35 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: rmk+lkml@arm.linux.org.uk, Pierre Ossman <drzeus-list@drzeus.cx>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Lindent wbsd driver
Message-ID: <20060108012835.GA9815@mipter.zuzino.mipt.ru>
References: <20060107231747.29389.80042.stgit@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107231747.29389.80042.stgit@poseidon.drzeus.cx>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 12:17:48AM +0100, Pierre Ossman wrote:
> Fix the coding style in the wbsd driver once and for all.

> --- a/drivers/mmc/wbsd.c
> +++ b/drivers/mmc/wbsd.c
> @@ -61,21 +61,21 @@
>  #ifdef CONFIG_PNP
>  
>  static const struct pnp_device_id pnp_dev_table[] = {
> -	{ "WEC0517", 0 },
> -	{ "WEC0518", 0 },
> -	{ "", 0 },
> +	{"WEC0517", 0},
> +	{"WEC0518", 0},
> +	{"", 0},

Was OK.

> -#endif /* CONFIG_PNP */
> +#endif				/* CONFIG_PNP */

Was OK.

> +static inline char *wbsd_kmap_sg(struct wbsd_host *host)
>  {
>  	host->mapped_sg = kmap_atomic(host->cur_sg->page, KM_BIO_SRC_IRQ) +
> -		host->cur_sg->offset;
> +	    host->cur_sg->offset;

Doesn't make sense.

> +	for (i = 0; i < 4; i++) {
>  		cmd->resp[i] =
> -			wbsd_read_index(host, WBSD_IDX_RESP1 + i * 4) << 24;
> +		    wbsd_read_index(host, WBSD_IDX_RESP1 + i * 4) << 24;
>  		cmd->resp[i] |=
> -			wbsd_read_index(host, WBSD_IDX_RESP2 + i * 4) << 16;
> +		    wbsd_read_index(host, WBSD_IDX_RESP2 + i * 4) << 16;
>  		cmd->resp[i] |=
> -			wbsd_read_index(host, WBSD_IDX_RESP3 + i * 4) << 8;
> +		    wbsd_read_index(host, WBSD_IDX_RESP3 + i * 4) << 8;
>  		cmd->resp[i] |=
> -			wbsd_read_index(host, WBSD_IDX_RESP4 + i * 4) << 0;
> +		    wbsd_read_index(host, WBSD_IDX_RESP4 + i * 4) << 0;

Doesn't make sense.

> @@ -967,15 +924,15 @@ static void wbsd_request(struct mmc_host
>  		return;
>  	}
>
> -done:
> +      done:

Was OK. GNU indent is broken wrt labels.

"Was OK" for all labels below.


>  	dma_unmap_single(host->mmc->dev, host->dma_addr, WBSD_DMA_SIZE,
> -		DMA_BIDIRECTIONAL);
> -	host->dma_addr = (dma_addr_t)NULL;
> +			 DMA_BIDIRECTIONAL);
> +	host->dma_addr = (dma_addr_t) NULL;

Leave space after cast or not?

> @@ -2112,9 +2049,9 @@ static struct platform_driver wbsd_drive
>
>  	.suspend	= wbsd_platform_suspend,
>  	.resume		= wbsd_platform_resume,
> -	.driver		= {
> -		.name	= DRIVER_NAME,
> -	},
> +	.driver 	= {
> +				.name	= DRIVER_NAME,
> +			},

Was OK.

