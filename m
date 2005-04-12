Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVDLIls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVDLIls (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 04:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVDLIls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 04:41:48 -0400
Received: from witte.sonytel.be ([80.88.33.193]:63653 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262067AbVDLIjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 04:39:54 -0400
Date: Tue, 12 Apr 2005 10:39:40 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Petr Baudis <pasky@ucw.cz>
cc: "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: GIT license (Re: Re: Re: Re: Re: [ANNOUNCE] git-pasky-0.1)
In-Reply-To: <20050412014204.GB9145@pasky.ji.cz>
Message-ID: <Pine.LNX.4.62.0504121037590.10150@numbat.sonytel.be>
References: <200504120120.j3C1KII14991@adam.yggdrasil.com>
 <20050412014204.GB9145@pasky.ji.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2005, Petr Baudis wrote:
> Dear diary, on Tue, Apr 12, 2005 at 03:20:18AM CEST, I got a letter
> where "Adam J. Richter" <adam@yggdrasil.com> told me that...
> > >Dear diary, on Mon, Apr 11, 2005 at 05:46:38PM CEST, I got a letter
> > >where "Adam J. Richter" <adam@yggdrasil.com> told me that...
> > >..snip..
> > >> Graydon Hoare.  (By the way, I would prefer that git just punt to
> > >> user level programs for diff and merge when all of the versions
> > >> involved are different or at least have a very thin interface
> > >> for extending the facility, because I would like to do some character
> > >> based merge stuff.)
> > >..snip..
> > 
> > >But this is what git already does. I agree it could do it even better,
> > >by checking environment variables for the appropriate tools (then you
> > >could use that to pass diff e.g. -p etc.).
> > 
> > This message from Linus seemed to imply that git was going to get
> > its own 3-way merge code:
> > 
> > | Then the bad news: the merge algorithm is going to suck. It's going to be
> > | just plain 3-way merge, the same RCS/CVS thing you've seen before. With no
> > | understanding of renames etc. I'll try to find the best parent to base the
> > | merge off of, although early testers may have to tell the piece of crud
> > | what the most recent common parent was.
> 
> Well, from what I can read it says "just plain 3-way merge, the same
> RCS/CVS thing you've seen before". :-)
> 
> Basically, when you look at merge(1) :
> 
> SYNOPSIS
>        merge [ options ] file1 file2 file3
> DESCRIPTION
>        merge  incorporates  all  changes that lead from file2 to file3
> into file1.
> 
> The only big problem is how to guess the best file2 when you give it
> file3 and file1.

That's either the point just before you started modifying the file, or your
last merge point. Sounds simple, but if your SCM system doesn't track merges,
your SOL...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
