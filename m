Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131900AbQKJVfH>; Fri, 10 Nov 2000 16:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131899AbQKJVe5>; Fri, 10 Nov 2000 16:34:57 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:17925 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S131898AbQKJVet>; Fri, 10 Nov 2000 16:34:49 -0500
Date: Sat, 11 Nov 2000 00:29:22 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Gerard Roudier <groudier@club-internet.fr>
Cc: Richard Henderson <rth@twiddle.net>, axp-list@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: PCI-PCI bridges mess in 2.4.x
Message-ID: <20001111002922.A1348@jurassic.park.msu.ru>
In-Reply-To: <20001110021723.A4142@jurassic.park.msu.ru> <Pine.LNX.4.10.10011101929190.1448-100000@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.10.10011101929190.1448-100000@linux.local>; from groudier@club-internet.fr on Fri, Nov 10, 2000 at 07:35:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 07:35:41PM +0100, Gerard Roudier wrote:
> I only have spec 1.0 on paper. I should have checked 1.1. Anyway, it may
> still exist bridges that have been designed prior to spec. 1.1.

Yes, DEC 2105x bridges, for example.

The only update listed in revision history is "Update to include
target initial latency requirements", so this (base > limit) stuff
must be in rev. 1.0 as well. Please check chapters 3.2.5.[6,8,9].

> 
> > I/O is slightly different because it's optional for the bridge -
> > but if it's implemented same rules apply.
> 
> Will also check the spec. on this point. :)

Also, according the spec, we need some paranoia checks ;-)
1. check if the bridge has an I/O window not implemented
2. if the bridge has regular BARs, allocate them properly
   on the primary bus.

Ivan.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
