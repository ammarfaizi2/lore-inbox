Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbUKDUwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbUKDUwy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbUKDUt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:49:58 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:44039 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262410AbUKDUrQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:47:16 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: kaber@trash.net (Patrick McHardy)
Subject: Re: [BK PATCH] Fix ip_conntrack_amanda data corruption bug that breaks amanda dumps
Cc: matthias.andree@gmx.de, netfilter-devel@lists.netfilter.org,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <418A7B0B.7040803@trash.net>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.net
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CPoUT-0000sk-00@gondolin.me.apana.org.au>
Date: Fri, 05 Nov 2004 07:45:53 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy <kaber@trash.net> wrote:
>
> The data that is changed is only a copy, the actual packet is not touched.

Does it call skb_ip_make_writable anywhere? If not then it may be
shared/cloned and can't be written at all.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
