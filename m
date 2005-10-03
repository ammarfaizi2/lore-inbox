Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVJCASk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVJCASk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 20:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbVJCASk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 20:18:40 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:42507 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932082AbVJCASj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 20:18:39 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: yzcorp@gmail.com (Yan Zheng)
Subject: Re: [PATCH] fix ipv6 fragment ID selection at slow path
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, roque@di.fc.ul.pt
Organization: Core
In-Reply-To: <433FED06.8070806@gmail.com>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EME2E-0006dR-00@gondolin.me.apana.org.au>
Date: Mon, 03 Oct 2005 10:18:26 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yan Zheng <yzcorp@gmail.com> wrote:
> 
> --- linux-2.6.13.2/net/ipv6/ip6_output.c        2005-09-17 09:02:12.000000000 +0800
> +++ linux/net/ipv6/ip6_output.c 2005-10-02 22:12:54.000000000 +0800
> @@ -701,7 +701,7 @@
>                 */
>                fh->nexthdr = nexthdr;
>                fh->reserved = 0;
> -               if (frag_id) {
> +               if (!frag_id) {
>                        ipv6_select_ident(skb, fh);
>                        frag_id = fh->identification;
>                } else

This patch makes sense to me.

Please add a Signed-off-by line and send the patch to
davem@davemloft.net and yoshfuji@linux-ipv6.org.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
