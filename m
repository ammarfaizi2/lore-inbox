Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSEYACQ>; Fri, 24 May 2002 20:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSEYACP>; Fri, 24 May 2002 20:02:15 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:30469 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S313060AbSEYACO>; Fri, 24 May 2002 20:02:14 -0400
Date: Fri, 24 May 2002 17:02:07 -0700
From: jw schultz <jw@pegasys.ws>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Dave McCracken <dmccr@us.ibm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] POSIX personality
Message-ID: <20020524170207.C9600@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linus Torvalds <torvalds@transmeta.com>,
	Bill Davidsen <davidsen@tmr.com>, Dave McCracken <dmccr@us.ibm.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020523094611.11249A-100000@gatekeeper.tmr.com> <Pine.LNX.4.44.0205231004470.1006-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 10:09:28AM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 23 May 2002, Bill Davidsen wrote:
> >
> > I think the reason which comes to mind is avoiding future problems. By
> > having a single POSIX mode flag not only does the program not have to know
> > about setting the "right" other bits today, but if we find that POSIX
> > behaviour is needed in some other area in the future, the program doesn't
> > need to be modified and recompiled, because the POSIX behaviour "is in
> > there" for all things.
> 
> That's a nice argument in theory, but if you change the behaviour of
> existing flags, you might fix some program for the real semantics, but you
> might equally well _break_ some program that unwittingly depended on the
> old semantics.
> 
> So I think your argument is fundamentally flawed. The binary has been
> tested with the old behaviour, and assuming that you can "fix" existing
> binaries by changing kernel behaviour is a seriously flawed argument.
> 
> Yes, it might work for some programs, but basically you're on very thin
> ice.
> 
> Does Linux break stuff when absolutely required? Sure. But designing an
> interface that _plans_ on changing semantics is just incredibly stupid,
> and should absolutely not be done. Ever.
> 
> 			Linus

It seems to me that the biggest issue here is maintaining
POSIX behavior without having to modify application source
every time the flag set changes.

Perhaps a POSIX bitmask could be defined.

For a degree of binary compatibility a few unused flags
could be reserved and the POSIX bitmask include them
whether they had meaning yet or not. 

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
