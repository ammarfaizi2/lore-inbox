Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316476AbSEOTUK>; Wed, 15 May 2002 15:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316475AbSEOTUJ>; Wed, 15 May 2002 15:20:09 -0400
Received: from bitmover.com ([192.132.92.2]:5581 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S316474AbSEOTUF>;
	Wed, 15 May 2002 15:20:05 -0400
Date: Wed, 15 May 2002 12:20:03 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Changelogs on kernel.org
Message-ID: <20020515122003.A13795@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <30386.1021456050@redhat.com> <Pine.LNX.4.44.0205150931500.25038-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 09:39:30AM -0700, Linus Torvalds wrote:
> On Wed, 15 May 2002, David Woodhouse wrote:
> > Are you still accepting BK changesets by mail? I heard rumours that you'd
> > said you didn't want them any more -- but couldn't find a message in which
> > you actually said that.
> 
> I try to avoid it as much as possible - it's actually more work for me,
> and about 50% of the BK patches I get don't even apply, because the person
> who sent them to me didn't send the whole series (ie left out some patch
> he didn't like or something like that).

FYI, if they do a 

	bk send -ubk://linux.bkbits.net/linux-2.5 torvalds@transmeta.com

that problem goes away.  The -u<url> stuff does the same sort of handshake
that a pull does to figure out what needs to be sent to fill in the holes.

> > Having the facility to put per-file changelogs in with BK rather than just
> > sending patches is something I quite like, so I'd rather not just revert to
> > sending patches.
> 
> [ Personal opinion alert! No impact on patch acceptance, as long as
>   enough changelog information exists _somewhere_ ]
> 
> I personally like good changelog comments, and I find per-file comments to
> be a mistake.

<Also personal opinion>

Sometimes yes, sometimes no.  Certainly the high order bit is to capture
the logical change in the changeset comment.  One should only have to read
the change{set,log} comment to see if that change is interesting or not,
it should not be necessary to go read the file comments.

The file comments are more about the details of the implementation, not
the idea.  I think the reason that Linus doesn't care about file comments
is that he always reads the diffs and that's better than any comment, in
general.  That's more or less true, but the file comment is a place to
give yourself or others a hint as to what was in your mind when you made
that change.  Those hints can really save your butt when the pressure is
on to turn around a bugfix fast for a customer/whatever.

One of the engineers here said "Changeset comments are for managers,
file comments are for engineers", which is another way to look at it.

Anyway, I would agree 100% that the changeset comments are the most
important in general, so if those are gotten right then we're ahead
of the game.

>  - the per-file comments don't show up in many of the standard changelogs
>    (not mine, not in "bk changes" etc), so the per-changeset comment

bk changes -v

will list the file comments as well.  There is a minor sorting bug in there
when the timestamps are screwed up, but it tries pretty hard to make it be

	ChangeSet comments

	    File 1 comments

	    File 2 comments

	    Etc.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
