Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262243AbSIZILw>; Thu, 26 Sep 2002 04:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262244AbSIZILv>; Thu, 26 Sep 2002 04:11:51 -0400
Received: from mx1.elte.hu ([157.181.1.137]:55240 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262243AbSIZILu>;
	Thu, 26 Sep 2002 04:11:50 -0400
Date: Thu, 26 Sep 2002 10:25:47 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <conman@kolivas.net>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Useful fork info? WAS Re: [BENCHMARK] fork_load module tested
 for contest
In-Reply-To: <1033009036.3d92778cee9b9@kolivas.net>
Message-ID: <Pine.LNX.4.44.0209261023500.2944-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Sep 2002, Con Kolivas wrote:

> fork_load:
> Kernel                  Time            CPU             Ratio
> 2.4.19                  97.11           67%             1.33
> 2.4.19-ck7              72.34           92%             0.99
> 2.5.38                  75.32           92%             1.03
> 2.5.38-mm2              74.99           92%             1.03
> 
> 2.4.19: Children forked: 32750
> 2.4.19-ck7: Children forked: 6477
> 2.5.38: Children forked: 5545
> 2.5.38-mm2: Children forked: 5351
> 
> You can see clearly repeatedly forking a new process significantly slows
> down compile time for 2.4.19 but not the O(1) based kernels. However,
> the number of processes that are forked is significantly reduced.

shouldnt the CPU load be 100% for such a test? If it isnt then perhaps
some other thing factors in. VM load? And i dont understand how a faster
kernel forks less children in the end. Perhaps the test is hitting some
sort of resource limit which has a different default in 2.5?

	Ingo

