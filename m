Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263417AbREXIqd>; Thu, 24 May 2001 04:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263418AbREXIqX>; Thu, 24 May 2001 04:46:23 -0400
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:60678 "EHLO
	boris.prodako.se") by vger.kernel.org with ESMTP id <S263417AbREXIqQ>;
	Thu, 24 May 2001 04:46:16 -0400
Date: Thu, 24 May 2001 10:45:25 +0200 (CEST)
From: Tobias Ringstrom <tori@unhappy.mine.nu>
X-X-Sender: <tori@boris.prodako.se>
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <akpm@uow.edu.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/net/others 
In-Reply-To: <200105240102.DAA27178@green.mif.pg.gda.pl>
Message-ID: <Pine.LNX.4.33.0105241035230.10914-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrzej,

Thanks for your impressive clean-up patch.  I have a couple of comments
regarding your clean-up of the dmfe.c driver.

On Thu, 24 May 2001, Andrzej Krzysztofowicz wrote:

> @@ -395,7 +395,7 @@
>  	u32 dev_rev, pci_pmr;
>
>  	if (!printed_version++)
> -		printk(version);
> +		printk("%s", version);
>
>  	DMFE_DBUG(0, "dmfe_init_one()", 0);
>

Could you please explain the purpose of this change?  To me it looks less
efficient in both performance and memory usage.

> @@ -2024,8 +2027,10 @@
>  {
>  	int rc;
>
> -	printk(version);
> +#ifdef MODULE
> +	printk("s", version);
>  	printed_version = 1;
> +#endif /* MODULE */
>
>  	DMFE_DBUG(0, "init_module() ", debug);
>

Whoups...  And why did you add the ifdef, btw?

/Tobias

