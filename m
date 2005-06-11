Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVFKTgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVFKTgL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 15:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVFKTgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 15:36:08 -0400
Received: from goliath.apana.org.au ([202.12.88.44]:15790 "EHLO
	goliath.apana.org.au") by vger.kernel.org with ESMTP
	id S261783AbVFKTc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 15:32:59 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: willy@w.ods.org (Willy Tarreau)
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.)
Cc: davem@davemloft.net, xschmi00@stud.feec.vutbr.cz, alastair@unixtrix.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Organization: Core
In-Reply-To: <20050611074350.GD28759@alpha.home.local>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DhBic-0005dp-00@gondolin.me.apana.org.au>
Date: Sun, 12 Jun 2005 05:32:34 +1000
X-SA-Exim-Connect-IP: 203.14.152.115
X-SA-Exim-Mail-From: herbert@gondor.apana.org.au
X-SA-Exim-Scanned: No (on goliath.apana.org.au); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <willy@w.ods.org> wrote:
> 
> During this, the client cannot connect to www.kernel.org from this port
> anymore :
>  wks$ printf "HEAD / HTTP/1.0\r\n\r\n" | nc -p 10000 204.152.191.5 80; echo "ret=$?"
>  ret=1

What if you let the client connect from a random port which is what it
should do?
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
