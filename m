Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317304AbSFREGF>; Tue, 18 Jun 2002 00:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317305AbSFREGE>; Tue, 18 Jun 2002 00:06:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49929 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317304AbSFREGE>; Tue, 18 Jun 2002 00:06:04 -0400
Date: Mon, 17 Jun 2002 21:06:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: george anzinger <george@mvista.com>
cc: Matthew Wilcox <willy@debian.org>, Robert Love <rml@mvista.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Replace timer_bh with tasklet
In-Reply-To: <3D0EACCA.3290139@mvista.com>
Message-ID: <Pine.LNX.4.44.0206172104450.1164-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Jun 2002, george anzinger wrote:
>
> This patch replaces the timer_bh with a tasklet.  It also introduces a
> way to flag a tasklet as a must run (i.e. do NOT kick up to ksoftirqd).
>
> It make NO sense to pass timer work to a task.

I hate adding infrastructure that isn't needed.

Is there any reason why it would be _wrong_ to pass the timer work to a
task? In particular, is it really any more wrong than anything else?

I don't see that there is any difference between a timer bh and any other
BH.

		Linus

PS. Your email is also seriously whitespace-damaged, so the patch
wouldn't have worked anyway.


