Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268025AbUIGMrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268025AbUIGMrA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 08:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268024AbUIGMq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 08:46:59 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:63760 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S268019AbUIGMqv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 08:46:51 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: util@deuroconsult.ro (Catalinux aka Dino BOIE)
Subject: Re: [PATCH] Trivial fix for out of bounds array access in xfrm4_policy_check
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <Pine.LNX.4.61.0409071322100.8637@hosting.rdsbv.ro>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.26-1-686-smp (i686))
Message-Id: <E1C4fMc-000817-00@gondolin.me.apana.org.au>
Date: Tue, 07 Sep 2004 22:46:22 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Catalinux aka Dino BOIE <util@deuroconsult.ro> wrote:
> 
> Coverity found a bug in accessing xfrm4_policy_check using XFRM_POLICY_FWD 
> (=2) as index in sk->sk_policy.
> 
> sk->sk_policy[] is defined in sock.h as:
> 
> struct xfrm_policy *sk_policy[2];
> 
> Attached is the fix.

This is bogus as if the packet is forwarded then sk == NULL.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
