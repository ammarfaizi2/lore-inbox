Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278908AbRKDF5E>; Sun, 4 Nov 2001 00:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279794AbRKDF4q>; Sun, 4 Nov 2001 00:56:46 -0500
Received: from bitmover.com ([192.132.92.2]:43924 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S278908AbRKDF4e>;
	Sun, 4 Nov 2001 00:56:34 -0500
Date: Sat, 3 Nov 2001 21:56:34 -0800
From: Larry McVoy <lm@bitmover.com>
To: Bernd Eckenfels <ecki@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CVS / Bug Tracking System
Message-ID: <20011103215634.A10051@work.bitmover.com>
Mail-Followup-To: Bernd Eckenfels <ecki@lina.inka.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <flk.1004824861.fsf@jens.unfaehig.de> <E160Epp-0008Sa-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E160Epp-0008Sa-00@calista.inka.de>; from ecki@lina.inka.de on Sun, Nov 04, 2001 at 05:24:37AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm the BitKeeper guy in case someone doesn't know.)

On Sun, Nov 04, 2001 at 05:24:37AM +0100, Bernd Eckenfels wrote:
> Some architectures and branches are kept in Source control. Like sparc, xfs.
> Also the complete kernel is available in bitkeeper. Linux does not see a
> reason to have his version in the CVS. And since he is the only commiter it
> is quite valid for him to choose the tool he wants to use.

Linus has toyed with using BitKeeper but has always found some fault with
it (we're not complaining, we tend to agree with his complaints and fix 
them as fast as we can).  It's still not as good as he wants so I'm not
sure if he'll take it for a spin for 2.5 or not.

> It is is not your problem to merge them. Alan and Linus are doing that. And
> they are fine without CVS. 

One thing we have been doing is working on merge tools.  Some of our users
have really nasty merge problems and need better merge technology.  We've
come up with something that we think is very good.  You can see a screen
shot at
	
	http://www.bitkeeper.com/gifs/fm3new.gif

and if you'd like to take it for a test drive, we've put up just the stuff
you need at

	http://www.bitkeeper.com/promerge.tgz

You don't need BitKeeper installed to run it, but if you do then as you move
through the diffs, the checkin comments for the affected lines will show
up in the top two windows (very handy when you are scratching your head and
wondering why did someone change this).

It takes a little getting used to and it could sure use some docs, but we
have compared this to other graphical merge tools out there and think we
have the best of the lot.  It takes advantage of some unique information
we can extract from the data in the revision control system; unless you
have a very similar revision engine, it's impossible to do as well as we
do.  And for you poor PPC BK guys, yeah, we know that the original merge
tool sucked.  You'll like this better.

Anyway, getting back to Linus & Co, and for that matter, open source
efforts in general, they typically have a somewhat different model
than BK.  In BK today, before you can push up a change you have to merge
it with whatever is in the tree to which you are sending the change.
In other words, each user merges rather than the maintainer.  We're well
aware that not everyone likes this model so we're working on a small set
of changes so that users can push their changes to the maintainer and the
maintainer merges them.  This makes merge tools even more important to
the maintainers, so if you give the filemerge a try and have suggestions
for improvements, we'd love to hear them.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
