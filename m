Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266334AbUAHWgu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 17:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266349AbUAHWgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 17:36:50 -0500
Received: from p68.rivermarket.wintek.com ([208.13.56.68]:6064 "EHLO
	dust.p68.rivermarket.wintek.com") by vger.kernel.org with ESMTP
	id S266334AbUAHWgr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 17:36:47 -0500
Date: Thu, 8 Jan 2004 17:40:46 -0500 (EST)
From: Alex Goddard <agoddard@purdue.edu>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Diego Calleja <grundig@teleline.es>, Ian Kent <raven@themaw.net>,
       linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
In-Reply-To: <200401082220.24127.arvidjaar@mail.ru>
Message-ID: <Pine.LNX.4.58.0401081712520.3452@dust>
References: <E1Aeab1-0009FQ-00.arvidjaar-mail-ru@f20.mail.ru>
 <Pine.LNX.4.44.0401082333280.449-100000@donald.themaw.net>
 <20040108182621.1278db90.grundig@teleline.es> <200401082220.24127.arvidjaar@mail.ru>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To shorten my reply from one post to two:

I wasn't aware the lookup race had been fixed.  Silly me.  As to the
number of results for the terms I used, I was looking for that specific
post, as I'd cited it before.  'devfs deadlock' also returns plenty of
good (and irrelevant)  results at that same archive.

On Thu, 8 Jan 2004, Andrey Borzenkov wrote:

> On Thursday 08 January 2004 20:26, Diego Calleja wrote:
> > El Thu, 8 Jan 2004 23:40:16 +0800 (WST) Ian Kent <raven@themaw.net> 
> escribió:
> > > Again I'm also unable to find descriptions of the 'unsolvable' races.
> > >
> > > I wouldn't mind knowing what they are either. Anyone?
> >
> > You can find tons of examples (several of them patches by Al Viro to fix
> > them) by searching with google with keywords like "devfs races". The
> > "should fix" list
> > (http://www.kernel.org/pub/linux/kernel/people/akpm/must-fix) has this:
> >
> 
> is it a gospel?

Given akpm's track record and, the fact that he's going to be maintaining
2.6, his word is enough for me.  But...

[lookup vs. devfsd deadlock]

> oh, well ... if you selected this example ...
> 
> Mandrake workaround it mentions was my first attempt to fix this; this
> did not fix the devfs but rather fixed the user-space program that
> provoked this on boot (and that was buggy irrespectively of this
> problem).
> 
> Current 2.6 kernel includes my fix to deadlock condition. Current -mm
> includes one possible fix for race condition; Andrew Morton mentioned
> that it is unlikely to be accepted due to minor changes in VFS layer; I
> am working on another less intrusive fix and overall devfs cleanup.
> 
> Would you please instead of citing long obsolete paper show me real example 
> and explain *why* it is not fixable. Better yet, would you take some time to 
> try to provoke any of those huge races and report back your success (stack 
> trace and instructions how to reproduce them are welcome :)
> 
> Thank you

One should do one's own research.  If I'd done my own better, I would've
found a better example than the one I posted previously.  However, since
you seem unwilling or unable to do your own homework, and I have nearly
unlimited free time until next Monday, here's some more:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103696697201341&w=2

Some parts of that post have been fixed.  I haven't taken the time to read
the rest of the thread (I don't remember that thread being very long).

However, I'm all but positive the problems Viro points out in this post
still apply:  
http://marc.theaimsgroup.com/?l=linux-kernel&m=107223747630894&w=2

These posts are out there and they are _not_ hard to find at all.  That
last one was from about two weeks ago.  The other is much older, and I'd
have to do some digging in ugly, ugly code to find points that still
apply.  However, as I started this paragraph by saying, this stuff isn't
hard to find at all.

Please consider doing your own homework.  It's not like discussion of
devfs and its problems has been rare.

Thank you.

-- 
Alex Goddard
agoddard at purdue.edu
