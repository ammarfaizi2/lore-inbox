Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318166AbSIOSqN>; Sun, 15 Sep 2002 14:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318173AbSIOSqN>; Sun, 15 Sep 2002 14:46:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:11446 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318166AbSIOSqM>;
	Sun, 15 Sep 2002 14:46:12 -0400
Date: Sun, 15 Sep 2002 20:57:46 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] thread-exec-2.5.34-B1, BK-curr
In-Reply-To: <Pine.LNX.4.44.0209151137490.10830-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209152055290.9822-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 15 Sep 2002, Linus Torvalds wrote:

> > i dont like those semantics either - will verify whether thread-specific
> > exec() works via a helper thread (or vfork) - it really should.
> 
> As long as it works with something sane (and vfork() is sane), I'm happy
> with the posix behaviour by default. [...]

yes - the default case is very similar to that: exec() works for a
1-member thread_group, otherwise i couldnt have booted the kernel.

> [...] After all, the execve() really _does_ need to "de-thread" anyway,
> and if we need to make that explicit (with the vfork()) then that's
> fine.

ok. libpthreads uses an internal clone() for posix_spawn() [which does
what your example illustrates] which should be a tad faster than vfork() -
but vfork() should work just as well.

	Ingo

