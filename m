Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264425AbSIVRVg>; Sun, 22 Sep 2002 13:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264427AbSIVRVg>; Sun, 22 Sep 2002 13:21:36 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:43022 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264425AbSIVRVf>; Sun, 22 Sep 2002 13:21:35 -0400
Date: Sun, 22 Sep 2002 19:26:26 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Ingo Molnar <mingo@elte.hu>
cc: Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
In-Reply-To: <Pine.LNX.4.44.0209221222060.21475-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209221830400.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 22 Sep 2002, Ingo Molnar wrote:

> Eg. for the scheduler i wrote a simple tracer, but the rate of
> trace points that started to make sense for me from a development and
> debugging POV also made kernel/sched.c butt-ugly and unmaintainable, so i
> always kept the tracer separate and did the hacking in the untained code.
>
> also, the direction things are taking these days seems to be towards
> hardware-assisted tracing. Ie. on the P4 we can recover a trace of EIPs
> traversed by the CPU recently. Stuff like this is powerful and can can
> debug bugs that cannot be debugged via software.

To summarize: You find tracing useful, but software tracing is only of
limited value in areas you're working at.
What about other developers, which only want to develop a simple driver,
without having to understand the whole kernel? Traces still work where
printk() or kgdb don't work. I think it's reasonable to ask an user to
enable tracing and reproduce the problem, which you can't reproduce
yourself.

> It does have its uses, no doubt, but usually we apply
> things to the kernel that have either a positive, or at worst, a neutral
> impact on the kernel proper - kernel tracing clearly is not such a
> feature.

Last time I checked it has no impact on the kernel as long as it's not
enabled. Anyway, it would already be very useful to have at least the core
integrated. How many drivers currently define a "dprint"? Some even
implement its own tracing. While debug prints are mostly useful during
early development, they are usually completely useless, when you have to
reproduce a problem.

> so use the power of the GPL-ed kernel and keep your patches separate,
> releasing them for specific stable kernel branches (or even development
> kernels).

While I agree that this acceptable approach for things like kgdb, I think
it would very useful to have at least the tracing core in the kernel.

bye, Roman

