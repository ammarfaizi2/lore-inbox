Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317601AbSFRUVJ>; Tue, 18 Jun 2002 16:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317600AbSFRUVI>; Tue, 18 Jun 2002 16:21:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28423 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317601AbSFRUVH>; Tue, 18 Jun 2002 16:21:07 -0400
Date: Tue, 18 Jun 2002 13:21:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Benjamin LaHaise <bcrl@redhat.com>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken 
In-Reply-To: <E17KPMG-0003oZ-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0206181319400.872-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Jun 2002, Rusty Russell wrote:
>
> > That doesn't work.  Think of SMT CPU pairs (aka HyperThreading) or
> > quads that share caches.
>
> This is the NUMA "I want to be in this group" problem.  If you're
> serious about this, you'll go for a sys_sched_groupaffinity call, or
> add an extra arg to sys_sched_setaffinity, or simply use the top 16
> bits of the cpu arg.

Oh, yes. That makes sense. NOT.

> Sorry, the current interface is insufficient for NUMA *and* is
> impossible[1] for the user to use correctly.

Don't be silly.

Give _one_ good reason why the affinity system call cannot take a simple
bitmask? It's trivial to use, your arguments do not make any sense.

		Linus

