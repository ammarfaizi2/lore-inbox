Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135181AbRDRN5V>; Wed, 18 Apr 2001 09:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135180AbRDRN5M>; Wed, 18 Apr 2001 09:57:12 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:2054 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135181AbRDRN5D>;
	Wed, 18 Apr 2001 09:57:03 -0400
Date: Wed, 18 Apr 2001 09:58:02 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.1.5, more comments
Message-ID: <20010418095802.B17193@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010417174407.A6667@thyrsus.com> <5.0.2.1.2.20010418020921.03e99d40@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.0.2.1.2.20010418020921.03e99d40@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Wed, Apr 18, 2001 at 02:12:00AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk>:
> A few comments on cml2 1.1.5 running on my Pentium 133S (make menuconfig, 
> fastmode):
> 
> - Instantaneous moving up/down! Excellent!

A consequence of getting the incremental-refresh logic right.
 
> - Thanks for dark blue! The cyan was barely readable. Now all the colours 
> are nicely readable. I don't necessarily like your choice of colours but as 
> long as I can read the text, that's fine.

It's a difficult balancing act.  A lot of the people asking for color changes
aren't aware of some of the constraints -- one of them being that 12% of the 
male population has red-green color blindness.  Blue turns out to be about the
only color that people with any form of color blindness can recognize.

> - When I set something to yes it goes green. When I then set something else 
> to yes the new one goes green, too, but the old one also remains green. Is 
> this intended? (i.e. does green mean "already visited" or something like 
> that?) Also, on the CPU selection menu, it started off with two of the CPUs 
> already in green (but only one with a yes). Is that a feature or a bug?

That's right. Green means "visited or set".

> - Moving left/right can still be quite painfully slow...

I know.  The basic problem here is that the configurator has to recalculate
visibilities for every item in the new nenu.  I have some ideas for speed-
tuning this.

> - Setting options is sometimes very slow, sometimes ok... (depends on 
> complexity of underlying rules I guess)

Yes.  There is at least one more major speedup I may be able to get out
of this.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Whether the authorities be invaders or merely local tyrants, the
effect of such [gun control] laws is to place the individual at the 
mercy of the state, unable to resist.
        -- Robert Anson Heinlein, 1949
