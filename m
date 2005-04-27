Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVD0K0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVD0K0X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 06:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVD0K0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 06:26:23 -0400
Received: from [62.206.217.67] ([62.206.217.67]:5518 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261368AbVD0K0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 06:26:20 -0400
Message-ID: <426F68C5.4010109@trash.net>
Date: Wed, 27 Apr 2005 12:26:13 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Yair@arx.com, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@oss.sgi.com
Subject: Re: Re-routing packets via netfilter (ip_rt_bug)
References: <E1DQ1Ct-00055s-00@gondolin.me.apana.org.au> <426D0CB9.4060500@trash.net> <20050425213400.GB29288@gondor.apana.org.au> <426D8672.1030001@trash.net> <20050426003925.GA13650@gondor.apana.org.au> <426E3F67.8090006@trash.net> <20050426232857.GA18358@gondor.apana.org.au> <426EE350.1070902@trash.net> <20050427010730.GA18919@gondor.apana.org.au>
In-Reply-To: <20050427010730.GA18919@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> Couldn't we feed the TCP RST packets with foreign sources through
> the FORWARD table? We're lying to the routing system already by
> telling it that the packet is forwarded.  So I don't see anything
> wrong with lying to netfilter as well :)

Forwarded packets can't have any NAT manips in LOCAL_OUT, so it
should work. I'm not sure about it though because it would be
the only place where packets just appear in FORWARD, usually
all packets enters through PRE_ROUTING or LOCAL_OUT.

Regards
Patrick
