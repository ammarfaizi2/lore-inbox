Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263147AbSIUEpv>; Sat, 21 Sep 2002 00:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263218AbSIUEpv>; Sat, 21 Sep 2002 00:45:51 -0400
Received: from mx1.elte.hu ([157.181.1.137]:17825 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S263147AbSIUEpv>;
	Sat, 21 Sep 2002 00:45:51 -0400
Date: Sat, 21 Sep 2002 06:58:15 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <20020920234509.GA2810@gnuppy.monkey.org>
Message-ID: <Pine.LNX.4.44.0209210649280.2441-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Sep 2002, Bill Huey wrote:

> Also throwing a signal to get the ucontext is pretty a expensive way of
> getting it. But you folks know this already. [...]

as i've mentioned in the previous mail, 2.5.35+ kernels have a very fast
SIGSTOP/SIGCONT implementation, which change was done as part of this
project - a few orders faster than throwing/catching SIGUSR1 to every
single thread for example.

so right now we first need to get some results back about how big the GC
problem is with the new SIGSTOP/SIGCONT implementation. If it's still not
fast enough then we still have a number of options.

	Ingo

