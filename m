Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262150AbSIZCwE>; Wed, 25 Sep 2002 22:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262151AbSIZCwE>; Wed, 25 Sep 2002 22:52:04 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:55222 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S262150AbSIZCwD>;
	Wed, 25 Sep 2002 22:52:03 -0400
Message-ID: <1033009036.3d92778cee9b9@kolivas.net>
Date: Thu, 26 Sep 2002 12:57:16 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Rik van Riel <riel@conectiva.com.br>
Subject: Useful fork info? WAS Re: [BENCHMARK] fork_load module tested for contest
References: <1032964936.3d91cb48b1cca@kolivas.net>
In-Reply-To: <1032964936.3d91cb48b1cca@kolivas.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Con Kolivas <conman@kolivas.net>:

> I've been trialling a new load module for the contest benchmark
> (http://contest.kolivas.net) which simply forks a process that just exits
> waits for it to die, then repeats. Here are the results I have obtained so
> far:
> 

[...fresh results below...]

> ck7 uses O1, preempt, low latency
> Preempt=N for all other kernels
> 
> Clearly you can see the 2.5 kernels have a substantial lead over the
> current
> stable kernel.
> 
> This load module is not part of the contest package yet. I could certainly
> change it to fork n processes but I'm not really sure just how many n should
> be.


I have extra information from the trial of this module:

noload:
Kernel                  Time            CPU             Ratio
2.4.19                  72.90           99%             1.00
2.4.19-ck7              71.55           100%            0.98
2.5.38                  73.86           99%             1.01
2.5.38-mm2              73.93           99%             1.01

fork_load:
Kernel                  Time            CPU             Ratio
2.4.19                  97.11           67%             1.33
2.4.19-ck7              72.34           92%             0.99
2.5.38                  75.32           92%             1.03
2.5.38-mm2              74.99           92%             1.03

2.4.19: Children forked: 32750
2.4.19-ck7: Children forked: 6477
2.5.38: Children forked: 5545
2.5.38-mm2: Children forked: 5351

You can see clearly repeatedly forking a new process significantly slows down
compile time for 2.4.19 but not the O(1) based kernels. However, the number of
processes that are forked is significantly reduced.

Is this information useful? 

Con
