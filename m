Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266982AbRGXFef>; Tue, 24 Jul 2001 01:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266995AbRGXFeZ>; Tue, 24 Jul 2001 01:34:25 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:62774
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S266982AbRGXFeS>; Tue, 24 Jul 2001 01:34:18 -0400
Date: Mon, 23 Jul 2001 22:34:13 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Larry McVoy <lm@bitmover.com>,
        Jerome de Vivie <jerome.de-vivie@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-fsdev@vger.kernel.org,
        martizab@libertsurf.fr, rusty@rustcorp.com.au
Subject: Re: Yet another linux filesytem: with version control
Message-ID: <20010723223413.G15284@work.bitmover.com>
Mail-Followup-To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Larry McVoy <lm@bitmover.com>,
	Jerome de Vivie <jerome.de-vivie@wanadoo.fr>,
	linux-kernel@vger.kernel.org, linux-fsdev@vger.kernel.org,
	martizab@libertsurf.fr, rusty@rustcorp.com.au
In-Reply-To: <20010723141751.W6820@work.bitmover.com> <200107240524.f6O5OwX286884@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200107240524.f6O5OwX286884@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Tue, Jul 24, 2001 at 01:24:57AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> > b) Filesystem support for SCM is really a flawed approach.  No matter how
> >    much you hate all SCM systems out there, shoving the problem into the
> >    kernel isn't the answer.  All that means is that you have an ongoing
> >    battle to keep your VFS up to date with the kernel.  Ask Rational
> >    how much fun that is...
> 
> I'm sure it is a pain to maintain, but consider recovery
> with revision control in your root filesystem:
> 
> LILO: linux init=/bin/sh rootfsopts=ver:/bin/sh@@/main/1
> 
> Nice, isn't it? You can trash /bin/* all you want.

Yeah, that's cool.  I'm with you in spirit on this one Albert, I've long
promoted that we use revision control for all the config files (stuff
like /etc/sendmail.cf, etc).

And we have customers who use BitKeeper to manage their entire OS, I mean
all the binaries are in there. 

That said, I'd really urge people to listen to Rik, he has the right idea
with the user level NFS idea.  There is no good reason and a lot of bad
reasons to put this stuff in the kernel.

I realize that since this is our business that my credibility is low,
you'll expect that I'm pushing this because it somehow benefits us (how,
I'm not sure, but I have faith that someone will think that).  Anyway,
that's not the case, this is purely from a kernel point of view, I think
this is a dead end.

Useful stuff would be the copy on write file system, that's good for SCM
and other things.  And the user level NFS approach.  That way if you hate
the BK license you can plug PRCS or CVS or my-favorite-SCM system into the
back end.  I'd much rather see that than BK in the kernel.  Yuck.

> Distributed filesystems like Coda seem to get pretty close
> to having revision control anyway. They need something like
> it for conflict resolution.

Yeah!  No kidding.  If Coda had this I think there is a reasonable chance
that most SCM systems would go away.  Certainly the trivial ones would.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
