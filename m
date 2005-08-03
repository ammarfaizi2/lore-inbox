Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262661AbVHDURk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbVHDURk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 16:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbVHDURj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 16:17:39 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43142 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262661AbVHDUQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 16:16:36 -0400
Date: Wed, 3 Aug 2005 23:12:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: Prakash Punnoor <prakash@punnoor.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>, Tony Lindgren <tony@atomide.com>,
       tuukka.tikkanen@elektrobit.com
Subject: Re: [PATCH] no-idle-hz aka dynamic ticks-2
Message-ID: <20050803211238.GA1291@elf.ucw.cz>
References: <200508022225.31429.kernel@kolivas.org> <42EF6DF7.6030100@punnoor.de> <200508022328.09482.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508022328.09482.kernel@kolivas.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > As promised, here is an updated patch for the newly released 2.6.13-rc5.
> > > Boots and runs fine on P4HT (SMP+SMT kernel) built with gcc 4.0.1.
> >
> > Doesn't compile for me w/ gcc 3.4.4:
> 
> Thanks for the report. Tiny change required. Here is a respun patch.


Sorry, it breaks my machine in "interesting" way. Cursor no longer
blinks, sleep 1 takes more than five seconds, ...

Pentium-M in compaq evo n620c notebok, cpufreq active:

pavel@Elf:~$ dmesg | grep tick
dyn-tick: Found suitable timer: tsc
dyn-tick: Registering dynamic tick timer v050610-1
dyn-tick: Maximum ticks to skip limited to 13
dyn-tick: Timer not enabled during boot
pavel@Elf:~$

Ouch, even system time seems to go slower. I'll try setting
DYNTICK_USE_APIC next.
								Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.
