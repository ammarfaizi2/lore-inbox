Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbTJTLzj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 07:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbTJTLzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 07:55:39 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:56839 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262546AbTJTLzh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 07:55:37 -0400
Date: Mon, 20 Oct 2003 13:55:33 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where's the bzip2 compressed linux-kernel patch?
Message-ID: <20031020115533.GA5646@alpha.home.local>
References: <200310180018.21818.rob@landley.net> <200310191900.47300.rob@landley.net> <20031020042837.GA4994@alpha.home.local> <200310200047.53468.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310200047.53468.rob@landley.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 20, 2003 at 12:47:52AM -0500, Rob Landley wrote:
 
> > > And no, gzip -9 does not add anything to decompression time, only
> > > compression time.
> >
> > Where did you get this interesting idea ? every decompressor needs
> > decompression time.
> 
> I mean that the -9 version of gzip does not take any more time to decompress 
> than the -1 version does, it only affects how many matches are checked in the 
> dictionary before it stops looking for a shorter match.  During decompression 
> the offsets are all stored, it doesn't matter how they were calculated.

OK, I misunderstood your statement. I thought you were saying that gunzip
costs nothing !

> Interesting.  So you're suggesting that your algorithm is optimized for a 
> processor with no L1 or L2 cache whatsoever?  Or are you suggesting that an 
> algorithm that takes upwards of 3 seconds on a system that maxed out at 16 
> mhz and had a 16 bit data path, a system with a maximum memory throughput 
> slower than modern low-end hard drives (16mhz*2 bytes is 32 megabyts per 
> second, and half for read and half for write is 16 megabytes per second when 
> copying data without actually PROCESSING any of it, and this glosses over the 
> fact that with no instruction cache you'll never see even close to that 
> theoretical throughput on any code snippet longer than "rep movsw")...  That 
> this algorithm is slow enough to be a legitimate optimization target and 
> worth using closed source software to optimize this bottleneck.

No, I simply meant that I *observed* consequent gains on this rather limited
platform (it's 33 Mhz, BTW), and I think that if the decompression time is
unnoticeable on it, it will also be on any newer hardware.

> Are you really suggesting that gzip isn't fast enough?  (Out of morbid 
> curiosity, how long did it take the bios code to boot up this straw man to 
> the point where it loaded the boot sector?)

I'm not saying that gzip isn't fast enough, and yes the bios takes longer.

> No, I posted a link to code.  And I offered to use that code to update an 
> existing kernel patch if I could track it down, which I did.  (And I'm 
> working on a 2.6 port with the new engine, albeit not at a particularly high 
> priority seeing as we're in the middle of a code freeze...)
> 
> You're welcome to code up your own patch to do whatever you darn well please.  
> I'm not interested.

I don't want to code it, and never asked you to code it. I stated that this
code already exists, and all that would be needed is its author to agree to
open it. Then if he did, it would even save you some time coding your bzip2
version.

> You suggested I spend my free time to code up a patch to support a closed 
> source compressor I'd never heard of.  I've taken it under advisement, and 
> filed it appropriately.

I didn't suggest to code it (since it already exists), but only to study it
among other algos. I'm sorrt you took it for advertisement while it really
was not.

> Good for you.  Code up a patch, so I can start ignoring code instead of just 
> ignoring suggestions.

I don't want to fight, you clearly stated that you don't want to hear about
this one. That's OK, period. I can still use upx as I did before if I need.
I repeat, I was only *suggesting* something which already exists, but is not
(yet?) open source.

Regards,
Willy

