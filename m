Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWGKXUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWGKXUD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 19:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWGKXUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 19:20:02 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:57615 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932099AbWGKXUA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 19:20:00 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: johnstul@us.ibm.com (john stultz)
Subject: Re: [BUG] Two BUG warnings in net/core/dev.c
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Organization: Core
In-Reply-To: <1152659106.5364.7.camel@localhost>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1G0RWA-0001m9-00@gondolin.me.apana.org.au>
Date: Wed, 12 Jul 2006 09:19:50 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> wrote:
> Both of these were seen on my laptop w/ the current (as of this writing)
> -git tree using the e1000 driver after a suspend/resume cycle.

It's just a reminder that we need to fix NAT to update checksums
incrementally.  You'll only see it once per boot.

> BUG: warning at net/core/dev.c:1171/skb_checksum_help()
> [<c0103d69>] show_trace_log_lvl+0x149/0x170
> [<c01052bb>] show_trace+0x1b/0x20
> [<c01052e4>] dump_stack+0x24/0x30
> [<c03c7523>] skb_checksum_help+0x163/0x170
> [<c0439c15>] ip_nat_fn+0x1a5/0x210

Of course, if anyone sees it with a backtrace that does not contain
ip_nat_fn, please let us know.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
