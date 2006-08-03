Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbWHCX7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWHCX7k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 19:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWHCX7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 19:59:40 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:12296 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1030233AbWHCX7j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 19:59:39 -0400
Date: Fri, 4 Aug 2006 09:59:27 +1000
To: David Miller <davem@davemloft.net>
Cc: tytso@mit.edu, mchan@broadcom.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
Message-ID: <20060803235927.GB10932@gondor.apana.org.au>
References: <20060803201741.GA7894@thunk.org> <20060803.144845.66061203.davem@davemloft.net> <20060803235326.GC7894@thunk.org> <20060803.165654.45876296.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803.165654.45876296.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 04:56:54PM -0700, David Miller wrote:
> 
> As Michael explained, it's the ASF heartbeat sent by tg3_timer() that
> must be delivered to the chip within certain timing constraints.
> 
> If you had any watchdog devices on this machine, they would likely
> trigger too and reset your machine :)

Watchdogs usually require one heartbeat every 30 seconds or so.  Does
the ASF heartbeat need to be that frequent?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
