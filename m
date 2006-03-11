Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752327AbWCKCvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbWCKCvj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 21:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWCKCvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 21:51:39 -0500
Received: from CyborgDefenseSystems.Corporatebeast.com ([64.62.148.172]:47886
	"EHLO arnor.apana.org.au") by vger.kernel.org with ESMTP
	id S1751541AbWCKCvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 21:51:38 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: bunk@stusta.de (Adrian Bunk)
Subject: Re: [2.6 patch] net/decnet/dn_route.c: fix inconsequent NULL checking
Cc: patrick@tykepenguin.com, linux-decnet-user@lists.sourceforge.net,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20060310230233.GB21864@stusta.de>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1FHuCW-0005k2-00@gondolin.me.apana.org.au>
Date: Sat, 11 Mar 2006 13:51:28 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
> The Coverity checker noted this inconsequent NULL checking in
> dnrt_drop().
> 
> Since all callers ensure that NULL isn't passed, we can simply remove 
> the check.

Ack.

In fact it's pointless even if the caller didn't check as dst_release
checks it anyway.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
