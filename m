Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265358AbSIWKZN>; Mon, 23 Sep 2002 06:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265362AbSIWKZN>; Mon, 23 Sep 2002 06:25:13 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:12937 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S265358AbSIWKZM>;
	Mon, 23 Sep 2002 06:25:12 -0400
Message-ID: <1032777021.3d8eed3d55f53@kolivas.net>
Date: Mon, 23 Sep 2002 20:30:21 +1000
From: Con Kolivas <conman@kolivas.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, gcc@gcc.gnu.org
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
References: <Pine.LNX.4.44.0209230945260.2917-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0209230945260.2917-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ingo Molnar <mingo@elte.hu>:

> On Mon, 23 Sep 2002, Con Kolivas wrote:
> 
> > IO Full Load:
> > 2.5.38                  170.21          42%
> > 2.5.38-gcc32            230.77          30%
> 
> how many times are you running each test? You should run them at least
> twice (ideally 3 times at least), to establish some sort of statistical
> noise measure. Especially IO benchmarks tend to fluctuate very heavily
> depending on various things - they are also very dependent on the initial
> state - ie. how the pagecache happens to lay out, etc. Ie. a meaningful
> measurement result would be something like:

Yes you make a very valid point and something I've been stewing over privately
for some time. contest runs benchmarks in a fixed order with a "priming" compile
to try and get pagecaches etc back to some sort of baseline (I've been trying
hard to make the results accurate and repeatable). 

Despite that, you're correct in assuming the IO load will fluctuate widely. My
initial tests show that noload and process_load (not surprisingly) vary very
little. Mem_load varies a little. IO Loads can vary wildly, and the worse the
average performance is, the greater the variation (I mean percentage variation
not just absolute).

>  IO Full Load:
>  2.5.38                  170.21 +- 55.21 sec        42%
>  2.5.38-gcc32            230.77 +- 60.22 sec        30%
> 
> where the first column is the average of two measurements, the second
> column is the delta of the two measurements divided by 2. This way we can
> see the 'spread' of the results.

I'll create some results based on 3 runs soon. 

> I simply cannot believe that gcc32 can produce any visible effect in any
> of the IO benchmarks, the only explanation would be heavy fluctuation of
> IO results.

Agreed. There probably is no statistically significant difference in the
different gcc versions.

Contest is very new and I appreciate any feedback I can get to make it as
worthwhile a benchmark as possible to those who know.

Con.
