Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283354AbRK3JEe>; Fri, 30 Nov 2001 04:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283574AbRK3JEZ>; Fri, 30 Nov 2001 04:04:25 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:174 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S283354AbRK3JEK>;
	Fri, 30 Nov 2001 04:04:10 -0500
Date: Fri, 30 Nov 2001 04:04:07 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [LART] pc_keyb.c changes
In-Reply-To: <Pine.GSO.4.21.0111300252030.13367-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0111300354080.13367-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Nov 2001, Alexander Viro wrote:

> 	Could the person who switched from BKL to spin_lock_irqsave() in
> pc_keyb.c please share whatever the hell he had been smoking?  Free clue:
> disabling interrupts for long intervals to improve scalability is right up
> there with fighting for peace and fucking for virginity.
> 
> 	Linus, could we please revert that crap and feed the authors to
> Larry?  If they are religious about Scalability At Any Cost, Common Sense
> Be Damned(tm) - let's give them a chance to become martyrs...

BTW, while we are at it, one is _not_ supposed to do inclusion to/removal from
single-linked list without any exclusion whatsoever.  Example:
drivers/input/evdev.c::evdev_{open,release}().  Or drivers/input/joydev.c
and drivers/input/mousedev.c, for that matter.  Sigh...

