Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286864AbRL1MWo>; Fri, 28 Dec 2001 07:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286866AbRL1MWe>; Fri, 28 Dec 2001 07:22:34 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:18692 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S286864AbRL1MWd>;
	Fri, 28 Dec 2001 07:22:33 -0500
Date: Fri, 28 Dec 2001 10:22:15 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Shaya Potter <spotter@cs.columbia.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: replacing the page replacement algo.
In-Reply-To: <E16JsIX-00009S-00@starship.berlin>
Message-ID: <Pine.LNX.4.33L.0112281020170.24031-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001, Daniel Phillips wrote:
> On November 19, 2001 03:51 am, Shaya Potter wrote:
> > ok, but if what I'm interested in playing with right now is playing
> > around with which pages get swapped out, and not with the actual
> > reclamation procedure, is it ok to just play with swap_out and having it
> > do the thing it does, and let the rest of the kernel behave as is, or
> > will this cause problems?
>
> No, it's quite a bit more complex than you imagine.  I'll do a *very
> quick* trip through it.

[snip complex interaction in standard kernel]

Shaya, if you want a VM where you can easily change the page
replacement algorithm, you probably want to work on top of my
'rmap' patch. The VM in that patch uses reverse mappings to
determine which process uses a page, so you could put normal
clock, lru, ... algorithms on top of it.

Things like swap_out() are completely gone in my patch, it's
just one selection based on physical page.

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

