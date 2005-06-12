Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbVFLMG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbVFLMG5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 08:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVFLMG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 08:06:57 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:32518 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262229AbVFLMG4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 08:06:56 -0400
Date: Sun, 12 Jun 2005 22:06:27 +1000
To: Willy Tarreau <willy@w.ods.org>
Cc: davem@davemloft.net, xschmi00@stud.feec.vutbr.cz, alastair@unixtrix.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.)
Message-ID: <20050612120627.GA5858@gondor.apana.org.au>
References: <20050611074350.GD28759@alpha.home.local> <E1DhBic-0005dp-00@gondolin.me.apana.org.au> <20050611195144.GF28759@alpha.home.local> <20050612081327.GA24384@gondor.apana.org.au> <20050612083409.GA8220@alpha.home.local> <20050612103020.GA25111@gondor.apana.org.au> <20050612114039.GI28759@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050612114039.GI28759@alpha.home.local>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 01:40:39PM +0200, Willy Tarreau wrote:
>
> Sorry Herbert, but both RFC793 page 32 figure 9 and my Linux box disagree
> with this statement. Look: at line 5, A rejects the SYN-ACK because the
> ACK is wrong during the session setup.

Look at the first check inside th->ack in tcp_rcv_synsent_state_process.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
