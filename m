Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVFMFZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVFMFZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 01:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVFMFZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 01:25:25 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:22282 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261369AbVFMFY3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 01:24:29 -0400
Date: Mon, 13 Jun 2005 15:24:04 +1000
To: Willy Tarreau <willy@w.ods.org>
Cc: davem@davemloft.net, xschmi00@stud.feec.vutbr.cz, alastair@unixtrix.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.)
Message-ID: <20050613052404.GA7611@gondor.apana.org.au>
References: <20050612114039.GI28759@alpha.home.local> <20050612120627.GA5858@gondor.apana.org.au> <20050612123253.GK28759@alpha.home.local> <20050612131323.GA10188@gondor.apana.org.au> <20050612133349.GA6279@gondor.apana.org.au> <20050612134725.GB8951@alpha.home.local> <20050612135018.GA10910@gondor.apana.org.au> <20050612142401.GA10772@alpha.home.local> <20050613044810.GA32103@gondor.apana.org.au> <20050613052148.GF8907@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050613052148.GF8907@alpha.home.local>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 07:21:48AM +0200, Willy Tarreau wrote:
> 
> > A much better place to do that is netfilter.  If you do it there
> > then not only will your protect all Linux machines from this attack,
> > but you'll also protect all the other BSD-derived TCP stacks.
> 
> Netfilter already blocks simultaneous connection. A SYN in return to
> a SYN produces an INVALID state.

Any reason why that isn't enough?
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
