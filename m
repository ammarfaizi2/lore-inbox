Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265437AbSKFAUv>; Tue, 5 Nov 2002 19:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265439AbSKFAUv>; Tue, 5 Nov 2002 19:20:51 -0500
Received: from waste.org ([209.173.204.2]:19688 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S265437AbSKFAUu>;
	Tue, 5 Nov 2002 19:20:50 -0500
Date: Tue, 5 Nov 2002 18:27:08 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: David Schwartz <davids@webmaster.com>
Cc: cfriesen@nortelnetworks.com, Alexander Viro <viro@math.psu.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Entropy from disks
Message-ID: <20021106002708.GA25611@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 03:55:57PM -0800, David Schwartz wrote:
> 
> On Tue, 29 Oct 2002 13:02:39 -0500, Chris Friesen wrote:
> >Oliver Xymoron wrote:
> 
> >I'm not an expert in this field, so bear with me if I make any blunders
> >obvious to one trained in information theory.
> 
> >>The current Linux PRNG is playing fast and loose here, adding entropy
> >>based on the resolution of the TSC, while the physical turbulence
> >>processes that actually produce entropy are happening at a scale of
> >>seconds. On a GHz processor, if it takes 4 microseconds to return a
> >>disk result from on-disk cache, /dev/random will get a 12-bit credit.
> 
> >In the paper the accuracy of measurement is 1ms.  Current hardware has
> >tsc precision of nanoseconds, or about 6 orders of magnitude more
> >accuracy.  Doesn't this mean that we can pump in many more bits into the
> >algorithm and get out many more than the 100bits/min that the setup in
> >the paper acheives?
> 
> 	In theory, if there's any real physical randomness in a timing source, the 
> more accuracy you measure the timing to, the more bits you get.

Not if the timing source is clocked at a substantially slower speed
than the measurement clock and is phase locked. Which is the case.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
