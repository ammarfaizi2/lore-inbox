Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289291AbSBJFaQ>; Sun, 10 Feb 2002 00:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288677AbSBJFaH>; Sun, 10 Feb 2002 00:30:07 -0500
Received: from [206.40.79.199] ([206.40.79.199]:16256 "EHLO
	sparrow.websense.net") by vger.kernel.org with ESMTP
	id <S289290AbSBJF36>; Sun, 10 Feb 2002 00:29:58 -0500
Date: Sun, 10 Feb 2002 00:25:12 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: <wstearns@sparrow.websense.net>
Reply-To: William Stearns <wstearns@pobox.com>
To: Larry McVoy <lm@bitmover.com>
cc: David Lang <dlang@diginsite.com>, Tom Rini <trini@kernel.crashing.org>,
        Patrick Mochel <mochel@osdl.org>,
        ML-linux-kernel <linux-kernel@vger.kernel.org>,
        William Stearns <wstearns@pobox.com>
Subject: Re: [bk patch] Make cardbus compile in -pre4
In-Reply-To: <20020209134132.J13735@work.bitmover.com>
Message-ID: <Pine.LNX.4.33.0202092358500.1868-100000@sparrow.websense.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, Larry,

On Sat, 9 Feb 2002, Larry McVoy wrote:

> On Sat, Feb 09, 2002 at 01:01:34PM -0800, David Lang wrote:
> > do you have a script that can go back after the fact and see what can be
> > hardlinked?
> > 
> > I'm thinking specififcly of the type of thing that will be happening to
> > your server where you have a bunch of people putting in a clone of one
> > tree who will probably not be doing a clone -l to set it up, but who could
> > have and you want to clean up after the fact (and perhapse again on a
> > periodic basis, becouse after all of these trees apply a changeset from
> > linus they will all have changed (breaking the origional hardlinks) but
> > will still be duplicates of each other.
> 
> We don't, but we can, and we should.  "bk relink tree1 tree2" seems like 
> the right interface.
> 
> Right now we aren't too worried about the disk space, the data is sitting 
> on a pair of 40GB drives and we're running the trees in gzip mode, so they
> are 75MB each.  But yes, it's a good idea, we should do it, and probably
> should figure out some way to make it automatic.  I'll add it to the
> (ever growing) list, thanks.

	Larry, I'll save you the time.
	"freedups -a -d /some/dir [/other/dirs]" will look for identical
files (the -d requires dates to be equal as well as the content) and
hardlink them.  It's not terribly efficient, but works marvelously well.  
Run it from cron once a week or so, perhaps?
	http://www.stearns.org/freedups/
	Cheers,
	- Bill

---------------------------------------------------------------------------
        "Patience is a minor form of despair, disguised as virtue."
        -- Ambrose Bierce, on qualifiers
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, named2hosts, 
and ipfwadm2ipchains are at:                http://www.pobox.com/~wstearns
LinuxMonth; articles for Linux Enthusiasts! http://www.linuxmonth.com
--------------------------------------------------------------------------


