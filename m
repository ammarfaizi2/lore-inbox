Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbTLLPot (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 10:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265265AbTLLPos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 10:44:48 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:56221 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S265264AbTLLPop
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 10:44:45 -0500
Date: Fri, 12 Dec 2003 08:44:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] -tiny tree for small systems (2.6.0-test11)
Message-ID: <20031212154443.GN23731@stop.crashing.org>
References: <20031212033734.GG23787@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031212033734.GG23787@waste.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 09:37:34PM -0600, Matt Mackall wrote:

> This is the first release of a new kernel tree dubbed '-tiny' (someone
> already took -mm). The aim of this tree is to collect patches that
> reduce kernel disk and memory footprint as well as tools for working
> on small systems, an area Linux mainstream has been moving away from
> since Linus got a real job. Target users are things like embedded
> systems, small or legacy desktop folks, and handhelds.
> 
> To get the ball rolling, I've thrown in about 50 patches that trim
> various bits of the kernel, almost all configurable, and a fair number
> may eventually be appropriate for mainline. All the config options are
> currently thrown under CONFIG_EMBEDDED and many of the minor tweaks
> are covered under a set of config options called CONFIG_CORE_SMALL,
> CONFIG_NET_SMALL, and CONFIG_CONSOLE_SMALL.
> 
> Nifty things I've included:
>  - building with -Os
>  - 4k process stacks (via -wli)
>  - configurable removal of printk, BUG, and panic() strings
>  - configurable HZ
>  - configurable support for vm86, core dumps, kcore, sysfs, aio, etc.
>  - a very nice kmalloc auditing system via /proc/kmalloc
>  - auditing of bootmem usage
>  - a system for counting inline instantiations
>  - my netpoll/netconsole patches
>  - my drivers/char/random fixups

I'd like to suggest you check out the "tweaks" idea I tossed out here:
http://www.ussg.iu.edu/hypermail/linux/kernel/0211.0/2229.html
If this sounds interesting, I've got a version of the patch (albeit old
and not applying directly right now I bet) that moved things into header
files and got all of the dependancy stuff correct except for the initial
run (so I think I was forcing an update with any make invocation, but
there were no spurious recompiles).

-- 
Tom Rini
http://gate.crashing.org/~trini/
