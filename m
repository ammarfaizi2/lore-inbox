Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWFLHEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWFLHEc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 03:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWFLHEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 03:04:32 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:39954 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751409AbWFLHEb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 03:04:31 -0400
Date: Mon, 12 Jun 2006 17:03:56 +1000
To: Ingo Molnar <mingo@elte.hu>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, Valdis.Kletnieks@vt.edu,
       Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>,
       arjan@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch] undo AF_UNIX _bh locking changes and split lock-type instead
Message-ID: <20060612070356.GA1273@gondor.apana.org.au>
References: <200606060250.k562oCrA004583@turing-police.cc.vt.edu> <44852819.2080503@gmail.com> <4485798B.4030007@s5r6.in-berlin.de> <4485AFB9.3040005@s5r6.in-berlin.de> <20060607071208.GA1951@gondor.apana.org.au> <20060612063807.GA23939@elte.hu> <20060612064122.GA1101@gondor.apana.org.au> <20060612065701.GA24213@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060612065701.GA24213@elte.hu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 08:57:01AM +0200, Ingo Molnar wrote:
>
> regarding your point wrt. path of integration - it is pretty much the 
> only practical way to do this centrally as part of the lock validator 
> patches, but to collect ACKs from subsystem maintainers in the process. 
> So if you like it i'd like to have your ACK but this patch depends on 
> the other lock validator patches (and only makes sense together with 
> them), so they should temporarily stay in the lock validator queue. 
> Hopefully this wont be a state that lasts too long and once the 
> validator is upstream, all patches of course go via the subsystem 
> submission rules.

Obviously as long as Dave is happy with it then it's fine.  However,
it's probably a good idea to cc netdev for relevant patches so that
they get a wider review.  If you've already sent this one there then
I apologise for missing it :)

> (the #ifdef LOCKDEP should probably be converted to some sort of 
> lockdep_split_lock_key(&sk->sk_receive_queue.lock) op - i'll do that 
> later)

Cool.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
