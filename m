Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbVC2Kip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbVC2Kip (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 05:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbVC2Khf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 05:37:35 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:63501 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262333AbVC2KgO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 05:36:14 -0500
Date: Tue, 29 Mar 2005 20:35:04 +1000
To: "Artem B. Bityuckiy" <dedekind@infradead.org>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, jmorris@redhat.com
Subject: Re: [RFC] CryptoAPI & Compression
Message-ID: <20050329103504.GA19468@gondor.apana.org.au>
References: <1111766900.4566.20.camel@sauron.oktetlabs.ru> <20050326044421.GA24358@gondor.apana.org.au> <1112030556.17983.35.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112030556.17983.35.camel@sauron.oktetlabs.ru>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artem:

On Mon, Mar 28, 2005 at 05:22:36PM +0000, Artem B. Bityuckiy wrote:
> 
> The first patch is the implementation of the deflate_pcompress()

Thanks for the patch.  I'll comment on the second patch later.

Are you sure that 12 bytes is enough for all cases? It would seem
to be safer to use the formula in deflateBound/compressBound from
later versions (> 1.2) of zlib to calculate the reserve.

> +	while (stream->total_in < *slen
> +	       && stream->total_out < *dlen - DEFLATE_PCOMPR_RESERVE) {

We normally put the operator on the preceding line, i.e.,

while (foo &&
       bar) {

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
