Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVBFVDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVBFVDE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 16:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVBFVDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 16:03:04 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:35076 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261318AbVBFVDB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 16:03:01 -0500
Date: Mon, 7 Feb 2005 08:01:50 +1100
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: davem@davemloft.net, mirko.parthey@informatik.tu-chemnitz.de,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, shemminger@osdl.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
Message-ID: <20050206210150.GA24206@gondor.apana.org.au>
References: <20050205064643.GA29758@gondor.apana.org.au> <20050205104559.GA30981@gondor.apana.org.au> <20050206114145.GA20883@gondor.apana.org.au> <20050206.213018.92031627.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206.213018.92031627.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 09:30:18PM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:
> 
> How about this; Ignore entries addrconf_dst_alloc'ed entries in rt6_ifdown()?

Great, that definitely fixes the local address problem.

I'm not sure about anycast routes though.  Who's going to delete them
when the real device goes down?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
