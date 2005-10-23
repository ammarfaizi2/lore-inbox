Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbVJWHar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbVJWHar (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 03:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbVJWHaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 03:30:46 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:15622 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751422AbVJWHaq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 03:30:46 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: reuben-lkml@reub.net (Reuben Farrelly)
Subject: [0/3] Fix timer bugs in neighbour cache
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       acme@conectiva.com.br, davem@davemloft.net, greearb@candelatech.com
Organization: Core
In-Reply-To: <43534273.2050106@reub.net>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1ETaJB-0004a0-00@gondolin.me.apana.org.au>
Date: Sun, 23 Oct 2005 17:30:21 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
> 
> Oct 17 18:49:40 tornado kernel: NEIGH: BUG, double timer add, state is 1
> Oct 17 18:51:04 tornado last message repeated 3 times
> Oct 17 18:52:05 tornado last message repeated 5 times
> Oct 17 18:52:11 tornado last message repeated 2 times

Excellent.  Looks like we actually caught something.  Pity we don't have
a stack trace which means that there might be more bugs.

Anyway, here are three patches which should fix this.  This should go
into 2.6.14.

Arnaldo, you can pull them from

master.kernel.org:/pub/scm/linux/kernel/git/herbert/net-2.6.git

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
