Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290779AbSBLRVU>; Tue, 12 Feb 2002 12:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290946AbSBLRVK>; Tue, 12 Feb 2002 12:21:10 -0500
Received: from 1Cust118.tnt15.sfo3.da.uu.net ([67.218.75.118]:31498 "EHLO
	morrowfield.home") by vger.kernel.org with ESMTP id <S290767AbSBLRVG>;
	Tue, 12 Feb 2002 12:21:06 -0500
Date: Tue, 12 Feb 2002 12:28:54 -0800 (PST)
Message-Id: <200202122028.MAA24835@morrowfield.home>
From: Tom Lord <lord@regexps.com>
To: tytso@mit.edu
CC: lm@bitmover.com, jmacd@CS.Berkeley.EDU, jaharkes@cs.cmu.edu,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020211225935.B5514@thunk.org> (message from Theodore Tso on
	Mon, 11 Feb 2002 22:59:35 -0500)
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <Pine.LNX.4.44.0202052328470.32146-100000@ash.penguinppc.org> <20020207165035.GA28384@ravel.coda.cs.cmu.edu> <200202072306.PAA08272@morrowfield.home> <20020207132558.D27932@work.bitmover.com> <20020211002057.A17539@helen.CS.Berkeley.EDU> <20020211070009.S28640@work.bitmover.com> <20020211141404.A21336@work.bitmover.com> <200202120517.VAA21821@morrowfield.home> <20020211225935.B5514@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I think arch can help you manage the limited space on a laptop disk
quite well, too.  You'll have trouble if that's the _only_ disk you
have, but otherwise:

	1. Make a nice big expansive development environment
 	   on a larger machine, with lots of revisions cached in the
 	   revision library, mirrors of your favorite archives, etc.

	2. On your laptop, store only the repository you'll need for
           day to day work, plus a very sparsely populated revision
           library -- it might even be empty depending on the kind of
           work you're doing.  The repository needs only a single
           baseline (a compressed tar file) and compressed deltas for
           each revision it contains.  It doesn't even have to be your
           main repository -- it can be an otherwise empty repository
           containing only a branch from your main repository plus
           those revisions you create from your laptop.

	3. Make a simple shell script, "prepare-detached", that
           updates the contents of your laptop in anticipation of work
           on particular branches or with particular historic
           revisions, copying bits and pieces from your nice big
           environment.  Make a shell script "return-home" that moves
           a branch from your laptop to your stationary archive.

Having a huge revision library is a win if what you're doing is
fielding patches from many contributors, against many baselines,
wanting to try out various combinations of baseline and patch, and
wanting to do lots of archeology to trace the history of various
changes.  If, on the other hand, what you're doing is going off
somewhere to work on coding a particular change, you don't need a big
revision library.


-t




   Date: Mon, 11 Feb 2002 22:59:35 -0500
   From: Theodore Tso <tytso@mit.edu>
   Cc: lm@bitmover.com, jmacd@CS.Berkeley.EDU, jaharkes@cs.cmu.edu,
	   linux-kernel@vger.kernel.org
   Mail-Followup-To: Theodore Tso <tytso@mit.edu>, Tom Lord <lord@regexps.com>,
	   lm@bitmover.com, jmacd@CS.Berkeley.EDU, jaharkes@cs.cmu.edu,
	   linux-kernel@vger.kernel.org
   Content-Type: text/plain; charset=us-ascii
   Content-Disposition: inline
   User-Agent: Mutt/1.3.15i
   X-UIDL: 7c6ac808cf42f277fa20d221ae51da13

   On Mon, Feb 11, 2002 at 09:17:43PM -0800, Tom Lord wrote:
   > 
   > It may be theoretically interesting to minimize the space taken up by
   > revisions, but I think it is more economically sensible to screw that
   > and and instead, maximize convenience and interactive speed with
   > features like revision libraries (as in arch).  This ain't the early
   > 90's any more.

   For What It's Worth, on a laptop environment (where I work quite a
   bit) and for something the size of the Linux kernel, and where things
   change at the speed of the Linux kernel, in fact space efficiency
   matters a lot.

   In fact, the one thing for which I was quite unhappy with BK until
   Larry implemented bk lclone (aka bk clone -l) was the amount of space
   having multiple copies of the same repository took up, since BK really
   requires multiple sandboxes for parallel development.  It's not a big
   deal with something the size of e2fsprogs, but for something the size
   of the BK linux tree, Size Really Matters.

						   - Ted


