Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284272AbRLRRCa>; Tue, 18 Dec 2001 12:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284282AbRLRRCW>; Tue, 18 Dec 2001 12:02:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60173 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284272AbRLRRCN>; Tue, 18 Dec 2001 12:02:13 -0500
Date: Tue, 18 Dec 2001 09:00:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rik van Riel <riel@conectiva.com.br>,
        Davide Libenzi <davidel@xmailserver.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <E16GKvk-0007Sc-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0112180854070.2867-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Dec 2001, Alan Cox wrote:
>
> The scheduler is eating 40-60% of the machine on real world 8 cpu workloads.
> That isn't going to go away by sticking heads in sand.

Did you _read_ what I said?

We _have_ patches. You apparently have your own set.

Fight it out. Don't involve me, because I don't think it's even a
challenging thing. I wrote what is _still_ largely the algorithm in 1991,
and it's damn near the only piece of code from back then that even _has_
some similarity to the original code still. All the "recompute count when
everybody has gone down to zero" was there pretty much from day 1 (*).

Which makes me say: "oh, a quick hack from 1991 works on most machines in
2001, so how hard a problem can it be?"

Fight it out. People asked whether I was interested, and I said "no". Take
a clue: do benchmarks on all the competing patches, and try to create the
best one, and present it to me as a done deal.

		Linus

(*) The single biggest change from day 1 is that it used to iterate over a
global array of process slots, and for scalability reasons (not CPU
scalability, but "max nr of processes in the system" scalability) the
array was gotten rid of, giving the current doubly linked list. Everything
else that any scheduler person complains about was pretty much there
otherwise ;)

