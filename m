Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVDZAI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVDZAI1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 20:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVDZAI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 20:08:27 -0400
Received: from [62.206.217.67] ([62.206.217.67]:6068 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261177AbVDZAIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 20:08:25 -0400
Message-ID: <426D8672.1030001@trash.net>
Date: Tue, 26 Apr 2005 02:08:18 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Yair@arx.com, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@oss.sgi.com
Subject: Re: Re-routing packets via netfilter (ip_rt_bug)
References: <E1DQ1Ct-00055s-00@gondolin.me.apana.org.au> <426D0CB9.4060500@trash.net> <20050425213400.GB29288@gondor.apana.org.au>
In-Reply-To: <20050425213400.GB29288@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> You're right.  But then we can't call ip_route_output in the case
> where saddr is foreign but daddr is local.  Nor can we call
> ip_route_input since the output will be ip_rt_bug.

In that case we need to use saddr=0, which shouldn't make any difference
with sane routing.

Regards
Patrick
