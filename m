Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291924AbSBATcb>; Fri, 1 Feb 2002 14:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291925AbSBATcW>; Fri, 1 Feb 2002 14:32:22 -0500
Received: from sunfish.linuxis.net ([64.71.162.66]:7878 "HELO
	sunfish.linuxis.net") by vger.kernel.org with SMTP
	id <S291924AbSBATcL>; Fri, 1 Feb 2002 14:32:11 -0500
Date: Fri, 1 Feb 2002 11:24:16 -0800
To: linux-kernel@vger.kernel.org
Subject: should I trust 'free' or 'top'?
Message-ID: <20020201192415.GC23997@flounder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Delivery-Agent: TMDA v0.42/Python 2.1.1 (sunos5)
From: "Adam McKenna" <adam-dated-1013023458.e87e05@flounder.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There have been a lot of issues lately on our oracle servers with runaway
processes and swapping, enough that I feel compelled to report them here.  We
have tried all different kernels from 2.4.6 to 2.4.16, and the problem seems
to happen with all of them (but is more pronounced on certain kernels)

Basically, what happens is that after an unspecified amount of time, the
boxes will become unresponsve and start swapping wildly.  At that time, I
will login to the box to see what is going on, and I generally see something
like this:

adam@xpdb:~$ uptime
 11:21am  up 42 days, 18:53,  3 users,  load average: 54.72, 21.21, 17.60
adam@xpdb:~$ free
             total       used       free     shared    buffers     cached
Mem:       5528464    5522744       5720          0        476    5349784
-/+ buffers/cache:     172484    5355980
Swap:      2939804    1302368    1637436

As you can see, there are supposedly 5.3 gigs of memory free (not counting
memory used for cache).  However, the box is swapping like mad (about 10 megs
every 2 seconds according to vmstat) and the load is skyrocketing.

Now top, on the other hand, has a very different idea about the amount of
free memory:

CPU states:  0.0% user,  0.1% system,  0.1% nice,  0.0% idle
Mem:  5528464K av, 5523484K used,   4980K free,      0K shrd,    340K buff
Swap: 2939804K av, 1082008K used, 1857796K free                5351892K
cached

So, what am I supposed to believe?  Is 'free' a useful tool?  Is it providing
accurate results?  I'm constantly fielding questions from people who want to
know why a box is swapping, even though 'free' reports a whole bunch of
memory free, and I'm tired of not having an answer for them.

Thanks,

--Adam
-- 
Adam McKenna <adam@flounder.net>   | GPG: 17A4 11F7 5E7E C2E7 08AA
http://flounder.net/publickey.html |      38B0 05D0 8BF7 2C6D 110A
