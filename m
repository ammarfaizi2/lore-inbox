Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261242AbSIWNEj>; Mon, 23 Sep 2002 09:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261246AbSIWNEj>; Mon, 23 Sep 2002 09:04:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:46210 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261242AbSIWNEi>; Mon, 23 Sep 2002 09:04:38 -0400
Date: Mon, 23 Sep 2002 09:11:20 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Pavel Machek <pavel@suse.cz>
cc: Richard Henderson <rth@twiddle.net>, Brian Gerst <bgerst@didntduck.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, dvorak <dvorak@xs4all.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
In-Reply-To: <20020922013346.A39@toy.ucw.cz>
Message-ID: <Pine.LNX.3.95.1020923090547.2963B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Sep 2002, Pavel Machek wrote:

> Hi!
> 
> > It's a problem with a 'general purpose' compiler that wants to
> > be "all things" to all people. If somebody made a gcc-compatible
> > compiler, tuned to the ix86 characteristics, I think we could
> > cut the extra instructions by at least 1/2, maybe more.
> 
> Remember pgcc? 
> 
> And btw cutting instructions by 1/2might look nice but unless you can
> keep it as fast as it was, its useless.
> 								Pavel
> -- 
Yes, but to see the affect of cutting down the instruction length, you
need to make benchmarks that emulate running 'forever'. Many bench-
marks access some memory over-and-over again in a loop. This does
not exercise the need to refill prefetch so the benchmarks ignore
the advantages obtained by reducing the amount of instructions needed
to be fetched from memory.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

