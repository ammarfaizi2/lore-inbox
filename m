Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVBFKzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVBFKzj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 05:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbVBFKzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 05:55:35 -0500
Received: from mail1.skjellin.no ([80.239.42.67]:1171 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S261152AbVBFKzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 05:55:25 -0500
Message-ID: <4205F797.8080804@tomt.net>
Date: Sun, 06 Feb 2005 11:55:19 +0100
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>,
       mirko.parthey@informatik.tu-chemnitz.de, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, yoshfuji@linux-ipv6.org, shemminger@osdl.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
References: <20050131162201.GA1000@stilzchen.informatik.tu-chemnitz.de> <20050205052407.GA17266@gondor.apana.org.au> <20050204213813.4bd642ad.davem@davemloft.net> <20050205061110.GA18275@gondor.apana.org.au>
In-Reply-To: <20050205061110.GA18275@gondor.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> On Fri, Feb 04, 2005 at 09:38:13PM -0800, David S. Miller wrote:
> 
>>It is just the first such thing I found, scanning rt6i_idev uses
>>will easily find several others.
> 
> 
> You're right of course.  I thought they were all harmless but I was
> obviously wrong about this one.
> 
> So here is a patch that essentially reverts the split devices
> semantics introduced by these two changesets:
> 
>   [IPV6] addrconf_dst_alloc() to allocate new route for local address.
>   [IPV6] take rt6i_idev into account when looking up routes.
> 
> Signed-off-by: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>

Now that this fix have been written off as probably wrong; how much does 
it break? As far as I've understood it "just" reverts to old semantics, 
probably not correct semantics, but still not unexpected semantics 
(like, say, hang on device unregistration ;) )

I'm contemplating just using it as a quick-fix until 2.6.11 to get this 
problem under control.
