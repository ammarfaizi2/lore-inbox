Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbVA2KKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbVA2KKe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 05:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbVA2KJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 05:09:49 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:8709 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262892AbVA2KIa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 05:08:30 -0500
Date: Sat, 29 Jan 2005 21:06:56 +1100
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: wweissmann@gmx.at, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       davem@davemloft.net, 282492@bugs.debian.org
Subject: Re: multiple neighbour cache tables for AF_INET
Message-ID: <20050129100656.GA13584@gondor.apana.org.au>
References: <24939.1106917237@www31.gmx.net> <E1CueSz-0000lz-00@gondolin.me.apana.org.au> <20050129.074605.78506312.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050129.074605.78506312.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 07:46:05AM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:
> In article <E1CueSz-0000lz-00@gondolin.me.apana.org.au> (at Sat, 29 Jan 2005 09:19:49 +1100), Herbert Xu <herbert@gondor.apana.org.au> says:
> 
> > IMHO you need to give the user a way to specify which table they want
> > to operate on.  If they don't specify one, then the current behaviour
> > of choosing the first table found is reasonble.
> 
> We have dev. Isn't is sufficient?

It could be used for neigh_add/neigh_delete.  We'll need to add a way
to query whether a given table is the right one for a device.

For dump it isn't the same.  However, perhaps it's not too important
to query a specific table.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
