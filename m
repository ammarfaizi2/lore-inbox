Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265443AbRGSRYi>; Thu, 19 Jul 2001 13:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265467AbRGSRY2>; Thu, 19 Jul 2001 13:24:28 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:17681 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S265452AbRGSRYR>;
	Thu, 19 Jul 2001 13:24:17 -0400
Date: Thu, 19 Jul 2001 14:24:12 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Dave McCracken <dmc@austin.ibm.com>, Dirk Wetter <dirkw@rentec.com>
Subject: Re: [PATCH] swap usage of high memory (fwd)
In-Reply-To: <Pine.LNX.4.33.0107190940370.7162-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0107191358070.8447-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 19 Jul 2001, Linus Torvalds wrote:

> Note that the unfair aging (apart from just being a natural requirement of
> higher allocation pressure) actually has some other advantages too: it
> ends up being  aload balancing thing. Sure, it might throw out some things
> that get "unfairly" treated, but once we bring them in again we have a
> better chance of bringing them into a zone that _isn't_ under pressure.
>
> So unfair eviction can actually end up being a natural solution to
> different memory pressure too

Note the difference between unfair aging and unfair eviction.

Unfair eviction is needed and is no problem because with
fair aging this will lead to a large surplus of inactive
pages in less loaded zones, increasing the chances that
future allocations will end up in those zones.

Unfair aging, OTOH, throws away that information, making
it harder for the system to get the pressure across the
zones equal again.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

