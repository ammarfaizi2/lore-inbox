Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262009AbTCQXWo>; Mon, 17 Mar 2003 18:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262012AbTCQXWo>; Mon, 17 Mar 2003 18:22:44 -0500
Received: from bitmover.com ([192.132.92.2]:50050 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262009AbTCQXWn>;
	Mon, 17 Mar 2003 18:22:43 -0500
Date: Mon, 17 Mar 2003 15:33:32 -0800
From: Larry McVoy <lm@bitmover.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: David Mansfield <lkml@dm.cobite.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030317233332.GC529@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrea Arcangeli <andrea@suse.de>,
	David Mansfield <lkml@dm.cobite.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0303171804010.23829-100000@admin> <20030317232544.GB30541@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030317232544.GB30541@dualathlon.random>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 12:25:44AM +0100, Andrea Arcangeli wrote:
> yes, this is very helpful thanks ;). I'd suggest you to also parse the
> logic tag and to print a warning if there's an error and not only to
> trust the timestamps. 

The time stamps we're talking about are *in* the revision history. 
We do all checkins to all files with the same timestamp in the same
changeset.  

If you thought that we were talking about on disk timestamps, that's 
way too fragile but these are fine.

> certain logic tag out of the tree. This logic tag will be the
> "changeset" number for us, but one that is also persistent and no only
> unique 

(Logical tag 1.XXXX) 

is in each file's checkin comments and the 1.XXXX is the ChangeSet file's
rev for that changeset.

> I also wonder if it wouldn't be better if Larry would simply tag the CVS
> with the logic tag number since the first place, rather than writing it

That means that *all* files get tags.  There would be 8300 x 15,000 files
times sizeof(tag).  That's too big.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
