Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318046AbSHLN5K>; Mon, 12 Aug 2002 09:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318044AbSHLN43>; Mon, 12 Aug 2002 09:56:29 -0400
Received: from mx1.elte.hu ([157.181.1.137]:21457 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318040AbSHLNzN>;
	Mon, 12 Aug 2002 09:55:13 -0400
Date: Mon, 12 Aug 2002 17:57:33 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Alexandre Julliard <julliard@winehq.com>
Subject: Re: [patch] tls-2.5.31-C3
In-Reply-To: <1029159781.4713.52.camel@ldb>
Message-ID: <Pine.LNX.4.44.0208121754250.20225-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Aug 2002, Luca Barbieri wrote:

> > > Numbers:
> > > unconditional copy of 2 tls descs: 5 cycles
> > > this patch with 1 tls desc: 26 cycles
> > > this patch with 8 tls descs: 52 cycles
> > 
> > [ 0 tls descs: 2 cycles. ]
> Yes but common multithreaded applications will have at least 1 for
> pthreads.

i would not say 'common' and 'multithreaded' in the same sentence. It
might be so in the future, but it isnt today.

> > how did you calculate this?
> ((26 - 5) / 2000) * 100 ~= 1
> Benchmarks done in kernel mode (2.4.18) with interrupts disabled on a
> Pentium3 running the rdtsc timed benchmark in a loop 1 million times
> with 8 unbenchmarked iterations to warm up caches and with the time to
> execute an empty benchmark subtracted.

old libpthreads or new one?

> > glibc multithreaded applications can avoid the
> > lldt via using the TLS, and thus it's a net win.
> Surely, this patch is better than the old LDT method but much worse than
> the 2-TLS one.

people asked for a 3rd TLS already.

	Ingo

