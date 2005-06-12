Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbVFLNRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbVFLNRN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 09:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbVFLNRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 09:17:12 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:54278 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262476AbVFLNQ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 09:16:57 -0400
Date: Sun, 12 Jun 2005 23:16:24 +1000
To: Thomas Graf <tgraf@suug.ch>
Cc: Willy Tarreau <willy@w.ods.org>, davem@davemloft.net,
       xschmi00@stud.feec.vutbr.cz, alastair@unixtrix.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.)
Message-ID: <20050612131624.GB10188@gondor.apana.org.au>
References: <20050611074350.GD28759@alpha.home.local> <E1DhBic-0005dp-00@gondolin.me.apana.org.au> <20050611195144.GF28759@alpha.home.local> <20050612081327.GA24384@gondor.apana.org.au> <20050612083409.GA8220@alpha.home.local> <20050612103020.GA25111@gondor.apana.org.au> <20050612114039.GI28759@alpha.home.local> <20050612120627.GA5858@gondor.apana.org.au> <20050612122247.GB22463@postel.suug.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050612122247.GB22463@postel.suug.ch>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 02:22:47PM +0200, Thomas Graf wrote:
>
> > Look at the first check inside th->ack in tcp_rcv_synsent_state_process.
> 
> Usually a continious flow of ACK+RST is used to prevent a connection
> from being established, it's more reliable because even if you hit the
> ISS+rcv_next window the connection attempt will still be reset.

Sure.  My point is that there are a hundred and one ways to attack
a TCP connection in a manner similar to the original method that
started this thread.  So fixes like this are pretty pointless.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
