Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbTIOMUT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 08:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbTIOMUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 08:20:18 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:42254 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261301AbTIOMUP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 08:20:15 -0400
Date: Mon, 15 Sep 2003 08:11:12 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
In-Reply-To: <1063611959.2742.4.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1030915080336.19165D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Sep 2003, Alan Cox wrote:

> On Llu, 2003-09-15 at 04:55, Bill Davidsen wrote:
> > 1 - the code is not needed for Athlon, prefetch is turned off on broken
> >     CPUs now. A generic kernel runs fine on Athlon.
> 
> That disable you talk about is bloat. It also trashes the performance of
> PIV boxes. In fact I checked out of interest - the disable hack
> currently being used is adding *over* 300 bytes to my kernel as its
> inlined repeatedly. So its larger, and it ruins performance for all
> processors.

The code to disable prefetch on Athlon is 300 bytes and hurts your PIV?
Really? I'll dig back through the code, but I recall it as adding or
deleting an entry in a table to enable prefetch. If it's affecting PIV the
code to use prefetch is seriously broken.

And since this only buys 2-5% in the kernel, I really question your "ruins
performance" claim.

> 
> You also need it for userspace prefetch fault fixup for a kernel without
> CONFIG_MK7 to run stuff perfectly on Athlon.

You mean you have a program which enables userspace prefetch and doesn't
handle the botch? Or that you have programs which you compiled for PIV and
which don't run properly on Athlon. It's called misconfigured, they won't
run on 386 either.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

