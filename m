Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267131AbTBDGyq>; Tue, 4 Feb 2003 01:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267132AbTBDGyq>; Tue, 4 Feb 2003 01:54:46 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:28433 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267131AbTBDGyp>; Tue, 4 Feb 2003 01:54:45 -0500
Message-Id: <200302040656.h146uJs10531@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: root@chaos.analogic.com, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: gcc 2.95 vs 3.21 performance
Date: Tue, 4 Feb 2003 08:54:41 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
References: <Pine.LNX.3.95.1030203182417.7651A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1030203182417.7651A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 February 2003 01:31, Richard B. Johnson wrote:
> On Mon, 3 Feb 2003, Martin J. Bligh wrote:
> > People keep extolling the virtues of gcc 3.2 to me, which I'm
> > reluctant to switch to, since it compiles so much slower. But
> > it supposedly generates better code, so I thought I'd compile
> > the kernel with both and compare the results. This is gcc 2.95
> > and 3.2.1 from debian unstable on a 16-way NUMA-Q. The kernbench
> > tests still use 2.95 for the compile-time stuff.
>
> [SNIPPED tests...]

What was the size of uncompressed kernel binaries?
This is a simple (and somewhat inaccurate) measure of compiler
improvement ;)

> Don't let this get out, but egcs-2.91.66 compiled FFT code
> works about 50 percent of the speed of whatever M$ uses for
> Visual C++ Version 6.0  I was awfully disheartened when I

Yes. M$ (and some other compilers) beat GCC badly.

> found that identical code executed twice as fast on M$ than
> it does on Linux. I tried to isolate what was causing the
> difference. So I replaced 'hypot()' with some 'C' code that
> does sqrt(x^2 + y^2) just to see if it was the 'C' library.
> It didn't help. When I find out what type (section) of code
> is running slower, I'll report. In the meantime, it's fast
> enough, but I don't like being beat by M$.

I'm afraid it's code generation engine. It is just worse than
M$ or Intel's one. It is not easily fixable,
GCC folks have tremendous task at hand.

I wonder whether some big companies supposedly supporting 
Linux (e.g. Intel) can help GCC team (for example by giving
away some code and/or developer time).
--
vda
