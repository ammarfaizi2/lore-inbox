Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131739AbRCOOZj>; Thu, 15 Mar 2001 09:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131737AbRCOOZ3>; Thu, 15 Mar 2001 09:25:29 -0500
Received: from srv01s4.cas.org ([134.243.50.9]:13530 "EHLO srv01.cas.org")
	by vger.kernel.org with ESMTP id <S131735AbRCOOZU>;
	Thu, 15 Mar 2001 09:25:20 -0500
From: Mike Harrold <mharrold@cas.org>
Message-Id: <200103151424.JAA12827@mah21awu.cas.org>
Subject: Re: Is swap == 2 * RAM a permanent thing?
To: riel@conectiva.com.br (Rik van Riel)
Date: Thu, 15 Mar 2001 09:24:28 -0500 (EST)
Cc: mharris@opensourceadvocate.org (Mike A. Harris),
        linux-kernel@vger.kernel.org (Linux Kernel mailing list)
In-Reply-To: <Pine.LNX.4.21.0103151005210.4165-100000@imladris.rielhome.conectiva> from "Rik van Riel" at Mar 15, 2001 10:08:50 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The reason is that the Linux 2.4 kernel no longer reclaims swap
> space on swapin (2.2 reclaimed swap space on write access, which
> lead to fragmented swap space in lots of workloads).
> 
> This means that a lot of memory ends up "duplicated" in RAM and
> in swap.
> 
> I plan on doing some code to reclaim swap space when we run out,
> but Linus doesn't seem to like that idea very much. His argument
> (when you're OOM, you should just fail instead of limp along)
> makes a lot of sense, however, and the reclaiming of swap space
> isn't really high on my TODO list ...
> 
> OTOH, for people who have swap < RAM and use it just as a small
> overflow area, Linus' argument falls short, so I guess some time
> in the future we will have code to reclaim swap space when needed.

I have some questions on this.

1) If a process uses swap space and then later (after being paged
   into memory -- or even not) it completes, is killed, etc., is
   the swap space reclaimed then?

2) If a process uses swap, is paged into memory, and is then swapped
   out again, does it re-use the same swap as before?

If the answer to either question is no, then IMHO, that's a pretty
serious design flaw.

Regards,

/Mike
