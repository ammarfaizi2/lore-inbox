Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVFMHqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVFMHqD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 03:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVFMHqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 03:46:03 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:56330 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261417AbVFMHpx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 03:45:53 -0400
Date: Mon, 13 Jun 2005 17:45:21 +1000
To: Willy Tarreau <willy@w.ods.org>
Cc: davem@davemloft.net, xschmi00@stud.feec.vutbr.cz, alastair@unixtrix.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.)
Message-ID: <20050613074521.GA21661@gondor.apana.org.au>
References: <20050612123253.GK28759@alpha.home.local> <20050612131323.GA10188@gondor.apana.org.au> <20050612133349.GA6279@gondor.apana.org.au> <20050612134725.GB8951@alpha.home.local> <20050612135018.GA10910@gondor.apana.org.au> <20050612142401.GA10772@alpha.home.local> <20050613044810.GA32103@gondor.apana.org.au> <20050613052148.GF8907@alpha.home.local> <20050613052404.GA7611@gondor.apana.org.au> <20050613061748.GA13144@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050613061748.GA13144@alpha.home.local>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 08:17:48AM +0200, Willy Tarreau wrote:
> 
> What's the problem with the sysctl ? If you prefer, I can change the patch
> to keep the feature enabled by default so that only people aware of the
> problem have to fix it by hand. But I found it better the other way : people
> who need the feature enable it by hand.

Well that's exactly my problem :)

I reckon it should be off by default because the threat posed by
this problem is IMHO small compared to some of the other standard
threats that are applicable to TCP.  Plus this is a well-documented
feature so we can't be sure that someone somewhere isn't depending
on it.

However, if it were off by default then there is very little value
in providing it at all since the same thing can be achived easily
through netfilter.

Anyway, let's leave it to Dave to make the decision.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
