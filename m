Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265828AbSLIRls>; Mon, 9 Dec 2002 12:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265798AbSLIRls>; Mon, 9 Dec 2002 12:41:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45580 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265828AbSLIRlr>; Mon, 9 Dec 2002 12:41:47 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Intel P6 vs P7 system call performance
Date: Mon, 9 Dec 2002 17:48:45 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <at2l1t$g5n$1@penguin.transmeta.com>
References: <200212090830.gB98USW05593@flux.loup.net>
X-Trace: palladium.transmeta.com 1039456160 26934 127.0.0.1 (9 Dec 2002 17:49:20 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 9 Dec 2002 17:49:20 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200212090830.gB98USW05593@flux.loup.net>,
Mike Hayward  <hayward@loup.net> wrote:
>
>I have been benchmarking Pentium 4 boxes against my Pentium III laptop
>with the exact same kernel and executables as well as custom compiled
>kernels.  The Pentium III has a much lower clock rate and I have
>noticed that system call performance (and hence io performance) is up
>to an order of magnitude higher on my Pentium III laptop.  1k block IO
>reads/writes are anemic on the Pentium 4, for example, so I'm trying
>to figure out why and thought someone might have an idea.

P4's really suck at system calls.  A 2.8GHz P4 does a simple system call
a lot _slower_ than a 500MHz PIII. 

The P4 has problems with some other things too, but the "int + iret"
instruction combination is absolutely the worst I've seen.  A 1.2GHz
Athlon will be 5-10 times faster than the fastest P4 on system call
overhead. 

HOWEVER, the P4 is really good at a lot of other things. On average, a
P4 tends to perform quite well on most loads, and hyperthreading (if you
have a Xeon or one of the newer desktop CPU's) also tends to work quite
well to smooth things out in real life.

In short: the P4 architecture excels at some things, and it sucks at
others. It _mostly_ tends to excel more than suck.

			Linus
