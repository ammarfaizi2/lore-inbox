Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbVDODCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVDODCR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 23:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVDODCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 23:02:17 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:45573 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261725AbVDODCP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 23:02:15 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: juhl-lkml@dif.dk (Jesper Juhl)
Subject: Re: [PATCH] sched: fix never executed code due to expression always false
Cc: nickpiggin@yahoo.com.au, mingo@elte.hu, rml@tech9.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <Pine.LNX.4.62.0504150222390.3466@dragon.hyggekrogen.localhost>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DMH3H-0006Jg-00@gondolin.me.apana.org.au>
Date: Fri, 15 Apr 2005 12:59:27 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
> -               if (unlikely((long long)now - prev->timestamp < 0))
> +               if (unlikely(((long long)now - (long long)prev->timestamp) < 0))

You can write this as

(long long)(now - prev->timestamp)

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
