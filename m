Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbVHYQzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbVHYQzh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 12:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVHYQzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 12:55:36 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:29595 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S1751195AbVHYQzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 12:55:35 -0400
Message-ID: <430DF7FF.9080502@candelatech.com>
Date: Thu, 25 Aug 2005 09:55:27 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: danial_thom@yahoo.com
CC: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: 2.6.12 Performance problems
References: <20050825142647.70995.qmail@web33314.mail.mud.yahoo.com>
In-Reply-To: <20050825142647.70995.qmail@web33314.mail.mud.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danial Thom wrote:

> The tests I reported where on UP systems. Perhaps
> the default settings are better for this in 2.4,
> since that is what I used, and you used your
> hacks for both.

My modifications to the kernel are unlikely to speed anything
up, and probably will slow things down ever so slightly.

I can try with a UP kernel, but my machine at least has a single
processor.  I'm using the SMP kernel to take advantage of HT.

> Are you getting drops or overruns (or both)? I
> would assume drops is a decision to drop rather
> than an overrun which is a ring overrun. Overruns
> would imply more about performance than tuning,
> I'd think.

I was seeing lots of NIC errors...in fact, it was showing a great many
more errors than packets sent to it, so I just ignored them.

I increased the TxDescriptors and RxDescriptors and that helped a little.

Increasing the transmit queue for the NIC to 2000 also helped a little.

> I wouldn't think that HT would be appropriate for
> this sort of setup...?

2.6.11 seems to be faster when running SMP kernel on this system.
> 
> You're using a dual PCI-X NIC rather than the
> onboard ports? Supermicro runs their onboard

Of course.  Never found a motherboard yet with decent built-in
NICs.  The built-ins on this board are tg3 and they must be on
a slow bus, because they cannot go faster than about 700Mbps
(using big pkts).

I'll benchmark things again when 2.6.13 comes out and try to
get some more detailed numbers...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

