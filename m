Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268345AbUIWJ3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268345AbUIWJ3a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 05:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268346AbUIWJ3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 05:29:30 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:29341 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S268345AbUIWJ3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 05:29:14 -0400
Subject: Re: 2.6.9-rc2-mm2
From: Nuno Ferreira <nuno.ferreira@graycell.biz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E1CAJoH-0003J3-00@gondolin.me.apana.org.au>
References: <E1CAJoH-0003J3-00@gondolin.me.apana.org.au>
Content-Type: text/plain
Organization: Graycell
Date: Thu, 23 Sep 2004 10:29:16 +0100
Message-Id: <1095931756.5460.1.camel@taz.graycell.biz>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Qui, 2004-09-23 at 12:58 +1000, Herbert Xu wrote: 
> Andrew Morton <akpm@osdl.org> wrote:
> > 
> > hrm.  Lots of changes in fib_hash.c  Could you please try just 2.6.9-rc2 plus
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm2/broken-out/linus.patch
> 
> I just had a look at mm2 and it's missing davem's latest fix in fib_hash.c:
> 
> net/ipv4/fib_hash.c
>   1.22 04/09/21 16:31:48 davem@nuts.davemloft.net +1 -1
>   [IPV4]: Fix list traversal in fn_hash_insert().
> 
> That's probably the problem.

Tried with this patch, same result, besides pppd appears to be hanging
in fn_hash_delete, not fn_hash_insert. I'll try Andrew's suggestion
later today when I get home.
Thanks

