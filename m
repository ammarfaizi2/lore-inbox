Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965207AbWGKEzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965207AbWGKEzr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbWGKEzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:55:47 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:42504 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S965207AbWGKEzq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:55:46 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Subject: Re: [ACRYPTO] new release of asynchronous crrypto layer.
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Organization: Core
In-Reply-To: <20060710091353.GA19863@2ka.mipt.ru>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1G0AHY-0002BE-00@gondolin.me.apana.org.au>
Date: Tue, 11 Jul 2006 14:55:36 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evgeniy:

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
> * IPsec ESP4 port to acrypto

I noticed a bug in the ESP IV processing.  When you do ESP asynchronously,
you can no longer use the last block of the previous packet as the IV of
the next.  This is because the next packet may have started processing
before the last packet has even been finalised.

A simple solution is to generate a random IV.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
