Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbVBIXxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVBIXxg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 18:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVBIXxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 18:53:36 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:52106 "EHLO
	mail.bitmover.com") by vger.kernel.org with ESMTP id S261974AbVBIXxO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 18:53:14 -0500
Date: Wed, 9 Feb 2005 15:53:12 -0800
To: Nicolas Pitre <nico@cam.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Jon Smirl <jonsmirl@gmail.com>,
       tytso@mit.edu, Stelian Pop <stelian@popies.net>,
       Francois Romieu <romieu@fr.zoreil.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050209235312.GA25351@bitmover.com>
Mail-Followup-To: lm@bitmover.com, Nicolas Pitre <nico@cam.org>,
	Roman Zippel <zippel@linux-m68k.org>, Jon Smirl <jonsmirl@gmail.com>,
	tytso@mit.edu, Stelian Pop <stelian@popies.net>,
	Francois Romieu <romieu@fr.zoreil.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <20050209184629.GR22893@bitmover.com> <Pine.LNX.4.61.0502091513060.7836@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502091513060.7836@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 03:13:48PM -0500, Nicolas Pitre wrote:
> Are you saying that it is now OK to write scripts that would bit bang
> on
> the bkbits http interface to fetch patches/comments with the purpose
> of
> populating an alternate scm?  Andreas tried that a while ago but you
> threatened to shut the service down entirely if he was to continue.

Go for it, if it becomes a problem we'll rate limit it.  Our first
concern is that the BK users can get at the trees so if you are eating up
the bandwidth too much we'll slow down the web interface.

> | What you could make available in the bkcvs export would be, for each
> | changeset (both for the changesets and for the merged changesets),
> | include three BKRevs:  the changeset's one, the changeset's parent
> one,
> | and the changeset's merge parent one.
>
> Is the above actually part of the protected BK IP?  

Yes.

> I think what people want here is the tree structure representation in
> whatever form, not necessarily in the BK format.  

That's fine, they can do that.  Get the patches and figure out how to
put them back together.  These people do know how to use patch, right?
OK, then they are welcome to patch things in, when they don't work, find
a place they do work and create a branch, patch them, repeat.  Haven't
they ever dealt with a patch reject before?  It's not that hard.

> You can't deny others access to the whole of the
> Linux kernel development history even if their purpose is to import it
> into a competing system (more on that below).

I'm not denying anyone that.  The history consists of the diffs and the
checkin comments, you have that.

> Again I wholeheartedly agree with you above.  But that's not exactly the
> point.  You certainly have the right to protect your work.  But please
> admit that the Linux kernel developers own the right to move (100% not
> 96%) of the development tree with all its branches _they_ produced.

_They_ didn't produce the branching structure, BitKeeper did that.
Go look, there isn't a way to type a command which produces a branch in
BK.  So claiming that metadata is property of the developers is nonsense,
they didn't produce, it isn't physically possible for them to produce it.

That's part of BK's design and power.  100% of what any developer
produced is already available on the web, in the form that has been
used for more than 10 years as the preferred form, a unified diff.
And we added comments because those are useful and you typed them in.
You guys have been importing patches for more than a decade, since when
did that become a problem?

> Now obviously enough some people will run away with that raw data and
> try to import the Linux kernel source tree in their own scm of choice.
> That's why I'm asking you "and so what?"

That's fine if they want to do that, they have the patches.  What they
don't get is the tree structure that BK has because that gives them the
ability to go back and forth and say "well, BK did it this way and it
worked, why doesn't it work in our system?".  

> Note that if someone actually needs a big tree to test bench an
> alternate scm there are alternatives to the kernel -- gcc is a good
> example.  So allowing the Linux kernel tree to be imported into another
> scm is not really a requirement for developing on said scm.

Indeed.  I don't suppose there is any chance you could get people to go
play with the gcc tree?  

> I'm just wondering why providing some additional info which would allow
> for rebuilding the tree with all changeset relationships (into whatever
> alternate inferior scm that's not the point) would uncover your IP.

I think you are fishing for BK internal information and I'm not going
to bite.  The bottom line is that we laid out some rules, the BK users
agreed to them, that's the deal.  If you don't like the deal then go
build an alternative.  You can use all the patches you want from BK but
you don't get to use BK's metadata.

--lm
