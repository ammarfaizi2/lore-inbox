Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbWIWVFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWIWVFV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 17:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWIWVFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 17:05:21 -0400
Received: from main.gmane.org ([80.91.229.2]:678 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964921AbWIWVFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 17:05:21 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Forwarded message from Linus Torvalds <torvalds@osdl.org>
Date: Sat, 23 Sep 2006 21:04:52 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnehb8ch.9ia.olecom@deen.upol.cz.local>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 158.194.180.30
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Forwarded message from Linus Torvalds <torvalds@osdl.org> -----

Envelope-to: olecom@flower.upol.cz
Delivery-date: Sat, 23 Sep 2006 19:36:21 +0200
From: Linus Torvalds <torvalds@osdl.org>
To: Oleg Verych <olecom@flower.upol.cz>
cc: David Schwartz <davids@webmaster.com>
Subject: Re: The GPL: No shelter for the Linux kernel?


On Sat, 23 Sep 2006, Oleg Verych wrote:

> 
> On 2006-09-22, Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > I don't actually want people to need to trust anybody - and that very much 
> > includes me - implicitly.
> >
> > I think people can generally trust me, but they can trust me exactly 
> > because they know they don't _have_ to.
> 
> And somebody chooses anoter license, f.e see:
> linux/drivers/video/aty/radeon_base.c

We have always (and will continue to do so) accepted licenses that are 
compatible with the GPLv2 for the kernel. 

That's also the only reason we also have files that are marked "GPLv2 or 
later": that license (the same was as the BSD license) allows a superset 
of what the GPLv2 allows, and is as such compatible.

I think this is a strength, and I also think it's something that most 
developers want. People have to accept the GPLv2 (because the kernel as a 
whole is GPLv2), but it's ok to then allow extended rights for certain 
files. For example, some of the SCSI drivers were co-maintained with the 
BSD's, so having those be dual-licensed was the only sane thing to do.

(And the one you point to is basically co-maintained with X.org, so it 
falls under the same situation).

A pure GPLv3 contribution is obviously not compatible with a GPLv2, but if 
anybody thought that the informal poll was in any way going to remove the 
files that had "v2 or any later", then no. We'll very much continue to 
have various dual-licensed code.

(Some of the dual-licensing isn't even with open source licenses. Some 
people release their code both under the GPLv2 _and_ separately they 
license use their own code in a commercial product too. You just don't see 
that as much in the kernel, since that "separation" tends to happen 
outside, so by the time the code is integrated into the kernel, the 
proprietary licensed version has already been split off).

> > just picked the first screenful of people (and Alan. And later we added 
> > three more people after somebody pointed out that some top people use 
> 
> Alan *is on top* of (old fashioned, gitless):
> 
> $ for i in `find linux/drivers/`
> do dd count=1 <$i | grep @ | sed 's_[^<]*<\(.*@.*\)>[^>]*_\1_g'
> done | sort | uniq -c | sort -rn | most

Well, quite frankly, I don't think the copyright messages in the source 
code is necessarily very good. Some people add them, most don't. 

But yes, for obvious reasons Alan was added _regardless_ of any counts.

> And what about linux/CREDITS ? Creating (even in the past) is also worth.

And what about the old history from BK time? And what about a million 
other ways? There's no "one" right answer, but I doubt you'll find any 
really obviously better answers than the one I picked.

In other words, yes, there are other ways to count things. This was a 
poll. And I do think the list of people was a very good list, because 
while the particular way it was generated (from current -git sources), I 
did actually double-check it different ways (including my own gut feel, 
and verifying that the "author" and "sign-off" lists roughtly matched, 
etc)

Btw, if it makes you feel any better, if you look at the old 
linux-historic archive (which goes back another 3+ years), and do the same 
statistics, it's quite impressive how similar the list would be (Alan 
_did_ show up on that list on his own, btw).

So I claim that my list of people is one of the better lists you can come 
up with. 

The really arbitrary point was the cut-off, and I could have picked 50 or 
a hundred people instead of just a screenful. That's not the point. It's a 
poll, and I do claim it's statistically relevant.

The _real_ thing I wanted to avoid was yet another poll where "loudmouth" 
counted. I've seen enough of those, thank you very much. If I wanted a 
poll where the only thing that counted was how much you love the FSF and 
how willing you were to be vocal about it, I'd have gone to osnews or some 
other random site.

This poll was for the people who actually DO things, not just make 
political noises about licensing.

			Linus

----- End forwarded message -----

