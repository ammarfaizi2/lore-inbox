Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271987AbRIIPSp>; Sun, 9 Sep 2001 11:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271995AbRIIPSf>; Sun, 9 Sep 2001 11:18:35 -0400
Received: from colorfullife.com ([216.156.138.34]:58891 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S271987AbRIIPSZ>;
	Sun, 9 Sep 2001 11:18:25 -0400
Message-ID: <001201c13942$b1bec9a0$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Andrea Arcangeli" <andrea@suse.de>
Cc: <linux-kernel@vger.kernel.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        <torvalds@transmeta.com>
In-Reply-To: <3B9B4CFE.E09D6743@colorfullife.com> <20010909162613.Q11329@athlon.random>
Subject: Re: Purpose of the mm/slab.c changes
Date: Sun, 9 Sep 2001 17:18:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> it provides lifo allocations from both partial and unused slabs.
>

lifo/fifo for unused slabs is obviously superflous - free is free, it
doesn't matter which free page is used first/last.
The partial slabs are already lifo: if a slab goes from full to partial,
it's added to the head of the partial list.

> You
> should benchmark it with a real load, not with dummy
> allocations/freeing.
>
Did you run any benchmarks? If yes, could you post them?

What I did was checking the number of branches in the hot path
(increased), the code length (increased) and execution time with dummy
loads (slower).

--
    Manfred



