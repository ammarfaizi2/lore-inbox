Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316481AbSE0BUj>; Sun, 26 May 2002 21:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316482AbSE0BUi>; Sun, 26 May 2002 21:20:38 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:38919 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316481AbSE0BUh>; Sun, 26 May 2002 21:20:37 -0400
Date: Sat, 25 May 2002 10:18:52 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Frank Davis <fdavis@si.rr.com>
Cc: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5.18 : drivers/pci/pool.c minor printk fix
Message-ID: <20020525131852.GB15907@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Frank Davis <fdavis@si.rr.com>, <linux-kernel@vger.kernel.org>,
	<torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0205262058570.18267-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 26, 2002 at 09:06:08PM -0400, Frank Davis escreveu:
>   The following patch addresses a compile warning. printk saw the "," as 
> an argument, which it shouldn't.
> Regards,
> Frank
> 
> --- drivers/pci/pool.c.old	Thu May  9 19:01:28 2002
> +++ drivers/pci/pool.c	Sun May 26 20:55:42 2002
> @@ -309,7 +309,7 @@
>  		return;
>  	}
>  	if (page->bitmap [map] & (1UL << block)) {
> -		printk (KERN_ERR "pci_pool_free %s/%s, dma %x already free\n",
> +		printk (KERN_ERR "pci_pool_free %s/%s dma %x already free\n",
>  			pool->dev ? pool->dev->slot_name : NULL,
>  			pool->name, dma);
>  		return;

OUCH, so you should fix printk instead ;)

 Arnaldo
