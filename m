Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288609AbSADMHP>; Fri, 4 Jan 2002 07:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288608AbSADMHF>; Fri, 4 Jan 2002 07:07:05 -0500
Received: from mx2.elte.hu ([157.181.151.9]:29576 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288607AbSADMG5>;
	Fri, 4 Jan 2002 07:06:57 -0500
Date: Fri, 4 Jan 2002 15:04:18 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: David Lang <david.lang@digitalinsight.com>
Cc: Dieter Nutzel <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.40.0201040330460.7718-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.33.0201041502260.6188-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Jan 2002, David Lang wrote:

> I remember running into problems with some user apps (not lockups, but
> the apps failed) on my 2x400MHz pentium box. I specificly remember the
> Citrix client hanging, but I think there were others as well.

ok. Generally there is no guarantee that the parent will run first under
the current scheduler, but it's likely to run first. But if eg. a higher
priority process preempts the forking process while it's doing fork() then
the child will run first in 50% of the cases. So this ordering is not
guaranteed by the 2.4 (or 2.2) Linux scheduler in any way.

	Ingo

