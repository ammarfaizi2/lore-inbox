Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbVAENlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbVAENlh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 08:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVAENlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 08:41:37 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:12217 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262411AbVAENlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 08:41:32 -0500
Subject: Re: [PATCH] request_irq: avoid slash in proc directory entries
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Olaf Hering <olh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050105075357.GA12473@suse.de>
References: <20050105075357.GA12473@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104928634.24187.168.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 05 Jan 2005 12:37:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-01-05 at 07:53, Olaf Hering wrote:
> diff -purNx tags linux-2.6.10.orig/drivers/net/wan/hostess_sv11.c linux-2.6.10-olh/drivers/net/wan/hostess_sv11.c
> --- linux-2.6.10.orig/drivers/net/wan/hostess_sv11.c	2004-08-14 07:37:27.000000000 +0200
> +++ linux-2.6.10-olh/drivers/net/wan/hostess_sv11.c	2005-01-01 19:34:46.000000000 +0100
> @@ -263,7 +263,7 @@ static struct sv11_device *sv11_init(int
>  	/* We want a fast IRQ for this device. Actually we'd like an even faster
>  	   IRQ ;) - This is one driver RtLinux is made for */
>  	   
> -	if(request_irq(irq, &z8530_interrupt, SA_INTERRUPT, "Hostess SV/11", dev)<0)
> +	if(request_irq(irq, &z8530_interrupt, SA_INTERRUPT, "Hostess SV-11", dev)<0)
>  	{
>  		printk(KERN_WARNING "hostess: IRQ %d already in use.\n", irq);
>  		goto fail1;

SV11 would probably be better but fine by me as the sv11 author

