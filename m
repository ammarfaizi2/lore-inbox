Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261972AbTCQXOu>; Mon, 17 Mar 2003 18:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262000AbTCQXOu>; Mon, 17 Mar 2003 18:14:50 -0500
Received: from mail-7.tiscali.it ([195.130.225.153]:4180 "EHLO mail.tiscali.it")
	by vger.kernel.org with ESMTP id <S261972AbTCQXOt>;
	Mon, 17 Mar 2003 18:14:49 -0500
Date: Tue, 18 Mar 2003 00:25:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: David Mansfield <lkml@dm.cobite.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030317232544.GB30541@dualathlon.random>
References: <Pine.LNX.4.44.0303171804010.23829-100000@admin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303171804010.23829-100000@admin>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 06:08:11PM -0500, David Mansfield wrote:
> 
> Andrea,
> 
> FWIW, I have already written a program called cvsps (www.cobite.com/cvsps) 
> which extracts 'patchset' information from cvs log output.  
> 
> Currently, this program doesn't work with the bk-cvs because the log 
> messages that are committed with each file in a changeset can be 
> different, and cvsps assumes the log message will  be the same.  
> 
> However, about a 5 line hack to my program (in progress) will allow it to 
> recreate the ChangeSet information, since Larry has promised that the 
> timestamps of all files touched by a changeset will be unique.
> 
> This might help you out.  I'll let you know when the '--bk-cvs' option has 
> been implemented ;-)

yes, this is very helpful thanks ;). I'd suggest you to also parse the
logic tag and to print a warning if there's an error and not only to
trust the timestamps. In general I don't love to depend on timestamps,
so I appreciate the availability of the logical tag in the cvs log.

Infact it would be nice to also be able to ask for the extraction of a
certain logic tag out of the tree. This logic tag will be the
"changeset" number for us, but one that is also persistent and no only
unique (unlike in bk where the changeset number of a changeset can
change anytime AFIK)

I also wonder if it wouldn't be better if Larry would simply tag the CVS
with the logic tag number since the first place, rather than writing it
in the logs and having to parse the stuff with an external utility. 
Personally I would prefer the logical tag to be applied to the CVS with
a true `cvs tag`, not only written into the logs. dozen thousand of tags
(i.e. changesets) shouldn't be a problem for cvs. Doing this change
should be trivial, it should be easier than embedding the logical tag in
the cvs comments. what do you think?

Andrea
