Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131155AbQLOUxY>; Fri, 15 Dec 2000 15:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131174AbQLOUxP>; Fri, 15 Dec 2000 15:53:15 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:29528 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131155AbQLOUxK>; Fri, 15 Dec 2000 15:53:10 -0500
Date: Fri, 15 Dec 2000 21:22:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Ulrich Drepper <drepper@cygnus.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 signal.h
Message-ID: <20001215212219.K17781@inspiron.random>
In-Reply-To: <20001215205721.I17781@inspiron.random> <Pine.LNX.4.21.0012151808540.3596-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0012151808540.3596-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Fri, Dec 15, 2000 at 06:09:16PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2000 at 06:09:16PM -0200, Rik van Riel wrote:
> On Fri, 15 Dec 2000, Andrea Arcangeli wrote:
> 
> > And yes I can see that the whole point of the change is that
> > they want to also forbids this:
> > 
> > x()
> > {
> > 	goto out;
> > out:
> > }
> > 
> > and I dislike not being allowed to do the above as well infact ;).
> 
> What's wrong with the - more readable - `break;' ?

You meant "return" of course as you can't put a break there (there's no loop).

`return' doesn't define the fast path (but ok it's a minor issue and
I think latest gcc can use some stuff to define fast paths).

In general all I'm saying is that they don't want a label before the end of a
compound statement and that's a not interesting requirement IMHO that will just
force people to use one additional "suprious" `;' after the last label. It
doesn't make the code more readable and it doesn't give any advantage other
than maybe having simplified some formal language definition.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
