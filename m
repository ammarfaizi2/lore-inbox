Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262028AbTCQXq4>; Mon, 17 Mar 2003 18:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262031AbTCQXq4>; Mon, 17 Mar 2003 18:46:56 -0500
Received: from mail-2.tiscali.it ([195.130.225.148]:9329 "EHLO mail.tiscali.it")
	by vger.kernel.org with ESMTP id <S262028AbTCQXqw>;
	Mon, 17 Mar 2003 18:46:52 -0500
Date: Tue, 18 Mar 2003 00:57:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Larry McVoy <lm@work.bitmover.com>, David Mansfield <lkml@dm.cobite.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030317235742.GD30541@dualathlon.random>
References: <Pine.LNX.4.44.0303171804010.23829-100000@admin> <20030317232544.GB30541@dualathlon.random> <20030317233332.GC529@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030317233332.GC529@work.bitmover.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 03:33:32PM -0800, Larry McVoy wrote:
> On Tue, Mar 18, 2003 at 12:25:44AM +0100, Andrea Arcangeli wrote:
> > yes, this is very helpful thanks ;). I'd suggest you to also parse the
> > logic tag and to print a warning if there's an error and not only to
> > trust the timestamps. 
> 
> The time stamps we're talking about are *in* the revision history. 
> We do all checkins to all files with the same timestamp in the same
> changeset.  
> 
> If you thought that we were talking about on disk timestamps, that's 
> way too fragile but these are fine.

ok, I see. But then why not using the logical number by default, that
sounds simpler to parse and to work with.

> > certain logic tag out of the tree. This logic tag will be the
> > "changeset" number for us, but one that is also persistent and no only
> > unique 
> 
> (Logical tag 1.XXXX) 
> 
> is in each file's checkin comments and the 1.XXXX is the ChangeSet file's
> rev for that changeset.
> 
> > I also wonder if it wouldn't be better if Larry would simply tag the CVS
> > with the logic tag number since the first place, rather than writing it
> 
> That means that *all* files get tags.  There would be 8300 x 15,000 files
> times sizeof(tag).  That's too big.

you're writing this tag in the textual log anyways, wouldn't it only
move the too big space from one place to another? I'm saying this
because cvs just provides a means of diffing a tag against another, and
so it looks more efficient (especially in term of saving bandwidth from
your part) to use the cvs feature, rather than doing it by hand with
multiple transfers.

Andrea
