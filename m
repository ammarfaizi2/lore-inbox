Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbUDEN63 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 09:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUDEN62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 09:58:28 -0400
Received: from [151.39.82.11] ([151.39.82.11]:52704 "HELO abbeynet.it")
	by vger.kernel.org with SMTP id S262542AbUDEN60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 09:58:26 -0400
Message-ID: <407165FF.903@abbeynet.it>
Date: Mon, 05 Apr 2004 15:58:23 +0200
From: Marco Fais <marco.fais@abbeynet.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; it-IT; rv:1.4.2) Gecko/20040308
X-Accept-Language: it, en, en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: kernel BUG at page_alloc.c:98 -- compiling with distcc
References: <406D3E8F.20902@abbeynet.it>	<20040402153628.4a09d979.akpm@osdl.org>	<4071394A.1060007@abbeynet.it> <20040405035606.0b470efb.akpm@osdl.org>
In-Reply-To: <20040405035606.0b470efb.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.24.0.7; VDF: 6.24.0.86; host: abbeynet.it)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hola Andrew!

Andrew Morton ha scritto:

>>There are any workarounds for this, until the problem is corrected?
> This will probably make it go away.
> 
> --- linux-2.4.26-rc1/drivers/net/8139too.c	2004-03-27 22:06:18.000000000 -0800
> +++ 24/drivers/net/8139too.c	2004-04-05 03:54:50.478692968 -0700
> @@ -983,7 +983,7 @@ static int __devinit rtl8139_init_one (s
>  	 * through the use of skb_copy_and_csum_dev we enable these
>  	 * features
>  	 */
> -	dev->features |= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_HIGHDMA;
> +	dev->features |= NETIF_F_SG | NETIF_F_HIGHDMA;
>  
>  	dev->irq = pdev->irq;

Unfortunately, this doesn't solve the problem. Seems that the panic it's 
triggered a little later (1-2 minutes instead of a few seconds), but 
anyway I have a kernel panic every time, also with this patch.

The oops tracing looks very similar to the one I've posted on the 
linux-kernel list.

Thank you Andrew, bye!

