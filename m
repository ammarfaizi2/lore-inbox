Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265607AbUAQNQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 08:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265963AbUAQNQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 08:16:28 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:30529 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S265607AbUAQNPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 08:15:38 -0500
From: Bart Samwel <bart@samwel.tk>
To: Timothy Miller <miller@techsource.com>, Valdis.Kletnieks@vt.edu
Subject: Re: [OT] Redundancy eliminating file systems, breaking MD5, donating money to OSDL
Date: Sat, 17 Jan 2004 14:15:31 +0100
User-Agent: KMail/1.5.4
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4008480F.70206@techsource.com> <200401162037.i0GKbgWY005453@turing-police.cc.vt.edu> <4008509B.2060707@techsource.com>
In-Reply-To: <4008509B.2060707@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401171415.31645.bart@samwel.tk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 January 2004 21:59, Timothy Miller wrote:
> Valdis.Kletnieks@vt.edu wrote:
> > On Fri, 16 Jan 2004 15:22:39 EST, Timothy Miller <miller@techsource.com>  
said:
> >>Think about it!  If we had a filesystem that actually DID this, and it
> >>was in the Linux kernel, it would spread far and wide.  It's bound to
> >>happen that someone will identify a collision.  We then report that to
> >>the committee offering the reward and then donate it to OSDL to help
> >>Linux development.
> >
> > Actually, it's *not* "bound to happen".  Figure out the number of blocks
> > you'd need to have even a 1% chance of a birthday collision in a 2**128
> > space.
> >
> > And you'd need that many disk blocks on *a single system*.
> >
> > Then figure out the chances of a collision on a small machine that only
> > has 20 or 30 terabytes (yes, in this case terabytes is small).
>
> Certainly.  No one machine is going to find it in a reasonable period.
> OTOH, if a million machines were doing it, it increases the chances by
> just that much.

Let's take a look at the chances. 30 terabytes is, in a best-case scenario 
(with 512-byte blocks) about 6e10 blocks. That would be roughly 
6e10*6e10*(2**(-128)), or about 1e-17. With a hundred million machines, the 
chances of a collision would be about 1e-9, disregarding the fact that all 
these machines have a large chance of containing similar blocks -- their data 
isn't truly random, so some blocks have a larger chance of occurring than 
others. The data sets on the machines are probably reasonably static, so if 
the collision isn't found *at once* the chances of it occurring later are 
much smaller. So, even under the most positive assumptions, with a hundred 
million machines with 30 terabytes of storage each, it's extremely probable 
that you won't find a collision. (A 96-bit hash could have been broken with 
this setup however. :) )

-- Bart
