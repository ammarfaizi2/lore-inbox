Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264964AbRGNWon>; Sat, 14 Jul 2001 18:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264959AbRGNWoc>; Sat, 14 Jul 2001 18:44:32 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:28682 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S264964AbRGNWoO>; Sat, 14 Jul 2001 18:44:14 -0400
Date: Sat, 14 Jul 2001 15:44:15 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Stephen Frost <sfrost@snowman.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Starfire issues
In-Reply-To: <20010714181607.O11136@ns>
Message-ID: <Pine.LNX.4.33.0107141535280.24347-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jul 2001, Stephen Frost wrote:

> Hello,
> 
> 	I've been having some trouble with a starfire I have in that it seems
> 	to drop packets every once in a while for a little bit and then start
> 	up again.  Also getting strange kernel messages:
> 
> ----
> eth2: Increasing Tx FIFO threshold to 320 bytes
> eth2: Something Wicked happened! 2049001.
> eth2: Increasing Tx FIFO threshold to 496 bytes
> eth2: Something Wicked happened! 2049001.
> ----

Well, there are two issues here. First, the "something wicked happened"  
message is bogus and should not get printed. I have to sit down and
analyze all the bits in the status, because somehow it keeps passing my
filters when it shouldn't.

The second is that while it's somewhat normal to have the FIFO threshold
increased a few times, especially when there is lots of activity on the
PCI bus, the value really shouldn't have to go very high. So maybe you
have a video card or something else that hogs the bus a lot? A Matrox card 
runnin XFree4.x, maybe?

> 	This happens on other interfaces, not just this one.  The kernel being
> 	used is stock 2.4.6-ac2.  Would the patches you've posted to lkml help?
> 	If so I can give them a shot...

Hmm. I'm really unsure of which driver version is in 2.4.6-ac2, but ac3 
should have the latest, including all the patches I posted to the list. So 
if you could give that kernel a whirl, it would be very useful.

Other things of interest, if ac3 still gives you troubles:

- the speed and the duplex mode reported by the driver (dmesg will have 
them, the syslog logs might not)
- whether you are using Adaptec's firmware (converted from their Novell 
drivers)

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

