Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129423AbQKHLYM>; Wed, 8 Nov 2000 06:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129584AbQKHLXw>; Wed, 8 Nov 2000 06:23:52 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:48135 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S129423AbQKHLXl>; Wed, 8 Nov 2000 06:23:41 -0500
Date: Wed, 8 Nov 2000 12:34:02 +0100 (MET)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Looking for better VM
In-Reply-To: <Pine.LNX.4.05.10011061954520.26327-100000@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.21.0011081052010.1242-100000@fs129-190.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Nov 2000, Rik van Riel wrote:
> On Mon, 6 Nov 2000, Szabolcs Szakacsits wrote:
> > On Wed, 1 Nov 2000, Rik van Riel wrote:
> > > but simply because 
> > > it appears there has been amazingly little research on this 
> > > subject and it's completely unknown which approach will work 
> > There has been lot of research, this is the reason most Unices support
> > both non-overcommit and overcommit memory handling default to
> > non-overcommit [think of reliability and high availability].
> It's a shame you didn't take the trouble to actually
> go out and see that non-overcommit doesn't solve the
> "out of memory" deadlock problem.

Read my *entire* email again and please try to understand. No deadlock
at all since kernel *falls back* to process killing if memory reserved
for *root* is also out.

You could ask, so what's the point for non-overcommit if we use
process killing in the end? And the answer, in *practise* this almost
never happens, root can always clean up and no processes are lost
[just as when disk is "full" except the reserved area for root]. See?
Human get a chance against hard-wired AI.

I also didn't say non-overcommit should be used as default and a
patch http://www.cs.helsinki.fi/linux/linux-kernel/2000-13/1208.html,
developed for 2.3.99-pre3 by Eduardo Horvath and unfortunately was
ignored completely, implemented it this way. 

And with a runtime tunable OOM killer, Linux really would beat the
competitors [where it is quite behind at present] in this area. See?
Human get a chance against hard-wired AI again.

Believe me, there are people [don't read only kernel lists] who wants
a reliable and controllable system and where the kernel doesn't play
Russan rulet.

[who missed my first email: forget about mem quotas and the the
non-scalable "add GB's of swap" in this discussion].

> [if you want an explanation, look in the archives,
> we've explained this a dozen times now]
 
I've been reading the list much longer than you and really pissed of
that after so many years of discussions, this problem and user
requirements^Wwishes are still not understood. You think black and
white but the world is colorful.

	Szaka

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
