Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVASTSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVASTSt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 14:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVASTSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 14:18:49 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:58065 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261856AbVASTSr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 14:18:47 -0500
Date: Wed, 19 Jan 2005 11:17:31 -0800
From: Tony Lindgren <tony@atomide.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119191731.GG14545@atomide.com>
References: <20050119000556.GB14749@atomide.com> <20050119094342.GB25623@elf.ucw.cz> <20050119171323.GB14545@atomide.com> <20050119174858.GB12647@dualathlon.random> <20050119181947.GF14545@atomide.com> <20050119191208.GC12647@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119191208.GC12647@dualathlon.random>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrea Arcangeli <andrea@suse.de> [050119 11:12]:
> On Wed, Jan 19, 2005 at 10:19:47AM -0800, Tony Lindgren wrote:
> > If you have a chance, can you please provide me with some more info
> > on your system, see my recent reply to Pavel in this thread for the
> 
> It's a normal UP athlon 1ghz, it should be quite widespread hardware.
> I know at least another system that had the problem of system time going
> in the future with 2.6 at the same rate of mine. Still it could be an
> hardware issue after all if nobody else can reproduce it. At HZ=100 the
> system time is again perfectly accurate like in 2.4, so probably at least
> the PIT is ok.

I've tested it with a celeron a300 box, tyan s2460 dual athlon,
tyan tiger 100 dual p3, and fujitsu p1110 crusoe laptop. Fujitsu I
may not have tested with TSC, but others work with both ACPI PM
timer and TSC.

Maybe try disabling or enabling ACPI PM timer? Or maybe it does not
use TSC or ACPI PM timer, and that there's some bug in my patch that
kills the plain PIT timer?

Tony
