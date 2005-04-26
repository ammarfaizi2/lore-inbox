Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVDZAjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVDZAjr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 20:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVDZAjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 20:39:47 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:57612 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261202AbVDZAjo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 20:39:44 -0400
Date: Tue, 26 Apr 2005 10:39:25 +1000
To: Patrick McHardy <kaber@trash.net>
Cc: Yair@arx.com, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@oss.sgi.com
Subject: Re: Re-routing packets via netfilter (ip_rt_bug)
Message-ID: <20050426003925.GA13650@gondor.apana.org.au>
References: <E1DQ1Ct-00055s-00@gondolin.me.apana.org.au> <426D0CB9.4060500@trash.net> <20050425213400.GB29288@gondor.apana.org.au> <426D8672.1030001@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426D8672.1030001@trash.net>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 02:08:18AM +0200, Patrick McHardy wrote:
> Herbert Xu wrote:
> >You're right.  But then we can't call ip_route_output in the case
> >where saddr is foreign but daddr is local.  Nor can we call
> >ip_route_input since the output will be ip_rt_bug.
> 
> In that case we need to use saddr=0, which shouldn't make any difference
> with sane routing.

Makes sense.  But what about the case where saddr is foreign but
daddr is broadcast/multicast?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
