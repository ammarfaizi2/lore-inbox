Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbWE0Xu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWE0Xu2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 19:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbWE0Xu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 19:50:28 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:12712 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964966AbWE0Xu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 19:50:28 -0400
Date: Sun, 28 May 2006 01:50:22 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] a few small mconf improvements
In-Reply-To: <9a8748490605131359h18f47e89o1f8545269fbf3502@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0605280140280.32445@scrub.home>
References: <200605071749.28822.jesper.juhl@gmail.com> 
 <Pine.LNX.4.64.0605082337280.32445@scrub.home>
 <9a8748490605131359h18f47e89o1f8545269fbf3502@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 13 May 2006, Jesper Juhl wrote:

(Sorry for the delay.)

> > >  - if the sscanf() call in conf() fails and stat==0 && type=='t', then
> > >    we'll end up dereferencing a NULL 'sym' in sym_is_choice(). The patch
> > >    adds a NULL check of 'sym' to that path and bails out with a big fat
> > >    error message if that should ever happen (better than just crashing
> > >    IMHO).
> > 
> > That error message is as useful to the normal user as a segfault - mconf
> > doesn't work. Since it shouldn't happen, this check adds no real value,
> > the user still has to provide enough information to reproduce the problem
> > and at this point it makes no difference, whether I get this message or I
> > see where it stops with gdb.
> > 
> I disagree a little here. It may not really matter to you if you get a
> report of a crash or if you get a report that mconf spewed an error
> message, but to the user who experiences it (should it ever happen)
> there's a difference - it's either "the damn thing crashed on me, what
> a piece of crap" or "the damn thing crashed on me, but at least it
> told me something went wrong, so now I can report it"... Printing an
> error and exiting cleanly is IMHO always preferable to a crash - users
> respond better to that and it's the "right" thing to do.

The point is that this shouldn't happen and so far didn't, you have to do 
something really weird to trigger this, so a big error message is not 
appropriate. Something like assert() would be more acceptable, but IMO 
it's just not important enough.

> What about the other bits of the patch? are those OK?

Yes, it's OK.

bye, Roman
