Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135818AbRDZSHY>; Thu, 26 Apr 2001 14:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135817AbRDZSHO>; Thu, 26 Apr 2001 14:07:14 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:32777 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135822AbRDZSG6>; Thu, 26 Apr 2001 14:06:58 -0400
Date: Thu, 26 Apr 2001 15:06:45 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Ingo Molnar <mingo@elte.hu>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.33.0104261630240.403-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33.0104261503360.17635-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Mike Galbraith wrote:

> > > > No.  It livelocked on me with almost all active pages exausted.
> > > Misspoke.. I didn't try the two mixed.  Rik's patch livelocked me.
> >
> > Interesting. The semantics of my patch are practically the same as
> > those of the stock kernel ... can you get the stock kernel to
> > livelock on you, too ?
>
> Generally no.  Let kswapd continue to run?  Yes, but not always.

OK, then I guess we should find out WHY the thing livelocked...

I've heard reports that it's possible to livelock the kernel,
but for some reason you find it easier to livelock the kernel
with my patch applied.

Maybe this is enough of a clue to find out some things on why
the kernel livelocked?  Maybe we should add some instrumentation
to the kernel to find out why things like this happen?

IMHO having good instrumentation in the kernel makes sense
anyway, since it will allow us to do easier performance analysis
of people's machines, so we'll have less guesswork and it'll be
easier to get the kernel to perform well on more machines...

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

