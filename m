Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261297AbRE3P24>; Wed, 30 May 2001 11:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261410AbRE3P2g>; Wed, 30 May 2001 11:28:36 -0400
Received: from www.wen-online.de ([212.223.88.39]:42001 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261297AbRE3P2a>;
	Wed, 30 May 2001 11:28:30 -0400
Date: Wed, 30 May 2001 17:27:21 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Jonathan Morton <chromi@cyberspace.org>,
        Craig Kulesa <ckulesa@as.arizona.edu>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Plain 2.4.5 VM
In-Reply-To: <Pine.LNX.4.21.0105300913240.4783-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0105301718260.410-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Marcelo Tosatti wrote:

> On Wed, 30 May 2001, Jonathan Morton wrote:
>
> > >The page aging logic does seems fragile as heck.  You never know how
> > >many folks are aging pages or at what rate.  If aging happens too fast,
> > >it defeats the garbage identification logic and you rape your cache. If
> > >aging happens too slowly...... sigh.
> >
> > Then it sounds like the current algorithm is totally broken and needs
> > replacement.  If it's impossible to make a system stable by choosing the
> > right numbers, the system needs changing, not the numbers.  I think that's
> > pretty much what we're being taught in Control Engineering.  :)
>
> The problem is that we allow _every_ task to age pages on the system at
> the same time --- this is one of the things which is fucking up.

Yes.  (I've been muttering/mumbling about this for... ever.  look at the
last patch I posted in this light.. make -j30 load:)

> The another problem is that don't limit the writeout in the VM.

And sometimes we don't start writing out soon enough.

> We (me and Rik) are going to work on this later --- right now I'm busy
> with the distribution release and Rik is travelling.

Cool.

	-Mike

