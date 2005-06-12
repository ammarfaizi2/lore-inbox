Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVFLKbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVFLKbG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 06:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVFLKbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 06:31:06 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:6406 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261933AbVFLKax
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 06:30:53 -0400
Date: Sun, 12 Jun 2005 20:30:20 +1000
To: Willy Tarreau <willy@w.ods.org>
Cc: davem@davemloft.net, xschmi00@stud.feec.vutbr.cz, alastair@unixtrix.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.)
Message-ID: <20050612103020.GA25111@gondor.apana.org.au>
References: <20050611074350.GD28759@alpha.home.local> <E1DhBic-0005dp-00@gondolin.me.apana.org.au> <20050611195144.GF28759@alpha.home.local> <20050612081327.GA24384@gondor.apana.org.au> <20050612083409.GA8220@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050612083409.GA8220@alpha.home.local>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 10:34:09AM +0200, Willy Tarreau wrote:
>
> > Sorry but this patch is pointless.  If I wanted to prevent you from
> > connecting to www.kernel.org 80 and I knew your source port number
> > I'd be directly sending you fake SYN-ACK packets which will kill
> > your connection immediately.
> 
> Only if your ACK was within my SEQ window, which adds about 20 bits of
> random when my initial window is 5840. You would then need to send one
> million times more packets to achieve the same goal.

Nope, no sequence validity check is made on the SYN-ACK.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
