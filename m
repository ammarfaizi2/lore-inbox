Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933394AbWF0JiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933394AbWF0JiI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbWF0JiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:38:07 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:35343 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S933396AbWF0JiG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:38:06 -0400
Date: Tue, 27 Jun 2006 19:35:20 +1000
To: Nigel Cunningham <nigel@suspend2.net>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org
Subject: Re: [Suspend2][ 0/2] Cryptoapi deflate fix.
Message-ID: <20060627093520.GA26364@gondor.apana.org.au>
References: <E1Fv6cg-000617-00@gondolin.me.apana.org.au> <200606271702.49408.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606271702.49408.nigel@suspend2.net>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 05:02:46PM +1000, Nigel Cunningham wrote:
> 
> Ok. Sorry for my wonky memory then :)

No problems.

> Yes, I'm always feeding it PAGE_SIZE chunks and compressing each page 
> separately. It's a long time since I looked at or thought about this, so I'll 
> spend some more time getting it fresh in my head if you like.

If you could give me a minimal test case to work with that'd be great.

> I just left Marc's original code as it was, so I'm not completely sure, but I 
> guess it's because we want lowmem.

The question is why do you need lowmem? It doesn't appear to be obvious
by looking at the code.

> > This is a double-free of local_buffer.
> 
> Is that from our previous correspondence? I can't find anything like it now.

Yes, that was from a year ago before you fixed the code :) Feel free to
resubmit this once you've addressed the vmalloc question.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
