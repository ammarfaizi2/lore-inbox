Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277665AbRJVTDj>; Mon, 22 Oct 2001 15:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277655AbRJVTD3>; Mon, 22 Oct 2001 15:03:29 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:6414 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S277686AbRJVTDR>; Mon, 22 Oct 2001 15:03:17 -0400
Date: Mon, 22 Oct 2001 15:03:52 -0400
Message-Id: <200110221903.f9MJ3qZ16095@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10ac10, cdrecord 1.9-6, Mitsumi CR-4804TE: lock up burning too large image
X-Newsgroups: linux.dev.kernel
In-Reply-To: <20011021135455.C1598@niksula.cs.hut.fi>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011021135455.C1598@niksula.cs.hut.fi> vherva@niksula.hut.fi wrote:
| When (accidentally) trying to burn ~670MB onto a 74" cdr disk, I experienced
| a complete lock up.
|                                                                                 
| It went to 99% (as one would expect), and then drive began giving weird
| sounds - as if it was moving the head from start to end over and over. After
| a short while, the whole system locked up, no mouse, keyboard, caps lock,
| ctrl-alt-del, alt-sysrq-{s,u,b}.
|                                                                                 
| It used to give a nice error when disk size was exceeded with 2.2.18pre19
| and a tad older cdrecord (1.9-something (1.10-4 failed on 2.2 BTW, giving
| error on mmapping /dev/null)).
|                                                                                 
| I assume this is a kernel thing...

  You are probably correct, but you might try running as a user other
than root, with proper permissions on the device. cdwrite tries to run
with realtime priority, and I don't know just how tightly a realtime
process could lock the systems if it gets its knickers in a twist.

  You might also try software watchdog, I would expect it to reboot if
the kernel is up but the RT process is looping, such as waiting for a
status to change or some such.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
