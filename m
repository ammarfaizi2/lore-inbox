Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279596AbRJXVDF>; Wed, 24 Oct 2001 17:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279598AbRJXVCz>; Wed, 24 Oct 2001 17:02:55 -0400
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:26388 "HELO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with SMTP
	id <S279596AbRJXVCw>; Wed, 24 Oct 2001 17:02:52 -0400
From: Lukasz Trabinski <lukasz@oceanic.wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.13 high SWAP
In-Reply-To: <9r73pv$8h1$1@penguin.transmeta.com>
X-Newsgroups: wsisiz.linux-kernel
User-Agent: tin/1.5.9-20010723 ("Chord of Souls") (UNIX) (Linux/2.4.13 (i686))
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Message-Id: <20011024210325.B03A598407@oceanic.wsisiz.edu.pl>
Date: Wed, 24 Oct 2001 23:03:25 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <9r73pv$8h1$1@penguin.transmeta.com> you wrote:
>>
>>Without use the tmpfs, appears to be OK!!!!!!!!!!

> Ok, the problem appears to be that tmpfs stuff just stays on the
> inactive list, and because it cannot be written out it eventually
> totally clogs the system.

> Suggested fix appended (from Andrea),

What about that:

 10:42pm  up 10:09,  2 users,  load average: 1.40, 1.31, 1.28
166 processes: 163 sleeping, 3 running, 0 zombie, 0 stopped
CPU0 states:  0.0% user, 97.0% system,  0.0% nice,  2.0% idle
CPU1 states:  0.1% user, 21.0% system,  0.0% nice, 77.0% idle
Mem:  2061632K av, 2057024K used,    4608K free,       0K shrd,   55412K buff
Swap: 1911528K av,    3060K used, 1908468K free                 1513964K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    5 root      16   0     0    0     0 RW   99.9  0.0 157:00 kswapd

It's looks strange and danger. On this machine squid and INN running.
Swap is on still level, but 99.9% for CPU? System without tmpfs, but
with resierfs (50GB of squid spool on 5 partitions).


-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
