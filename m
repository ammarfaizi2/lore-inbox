Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVFLIOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVFLIOJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 04:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVFLIOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 04:14:09 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:46597 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261553AbVFLIOG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 04:14:06 -0400
Date: Sun, 12 Jun 2005 18:13:27 +1000
To: Willy Tarreau <willy@w.ods.org>
Cc: davem@davemloft.net, xschmi00@stud.feec.vutbr.cz, alastair@unixtrix.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.)
Message-ID: <20050612081327.GA24384@gondor.apana.org.au>
References: <20050611074350.GD28759@alpha.home.local> <E1DhBic-0005dp-00@gondolin.me.apana.org.au> <20050611195144.GF28759@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050611195144.GF28759@alpha.home.local>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 09:51:44PM +0200, Willy Tarreau wrote:
> 
> Please note that if I only called it "small DoS", it's clearly because
> I don't consider this critical, but I think that most people involved
> in security will find that DoSes based on port guessing should be
> addressed when possible.

Sorry but this patch is pointless.  If I wanted to prevent you from
connecting to www.kernel.org 80 and I knew your source port number
I'd be directly sending you fake SYN-ACK packets which will kill
your connection immediately.

If you want reliability and security you really should be using IPsec.
There is no other way.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
