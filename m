Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318315AbSHEFs7>; Mon, 5 Aug 2002 01:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318319AbSHEFs6>; Mon, 5 Aug 2002 01:48:58 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:17625 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S318315AbSHEFs4>;
	Mon, 5 Aug 2002 01:48:56 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] 2.4.19 warnings cleanup
References: <m3znw3k8qq.fsf@defiant.pm.waw.pl>
	<1028470583.14196.29.camel@irongate.swansea.linux.org.uk>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 05 Aug 2002 01:28:48 +0200
In-Reply-To: <1028470583.14196.29.camel@irongate.swansea.linux.org.uk>
Message-ID: <m3ofcitd8v.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > --- linux/drivers/net/ppp_generic.c.orig	Sat Aug  3 17:13:58 2002
> > +++ linux/drivers/net/ppp_generic.c	Sat Aug  3 19:11:54 2002
> > @@ -378,7 +378,7 @@
> >  {
> >  	struct ppp_file *pf = file->private_data;
> >  	DECLARE_WAITQUEUE(wait, current);
> > -	ssize_t ret;
> > +	ssize_t ret = 0; /* suppress compiler warning */
> >  	struct sk_buff *skb = 0;
> >  
> >  	if (pf == 0)
> 
> 
> Please don't do this. I'm regularly having to fix drivers where people
> hid bugs this way rather than working out if it was a real problem. If
> it is genuinely a compiler corner case then let the gcc folks know and
> comment it but leave the warning.

Ok.
-- 
Krzysztof Halasa
Network Administrator
