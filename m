Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286692AbSAFB3E>; Sat, 5 Jan 2002 20:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286699AbSAFB2o>; Sat, 5 Jan 2002 20:28:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45321 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286692AbSAFB2m>; Sat, 5 Jan 2002 20:28:42 -0500
Date: Sat, 5 Jan 2002 17:27:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Davide Libenzi <davidel@xmailserver.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.33.0201060349380.3424-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0201051722540.24370-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 6 Jan 2002, Ingo Molnar wrote:
>
> (if Davide's post gave you the impression that my patch doesnt do per-CPU
> queues then i'd like to point out that it does so. Per-CPU runqueues are a
> must for good performance on 8-way boxes and bigger. It's just the actual
> implementation of the 'per CPU queue' that is O(1).)

Ahh, ok. No worries then.

At that point I don't think O(1) matters all that much, but it certainly
won't hurt. UNLESS it causes bad choices to be made. Which we can only
guess at right now.

Just out of interest, where have the bugs crept up? I think we could just
try out the thing and see what's up, but I know that at least some
versions of bash are buggy and _will_ show problems due to the "run child
first" behaviour. Remember:  we actually tried that for a while in 2.4.x.

[ In 2.5.x it's fine to break broken programs, though, so this isn't that
  much of an issue any more. From the reports I've seen the thing has
  shown more bugs than that, though. I'd happily test a buggy scheduler,
  but I don't want to mix bio problems _and_ scheduler problems, so I'm
  not ready to switch over until either the scheduler patch looks stable,
  or the bio stuff has finalized more. ]

		Linus

