Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbTIOTY7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 15:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbTIOTY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 15:24:59 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:33551 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261380AbTIOTY5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 15:24:57 -0400
Date: Mon, 15 Sep 2003 15:15:49 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: richard.brunner@amd.com
cc: alan@lxorguk.ukuu.org.uk, zwane@linuxpower.ca,
       linux-kernel@vger.kernel.org
Subject: RE: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
In-Reply-To: <99F2150714F93F448942F9A9F112634C0638B1DE@txexmtae.amd.com>
Message-ID: <Pine.LNX.3.96.1030915145137.20945F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Sep 2003 richard.brunner@amd.com wrote:

> I think Alan brought up a very good point. Even if you
> use a generic kernel that avoids prefetch use on Athlon
> (which I am opposed to), it doesn't solve the problem
> of user space programs detecting that the ISA supports
> prefetch and using prefetch instructions and hitting the
> errata on Athlon.
> 
> The user space problem worries me more, because the expectation
> is that if CPUID says the program can use perfetch, it could
> and should regardless of what the kernel decided to do here.
> 
> Andi's patch solves both the kernel space and the user space
> issues in a pretty small footprint.

Clearly AMD would like to avoid having PIV and Athlon optimized kernels,
and to default to adding unnecessary size to the PIV kernel to support
errata in the Athlon. But fighting against having a config which produces
a smaller and faster kernel for all non-Athlon users and all embedded or
otherwise size limited users seems to be just a marketing thing so P4 code
will seem to work correctly on Athlon.

Vendors will build a kernel which runs as well as possible on as many CPUs
as possible, but users who build their own kernel want to build a kernel
for a particular config in most cases and should have the option. There
should be a "support Athlon prefetch" option as well, which turns on
the fix only when it's needed, just as there is for P4 thermal throttling,
F.P. emulation, etc. Why shouldn't this be treated the same way as other
features already in the config menu?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

