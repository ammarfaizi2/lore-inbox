Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291614AbSBTTIq>; Wed, 20 Feb 2002 14:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292214AbSBTTIh>; Wed, 20 Feb 2002 14:08:37 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:17909 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S291614AbSBTTIX>;
	Wed, 20 Feb 2002 14:08:23 -0500
Date: Wed, 20 Feb 2002 12:07:51 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Larry McVoy <lm@work.bitmover.com>, Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Larry McVoy <lm@bitmover.com>
Subject: Re: [PATCH] struct page, new bk tree
Message-ID: <20020220120751.B1506@lynx.adilger.int>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Larry McVoy <lm@bitmover.com>
In-Reply-To: <Pine.LNX.4.33L.0202192044140.7820-100000@imladris.surriel.com> <20020219155706.H26350@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020219155706.H26350@work.bitmover.com>; from lm@bitmover.com on Tue, Feb 19, 2002 at 03:57:06PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 19, 2002  15:57 -0800, Larry McVoy wrote:
> On Tue, Feb 19, 2002 at 08:47:17PM -0300, Rik van Riel wrote:
> > I've removed the old (broken) bitkeeper tree with the
> > struct page changes and have put a new one in the same
> > place ... with the struct page changes in one changeset
> > with ready checkin comment.
> > 
> > You can resync from bk://linuxvm.bkbits.net/linux-2.5-struct_page
> > and you'll see that the stupid etc/config change is no longer there.
> 
> Since you two are doing the BK dance, here's a question for you: 
> I can imagine that this sort of back and forth will happen quite a bit,
> someone makes a change, then Linus (or whoever) says "no way", and the
> developer goes back, cleans up the change, and repeats.  That's fine for
> Linus & Rik because Linus tosses the changeset and Rik tosses it, but
> what about the other people who have pulled?  Those changesets are now
> wandering around in the network, just waiting to pop back into a tree.
> 
> This is at the core of my objections to the "reorder the events" theme
> which we had a while back.  You can reorder all you want, but if there
> are other copies of the events floating around out there, they may come
> back.
> 
> A long time ago, there was some discussion of a changeset blacklist.
> The idea being that if you want to reorder/rewrite/whatever, and your
> changes have been pulled/pushed/whatever, then it would be good to be
> able to state that in the form of some list which may be used to see 
> if you have garbage changesets.
> 
> We could have a --blacklist option to undo which says "undo these
> changes but remember their "names" in the BitKeeper/etc/blacklist file.
> The next changeset you make will check in that file.  Note that each
> changeset has a unique name which is used internally, somewhat like a
> file has an inode number.  So we can save those names.  Then if you do
> a pull or someone does a push, the incoming csets can be compared with
> the blacklist and rejected if found.

So what happens to the person who pulled the (now-blacklited) CSET in
the first place?  If they do a pull from the repository where the original
CSET lived, will the blacklisted CSET be undone and the replacement CSET
be used in its place?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

