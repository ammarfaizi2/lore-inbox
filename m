Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264908AbTBJKDq>; Mon, 10 Feb 2003 05:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264915AbTBJKDp>; Mon, 10 Feb 2003 05:03:45 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:54425 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S264908AbTBJKDo>; Mon, 10 Feb 2003 05:03:44 -0500
Message-Id: <200302101013.h1AADOd4012400@eeyore.valparaiso.cl>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Frank Davis <fdavis@si.rr.com>, linux-kernel@vger.kernel.org,
       Hai-Pao Fan <haipao@mvista.com>, source@mvista.com
Subject: Re: [PATCH] 2.5.59 : drivers/char/ite_gpio.c 
In-Reply-To: Your message of "Mon, 10 Feb 2003 11:29:30 +1100."
             <20030210014641.02ABE2C09B@lists.samba.org> 
Date: Mon, 10 Feb 2003 11:13:24 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> said:
> In message <Pine.LNX.4.44.0302071217520.6917-100000@master> you write:
> > --- linux/drivers/char/ite_gpio.c.old	2003-01-16 21:22:23.000000000 -0500
> > +++ linux/drivers/char/ite_gpio.c	2003-02-07 02:04:43.000000000 -0500
> > @@ -140,7 +140,7 @@
> >  {
> >  	int ret=-1;
> >  
> > -	if (MAX_GPIO_LINE > *data >= 0) 
> > +	if ((MAX_GPIO_LINE > *data) && (*data >= 0)) 
> >  		ret=ite_gpio_irq_pending[*data];
> >   
> >  	DEB(printk("ite_gpio_in_status %d ret=%d\n",*data, ret));
> 
> Nope, of course *data is >= 0, it's a u32.

MAX_GPIO_LINE > *data >= 0 is (MAX_GPIO_LINE > *data) >= 0 is (0 or 1) >= 0
is 1 ;-)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
