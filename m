Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261710AbSJQOPK>; Thu, 17 Oct 2002 10:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261720AbSJQOPK>; Thu, 17 Oct 2002 10:15:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23823 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261710AbSJQOPJ>;
	Thu, 17 Oct 2002 10:15:09 -0400
Message-ID: <3DAEC758.5040209@pobox.com>
Date: Thu, 17 Oct 2002 10:21:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrey Panin <pazke@orbita1.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][TRIVIAL] de2104x.c missing __devexit_p in 2.5.43
References: <20021017070332.GB304@pazke.ipt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Panin wrote:
> diff -urN -X /usr/share/dontdiff linux-vanilla/drivers/net/tulip/de2104x.c linux/drivers/net/tulip/de2104x.c
> --- linux-vanilla/drivers/net/tulip/de2104x.c	Sun Sep  1 02:04:53 2002
> +++ linux/drivers/net/tulip/de2104x.c	Thu Oct 17 04:10:19 2002
> @@ -2216,7 +2216,7 @@
>  	.name		= DRV_NAME,
>  	.id_table	= de_pci_tbl,
>  	.probe		= de_init_one,
> -	.remove		= de_remove_one,
> +	.remove		= __devexit_p(de_remove_one),
>  #ifdef CONFIG_PM
>  	.suspend	= de_suspend,
>  	.resume		= de_resume,


alas, it is incorrect, as no one hotplugs this hardware.

	Jeff



