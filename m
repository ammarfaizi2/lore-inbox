Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268258AbVBFKnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268258AbVBFKnh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 05:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268334AbVBFKng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 05:43:36 -0500
Received: from gprs214-130.eurotel.cz ([160.218.214.130]:37848 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268258AbVBFKmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 05:42:44 -0500
Date: Sun, 6 Feb 2005 11:42:30 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-bk: something very wrong with top
Message-ID: <20050206104229.GA1151@elf.ucw.cz>
References: <20050206092335.GA1488@elf.ucw.cz> <20050206022906.13ece818.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206022906.13ece818.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 06-02-05 02:29:06, Andrew Morton wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
> >
> > There seem to be some problems with top:
> > 
> >  top - 10:19:24 up 4 min,  3 users,  load average: 0.74, 0.48, 0.21
> >  Tasks:  58 total,   2 running,  56 sleeping,   0 stopped,   0 zombie
> >  Cpu(s): 55.1% us,  6.4% sy,  0.0% ni,  0.0% id, 38.5% wa,  0.0% hi, 0.0% si
> >  Mem:   1031424k total,    72840k used,   958584k free,     8804k buffers
> >  Swap:  1953464k total,     5452k used,  1948012k free,    34860k cached
> > 
> >    PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
> >    967 root      34  19  2128  620  456 R  0.6  0.1   0:00.35 top
> >      1 root      16   0  1580   80   56 S  0.0  0.0   0:03.27 init
> >      2 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0
> >      3 root      10  -5     0    0    0 S  0.0  0.0   0:00.31 events/0
> >      4 root      11  -5     0    0    0 S  0.0  0.0   0:00.00 khelper
> >      9 root      10  -5     0    0    0 S  0.0  0.0   0:00.00 kthread
> >     21 root      10  -5     0    0    0 S  0.0  0.0   0:00.00 kacpid
> >     97 root      10  -5     0    0    0 S  0.0  0.0   0:00.03 kblockd/0
> >    269 root      20   0     0    0    0 S  0.0  0.0   0:00.00 pdflush
> > 
> >  ...while compiling kernel, 50%+ time is spent in gcc, but top does not
> >  show it, or it shows it with something like 3% :-(. Same problem seems
> >  to be in 2.6.10-rc3... Does anybody else see that?
> 
> I can't say that I can see any difference between 2.6.10 and tip-of-tree.
> 
> In fact 2.4 does the same thing: cc1 is either not shown at all or is shown
> as taking just a few percent CPU.  Occasionally it blips up to 50%
> or more.

It happened in 2.6.10, too... Okay, probably I have just too fast
CPU. Sorry for the noise. 

> Presumably cc1 just doesn't run long enough for it to register.  How fast
> is your CPU?

2GHz athlon64...
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
