Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135553AbRDSFU3>; Thu, 19 Apr 2001 01:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135554AbRDSFUW>; Thu, 19 Apr 2001 01:20:22 -0400
Received: from tinylinux.tip.CSIRO.AU ([130.155.192.102]:33797 "EHLO
	mobilix.atnf.CSIRO.AU") by vger.kernel.org with ESMTP
	id <S135553AbRDSFUK>; Thu, 19 Apr 2001 01:20:10 -0400
Date: Thu, 19 Apr 2001 15:06:44 +1000
Message-Id: <200104190506.f3J56ik01292@mobilix.atnf.CSIRO.AU>
From: Richard Gooch <rgooch@atnf.csiro.au>
To: "Edward S. Marshall" <esm@logic.net>
Cc: Rik van Riel <riel@conectiva.com.br>, esr@thyrsus.com,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: Cross-referencing frenzy
In-Reply-To: <20010418233618.A28546@labyrinth.local>
In-Reply-To: <200104190400.f3J40Dm00992@mobilix.atnf.CSIRO.AU>
	<Pine.LNX.4.21.0104190109480.1685-100000@imladris.rielhome.conectiva>
	<20010418233618.A28546@labyrinth.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edward S. Marshall writes:
> On Thu, Apr 19, 2001 at 01:11:07AM -0300, Rik van Riel wrote:
> > On Thu, 19 Apr 2001, Richard Gooch wrote:
> > > esr wrote:
> > > > CONFIG_DEVFS: Documentation/filesystems/devfs/ChangeLog
> > > 
> > > These are options that used to be used,
> >     ....
> > > These should not be removed
> > 
> > This makes no sense at all.  Do you have any particular
> > reason for keeping this deadwood around ?
>
> Look at the filename. ;-) They're not being kept around, they just
> happen to be mentioned in the devfs ChangeLog, and esr's overzealous
> crossref tool caught them. *grin*

Exactly. A ChangeLog should pre preserved for all time. It is an
incredibly useful tool. Many times I've gone back and checked when
something was done, and in relation to other changes before, after or
around the same time.

> Perhaps the tool should be modified to exempt comments in code and
> files in Documentation/*? :-)

Except the CONFIG_APM_IGNORE_SUSPEND_BOUNCE was in the apm.c source
file (in a ChangeLog). So just ignoring Documentation/ won't solve the
problem.

One trick I've used on my own (non-Linux) code is to insert a space
after the first underscore. That fools the global search, but leaves
the essence of the ChangeLog entry. It's a bit hackish, though.

A cleaner solution is to parse the source code, ignoring comment
blocks. However, that's a bit more work.

Either way, the solution adopted has to kill off the false
positives. It's not good enough to build up a list of CONFIG options
to ignore, as it will get stale. Furthermore, that list might be
overlooked by someone on a cleanup crusade, with the result that a
patch gets sent to Linus which "fixes" the "broken" CONFIG symbols.
And since too many global patches are not Cc'ed to the maintainers,
this kind of crap slips by.

Frankly, I'd rather see stale symbols left around, and have it really
difficult to detect them. Eric is making a tool that makes it too easy
for a random person to "detect" "problems" and then "fix" them,
thinking that "progess" is being made. In reality, it's just regress.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
