Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267664AbUIFIzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267664AbUIFIzz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 04:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266341AbUIFIzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 04:55:55 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:44128 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267678AbUIFIzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 04:55:25 -0400
Message-ID: <413C25F4.8030501@yahoo.com.au>
Date: Mon, 06 Sep 2004 18:55:16 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: anton@samba.org, akpm@osdl.org, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] beat kswapd with the proverbial clue-bat
References: <413AA7B2.4000907@yahoo.com.au>	<20040904230939.03da8d2d.akpm@osdl.org>	<20040905062743.GG7716@krispykreme>	<413AE5DA.9070208@yahoo.com.au> <20040905203331.7a2a2fad.davem@davemloft.net>
In-Reply-To: <20040905203331.7a2a2fad.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Sun, 05 Sep 2004 20:09:30 +1000
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>Yeah I had seen a few, surprisingly few though. Sorry I'm a bit clueless
>>about networking - I suppose there is a good reason for the 16K MTU? My
>>first thought might be that a 4K one could be better on CPU cache as well
>>as lighter on the mm. I know the networking guys know what they're doing
>>though...
> 
> 
> It's better to get as long a stride as possible for the copy
> from userspace, and yes as you get larger you run into cache
> issues.  16K turned out the be the break point considering those
> two attributes when I did my testing.
> 

OK. Makes sense.

> Just fool around with ifconfig lo mtu XXX and TCP bandwidth tests.
> See what you come up with.
> 

Thanks, I'll give that a try. I don't nearly have access to a
representitive range of architectures, but if I see anything
interesting on what I've got, I'll ping you.
