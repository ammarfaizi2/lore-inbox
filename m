Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130374AbQLJKLi>; Sun, 10 Dec 2000 05:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130599AbQLJKLO>; Sun, 10 Dec 2000 05:11:14 -0500
Received: from granch.com ([212.109.197.246]:50953 "EHLO granch.com")
	by vger.kernel.org with ESMTP id <S129960AbQLJKLH>;
	Sun, 10 Dec 2000 05:11:07 -0500
Date: Sun, 10 Dec 2000 14:59:46 +0600 (NOVT)
From: "Yaroslav S. Polyakov" <xenon@granch.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Yaroslav Polyakov <xenon@granch.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/sbni.c irq release on failure
In-Reply-To: <20001209174918.G859@conectiva.com.br>
Message-ID: <Pine.BSF.4.21.0012101457450.10468-100000@granch.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sat, 9 Dec 2000, Arnaldo Carvalho de Melo wrote:

> Alan/Yaroslav,
> 
> 	Please consider applying, a similar patch is already in 2.4.
I want to release new version of sbni driver soon (after QA
procedures). This new version will be ported to 2.4 kernel.
this version already have your patch applied. Thanks! :)

> - Arnaldo
> 
> --- linux-2.2.18-pre25/drivers/net/sbni.c	Sat Dec  9 15:08:17 2000
> +++ linux-2.2.18-pre25.acme/drivers/net/sbni.c	Sat Dec  9 17:44:53 2000
> @@ -456,6 +456,7 @@
>  	if(dev->priv == NULL)
>  	{
>  		DP( printk("%s: cannot allocate memory\n", dev->name); )
> +		free_irq(dev->irq, dev);
>  		return -ENOMEM;
>  	}
>     
> 

                                       .
                            Si vis pacem, para bellum
                          Granch ltd.  Security Analyst

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
