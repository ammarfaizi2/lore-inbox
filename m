Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVFTAue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVFTAue (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 20:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbVFTAue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 20:50:34 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:14865 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261358AbVFTAu3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 20:50:29 -0400
Date: Mon, 20 Jun 2005 10:50:08 +1000
To: "David S. Miller" <davem@davemloft.net>
Cc: kaber@trash.net, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netfilter-devel@manty.net,
       ebtables-devel@lists.sourceforge.net, rankincj@yahoo.com
Subject: Re: 2.6.12: connection tracking broken?
Message-ID: <20050620005008.GA7760@gondor.apana.org.au>
References: <42B56D9B.9070401@trash.net> <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au> <20050619.171813.104659699.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050619.171813.104659699.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2005 at 05:18:13PM -0700, David S. Miller wrote:
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Date: Mon, 20 Jun 2005 10:05:42 +1000
>
> > Why does it defer them at all? Shouldn't the fact that the device is
> > bridged be transparent to the IP layer?
> 
> The bridge netfilter layer uses netif_rx(skb) at the deepest level in
> order to avoid too deep stack usage.

Sorry, but I don't see the connection between this and deferring
NF_IP_* hooks on the transmit path.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
