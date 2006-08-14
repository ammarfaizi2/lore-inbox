Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752017AbWHNMwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbWHNMwU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 08:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbWHNMwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 08:52:20 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:20996 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1752017AbWHNMwT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 08:52:19 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: riel@redhat.com (Rik van Riel)
Subject: Re: [RFC][PATCH 0/4] VM deadlock prevention -v4
Cc: johnpol@2ka.mipt.ru, phillips@google.com, a.p.zijlstra@chello.nl,
       indan@nul.nu, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, davem@davemloft.net
Organization: Core
In-Reply-To: <44E06AC7.6090301@redhat.com>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1GCbux-0005CO-00@gondolin.me.apana.org.au>
Date: Mon, 14 Aug 2006 22:51:43 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:
> 
> That should not be any problem, since skb's (including cowed ones)
> are short lived anyway.  Allocating a little bit more memory is
> fine when we have a guarantee that the memory will be freed again
> shortly.

I'm not sure about the context the comment applies to, but skb's are
not necessarily short-lived.  For example, they could be queued for
a few seconds for ARP/NDISC and even longer for IPsec SA resolution.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
