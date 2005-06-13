Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVFMIKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVFMIKs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 04:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVFMIKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 04:10:48 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:50700 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261421AbVFMIKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 04:10:42 -0400
Date: Mon, 13 Jun 2005 10:10:26 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: davem@davemloft.net, xschmi00@stud.feec.vutbr.cz, alastair@unixtrix.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.)
Message-ID: <20050613081025.GA13407@alpha.home.local>
References: <20050612131323.GA10188@gondor.apana.org.au> <20050612133349.GA6279@gondor.apana.org.au> <20050612134725.GB8951@alpha.home.local> <20050612135018.GA10910@gondor.apana.org.au> <20050612142401.GA10772@alpha.home.local> <20050613044810.GA32103@gondor.apana.org.au> <20050613052148.GF8907@alpha.home.local> <20050613052404.GA7611@gondor.apana.org.au> <20050613061748.GA13144@alpha.home.local> <20050613074521.GA21661@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050613074521.GA21661@gondor.apana.org.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 05:45:21PM +1000, Herbert Xu wrote:
> On Mon, Jun 13, 2005 at 08:17:48AM +0200, Willy Tarreau wrote:
> > 
> > What's the problem with the sysctl ? If you prefer, I can change the patch
> > to keep the feature enabled by default so that only people aware of the
> > problem have to fix it by hand. But I found it better the other way : people
> > who need the feature enable it by hand.
> 
> Well that's exactly my problem :)
> 
> I reckon it should be off by default because the threat posed by
> this problem is IMHO small compared to some of the other standard
> threats that are applicable to TCP.  Plus this is a well-documented
> feature so we can't be sure that someone somewhere isn't depending
> on it.
> 
> However, if it were off by default then there is very little value
> in providing it at all since the same thing can be achived easily
> through netfilter.

I understand your point of view.

> Anyway, let's leave it to Dave to make the decision.

At least, he has enough elements in his mailbox now :-)

Cheers,
Willy

