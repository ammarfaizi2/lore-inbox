Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267885AbRGRN2N>; Wed, 18 Jul 2001 09:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267882AbRGRN2E>; Wed, 18 Jul 2001 09:28:04 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:49671 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S267876AbRGRN1r>;
	Wed, 18 Jul 2001 09:27:47 -0400
Date: Wed, 18 Jul 2001 10:27:48 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Inclusion of zoned inactive/free shortage patch 
In-Reply-To: <Pine.LNX.4.33.0107172051500.1414-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0107181024270.27454-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2001, Linus Torvalds wrote:

> In that case, what's the argument for not just replacing the zone
> parameter with
>
> 	/* If we have enough free pages in this zone, don't bother */
> 	if (page->zone->nrpages > page->zone->high)
> 		return;

> Comments?

Won't work.  If it did, it'd just bring us back to the
pathetic situation we had in 2.3.51, but with the
introduction of inactive_clean pages and an inactive
target all this test would do is either preventing
us from ever making the inactive target or from getting
the eviction balancing between zones right (see 2.3.51).

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

