Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVDZNRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVDZNRq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 09:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVDZNRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 09:17:46 -0400
Received: from [62.206.217.67] ([62.206.217.67]:52909 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261506AbVDZNRn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 09:17:43 -0400
Message-ID: <426E3F67.8090006@trash.net>
Date: Tue, 26 Apr 2005 15:17:27 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Yair@arx.com, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@oss.sgi.com
Subject: Re: Re-routing packets via netfilter (ip_rt_bug)
References: <E1DQ1Ct-00055s-00@gondolin.me.apana.org.au> <426D0CB9.4060500@trash.net> <20050425213400.GB29288@gondor.apana.org.au> <426D8672.1030001@trash.net> <20050426003925.GA13650@gondor.apana.org.au>
In-Reply-To: <20050426003925.GA13650@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> Makes sense.  But what about the case where saddr is foreign but
> daddr is broadcast/multicast?

Looks like we have no choice but to also use saddr=0 and
ip_route_output() in this case.

Regards
Patrick
