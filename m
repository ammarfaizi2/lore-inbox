Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268084AbTBRW2D>; Tue, 18 Feb 2003 17:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268087AbTBRW2D>; Tue, 18 Feb 2003 17:28:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59140 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268084AbTBRW2B>; Tue, 18 Feb 2003 17:28:01 -0500
Date: Tue, 18 Feb 2003 14:34:09 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Wedgwood <cw@f00f.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Linux v2.5.62 --- spontaneous reboots
In-Reply-To: <Pine.LNX.4.44.0302181408200.1107-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302181426020.1498-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Feb 2003, Linus Torvalds wrote:
> 
> But if it was getting hard to trigger with 2.5.52 too, things might be
> getting hairier and hairier.. If it becomes hard enough to trigger as to
> be practically nondeterministic, a better approach might be to just go
> back to -mjb4, and even if it is still there in -mjb4 try to see which
> part of the patch seems to be making it more stable.

Btw, this is particularly true if it takes you potentially hours to test 
something like 2.5.51 for stability, but you can reboot 2.5.59 at will in 
ten minutes. 

In that case, you can test several vrsions of "2.5.59 + partial -mjb
patches" much more quickly than you can walk backwards in 2.5.x, and try 
to pinpoint the "this part of -mjb makes it much less likely to reboot".

Also, with the -mjb patch there are some new configuration options. For 
example, CONFIG_100HZ on -mjb has very different behaviour than a plain 
2.5.59 kernel that defaults to 1kHz timer clock, and maybe the reason -mjb 
seems more stable is that you may have selected a configuration option 
that made -mjb act differently.

Regardless, it would be very interesting to hear what the -mjb split-down
results would be. Even if the answer might be "at 1kHz timer it is
unstable, at 100Hz it is stable" (and if that were to be it, then you'd
have to walk backwards to 2.5.24 to find the old 2.5.x kernel that had a
slow tick rate).

		Linus

