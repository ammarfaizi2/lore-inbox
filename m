Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315155AbSEZHas>; Sun, 26 May 2002 03:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315760AbSEZHar>; Sun, 26 May 2002 03:30:47 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:4008 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315155AbSEZHaq>;
	Sun, 26 May 2002 03:30:46 -0400
Date: Sun, 26 May 2002 03:30:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Larry McVoy <lm@bitmover.com>
cc: David Schleef <ds@schleef.org>, Karim Yaghmour <karim@opersys.com>,
        Wolfgang Denk <wd@denx.de>, linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <20020525211328.B20253@work.bitmover.com>
Message-ID: <Pine.GSO.4.21.0205260234460.15165-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 May 2002, Larry McVoy wrote:

> Here's a clue: go diff bmap() in 4.x BSD and in 32V.  Word for word, bit
> for bit, comment for comment, identical when I did it.  And I think anyone
> can verify that, both versions of the code are out there now.  And I also
> think that you, Al, would agree that bmap() is a pretty profound part of
> the file system.  That AT&T let that one slip is mind boggling.

You are tripping.  bmap() is obviously different in 32V and 4.2BSD -
filesystems are different and yes, it _is_ a profound part of filesystem.

Hint: there is no fucking way you'll find realloccg() called in 32V
bmap() or defined anywhere in the first place.  The only thing that
does match is use of function and fact that old and new filesystems
have similar data structure for indirect, etc. blocks.  Notice that
it's similar, not identical - e.g. use of fragments in FFS changes
quite a few things.

What the hell are you smoking?  Of all things that could be shared,
picking bmap() takes either something way stronger than dope or
complete lack of clue on the things aforementioned function is
supposed to do.
 
> > If somebody chooses to use these "free for GPLed works" patents - fine,
> > but at least have a decency to admit that it's a bit more complex than
> > "if you want to make money on my work I want a part of it".
> 
> Huh?  You lost me.  For the record, I do think it's that simple.  And in
> personal conversations with Victor, he's indicated that it is that simple.
> What else do you think is there?  I'm missing some subtlety here, bang me
> on the head with it.

Simple: $FOO prefers to put his code under free license other than GPL.
And does that without any plans to make money out of it.  For any
number of reasons.  $BAR has "GPL or pay" patent.  Well, too fscking
bad, $FOO can't do what he wants to.  Nothing to do, should've researched
 the situation better and yes, life is tough.  OK so far?

Now comes GPL advocate and says that the only reason why $FOO would
get in trouble here was (obviously) that he wanted to make money and
didn't want to share.  Which is demonstrably false.

Now, whether I have a problem with $BAR or not is a separate story.
What I _do_ have a problem with, though, is GPL advocate and his, er,
judgement.  Still sounds too subtle?

Frankly, I can see very few possible reasons:
	* you are on a serious trip
	* you really don't know about free licenses other than GPL.
	* you are pulling ESR and expecting that reference to a
holy cow (in this case "free == GPL" crap) will help.

Again, I don't fscking care for RT-anything.  I'm not too fond of
software patents of any nature, to put it mildly, but that's a
separate story.  What _really_ pisses me off is a sight of apparently
clued guy using this sort of rethorics and pretending that non-GPL ==
commercial.

