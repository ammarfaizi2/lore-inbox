Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262429AbVAENxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbVAENxf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 08:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbVAENxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 08:53:33 -0500
Received: from ns.suse.de ([195.135.220.2]:30593 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262427AbVAENxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 08:53:19 -0500
Date: Wed, 5 Jan 2005 14:53:13 +0100
From: Olaf Hering <olh@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] request_irq: avoid slash in proc directory entries
Message-ID: <20050105135313.GB22571@suse.de>
References: <20050105075357.GA12473@suse.de> <1104928634.24187.168.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1104928634.24187.168.camel@localhost.localdomain>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Jan 05, Alan Cox wrote:

> On Mer, 2005-01-05 at 07:53, Olaf Hering wrote:
> > diff -purNx tags linux-2.6.10.orig/drivers/net/wan/hostess_sv11.c linux-2.6.10-olh/drivers/net/wan/hostess_sv11.c
> > --- linux-2.6.10.orig/drivers/net/wan/hostess_sv11.c	2004-08-14 07:37:27.000000000 +0200
> > +++ linux-2.6.10-olh/drivers/net/wan/hostess_sv11.c	2005-01-01 19:34:46.000000000 +0100
> > @@ -263,7 +263,7 @@ static struct sv11_device *sv11_init(int
> >  	/* We want a fast IRQ for this device. Actually we'd like an even faster
> >  	   IRQ ;) - This is one driver RtLinux is made for */
> >  	   
> > -	if(request_irq(irq, &z8530_interrupt, SA_INTERRUPT, "Hostess SV/11", dev)<0)
> > +	if(request_irq(irq, &z8530_interrupt, SA_INTERRUPT, "Hostess SV-11", dev)<0)
> >  	{
> >  		printk(KERN_WARNING "hostess: IRQ %d already in use.\n", irq);
> >  		goto fail1;
> 
> SV11 would probably be better but fine by me as the sv11 author

Ok, and GPIO1-ADB could be 'GPIO1 ADB'. Andrew, want a new patch?
