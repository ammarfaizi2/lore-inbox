Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbQLSRSa>; Tue, 19 Dec 2000 12:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129573AbQLSRSU>; Tue, 19 Dec 2000 12:18:20 -0500
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:22283 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S129415AbQLSRSC>; Tue, 19 Dec 2000 12:18:02 -0500
Date: Tue, 19 Dec 2000 11:53:00 -0500
From: Michael Meissner <meissner@spectacle-pond.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Anuradha Ratnaweera <anuradha@gnu.org>,
        Ulrich Drepper <drepper@cygnus.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 signal.h
Message-ID: <20001219115300.A4144@munchkin.spectacle-pond.org>
In-Reply-To: <20001215205721.I17781@inspiron.random> <Pine.LNX.4.21.0012161337220.1433-100000@bee.lk> <20001216145242.C25150@inspiron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001216145242.C25150@inspiron.random>; from andrea@suse.de on Sat, Dec 16, 2000 at 02:52:42PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2000 at 02:52:42PM +0100, Andrea Arcangeli wrote:
> On Sat, Dec 16, 2000 at 01:53:50PM +0600, Anuradha Ratnaweera wrote:
> > GCC will complain the absence of a statement after `out1:out2:`, but not
> > two complains for `out1' and `out2', because they form a single entity.
> 
> I understand the formal specs (the email from Michael is very clear). What I'm
> saying is that as the `dummy' statement is redoundant information but you're
> requiring us to put it to build a labeled-statement, you could been even more
> lazy and not define the labeled-statement as a statement so requiring us to put
> a dummy statement after every label. That would been the same kind of issue
> we're facing right now (but of course defining a labeled-statement as a
> statement and allowing recursion makes the formal specs even simpler so that
> probably wouldn't happen that easily).

Basically, that's the way Dennis Ritchie decided it should be 26-27 years ago
(C emerged between 1972 and 1973, according to the published history).  It may
be that C's ancestor languages (B and BCPL) had the same syntax, but since I've
never used them, I can't say.  Ultimately, all syntax is arbitrary, merely an
agreement between language designers, implementers, standards committees and
users.  FWIW, it is rather low on my radar screen.  If I had a magic Delorean
and could go back in time to make some changes, I would:

   1)	Make all stdio functions consistant in taking the FILE * argument as
	the first argument.

   2)	Make && and || have the proper priority.

   3)	Make plain char and bitfields unsigned by default, add signed keyword
	to the original language.

   4)	Allow optional trailing ',' in enumeration lists.

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
