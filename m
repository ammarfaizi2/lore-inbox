Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267528AbTBJBiH>; Sun, 9 Feb 2003 20:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267506AbTBJBhA>; Sun, 9 Feb 2003 20:37:00 -0500
Received: from dp.samba.org ([66.70.73.150]:40877 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267499AbTBJBg4>;
	Sun, 9 Feb 2003 20:36:56 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org, Hai-Pao Fan <haipao@mvista.com>,
       source@mvista.com
Subject: Re: [PATCH] 2.5.59 : drivers/char/ite_gpio.c 
In-reply-to: Your message of "Fri, 07 Feb 2003 12:19:51 CDT."
             <Pine.LNX.4.44.0302071217520.6917-100000@master> 
Date: Mon, 10 Feb 2003 11:29:30 +1100
Message-Id: <20030210014641.02ABE2C09B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0302071217520.6917-100000@master> you write:
> --- linux/drivers/char/ite_gpio.c.old	2003-01-16 21:22:23.000000000 -0500
> +++ linux/drivers/char/ite_gpio.c	2003-02-07 02:04:43.000000000 -0500
> @@ -140,7 +140,7 @@
>  {
>  	int ret=-1;
>  
> -	if (MAX_GPIO_LINE > *data >= 0) 
> +	if ((MAX_GPIO_LINE > *data) && (*data >= 0)) 
>  		ret=ite_gpio_irq_pending[*data];
>   
>  	DEB(printk("ite_gpio_in_status %d ret=%d\n",*data, ret));

Nope, of course *data is >= 0, it's a u32.

Once again, the author needs to indicate (and test!) what was meant
here...

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
