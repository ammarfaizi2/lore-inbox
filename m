Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269177AbRHBWSC>; Thu, 2 Aug 2001 18:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269187AbRHBWRw>; Thu, 2 Aug 2001 18:17:52 -0400
Received: from w146.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.146]:19613 "EHLO
	windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S269184AbRHBWRm>; Thu, 2 Aug 2001 18:17:42 -0400
Date: Thu, 2 Aug 2001 15:17:09 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@heat.gghcwest.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <Pine.LNX.4.33L.0108021900080.5582-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0108021508310.21298-100000@heat.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001, Rik van Riel wrote:

> If you have a proposal on what to do when both ram
> and swap fill up and you need more memory, please
> let me know.
>
> Until then, we'll kill processes when we exhaust
> both memory and swap ;)

I'm telling you that's not what happens.  When memory pressure gets really
high, the kernel takes all the CPU time and the box is completely useless.
Maybe the VM sorts itself out but after five minutes of barely responding,
I usually just power cycle the damn thing.  As I said, this isn't a
classic thrash because the swap disks only blip perhaps once every ten
seconds!

You don't have to go to extremes to observe this behavior.  Yesterday, I
had one box where kswapd used 100% of one CPU for 70 minutes straight,
while user process all ran on the other CPU.  All RAM and half swap was
used, and I/O was heavy.  The machine had been up for 14 days.  I just
don't understand why kswapd needs to run and run and run and run and run
...

I'm very familiar with what should happen on a Unix box when user
processes get huge.  On my FreeBSD and Solaris machines, everything goes
to shit for a few minutes and then it comes back.  Linux used to work that
way too, but I can't count on the comeback in 2.4.

-jwb

