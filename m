Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261355AbREZOgu>; Sat, 26 May 2001 10:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261410AbREZOgk>; Sat, 26 May 2001 10:36:40 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:9733 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261355AbREZOg0>;
	Sat, 26 May 2001 10:36:26 -0400
Date: Sat, 26 May 2001 11:36:22 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ben LaHaise <bcrl@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <20010526163233.U9634@athlon.random>
Message-ID: <Pine.LNX.4.21.0105261135200.30264-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Andrea Arcangeli wrote:
> On Sat, May 26, 2001 at 01:45:27AM -0300, Rik van Riel wrote:
> > 3) If the device driver needs to allocate something, it
> >    has from zone->pages_min*3/4 down to zone->pages_min/4
> >    space to allocate stuff, this should be very useful
> >    for swap or mmap() over the network, or to encrypted
> >    block devices, etc...
> 
> Anything supposed to work because there's enough memory between
> zone->pages_min*3/4 and zone->pages_min/4 is just obviously broken
> period.

No. It's not about having enough memory between those levels.
It's about _failing_ the allocation when you reach a limit.

> > > Can you try to simply change NR_RESERVED to say 200*MAX_BUF_PER_PAGE
> > > and see if it makes a difference?
> >
> > No Comment(tm)   *grin*
> 
> I'm having lots of fun, thanks.

Now _this_ is tweaking magic limits ;)

cheers,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

