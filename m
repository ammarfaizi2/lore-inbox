Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVDEVoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVDEVoP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVDEVZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:25:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53658 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262025AbVDEVN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 17:13:57 -0400
Date: Tue, 5 Apr 2005 23:13:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Norbert Preining <preining@logic.at>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: It's getting worse: 2.6.12-rc2-mm1 and suspend2ram
Message-ID: <20050405211340.GF1380@elf.ucw.cz>
References: <20050405181628.GB6879@gamma.logic.tuwien.ac.at> <20050405204107.GD1380@elf.ucw.cz> <20050405210041.GA16263@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405210041.GA16263@gamma.logic.tuwien.ac.at>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I do not know why you can't unload them, but what about simply not
> > loading them at all? :-).
> 
> hotplug.
> 
> 
> Whatever, booting with init=/bin/sh I get these processes running
>   PID TTY      STAT   TIME COMMAND
>     1 ?        R      0:00 /bin/bash
>     2 ?        SN     0:00 [ksoftirqd/0]
>     3 ?        S      0:00 [watchdog/0]
>     4 ?        S<     0:00 [events/0]
>     5 ?        S<     0:00 [khelper]
>     6 ?        S<     0:00 [kthread]
>     8 ?        S<     0:00 [kacpid]
>    98 ?        S<     0:00 [kblockd/0]
>   153 ?        S      0:00 [pdflush]
>   154 ?        S      0:00 [pdflush]
>   155 ?        S      0:00 [kswapd0]
>   156 ?        S<     0:00 [aio/0]
>   231 ?        S      0:00 [kseriod]
>   301 ?        S      0:00 [kjournald]
>   309 ?        S<s    0:00 udevd
>   553 ?        R      0:00 ps ax
> 
> and the same happens. Instant reboot.
> 
> So who could be the culprit from the compiled in stuff:
> cpufreq
> netfilter
> input stuff
> serio stuff
> snd stuff (but not the actual driver snd_interl8x0 which is modular)
> 
> well that's it. Strange.

Well, I do not have working suspend-to-RAM setup close to me... Could
you try 2.6.12-rc1 to see if reboot problem is -mm specific or not?

input is known for some funky behaviour, especially with
synaptics. Disabling cpufreq might be good idea, too...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
