Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVAaFBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVAaFBm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 00:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVAaFBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 00:01:42 -0500
Received: from [62.206.217.67] ([62.206.217.67]:18333 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261918AbVAaFBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 00:01:39 -0500
Message-ID: <41FDBB78.2050403@trash.net>
Date: Mon, 31 Jan 2005 06:00:40 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050106 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: yoshfuji@linux-ipv6.org
CC: herbert@gondor.apana.org.au, davem@davemloft.net,
       rmk+lkml@arm.linux.org.uk, Robert.Olsson@data.slu.se, akpm@osdl.org,
       torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
References: <41FD2043.3070303@trash.net>	<E1CvSuS-00056x-00@gondolin.me.apana.org.au> <20050131.134559.125426676.yoshfuji@linux-ipv6.org>
In-Reply-To: <20050131.134559.125426676.yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

YOSHIFUJI Hideaki / $B5HF#1QL@ wrote:

>In article <E1CvSuS-00056x-00@gondolin.me.apana.org.au> (at Mon, 31 Jan 2005 15:11:32 +1100), Herbert Xu <herbert@gondor.apana.org.au> says:
>
>
>>Patrick McHardy <kaber@trash.net> wrote:
>>
>>>Ok, final decision: you are right :) conntrack also defragments locally
>>>generated packets before they hit ip_fragment. In this case the fragments
>>>have skb->dst set.
>>>
>>Well caught.  The same thing is needed for IPv6, right?
>>
>
>(not yet confirmed, but) yes, please.
>
We don't need this for IPv6 yet. Once we get nf_conntrack in we
might need this, but its IPv6 fragment handling is different from
ip_conntrack, I need to check first.

Regards
Patrick

