Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265389AbUADLUN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 06:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265392AbUADLUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 06:20:13 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:46852 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265389AbUADLUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 06:20:08 -0500
Date: Sun, 4 Jan 2004 12:19:45 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Soeren Sonnenburg <kernel@nn7.de>, Nick Piggin <piggin@cyberone.com.au>,
       Lincoln Dale <ltd@cisco.com>, Con Kolivas <kernel@kolivas.org>,
       Willy Tarreau <willy@w.ods.org>, Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gillb4@telusplanet.net
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
Message-ID: <20040104111945.GA14348@alpha.home.local>
References: <200401041242.47410.kernel@kolivas.org> <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca> <200401040815.54655.kernel@kolivas.org> <20040103233518.GE3728@alpha.home.local> <200401041242.47410.kernel@kolivas.org> <5.1.0.14.2.20040104195316.02151e98@171.71.163.14> <3FF7DA24.40802@cyberone.com.au> <1073211879.3261.6.camel@localhost> <20040104111257.GO1882@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040104111257.GO1882@matchmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 03:12:57AM -0800, Mike Fedyk wrote:
> On Sun, Jan 04, 2004 at 11:24:39AM +0100, Soeren Sonnenburg wrote:
> > [...]
> > > Or, out of interest, an alternate scheduler?
> > > 
> > > http://www.kerneltrap.org/~npiggin/w29p2.gz
> > > (applies 2.6.1-rc1-mm1, please renice X to -10 or so)
> > 
> > Thats nothing *I* can try out as I am on the powerpc benh tree.
> > 
> 
> Says who?  The scheduler isn't platform specific.  Nick, do you have any per
> arch defines in your patch?

I found slight changes to arch specific files, but IMHO this should not be
the problem. But AFAIR, benh's ppc patches are somewhat complete and may
introduce conflicts.

BTW, for Nick, the patch didn't compile, I had to change sched_clock()
definition from unsigned long long to unsigned long in
arch/i386/kernel/timers/timer_tsc.c. Don't know if it was the right thing to
do, but it compiles and boots.

Cheers,
Willy

