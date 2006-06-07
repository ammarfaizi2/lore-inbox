Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWFGHNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWFGHNW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 03:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWFGHNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 03:13:22 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:8964 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751082AbWFGHNV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 03:13:21 -0400
Date: Wed, 7 Jun 2006 17:12:08 +1000
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Valdis.Kletnieks@vt.edu, Jiri Slaby <jirislaby@gmail.com>,
       Andrew Morton <akpm@osdl.org>, arjan@infradead.org, mingo@redhat.com,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.17-rc5-mm3-lockdep -
Message-ID: <20060607071208.GA1951@gondor.apana.org.au>
References: <200606060250.k562oCrA004583@turing-police.cc.vt.edu> <44852819.2080503@gmail.com> <4485798B.4030007@s5r6.in-berlin.de> <4485AFB9.3040005@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4485AFB9.3040005@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2006 at 04:39:21PM +0000, Stefan Richter wrote:
> 
> BTW, the locking in -mm's net/unix/af_unix.c::unix_stream_connect() 
> differs a bit from stock unix_stream_connect(). I see spin_lock_bh() in 
> 2.6.17-rc5-mm3 where 2.6.17-rc5 has spin_lock().

Hi Ingo:

Looks like this change was introduced by the validator patch.  Any idea
why this was done? AF_UNIX is a user-space-driven socket so there shouldn't
be any need for BH to be disabled there.

Even if it does this patch should go through the normal channels rather
than the lock validator.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
