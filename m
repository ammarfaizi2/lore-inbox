Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262908AbSJLMBG>; Sat, 12 Oct 2002 08:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262909AbSJLMBF>; Sat, 12 Oct 2002 08:01:05 -0400
Received: from ns.ithnet.com ([217.64.64.10]:30991 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S262908AbSJLMBF>;
	Sat, 12 Oct 2002 08:01:05 -0400
Date: Sat, 12 Oct 2002 14:06:44 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "David S. Miller" <davem@redhat.com>
Cc: ahu@ds9a.nl, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] USAGI IPsec
Message-Id: <20021012140644.0d403b2c.skraw@ithnet.com>
In-Reply-To: <20021012.044137.42774593.davem@redhat.com>
References: <20021012.114330.78212112.yoshfuji@linux-ipv6.org>
	<20021011.194108.102576152.davem@redhat.com>
	<20021012111759.GA10104@outpost.ds9a.nl>
	<20021012.044137.42774593.davem@redhat.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Oct 2002 04:41:37 -0700 (PDT)
"David S. Miller" <davem@redhat.com> wrote:

>    From: bert hubert <ahu@ds9a.nl>
>    Date: Sat, 12 Oct 2002 13:17:59 +0200
> 
>    On Fri, Oct 11, 2002 at 07:41:08PM -0700, David S. Miller wrote:
>    > We believe that the whole SPD/SAD mechanism should move
>    > eventually to a top-level flow cache shared by ipv4 and
>    > ipv6.
>    
>    Is this the proposed stacked route system?
> 
> Yes, for output mostly.
> 
> Also the idea Alexey and I have to move towards a small
> efficient flow cache shared by IPv4/IPv6 plays into this
> as well.  There are changesets on their way to Linus tonight
> which moves ipv4 over to using ipv6's "struct flowi" from
> include/net/flow.h as the routing lookup key.
> 
> The initial ipsec is intended to be simple, singly linked
> lists for the spd/sad databases etc.  Making the feature
> freeze is pretty important right now, full blown flow cache
> is just performance improvement :)

Huhu!
Just a word on this one: I recently came across some heavy performance problem
regarding a setup with about 225 000 routes. It looked as if TCP experienced a
tremendous slowdown to about 50 KBytes/sec throughput, whereas UDP worked
pretty much normal. This was a 2.2.19 kernel with equal-cost-multipath enabled
and large routing-tables enabled.
The reason I am writing this is: please keep in mind situations like this with
several hundred thousands of routes in one box. This is a familiar setup for
the routing guys - and not a "just" case ;-)
Thanks for lending an ear.
-- 
Regards,
Stephan
