Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263713AbUE1RLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUE1RLu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 13:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUE1RLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 13:11:36 -0400
Received: from thunk.org ([140.239.227.29]:18151 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261862AbUE1RLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 13:11:30 -0400
Date: Fri, 28 May 2004 13:11:11 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Dave Jones <davej@redhat.com>, Larry McVoy <lm@work.bitmover.com>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Andrew Morton <akpm@osdl.org>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040528171110.GA21435@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Dave Jones <davej@redhat.com>, Larry McVoy <lm@work.bitmover.com>,
	"La Monte H.P. Yarroll" <piggy@timesys.com>,
	Andrew Morton <akpm@osdl.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20040527062002.GA20872@work.bitmover.com> <20040527010409.66e76397.akpm@osdl.org> <40B6591C.80901@timesys.com> <20040527214638.GA18349@thunk.org> <20040528132436.GA11497@work.bitmover.com> <20040528150740.GF18449@thunk.org> <20040528151919.GC11265@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528151919.GC11265@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 04:19:19PM +0100, Dave Jones wrote:
> bk revtool $filename
> ctrl-c in the gui that pops up
> click line that looks interesting - jumps to the cset with
> commit comments.
> 
> That what you meant ?

Yes, except you have to type all of the extra characters, and manually
dismiss the window after looking at the comments.  I was looking for
something where the window pops up automatically when you mouse over
the line number, and disappear when you move the mouse away.  (This is
not new; a number of modern GUI interfaces have this style of
interface).

On Fri, May 28, 2004 at 08:24:50AM -0700, Larry McVoy wrote:
> We already have that implemented in some tree somewhere, I think one of
> the commercial branches.  It's not hard at all, but it's fairly slow
> because it has to go pawing through the ChangeSet file.  Yeah, we could
> add a cache but it seems rather pointless.

How slow could it be on a 1.6 GHz Pentium-M with 2 gigs of memory?  :-)

All other BK operations tend to fly when everything is in the page cache.
<grin>

> It is simply better to have the correct information recorded in the
> correct place.  Saying that you can go dig it out of the ChangeSet file is
> self defeating, that sucker is 40MB and digging anything out of it hurts.

I agree with you, but that decision isn't up to me.  So I (and all of
us) have to make the best with what the Big Penguin has decided....

A compromise position might be to store multiple authorships (who
committed it into BK, who was the original author, etc.) into the SCM
metadata, but I'm not sure we could justify your putting that kind
feature into BK, especially when it's likely that the only users of it
would be the Linux kernel tree.

							- Ted
