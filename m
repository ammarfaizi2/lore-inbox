Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265032AbVBELYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265032AbVBELYj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 06:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVBELQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 06:16:51 -0500
Received: from mail1.skjellin.no ([80.239.42.67]:64200 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S266484AbVBELOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 06:14:08 -0500
Message-ID: <4204AA7C.9010509@tomt.net>
Date: Sat, 05 Feb 2005 12:14:04 +0100
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
<..>

This patch fixes my problems with hangs when dot1q VLAN interfaces gets 
removed when loopback is down, as reported in the thread "2.6.10 
ipv6/8021q lockup on vconfig on interface removal".

Yay :)
