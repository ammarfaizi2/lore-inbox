Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288957AbSA3IHr>; Wed, 30 Jan 2002 03:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288944AbSA3IHA>; Wed, 30 Jan 2002 03:07:00 -0500
Received: from femail19.sdc1.sfba.home.com ([24.0.95.128]:8934 "EHLO
	femail19.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S288828AbSA3IFF>; Wed, 30 Jan 2002 03:05:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Miles Lane <miles@megapathdsl.net>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Wed, 30 Jan 2002 03:06:15 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Chris Ricker <kaboom@gatech.edu>,
        World Domination Now! <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201291641090.1747-100000@penguin.transmeta.com> <1012354692.1777.4.camel@stomata.megapathdsl.net>
In-Reply-To: <1012354692.1777.4.camel@stomata.megapathdsl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020130080504.JUTO18525.femail19.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 January 2002 08:38 pm, Miles Lane wrote:
> On Tue, 2002-01-29 at 16:44, Linus Torvalds wrote:
> > It might not be a bad idea to just make that "mention maintainer at the
> > top of the file" the common case.
>
> I do similarly when I am testing Gnome software, but there
> I have the CVS sources to look at, including carefully updated
> ChangeLog files.  I find the ChangeLogs and the output of
> "cvs log ChangeLog" to be highly informative and helpful when
> attempting to track down the appropriate person to contact.
> Is it feasible to set up a read-only anonymous cvs server for
> the kernel tree?  It seems to me that it would be nice to
> good to have ChangeLogs for the kernel directories as well.

This isn't necessarily a problem for Linus to handle.

Right now, it's pretty easy to find/generate diffs between each "pre 
release".  Each of those could be incrementally fed into a CVS server, and 
bang, you have a revision history.  The granualrity might not be the 
greatest, but it's a start, and it can be done retroactively.  (I vaguely 
remember hearing some work along these lines...)

Now to get the kind of patch level granuarity that Linus likes to have made 
available to the rest of the world, you need the actual patches, as applied, 
made available.  Getting a patch penguin (I.E. Alan Cox or Dave Jones) to do 
this might not be too hard (as long as it's not too much work), but not 
enough patches go through them at the moment to necessarily make it 
worthwhile.

Long ago I suggested that since the way Linus works is "append various emails 
to a big file, then feed that to patch(1) at the end of a mail run", it 
should be possible to send Linus a perl script that copies the individual 
emails from the big file to a mailing list when he patches his tree.  Not 
just the actual patch, but the whole email with the description of the fix 
and everything.  (Again, no guarantee he wouldn't back them out again, but 
it's something that really requires no extra work on his part, gives 
immediate acknowledgement that he's looked at something, and gives the rest 
of the world access to the level of granularity he expects to receive from 
them.)

Of course until such a script is actually written, with a mailing list set up 
for it to post to (read-only except for Linus), it's just an idle thought I 
haven't had time to pursue.  (The diffs between pre-versions have generally 
been good enough for me personally, so...)

If the "patches-to-linus" list does get implemented, it would probably also 
be fairly easy to automatically match new pre-X->pre-Y diffs against the 
recent patches from the list, and extract most of the information that way.  
(Assuming Linus doesn't modify them too much, or end up taking a lot of 
patches from other sources.  A human would probably still have to do at least 
part of it, but it might be an improvement on just putting the whole big 
version diff in the cvs tree as one lump...)

> 	Miles

Rob
