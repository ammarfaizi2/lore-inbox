Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbSKCOcK>; Sun, 3 Nov 2002 09:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262040AbSKCOcK>; Sun, 3 Nov 2002 09:32:10 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:4268 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262038AbSKCOcJ>;
	Sun, 3 Nov 2002 09:32:09 -0500
Date: Sun, 3 Nov 2002 09:38:38 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Oliver Xymoron <oxymoron@waste.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Dax Kelson <dax@gurulabs.com>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <877kfuvjzh.fsf@goat.bogus.local>
Message-ID: <Pine.GSO.4.21.0211030904340.25010-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 3 Nov 2002, Olaf Dietsche wrote:

> > And as Al points out, new security features don't mean that you can just
> > stop being careful. 
> 
> Stating the obvious. Capabilities are not an end in itself, nor is suid
> root. It's just another line of defense to help with these binaries,
> which are _not_ capability aware.

Bullshit.  To _be_ careful you need to understand the implications of
what you are doing.  To do so in a more complicated model is harder,
not easier.

See Linus' suggestion regarding sendmail upthread - thing that looked
like improvement of security (hey, we can make it never retain any
traces of original UID, that should be good) had actually made thing
more vulnerable.

More features != better security.  Quite often it's exact opposite.
Human do make errors, otherwise suid-root stuff wouldn't be a problem
to start with.  And when security mechanism increases probability
of error it becomes a menace.

Odds of getting screwed are 0 if programs contain no bugs.  We are dealing
with real world and there are non-zero odds of exploitable holes being there
and getting found.  What we want is to decrease the odds of compromise,
right?  So how are ACLs/capabilities/etc. settings different from program
internals?  Either can contain bugs.  Neither is guaranteed to be done
correctly.  Odds of compromise depend on odds of bugs in both.  Yet you
seem to imply that metadata *will* be set correctly.  By the same vendors
that had shipped vulnerable binary in the first place.  Even though the
complexity of metadata had grown.

Please, get real.  "Completely understood" is much more important than
"versatile" when it comes to security models.  And as for additional lines
of defense...  How did it go?  "For extra privacy that message had been
twice encrypted with ROT13"...

