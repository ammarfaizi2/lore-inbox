Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316485AbSEOUJ7>; Wed, 15 May 2002 16:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316484AbSEOUJI>; Wed, 15 May 2002 16:09:08 -0400
Received: from bitmover.com ([192.132.92.2]:26829 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S316488AbSEOUIa>;
	Wed, 15 May 2002 16:08:30 -0400
Date: Wed, 15 May 2002 13:08:31 -0700
From: Larry McVoy <lm@bitmover.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Changelogs on kernel.org
Message-ID: <20020515130831.C13795@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Larry McVoy <lm@bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020515122003.A13795@work.bitmover.com> <30386.1021456050@redhat.com> <Pine.LNX.4.44.0205150931500.25038-100000@home.transmeta.com> <20020515122003.A13795@work.bitmover.com> <18732.1021493020@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 09:03:40PM +0100, David Woodhouse wrote:
> 
> lm@bitmover.com said:
> > FYI, if they do a 
> > 	bk send -ubk://linux.bkbits.net/linux-2.5 torvalds@transmeta.com
> > that problem goes away.  The -u<url> stuff does the same sort of
> > handshake that a pull does to figure out what needs to be sent to fill
> > in the holes.
> 
> Not quite. The sender usually omits changesets for a _reason_. You'll often
> find that one of the changesets in the middle wasn't necessary and didn't
> touch any of the same files -- in which case patches would have applied 
> just fine.

Understood.  BK doesn't work that way for multiple reasons, some which have
to do with how it synchronizes replicas, and some which have to do with
being able to reproduce a tree exactly.

It's probably best if you simply view this as a BK limitation which isn't
going away any time soon and don't put junk changesets in the middle of
your stream of changes.  It's easy enough to export the change you want
as a patch, export the comments in the form that bk comments wants,
undo the junk changeset, import the patch, and set the comments.  Yeah,
it's awkward; consider that a feedback loop which encourages you to
think a bit more about what you put in the tree.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
