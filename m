Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281883AbRKSCjK>; Sun, 18 Nov 2001 21:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281886AbRKSCjB>; Sun, 18 Nov 2001 21:39:01 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:65038 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S281883AbRKSCix>;
	Sun, 18 Nov 2001 21:38:53 -0500
Date: Mon, 19 Nov 2001 00:38:33 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: Shaya Potter <spotter@opus.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: replacing the page replacement algo.
In-Reply-To: <1006137133.604.8.camel@zaphod>
Message-ID: <Pine.LNX.4.33L.0111190037550.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Nov 2001, Shaya Potter wrote:
> On Sun, 2001-11-18 at 20:44, Rik van Riel wrote:
> > On 18 Nov 2001, Shaya Potter wrote:
> >
> > > If I wanted to experiment with different algorithms that chose which
> > > page to replace (say on a page fault) what functions would I have to
> > > replace?
> >
> > try_to_free_pages() and all the functions it calls.
>
> I was looking at vmscan.c and it appears that swap_out() is what I
> want.

You're missing the fact here that swap_out() only unmaps
pages from processes' page tables, actual reclaiming of
the pages is done elsewhere.

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

