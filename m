Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265663AbUATTWf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 14:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265667AbUATTWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 14:22:34 -0500
Received: from pdbn-d9bb9ed2.pool.mediaWays.net ([217.187.158.210]:29701 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S265663AbUATTVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 14:21:33 -0500
Date: Tue, 20 Jan 2004 20:21:14 +0100
From: Matthias Schniedermeyer <ms@citd.de>
To: Bart Samwel <bart@samwel.tk>
Cc: Timothy Miller <miller@techsource.com>, Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Redundancy eliminating file systems, breaking MD5, donating money to OSDL
Message-ID: <20040120192114.GA30755@citd.de>
References: <4008480F.70206@techsource.com> <200401162037.i0GKbgWY005453@turing-police.cc.vt.edu> <4008509B.2060707@techsource.com> <200401171415.31645.bart@samwel.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401171415.31645.bart@samwel.tk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 17, 2004 at 02:15:31PM +0100, Bart Samwel wrote:
> On Friday 16 January 2004 21:59, Timothy Miller wrote:
> > Valdis.Kletnieks@vt.edu wrote:
> > > On Fri, 16 Jan 2004 15:22:39 EST, Timothy Miller <miller@techsource.com>  
> said:
> > >>Think about it!  If we had a filesystem that actually DID this, and it
> > >>was in the Linux kernel, it would spread far and wide.  It's bound to
> > >>happen that someone will identify a collision.  We then report that to
> > >>the committee offering the reward and then donate it to OSDL to help
> > >>Linux development.
> > >
> > > Actually, it's *not* "bound to happen".  Figure out the number of blocks
> > > you'd need to have even a 1% chance of a birthday collision in a 2**128
> > > space.
> > >
> > > And you'd need that many disk blocks on *a single system*.
> > >
> > > Then figure out the chances of a collision on a small machine that only
> > > has 20 or 30 terabytes (yes, in this case terabytes is small).
> >
> > Certainly.  No one machine is going to find it in a reasonable period.
> > OTOH, if a million machines were doing it, it increases the chances by
> > just that much.
> 
> Let's take a look at the chances. 30 terabytes is, in a best-case scenario 
> (with 512-byte blocks) about 6e10 blocks. That would be roughly 
> 6e10*6e10*(2**(-128)), or about 1e-17. With a hundred million machines, the 
> chances of a collision would be about 1e-9, disregarding the fact that all 
> these machines have a large chance of containing similar blocks -- their data 
> isn't truly random, so some blocks have a larger chance of occurring than 
> others. The data sets on the machines are probably reasonably static, so if 
> the collision isn't found *at once* the chances of it occurring later are 
> much smaller. So, even under the most positive assumptions, with a hundred 
> million machines with 30 terabytes of storage each, it's extremely probable 
> that you won't find a collision. (A 96-bit hash could have been broken with 
> this setup however. :) )

There is one fundemental braino in the discussion.

Only HALF the bits are for preventing "accidental" collisions. (The
"birthday" thing). The rest is for preventing to "brute force" an input
that produces the same MD5.(*)

So MD5 has only 2**64 Bits against accidental collsions
Btw. I already had (a/the) MD5 collision(*2) in my life.

So you'd need SHA256 or SHA512 to be "really sure(tm)".



*: AFAIR i read this in the specs of SHA1 (160 bits). So i guess this is
also true for MD5.

*2: I had a direcory of about 1,5 Million images and "md5sum"med them to
eliminate doubles. The Log-file, at one point, had the same md5sum as
one of the pictures.

Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

