Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTK1CnL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 21:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbTK1CnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 21:43:11 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:50958 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261928AbTK1CnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 21:43:10 -0500
Date: Fri, 28 Nov 2003 00:47:54 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Peter Lieverdink <linux@cafuego.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: include/linux/skbuff.h Typo
Message-ID: <20031128024754.GC11703@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Peter Lieverdink <linux@cafuego.net>, linux-kernel@vger.kernel.org
References: <6.0.0.22.2.20031128132414.01b15568@caffeine.cc.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6.0.0.22.2.20031128132414.01b15568@caffeine.cc.com.au>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 28, 2003 at 01:26:17PM +1100, Peter Lieverdink escreveu:
> Compiling 2.6.0-test11 (PPC) errors out on line 844 of skbuff.h. I'm 
> guessing the following patch makes it do what it should.
> 
> - Peter.
> 
> 
> --- linux-2.6.0-test11/include/linux/skbuff_orig.h      2003-11-28 
> 13:22:47.892405000 +1100
> +++ linux-2.6.0-test11/include/linux/skbuff.h   2003-11-28 
> 13:20:02.142405000 +1100
> @@ -841,7 +841,7 @@
>         SKB_LINEAR_ASSERT(skb);
>         skb->tail += len;
>         skb->len  += len;
> -       if (unlikely(skb=>tail>skb->end))
> +       if (unlikely(skb->tail > skb->end))
>                 skb_over_panic(skb, len, current_text_addr());
>         return tmp;

Sure thing, but what tree is this one you are using? I checked 2.6.0-test11
and there is no => thinko there...

- Arnaldo
