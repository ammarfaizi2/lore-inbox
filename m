Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271989AbRIDQ2E>; Tue, 4 Sep 2001 12:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271988AbRIDQ1y>; Tue, 4 Sep 2001 12:27:54 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:43538 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271989AbRIDQ1r>;
	Tue, 4 Sep 2001 12:27:47 -0400
Date: Tue, 4 Sep 2001 13:27:50 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <20010904112629.A27988@cs.cmu.edu>
Message-ID: <Pine.LNX.4.33L.0109041320271.7626-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2001, Jan Harkes wrote:

> NO, please don't add another list to fix the symptoms of bad page aging.
>
> One of the graduate students here at CMU has been looking at the 2.4 VM,
> trying to predict the size of the app that can possibly be loaded
> without causing the system to start trashing.

	[snip results]

> Aging is broken. Horribly. As a result, the inactive list is filled with
> pages that are not necessarily inactive.

I've been working on a CPU and memory efficient reverse
mapping patch for Linux, one which will allow us to do
a bunch of optimisations for later on (infrastructure)
and has as its short-term benefit the potential for
better page aging.

It seems the balancing FreeBSD does (up aging +3, down
aging -1, inactive list in LRU order as extra stage) is
working nicely on my laptop now, but I don't think I'll
be releasing that as part of the patch ...

	http://www.surriel.com/patches/2.4/2.4.8-ac12-pmap3

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

