Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264245AbSIWHhA>; Mon, 23 Sep 2002 03:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbSIWHhA>; Mon, 23 Sep 2002 03:37:00 -0400
Received: from mx1.elte.hu ([157.181.1.137]:41428 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S264245AbSIWHg6>;
	Mon, 23 Sep 2002 03:36:58 -0400
Date: Mon, 23 Sep 2002 09:49:53 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <conman@kolivas.net>
Cc: linux-kernel@vger.kernel.org, Daniel Jacobowitz <dan@debian.org>,
       Andrew Morton <akpm@digeo.com>, Ville Herva <vherva@niksula.hut.fi>,
       Alexei Podtelezhnikov <apodtele@mccammon.ucsd.edu>, <gcc@gcc.gnu.org>,
       Robert Love <rml@tech9.net>
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
In-Reply-To: <1032764130.3d8ebae220908@kolivas.net>
Message-ID: <Pine.LNX.4.44.0209230945260.2917-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Sep 2002, Con Kolivas wrote:

> IO Full Load:
> 2.5.38                  170.21          42%
> 2.5.38-gcc32            230.77          30%

> This time only the IO loads showed a statistically significant
> difference.

how many times are you running each test? You should run them at least
twice (ideally 3 times at least), to establish some sort of statistical
noise measure. Especially IO benchmarks tend to fluctuate very heavily
depending on various things - they are also very dependent on the initial
state - ie. how the pagecache happens to lay out, etc. Ie. a meaningful
measurement result would be something like:

 IO Full Load:
 2.5.38                  170.21 +- 55.21 sec        42%
 2.5.38-gcc32            230.77 +- 60.22 sec        30%

where the first column is the average of two measurements, the second
column is the delta of the two measurements divided by 2. This way we can
see the 'spread' of the results.

I simply cannot believe that gcc32 can produce any visible effect in any
of the IO benchmarks, the only explanation would be heavy fluctuation of
IO results.

	Ingo

