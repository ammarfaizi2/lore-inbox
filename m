Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130816AbRABR1A>; Tue, 2 Jan 2001 12:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130849AbRABR0v>; Tue, 2 Jan 2001 12:26:51 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:26474 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130816AbRABR0k>; Tue, 2 Jan 2001 12:26:40 -0500
Date: Tue, 2 Jan 2001 17:55:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Thomas Dodd <ted@cypress.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 signal.h
Message-ID: <20010102175544.A2079@athlon.random>
In-Reply-To: <20001215195433.G17781@inspiron.random> <Pine.LNX.4.21.0012151752421.3596-100000@duckman.distro.conectiva> <20001215211404.J17781@inspiron.random> <3A424990.7CDA4A2C@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A424990.7CDA4A2C@cypress.com>; from ted@cypress.com on Thu, Dec 21, 2000 at 12:18:56PM -0600
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2000 at 12:18:56PM -0600, Thomas Dodd wrote:
> Andrea Arcangeli wrote:
> > 
> > On Fri, Dec 15, 2000 at 05:55:08PM -0200, Rik van Riel wrote:
> > > On Fri, 15 Dec 2000, Andrea Arcangeli wrote:
> > >
> > > > x()
> > > > {
> > > >
> > > >     switch (1) {
> > > >     case 0:
> > > >     case 1:
> > > >     case 2:
> > > >     case 3:
> > > >     ;
> > > >     }
> > > > }
> > > >
> > > > Why am I required to put a `;' only in the last case and not in
> > > > all the previous ones?
> > >
> > > That `;' above is NOT in just the last one. In your above
> > > example, all the labels will execute the same `;' statement.
> > >
> > > In fact, the default behaviour of the switch() operation is
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > to fall through to the next defined label and you have to put
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > in an explicit `break;' if you want to prevent `case 0:' from
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > reaching the `;' below the `case 3:'...
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > Are you kidding me?
> 
> Absolutely NOT.
> 
> switch (x) {
>   case 0:
>   case 1:
>       printf ("%d\n", x);
>       break;
>   case 2:
>       printf ("%d\n",x*x);
>   case 3:
>       printf ("%d\n", x*x*x);
>  }
> 
> if x==0 or 1, prints x (the 0 or one),
> if x==2 , it prints 4 and 8  since no break statement exits the switch,
> if x==3, it prints only 27,
> any othe value of x, and nothing is printed.
> 
> Every C compile I have ever used does this.
> Sun's C and C++, HP's C, Microsoft's VC++, Borland's C, and all versions
> of gcc and g++.
> 
> Grab any C programming book, and find the switch statement.

What I need is an English book, not a C book ;). Chip told me I should have
written "Do you really think I don't know that?" while referring to the
underlined text. If it wasn't obvious I hope it's clear now. Thanks to Chip for
the English lesson.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
