Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262551AbTCIRaw>; Sun, 9 Mar 2003 12:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262552AbTCIRaw>; Sun, 9 Mar 2003 12:30:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56072 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262551AbTCIRau>; Sun, 9 Mar 2003 12:30:50 -0500
Date: Sun, 9 Mar 2003 09:39:28 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Roman Zippel <zippel@linux-m68k.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Zack Brown <zbrown@tumblerings.org>, Larry McVoy <lm@work.bitmover.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
In-Reply-To: <8200000.1047228943@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0303090928570.11894-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Mar 2003, Martin J. Bligh wrote:
> 
> I think it's possible to get 90% of the functionality that most of us
> (or at least I) want without the distributed stuff.

No, I really don't think so.

The distribution is absolutely fundamental, and _the_ reason why I use BK.

Now, it's true that in 90% of all cases (probably closer to 99%) you will
never see the really nasty cases Larry was talking about. People just
don't rename files that much, and more importantly: then whey do, they
very very seldom have anybody else doing the same.

But what are you going to do when it happens? Because it _does_ happen:  
different people pick up the same patch or fix suggestion from the mailing
list, and do that as just a small part of normal development. Are the 
tools now going to break down?

BK doesn't. That' skind of the point. Larry 

> If the "maintainer" heirarchy was a strict tree structure, where you 
> send patches to your parent, and receive them from your children, that
> doesn't seem to need anything particularly fancy to me. 

But it's not, and the above would make BK much less than it is today.

On eof the things I always hated about CVS is how it makes it IMPOSSIBLE 
to "work together" on something between two different random people. Take 
one person who's been working on something for a while, but is chansing 
that one final bug, and asks another person for help. It just DOES NOT 
WORK in the CVS mentality (or _any_ centralized setup).

You have to either share the same sandbox (without any source control
support AT ALL), or you have to go to the central repository and create a
branch (never mind that you may not have write permissions, or that you 
may not know whether it's going to ever be something worthwhile yet).

With BK, the receiver just "bk pull"s. And if he is smart, he does that 
from a cloned repository so that after he's done with it he will just do a 
"rm -rf" or something.

This is FUNDAMENTAL.

And yes, maybe the really hard cases are rare. But does that mean that you 
aren't going to do it?

		Linus

