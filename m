Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292970AbSCDXKX>; Mon, 4 Mar 2002 18:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292967AbSCDXKO>; Mon, 4 Mar 2002 18:10:14 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:30625 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292970AbSCDXKB>; Mon, 4 Mar 2002 18:10:01 -0500
To: Andrea Arcangeli <andrea@suse.de>
cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: 2.4.19pre1aa1 
In-Reply-To: Your message of Mon, 04 Mar 2002 23:25:44 +0100.
             <20020304232544.P20606@dualathlon.random> 
Date: Mon, 04 Mar 2002 15:09:51 -0800
Message-Id: <E16i1aZ-0000jQ-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In message <20020304232544.P20606@dualathlon.random>, > : Andrea Arcangeli writ
es:
> it's better to make sure to use all available ram in all nodes instead
> of doing migrations when the local node is low on mem. But this again
> depends on the kind of numa system, I'm considering the new numas, not
> the old ones with the huge penality on the remote memory.

Andrea, don't forget that the "old" NUMAs will soon be the "new" NUMAs
again.  The internal bus and clock speeds are still quite likely to
increase faster than the speeds of most interconnects.  And even quite
a few "big SMP" machines today are really somewhat NUMA-like with a
2 to 1 - remote to local memory latency (e.g. the Corollary interconnect
used on a lot of >4-way IA32 boxes is not as fast as the two local
busses).

So, desiging for the "new" NUMAs is fine if your code goes into
production this year.  But if it is going into production in two to
three years, you might want to be thinking about some greater memory
latency ratios for the upcoming hardware configurations...

gerrit
