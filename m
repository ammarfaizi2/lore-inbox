Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264500AbSIVT1l>; Sun, 22 Sep 2002 15:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264503AbSIVT1l>; Sun, 22 Sep 2002 15:27:41 -0400
Received: from mx1.elte.hu ([157.181.1.137]:48528 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S264500AbSIVT1k>;
	Sun, 22 Sep 2002 15:27:40 -0400
Date: Sun, 22 Sep 2002 21:40:50 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
In-Reply-To: <3D8E179B.FCD06E7@opersys.com>
Message-ID: <Pine.LNX.4.44.0209222124580.28832-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 22 Sep 2002, Karim Yaghmour wrote:

> Source bloat is certainly not desirable, as I said to my reply to Ingo.

(then how should i interpret 90% of the patches you sent to lkml today?)

> What is desirable, however, is to have a uniform tracing mechanism
> replace the ad-hoc tracing mechanisms already implemented in many
> drivers and subsystems.

exactly what is the problem with keeping intrusive debugging patches
separate, just like all the other ones are kept separate? It's not like
this came out of the blue, per-CPU trace buffers (and other tracers) were
done years ago for Linux.

> The lockless scheme is pretty simple, instead of using a spinlock to
> ensure atomic allocation of buffer space, the code does an
> allocate-and-test routine where it tries to allocate space in the buffer
> and tests if it succeeded in doing so. If so, then it goes on to write
> the data in the event buffer, otherwise it tries again. In most cases,
> it does this loop only once and in most worst cases twice.

(this is in essence a moving spinlock at the tail of the trace buffer -
same problem.)

	Ingo

