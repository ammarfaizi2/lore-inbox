Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287359AbSA3Akx>; Tue, 29 Jan 2002 19:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287493AbSA3Akp>; Tue, 29 Jan 2002 19:40:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62727 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287359AbSA3Akc>; Tue, 29 Jan 2002 19:40:32 -0500
Date: Tue, 29 Jan 2002 16:39:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Rob Landley <landley@trommello.org>, Skip Ford <skip.ford@verizon.net>,
        <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.LNX.4.33L.0201292205370.32617-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33.0201291610020.1747-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, Rik van Riel wrote:
>
> That's fine with me, but _who_ do I send VM patches to if
> I can't send them to you ?

The VM stuff right now seems to be Andrea, Dave or you yourself (right now
I just wish you would split up your patches like Andrea does, that way I
can cherry-pick).

> There is no maintainer for mm/* or kernel/*, it's just you.

As to kernel/ there are actually maintainers for some sub-areas, the most
noticeable being Ingo on the scheduler. The rest of kernel/ hasn't ever
been much of a problem, really.

The VM is a big issue, of course. And that one isn't likely to go away
anytime soon as a point of contention. And it's not easy to modularize,
apart from the obvious pieces (ie "filemap.c" vs the rest).

You may not believe me when I say so, but I personally _really_ hope your
rmap patches will work out. I may not have believed in your patches in a
2.4.x kind of timeframe, but for 2.6.x I'm more optimistic. As to how to
actually modularize it better to make points of contention smaller, I
don't know how.

At the same time, while I can understand your personal pain, I don't think
most of the problems have been with the VM (maintenance-wise, that is.
Most of the _technical_ problems really have been with the VM, it's just
the most complex piece).

		Linus

