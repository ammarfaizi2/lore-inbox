Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284627AbRLJKj0>; Mon, 10 Dec 2001 05:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286216AbRLJKi7>; Mon, 10 Dec 2001 05:38:59 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:38922 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S286170AbRLJKhq>; Mon, 10 Dec 2001 05:37:46 -0500
Date: Sun, 9 Dec 2001 12:39:19 +0100
From: Pavel Machek <pavel@suse.cz>
To: brain@artax.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: 119.5% CPU load
Message-ID: <20011209123919.A137@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.30.0112081433280.1658-100000@ghost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0112081433280.1658-100000@ghost>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Look at this "top" snapshot:
> 
> -----------------------------------------------------------------------------
>   2:30pm  up  3:46, 10 users,  load average: 2.96, 1.50, 0.84
> 49 processes: 44 sleeping, 4 running, 0 zombie, 1 stopped
> CPU states:  0.1% user, 119.4% system,  0.0% nice,  0.0% idle
> Mem:   63208K av,  62004K used,   1204K free,  24556K shrd,  34892K buff
> Swap:  34236K av,    140K used,  34096K free                  7056K cached
> 
>   PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
>  1632 brain     20   0  1724 1724   992 R       0 33.4  2.7   1:19 mc
>  1654 brain     20   0   784  784   576 R       0 32.2  1.2   0:49 mpg123
>  1652 root      14   0   500  500   368 R       0 21.4  0.7   0:40 top
>    84 root       0   0   244  224   192 S       0 15.7  0.3   0:03 gpm
>  1655 root      20   0   624  624   476 R       0 10.6  0.9   0:02 vi
>     3 root       0   0     0    0     0 SW      0  5.0  0.0   0:18 kupdate
>   121 root       2   0   844  844   588 S       0  0.6  1.3   0:00 bash
>     4 root       0   0     0    0     0 SW      0  0.2  0.0   0:08 kswapd
> -----------------------------------------------------------------------------
> 
> That's not a joke, it WAS on my machine on very busy network. I've got 2.2.19
> kernel and single AMD K6-2/400. I don't have any turbocharger, so I suppose my
> CPU is able to perform mere 100% of the load. Can you explain it?

Yes. Reading /proc is not atomic. Therefore you can't expect values to
sum to 100%.

But I wonder... Why is it all in *system*?
									Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
