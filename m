Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263324AbUE1PZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263324AbUE1PZW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 11:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbUE1PZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 11:25:21 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:49339 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263324AbUE1PZB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 11:25:01 -0400
Date: Fri, 28 May 2004 08:24:50 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Andrew Morton <akpm@osdl.org>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040528152450.GA15718@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Theodore Ts'o <tytso@mit.edu>,
	"La Monte H.P. Yarroll" <piggy@timesys.com>,
	Andrew Morton <akpm@osdl.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20040527062002.GA20872@work.bitmover.com> <20040527010409.66e76397.akpm@osdl.org> <40B6591C.80901@timesys.com> <20040527214638.GA18349@thunk.org> <20040528132436.GA11497@work.bitmover.com> <20040528150740.GF18449@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528150740.GF18449@thunk.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 11:07:40AM -0400, Theodore Ts'o wrote:
> On Fri, May 28, 2004 at 06:24:36AM -0700, Larry McVoy wrote:
> > Not in any useful way.  If I go look at the file history, which is what
> > I'm going to do when tracking down a bug, all I see on the files included
> > in this changeset is akpm@osdl.org.
> > 
> > That means any annotated listing (BK or CVS blame) shows the wrong author.
> 
> One of the ways that I often use for tracking down potential fixes is
> to simply do "bk changes > /tmp/foo" and then use emacs's incremental
> search to look for interesting potential changes.  (I know, you're
> probably throwing up all over your keyboard just about now.  :-)

Hey, whatever works for you.

> One "interesting" thing I've wished for is to be able to do "bk
> revtool drivers/net/wireless/airo.c", and then when I put my mouse
> over a particular line number, have it display in a little popup box 
> the changelog description of whatever line my mouse happened to 
> be over.  It would be a real pain to try to implement that in tcl/Tk, 
> though....  

We already have that implemented in some tree somewhere, I think one of
the commercial branches.  It's not hard at all, but it's fairly slow
because it has to go pawing through the ChangeSet file.  Yeah, we could
add a cache but it seems rather pointless.

It is simply better to have the correct information recorded in the
correct place.  Saying that you can go dig it out of the ChangeSet file is
self defeating, that sucker is 40MB and digging anything out of it hurts.
So even if we gave you this feature in revtool, which is just

	bk sccslog -r`bk r2c -r$REV $FILE` $FILE

it's going to be too slow to be useful.

I dunno what to tell you other than I'm trying to guide you towards the 
use of the SCM that will be productive for you.  This would be true in
CVS as well, except it is worse unless you are using the bk2cvs tree
which maintains the backpointer to the changeset file there.

Why people persist in storing the less used information cheaply and the
commonly used information expensively is beyond me.  But hey, it's your
source base, knock yourself out.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
