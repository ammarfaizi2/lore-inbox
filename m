Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129193AbQKIXXG>; Thu, 9 Nov 2000 18:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbQKIXW4>; Thu, 9 Nov 2000 18:22:56 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:7430 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S129193AbQKIXWh>; Thu, 9 Nov 2000 18:22:37 -0500
Date: Fri, 10 Nov 2000 02:17:23 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Gerard Roudier <groudier@club-internet.fr>
Cc: Richard Henderson <rth@twiddle.net>, axp-list@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: PCI-PCI bridges mess in 2.4.x
Message-ID: <20001110021723.A4142@jurassic.park.msu.ru>
In-Reply-To: <20001109173920.A3205@jurassic.park.msu.ru> <Pine.LNX.4.10.10011092123320.1438-100000@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.10.10011092123320.1438-100000@linux.local>; from groudier@club-internet.fr on Thu, Nov 09, 2000 at 09:37:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2000 at 09:37:41PM +0100, Gerard Roudier wrote:
> Hmmm...
> The PCI spec. says that Limit registers define the top addresses
> _inclusive_.

Correct.

> The spec. does not seem to imagine that a Limit register lower than the
> corresponding Base register will ever exist anywhere, in my opinion. :-)

Not correct.
Here's a quote from `PCI-to-PCI Bridge Architecture Specification rev 1.1':
   The Memory Limit register _must_ be programmed to a smaller value
   than the Memory Base if there are no memory-mapped I/O addresses on the
   secondary side of the bridge.

I/O is slightly different because it's optional for the bridge -
but if it's implemented same rules apply.

> This let me think that trying to be clever here is probably a very bad
> idea. What is so catastrophic of having 1 to 4 bytes of addresses and no
> more being possibly in a forwardable range?
> 
Huh. 1 to 4 bytes? 4K for I/O and 1M for memory.
And it's not trying to be clever (anymore :-) - just strictly following
the Specs.

I understand your point very well, btw. I asked similar questions to myself
until I've had the docs.

Ivan.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
