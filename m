Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315919AbSFLRbu>; Wed, 12 Jun 2002 13:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317308AbSFLRbt>; Wed, 12 Jun 2002 13:31:49 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:58533 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315919AbSFLRbs>;
	Wed, 12 Jun 2002 13:31:48 -0400
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>, dent@cosy.sbg.ac.at,
        adilger@clusterfs.com, da-x@gmx.net, patch@luckynet.dynu.com,
        linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] 2.5.21 - list.h cleanup 
In-Reply-To: Your message of Wed, 12 Jun 2002 13:49:00 +1000.
             <E17Hz8A-0003oC-00@wagner.rustcorp.com.au> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5691.1023903055.1@us.ibm.com>
Date: Wed, 12 Jun 2002 10:30:55 -0700
Message-Id: <E17IBxQ-0001Tr-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E17Hz8A-0003oC-00@wagner.rustcorp.com.au>, > : Rusty Russell writes
:
> In message <E17HpqG-000454-00@w-gerrit2> you write:
> > In message <Pine.LNX.4.44.0206110128130.1987-100000@home.transmeta.com>, > : 
> Li
> > nus Torvalds writes:
> > > 
> > > 
> > > On Tue, 11 Jun 2002, Rusty Russell wrote:
> > > >
> > > > Worst sin is that you can't predeclare typedefs.  For many uses (not the
> > > > list macros of course):
> > > > 	struct xx;
> > > > is sufficient and avoids the #include hell,
> > > 
> > > True.
> > 
> > Untrue.  Or partially true (yes, you *can* use struct xx;).
> > 
> > But you can also use:
> > 
> > typedef foo_t;
> 
> Huh?  In what language?  Try it with -Wall to see what you're really
> doing here, and think about what happens when you put that in one
> header, and the real typedef in another.

I sit corrected.  Synapse must have misfired.  The only references
I see to incomplete typedefs in our code or in the ANSI spec are
related to:

typedef struct foo foo_t;

No, we didn't use gcc for our kernel but it was an ANSI compiler.
My test didn't use -Wall for gcc, duh...

I was thinking that incomplete typedefs would be okay as long as you
only used them in prototypes, but only struct */union * pointers
are guaranteed to be compatible, not int */struct * pointer, so
this couldn't have been of any use.

I'll be sure to consume one extra beer this weekend to kill off that
bad synapse.

gerrit
