Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265260AbUFRPmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265260AbUFRPmw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 11:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUFRPkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 11:40:36 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:53636 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S265285AbUFRPji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 11:39:38 -0400
Message-Id: <200406181539.i5IFd8BV004328@eeyore.valparaiso.cl>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: [Bug 2905] New: Aironet 340 PCMCIA card not working since 2.6.7 
In-Reply-To: Message from Jesper Juhl <juhl-lkml@dif.dk> 
   of "Fri, 18 Jun 2004 00:42:29 +0200." <Pine.LNX.4.56.0406180040050.15935@jjulnx.backbone.dif.dk> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Fri, 18 Jun 2004 11:39:07 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> said:
> Guennadi Liakhovetski <g.liakhovetski@gmx.de> said:
> > -			skb = dev_alloc_skb( len + hdrlen + 2 );
> > +			skb = dev_alloc_skb( len + hdrlen + 2 + 2 );
> 
> nitpicking, but why not
> 	skb = dev_alloc_skb( len + hdrlen + 4 );
> ?

- It makes no difference (C forces constant expresions to be computed at
  compile time)
- It _does_ matter if the 2 + 2 is clearer than 4
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
