Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271889AbRH2Nwh>; Wed, 29 Aug 2001 09:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271965AbRH2NwV>; Wed, 29 Aug 2001 09:52:21 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27914 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271889AbRH2NwG>; Wed, 29 Aug 2001 09:52:06 -0400
Date: Wed, 29 Aug 2001 06:49:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Andi Kleen <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <Pine.LNX.4.33L.0108291047060.27250-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0108290648420.8173-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 29 Aug 2001, Rik van Riel wrote:
> On 28 Aug 2001, Andi Kleen wrote:
>
> > Regarding kswapd in 2.4.9:
> >
> > At least something seems to be broken in it. I did run some 900MB processes
> > on a 512MB machine with 2.4.9 and kswapd took between 70 and 90% of the CPU
> > time.
>
> Well yes, if you never wait on IO synchronously kswapd turns
> into one big busy-loop. But we knew that, it was even written
> down in the comments in vmscan.c ;)

Rik, look again: kswapd _does_ wait on IO these days.

Not ever waiting for IO is just a sure way to overload the IO subsystem
and cause horribleinteractive behaviour.

		Linus

