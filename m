Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVD0BIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVD0BIB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 21:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVD0BIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 21:08:00 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:9480 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261875AbVD0BH5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 21:07:57 -0400
Date: Wed, 27 Apr 2005 11:07:30 +1000
To: Patrick McHardy <kaber@trash.net>
Cc: Yair@arx.com, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@oss.sgi.com
Subject: Re: Re-routing packets via netfilter (ip_rt_bug)
Message-ID: <20050427010730.GA18919@gondor.apana.org.au>
References: <E1DQ1Ct-00055s-00@gondolin.me.apana.org.au> <426D0CB9.4060500@trash.net> <20050425213400.GB29288@gondor.apana.org.au> <426D8672.1030001@trash.net> <20050426003925.GA13650@gondor.apana.org.au> <426E3F67.8090006@trash.net> <20050426232857.GA18358@gondor.apana.org.au> <426EE350.1070902@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426EE350.1070902@trash.net>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 02:56:48AM +0200, Patrick McHardy wrote:
> 
> The ipt_REJECT target can send TCP RSTs with foreign source which
> go through LOCAL_OUT. Restricting it to this case and adding proper

Couldn't we feed the TCP RST packets with foreign sources through
the FORWARD table? We're lying to the routing system already by
telling it that the packet is forwarded.  So I don't see anything
wrong with lying to netfilter as well :)

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
