Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268247AbTCFRyV>; Thu, 6 Mar 2003 12:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268253AbTCFRyV>; Thu, 6 Mar 2003 12:54:21 -0500
Received: from mx1.elte.hu ([157.181.1.137]:46520 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S268247AbTCFRyU>;
	Thu, 6 Mar 2003 12:54:20 -0500
Date: Thu, 6 Mar 2003 19:04:35 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <Pine.LNX.4.44.0303060949120.7720-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0303061900230.16118-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Linus Torvalds wrote:

> But the proof is in the pudding. Does this actually make things appear
> "nicer" to people? Or is it just another wanking session?

yes, it would be interesting to see Andrew's experiments redone for the 
following combinations:

   - your patch
   - my patch
   - both patches

in fact my patch was tested and it mostly solved the problem for Andrew,
but i'm now convinced that the combination of patches will be the real
solution for this class of problems - as that will attack _both_ ends,
both CPU hogs are recognized better, and interactivity detection
interactivity-distribution is improved.

but neither patch solves all problems. The typical DRI game just does
nothing but calls the DRI ioctl() and burns CPU time. So i'm convinced we
need one more way to help the kernel identify tasks that are important to
people - increasing the priority of those tasks programmatically is
certainly a workable solution, but there might be other solutions.

	Ingo

