Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbRAEALV>; Thu, 4 Jan 2001 19:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129563AbRAEALL>; Thu, 4 Jan 2001 19:11:11 -0500
Received: from nrg.org ([216.101.165.106]:53290 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S129348AbRAEALE>;
	Thu, 4 Jan 2001 19:11:04 -0500
Date: Thu, 4 Jan 2001 16:10:55 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: ludovic fernandez <ludovic.fernandez@sun.com>
cc: Roger Larsson <roger.larsson@norran.net>,
        Daniel Phillips <phillips@innominate.de>,
        george anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.0-prerelease: preemptive kernel.
In-Reply-To: <3A550433.52982189@sun.com>
Message-ID: <Pine.LNX.4.05.10101041554520.4946-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, ludovic fernandez wrote:
> This is not the point I was trying to make .....
> So far we are talking about real time behaviour. This is a very interesting/exciting
> thing and we all agree it's a huge task which goes much more behind
> just having a preemptive kernel.

You're right that it is more than just a preemptible kernel, but I don't
agree that it's all that huge.  But this is the third time I have worked
on enabling real-time behavior in unix-like OSes, so I may be biased ;-)

> I'm not convinced that a preemptive kernel is interesting for apps using
> the time sharing scheduling, mainly because it is not deterministic and the
> price of a mmu conntext switch is still way to heavy (that's my 2 cents belief
> anyway).

But as Roger pointed out, the number of extra context switches
introduced by having a preemptible kernel is actually very low.  If an
interrupt occurs while running in user mode, the context switch it may
cause will happen even in a non-preemptible kernel.  I think that
running a kernel compile for example, the number of context switches per
second caused by kernel preemption is probably between 1% and 10% of the
total context switches per second.  And it's certainly interesting to me
that I can listen to MP3s without interruption now, while doing a kernel
build!

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
