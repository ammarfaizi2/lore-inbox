Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbTHVB6t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 21:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbTHVB6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 21:58:49 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:14209
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262981AbTHVB6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 21:58:45 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Chris Friesen <cfriesen@nortelnetworks.com>
Subject: Re: [PATCH] Re: [PATCH] scsi.h uses "u8" which isn't defined.
Date: Thu, 21 Aug 2003 21:58:23 -0400
User-Agent: KMail/1.5
Cc: Jeff Garzik <jgarzik@pobox.com>, Jamie Lokier <jamie@shareable.org>,
       "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <lRjc.6o4.3@gated-at.bofh.it> <200308212032.25334.rob@landley.net> <3F4568D2.5080705@nortelnetworks.com>
In-Reply-To: <3F4568D2.5080705@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308212158.23678.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 August 2003 20:50, Chris Friesen wrote:

> > So I take it one of the goals of cleaned and pressed kernel-ABI headers
> > for 2.7 would be to have them distributable under LGPL?  (Just trying to
> > be explicit, here...)
>
> I thought that this case (including kernel headers) was the whole point
> of the exemption in the COPYING file.  Am I missing something?

It's legal contortionism, and it might leave some dangling technicalities.

The Linux kernel is licensed under the GPL.  Linus's statements are just his 
interpretation of what consitutes a derived work, and hence the scope of the 
GPL.  (So it's PROBABLY not an incompatable additional license clause thingy 
that makes it "not GPL" for the purpose of linking GPL code to it.)  But lots 
of other people's code has been combined with Linus's, and they might 
consider their code under the straight GPL (sans adendum).

Whether Linus's word is final on this matter is up to a judge.  (It PROBABLY 
is, since he's the project maintainer and the project license is "GPL plus 
this memo about derived work interpretation", and anybody who contributes to 
the project without knowing that is Not Paying Attention.  Certainly all the 
contributors have had warning about this when submitting code to Linux for 
more than the past 3 years (which might be the statute of limitations, 
depending on who you ask), so for code THEY contributed we should be okay.  
The corner case is when somebody other than the code's author lifts code from 
other GPL projects and puts it in Linux, but then again that's not amazingly 
common either since how many other GPL operating system kernels do you see 
out there?  (And even then, if Linus's guide is an interpretation about the 
scope of derived works rather than a license adendum, then it may not 
actually be incompatable with the GPL, but who knows...)

All this is hair splitting, but we've all seen what happens when companies 
with more lawyers than sense decide they have no profitable business model to 
live for, buy a bunch of liquor, and pledge to take their friends out with 
them.  Nobody as ornery and stupid as SCO has sued over this fine point yet 
to give us a straw man to shoot down, so the issue hasn't been resolved in 
court yet.  I can't see SCO suing to EXTEND the reach of the GPL right now, 
so it's not an immediate pressing issue.  And if it did, Linus would be the 
main wronged party, who A) doesn't WANT damages, B) would be thrilled to 
settle out of court for a gift certificate to Wendy's or something, C) could 
obviously whip out a kernel-ABI package in an afternoon to remedy it, D) 
would probably rip out the contributions of any author who made a major stink 
about never taking even a typo correction patch from them again.

But it would be nice to clean it up beforehand anyway.  The LGPL exists for a 
reason...

(And predicting SCO's actions based on what's good for their continued 
financial or legal health would not have been a particularly accurate 
prognostication technique over the past six months...)

This whole issue is about on the level of "do not remove this mattress tag", 
by the way.  That's why people have been so complacent about it so far...

> Chris

Rob

P.S.  Even if I was a lawyer, which I'm not, you'd have to be insane to take 
legal advice from a stranger on the internet who you hadn't even paid a 
retainer to.  If you really care, go find a lawyer who understands 
intellectual property as applied to software, and the GPL specifically, and 
ask them.  (This may take some time.  I can think of four in the whole of 
north america, and two of them have asked ME for a second opinion...)

P.P.S.  Don't even ASK about the "restricted to V2, not later versions" thing.  
I'm just not going there right now...

P.P.P.S.  If you're REALLY bored, might I suggest getting a copy of "Legal 
Battles that Shaped the Computer Industry".  (It's dry reading, but where 
else are you going to find out about a lawsuit between AT&T and Franklin Ace 
that probably helped lead to both AT&T's commercialization of Unix and the 
formation of the Free Software Foundation?  Of course you have to supply half 
the context yourself...)  It's reviewed here: 
http://www.hmdc.harvard.edu/micah_altman/papers/battles.pdf
