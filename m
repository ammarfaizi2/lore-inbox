Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVJWQQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVJWQQe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 12:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVJWQQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 12:16:34 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:7947 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S1750752AbVJWQQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 12:16:33 -0400
Date: Sun, 23 Oct 2005 14:16:18 -0200
From: Arnaldo Carvalho de Melo <acme@mandriva.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       davem@davemloft.net, greearb@candelatech.com
Subject: Re: [0/3] Fix timer bugs in neighbour cache
Message-ID: <20051023161617.GB26530@mandriva.com>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@mandriva.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Reuben Farrelly <reuben-lkml@reub.net>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	davem@davemloft.net, greearb@candelatech.com
References: <43534273.2050106@reub.net> <E1ETaJB-0004a0-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ETaJB-0004a0-00@gondolin.me.apana.org.au>
X-Url: http://advogato.org/person/acme
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Oct 23, 2005 at 05:30:21PM +1000, Herbert Xu escreveu:
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> > 
> > Oct 17 18:49:40 tornado kernel: NEIGH: BUG, double timer add, state is 1
> > Oct 17 18:51:04 tornado last message repeated 3 times
> > Oct 17 18:52:05 tornado last message repeated 5 times
> > Oct 17 18:52:11 tornado last message repeated 2 times
> 
> Excellent.  Looks like we actually caught something.  Pity we don't have
> a stack trace which means that there might be more bugs.
> 
> Anyway, here are three patches which should fix this.  This should go
> into 2.6.14.
> 
> Arnaldo, you can pull them from
> 
> master.kernel.org:/pub/scm/linux/kernel/git/herbert/net-2.6.git

Thanks, pulled.

I guess at some point I'll try to make the neighbour code more like the
sock one where we have things like sk_reset_timer and sk_stop_timer for
this purpose.

- Arnaldo
