Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280784AbRKTAGf>; Mon, 19 Nov 2001 19:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280783AbRKTAGZ>; Mon, 19 Nov 2001 19:06:25 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:17159 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280784AbRKTAGI>;
	Mon, 19 Nov 2001 19:06:08 -0500
Date: Mon, 19 Nov 2001 22:06:02 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@marcelothewonderpenguin.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Simon Kirby <sim@netnation.com>, Andrea Arcangeli <andrea@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: VM-related Oops: 2.4.15pre1
In-Reply-To: <Pine.LNX.4.33.0111191501080.8727-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0111192205080.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2001, Linus Torvalds wrote:
> On Mon, 19 Nov 2001, Rik van Riel wrote:
> >
> > Oh dear, that's an interesting case, too.
> >
> > __add_to_page_cache() blindly sets the PG_locked bit, but
> > it's possible for other functions to acquire the page lock
> > before that.
>
> No. The page is either already locked (add_to_swap_cache()), or
> exclusively owned by us..

The thing is, the "exclusively owned" situation cannot
be checked in any way, except maybe through the fact
that page->mapping==NULL ...

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

