Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758777AbWK2Ei6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758777AbWK2Ei6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 23:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758783AbWK2Ei6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 23:38:58 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:20494 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1758785AbWK2Ei5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 23:38:57 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: davem@davemloft.net (David Miller)
Subject: Re: Broken commit: [NETFILTER]: ipt_REJECT: remove largely duplicate route_reverse function
Cc: kaber@trash.net, khc@pm.waw.pl, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, netfilter-devel@lists.netfilter.org
Organization: Core
In-Reply-To: <20061128.202535.112619392.davem@davemloft.net>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev,apana.lists.os.linux.netfilter.devel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1GpHDJ-00059y-00@gondolin.me.apana.org.au>
Date: Wed, 29 Nov 2006 15:38:29 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> wrote:
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 9264139..95e86ac 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -94,7 +94,9 @@ #endif
> #endif
> 
> #if !defined(CONFIG_NET_IPIP) && \
> -    !defined(CONFIG_IPV6) && !defined(CONFIG_IPV6_MODULE)
> +    !defined(CONFIG_NET_IPGRE) && \
> +    !defined(CONFIG_IPV6_SIT) && \
> +    !defined(CONFIG_IPV6_TUNNEL)
> #define MAX_HEADER LL_MAX_HEADER
> #else
> #define MAX_HEADER (LL_MAX_HEADER + 48)

What if ipip/gre are modules?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
