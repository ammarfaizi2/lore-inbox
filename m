Return-Path: <linux-kernel-owner+willy=40w.ods.org-S274996AbVBFK3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274996AbVBFK3W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 05:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275020AbVBFK3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 05:29:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:21939 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274996AbVBFK3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 05:29:14 -0500
Date: Sun, 6 Feb 2005 02:29:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-bk: something very wrong with top
Message-Id: <20050206022906.13ece818.akpm@osdl.org>
In-Reply-To: <20050206092335.GA1488@elf.ucw.cz>
References: <20050206092335.GA1488@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> There seem to be some problems with top:
> 
>  top - 10:19:24 up 4 min,  3 users,  load average: 0.74, 0.48, 0.21
>  Tasks:  58 total,   2 running,  56 sleeping,   0 stopped,   0 zombie
>  Cpu(s): 55.1% us,  6.4% sy,  0.0% ni,  0.0% id, 38.5% wa,  0.0% hi, 0.0% si
>  Mem:   1031424k total,    72840k used,   958584k free,     8804k buffers
>  Swap:  1953464k total,     5452k used,  1948012k free,    34860k cached
> 
>    PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>    967 root      34  19  2128  620  456 R  0.6  0.1   0:00.35 top
>      1 root      16   0  1580   80   56 S  0.0  0.0   0:03.27 init
>      2 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0
>      3 root      10  -5     0    0    0 S  0.0  0.0   0:00.31 events/0
>      4 root      11  -5     0    0    0 S  0.0  0.0   0:00.00 khelper
>      9 root      10  -5     0    0    0 S  0.0  0.0   0:00.00 kthread
>     21 root      10  -5     0    0    0 S  0.0  0.0   0:00.00 kacpid
>     97 root      10  -5     0    0    0 S  0.0  0.0   0:00.03 kblockd/0
>    269 root      20   0     0    0    0 S  0.0  0.0   0:00.00 pdflush
> 
>  ...while compiling kernel, 50%+ time is spent in gcc, but top does not
>  show it, or it shows it with something like 3% :-(. Same problem seems
>  to be in 2.6.10-rc3... Does anybody else see that?

I can't say that I can see any difference between 2.6.10 and tip-of-tree.

In fact 2.4 does the same thing: cc1 is either not shown at all or is shown
as taking just a few percent CPU.  Occasionally it blips up to 50% or more.

Presumably cc1 just doesn't run long enough for it to register.  How fast
is your CPU?
