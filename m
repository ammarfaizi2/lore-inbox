Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262639AbRE3Gvf>; Wed, 30 May 2001 02:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262582AbRE3GvP>; Wed, 30 May 2001 02:51:15 -0400
Received: from www.wen-online.de ([212.223.88.39]:64010 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S262078AbRE3GvO>;
	Wed, 30 May 2001 02:51:14 -0400
Date: Wed, 30 May 2001 08:50:42 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Craig Kulesa <ckulesa@as.arizona.edu>
cc: <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Plain 2.4.5 VM
In-Reply-To: <Pine.LNX.4.33.0105292009310.9556-100000@loke.as.arizona.edu>
Message-ID: <Pine.LNX.4.33.0105300820470.750-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2001, Craig Kulesa wrote:

> Mike Galbraith (mikeg@wen-online.de) wrote:
> >
> > Emphatic yes.  We went from cache collapse to cache bloat.
>
> Rik, I think Mike deserves his beer.  ;)

:)

...

> So is there an ideal VM balance for everyone?  I have found that low-RAM

(I seriously doubt it)

> systems seem to benefit from being on the "cache-collapse" side of the
> curve (so I prefer the pre-2.4.5 balance more than Mike probably does) and

I hate both bad behaviors equally.  "cache bloat" hurts more people
than "cache collapse" does though because it shows under light load.

> those low-RAM systems are the first hit when, as now, we're favoring
> "cache bloat".  Should balance behaviors could be altered by the user
> (via sysctl's maybe?  Yeah, I hear the cringes)?  Or better, is it
> possible to dynamically choose where the watermarks in balancing should
> lie, and alter them automatically?  2.5 stuff there, no doubt.  Balancing
> seems so *fragile* (to me).

The page aging logic does seems fragile as heck.  You never know how
many folks are aging pages or at what rate.  If aging happens too fast,
it defeats the garbage identification logic and you rape your cache. If
aging happens too slowly...... sigh.

	-Mike

