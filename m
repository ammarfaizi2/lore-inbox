Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbVJAT37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVJAT37 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 15:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbVJAT37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 15:29:59 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:58118 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750772AbVJAT37
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 15:29:59 -0400
Date: Sun, 2 Oct 2005 05:29:34 +1000
To: Suzanne Wood <suzannew@cs.pdx.edu>
Cc: Robert.Olsson@data.slu.se, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, paulmck@us.ibm.com,
       walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] identify in_dev_get rcu read-side critical sections
Message-ID: <20051001192934.GA20741@gondor.apana.org.au>
References: <200510011837.j91IbE01012915@rastaban.cs.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510011837.j91IbE01012915@rastaban.cs.pdx.edu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2005 at 11:37:14AM -0700, Suzanne Wood wrote:
> 
> But the following may be worth considering.
> 
>   > It is also probably good to retain the old __in_dev_get()
> and deprecate it.

I think it's better to get rid of it actually so that if there are
external modules using this they can make sure that they're using
the right function.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
