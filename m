Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVDCLla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVDCLla (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 07:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVDCLla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 07:41:30 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:23051 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261684AbVDCLlZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 07:41:25 -0400
Date: Sun, 3 Apr 2005 21:40:45 +1000
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Artem B. Bityuckiy" <dedekind@yandex.ru>,
       "Artem B. Bityuckiy" <dedekind@infradead.org>,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
Message-ID: <20050403114045.GA21255@gondor.apana.org.au>
References: <20050401221303.GA6557@gondor.apana.org.au> <424FA7B4.6050008@yandex.ru> <20050403084415.GA20326@gondor.apana.org.au> <424FB06B.3060607@yandex.ru> <20050403093044.GA20608@gondor.apana.org.au> <424FBB56.5090503@yandex.ru> <20050403100043.GA20768@gondor.apana.org.au> <1112522762.3899.182.camel@localhost.localdomain> <20050403101752.GA20866@gondor.apana.org.au> <1112527158.3899.213.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112527158.3899.213.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2005 at 12:19:17PM +0100, David Woodhouse wrote:
> 
> But now we're not using Z_SYNC_FLUSH it doesn't matter if we feed the
> input in smaller chunks. We can calculate a conservative estimate of the
> amount we'll fit, and keep feeding it input till the amount of space
> left in the output buffer is 12 bytes.

Yes that's what we should do.  In fact newer versions of zlib carries
a deflateBound function which we can invert to calculate the conservative
estimate.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
