Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275449AbRJATpM>; Mon, 1 Oct 2001 15:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275455AbRJATpC>; Mon, 1 Oct 2001 15:45:02 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:30725 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S275449AbRJATos>;
	Mon, 1 Oct 2001 15:44:48 -0400
Date: Mon, 1 Oct 2001 16:44:52 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lorenzo Allegrucci <lenstra@tiscalinet.it>, <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: VM: 2.4.10 vs. 2.4.10-ac2 and qsort()
In-Reply-To: <E15o8xP-0002H3-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0110011643270.4835-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2001, Alan Cox wrote:

> > I'm not sure either, since qsort doesn't really have much
> > locality of reference but just walks all over the place.
>
> qsort can be made to perform reasonably well providing you try to cache
> colour the objects you sort and try to use prefetches a bit.

That won't quite work when the qsort in question is 150%
the size of your RAM ;)

> > One thing which could make 2.4.10 faster for this single case
> > is the fact that it doesn't keep any page aging info, so IO
> > clustering won't be confused by the process accessing its
> > pages ;)
>
> I don't think that is too unusual a case. If the smarter vm is making
> poorer I/O clustering decisions it wants investigating

Absolutely, this is something we really want to know ...

I guess I'll play with Lorenzo's program a bit to see how
the system behaves and how it can be improved.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

