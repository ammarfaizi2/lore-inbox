Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266505AbUIEKJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUIEKJw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 06:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266509AbUIEKJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 06:09:52 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:19595 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266505AbUIEKJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 06:09:50 -0400
Message-ID: <413AE5DA.9070208@yahoo.com.au>
Date: Sun, 05 Sep 2004 20:09:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC][PATCH 0/3] beat kswapd with the proverbial clue-bat
References: <413AA7B2.4000907@yahoo.com.au> <20040904230939.03da8d2d.akpm@osdl.org> <20040905062743.GG7716@krispykreme>
In-Reply-To: <20040905062743.GG7716@krispykreme>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
>>There have been few reports, and I believe that networking is getting
>>changed to reduce the amount of GFP_ATOMIC higher-order allocation
>>attempts.
> 
> 
> FYI I seem to remember issues on loopback due to its large MTU. Also the

Yeah I had seen a few, surprisingly few though. Sorry I'm a bit clueless
about networking - I suppose there is a good reason for the 16K MTU? My
first thought might be that a 4K one could be better on CPU cache as well
as lighter on the mm. I know the networking guys know what they're doing
though...

> printk_ratelimit stuff first appeared because the e1000 was spewing so
> many higher order page allocation failures on some boxes.
> 
> But yes, the e1000 guys were going to look into multiple buffer mode so
> they dont need a high order allocation.
> 

Well let me be the first to say I don't want to stop that from happening.

With regard to getting this patchset tested, I might see if I can hunt
down another e1000 and give it a try at the end of the week. If anyone
would like to beat me to it, just let me know and I'll send out a new
set of patches with those couple of required fixes.
