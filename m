Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbSLTVOc>; Fri, 20 Dec 2002 16:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265570AbSLTVOc>; Fri, 20 Dec 2002 16:14:32 -0500
Received: from palrel13.hp.com ([156.153.255.238]:20619 "HELO palrel13.hp.com")
	by vger.kernel.org with SMTP id <S265567AbSLTVOa>;
	Fri, 20 Dec 2002 16:14:30 -0500
Date: Fri, 20 Dec 2002 13:22:13 -0800
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, mj@ucw.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       turukawa@icc.melco.co.jp, ink@jurassic.park.msu.ru
Subject: Re: PATCH 2.5.x disable BAR when sizing
Message-ID: <20021220212213.GE21823@cup.hp.com>
References: <20021220195031.GC21823@cup.hp.com> <Pine.LNX.4.44.0212201203340.2035-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212201203340.2035-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
From: grundler@cup.hp.com (Grant Grundler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 12:14:43PM -0800, Linus Torvalds wrote:
> Th eone system I had myself was a Sony PCG-CR1. I don't have any pointers
> to the discussion, it was in the late 2.3.x tree if I remember correctly.

tnx - I'll look for that.

> Unlikely. The IO-APIC on x86 is in that region, but it doesn't respond
> from external sources, it's not actually on the PCI bus and only visible
> from the CPU. And the CPU decodes that address internally and sends it on
> the APIC bus and thus PCI devices simply do not matter for it.

xAPIC != APIC
xAPIC ~= SAPIC
AFAICT, My x86 system uses an IO-xAPIC which programmed exactly like
the IO-SAPIC on IA64. i wrote the parisc IO-SAPIC support.
I haven't tried to reproduce the problem seen with IA64 on this box
and it's possible I just can't.

> There's no point in you arguing about this. The problem exists and is real
> on x86. The patch posted IS NOT GOING IN. That's final, and there's just
> no point to arguing about it.

I agree - it shouldn't.

> Alternative methods anyone?

I'll work one out with Ivan K - he usually has good ideas.

thanks,
grant
