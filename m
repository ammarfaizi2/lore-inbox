Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbSLTUcF>; Fri, 20 Dec 2002 15:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265039AbSLTUcF>; Fri, 20 Dec 2002 15:32:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13586 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262258AbSLTUcE>; Fri, 20 Dec 2002 15:32:04 -0500
Date: Fri, 20 Dec 2002 12:14:43 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Grant Grundler <grundler@cup.hp.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <mj@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <turukawa@icc.melco.co.jp>, <ink@jurassic.park.msu.ru>
Subject: Re: PATCH 2.5.x disable BAR when sizing
In-Reply-To: <20021220195031.GC21823@cup.hp.com>
Message-ID: <Pine.LNX.4.44.0212201203340.2035-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Dec 2002, Grant Grundler wrote:
>
> Can someone send URL or old mail describing such a broken system?
> (or point me at previous attempts to submit this patch?)

Th eone system I had myself was a Sony PCG-CR1. I don't have any pointers
to the discussion, it was in the late 2.3.x tree if I remember correctly.

> Linux Torvalds wrote:
> | Think about it: if you move the BAR to high memory, you basically disable
> | only _that_ bar, and nothing else. You don't clobber any other associated
> | functions, or anything like that.
>
> That's exactly the problem on ia64 - it does.
> Could this also be a problem on i386 that we just haven't noticed yet?

Unlikely. The IO-APIC on x86 is in that region, but it doesn't respond
from external sources, it's not actually on the PCI bus and only visible
from the CPU. And the CPU decodes that address internally and sends it on
the APIC bus and thus PCI devices simply do not matter for it.

> | Ivan pointed out that it also disables things like VGA legacy registers.
>
> I expect disabling VGA is only a problem for debugging PCI code.
> Is that the only thing that outputs for the duration we have things disabled?
> Anyway, I've been there (debugging code crashes the box) and don't want
> to go there again.

There's no point in you arguing about this. The problem exists and is real
on x86. The patch posted IS NOT GOING IN. That's final, and there's just
no point to arguing about it.

Alternative methods anyone?

		Linus

