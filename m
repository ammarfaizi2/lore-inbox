Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261683AbSJCQfP>; Thu, 3 Oct 2002 12:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261641AbSJCQfP>; Thu, 3 Oct 2002 12:35:15 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:36751 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S261639AbSJCQfO>;
	Thu, 3 Oct 2002 12:35:14 -0400
Date: Thu, 3 Oct 2002 18:40:41 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cli()/sti() fix for drivers/net/depca.c
Message-ID: <20021003184041.A29041@se1.cogenit.fr>
References: <200210022005.g92K5Fp31816@Port.imtp.ilyichevsk.odessa.ua> <200210022133.g92LX0p32156@Port.imtp.ilyichevsk.odessa.ua> <20021003001228.A18629@fafner.intra.cogenit.fr> <200210030743.g937hBp01523@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210030743.g937hBp01523@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Thu, Oct 03, 2002 at 10:37:03AM -0200
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> :
[...]
> > depca_rx() looks strange:
> > buf = skb_put(skb, len);
> > [...]
> > netif_rx(skb);
> > [...]
> > if (buf[0] & ...)
> 
> I'd say this network stuff is a bit cryptic for untrained eye :-)
> What's strange with that code?

One shouldn't assume the buffer is available once it was passed to 
netif_rx().

-- 
Ueimor
