Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262246AbVBBKxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbVBBKxF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 05:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVBBKwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 05:52:44 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:45064 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262231AbVBBKwi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 05:52:38 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: agruen@suse.de (Andreas Gruenbacher)
Subject: Re: [PATCH 1/8] lib/sort: Heapsort implementation of sort()
Cc: mpm@selenic.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <1107191783.21706.124.camel@winden.suse.de>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CwI5w-0000mJ-00@gondolin.me.apana.org.au>
Date: Wed, 02 Feb 2005 21:50:48 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher <agruen@suse.de> wrote:
> 
> static inline void swap(void *a, void *b, int size)
> {
>        if (size % sizeof(long)) {
>                char t;
>                do {
>                        t = *(char *)a;
>                        *(char *)a++ = *(char *)b;
>                        *(char *)b++ = t;
>                } while (--size > 0);
>        } else {
>                long t;
>                do {
>                        t = *(long *)a;
>                        *(long *)a = *(long *)b;
>                        *(long *)b = t;
>                        size -= sizeof(long);
>                } while (size > sizeof(long));
>        }
> }

What if a/b aren't aligned?
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
