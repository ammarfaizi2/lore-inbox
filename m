Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVDCIqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVDCIqX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 04:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVDCIqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 04:46:23 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:35592 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261602AbVDCIqS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 04:46:18 -0400
Date: Sun, 3 Apr 2005 18:44:15 +1000
To: "Artem B. Bityuckiy" <dedekind@yandex.ru>
Cc: "Artem B. Bityuckiy" <dedekind@infradead.org>, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
Message-ID: <20050403084415.GA20326@gondor.apana.org.au>
References: <E1DGxa7-0000GH-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0504011534460.9305@phoenix.infradead.org> <20050401152325.GB4150@gondor.apana.org.au> <Pine.LNX.4.58.0504011640340.9305@phoenix.infradead.org> <20050401221303.GA6557@gondor.apana.org.au> <424FA7B4.6050008@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424FA7B4.6050008@yandex.ru>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2005 at 12:22:12PM +0400, Artem B. Bityuckiy wrote:
> 
> The latter case is possible if the input isn't compressible and it is up 
> to user to detect that handle this situation properly (i.e., just not to 
> compress this). So, IMO, there are no problems here at least for the 
> crypto_comp_pcompress() function.

Surely that defeats the purpose of pcompress? I thought the whole point
was to compress as much of the input as possible into the output?

So 1G into 1G doesn't make sense here.  But 1G into 1M does and you
want to put as much as you can in there.  Otherwise we might as well
delete crypto_comp_pcompress :)
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
