Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbVFSRMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVFSRMv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 13:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbVFSRMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 13:12:51 -0400
Received: from tim.rpsys.net ([194.106.48.114]:24501 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262209AbVFSRMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 13:12:49 -0400
Subject: Re: 2.6.12-rc6-mm1
From: Richard Purdie <rpurdie@rpsys.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050619101120.B6499@flint.arm.linux.org.uk>
References: <20050607042931.23f8f8e0.akpm@osdl.org>
	 <1119134359.7675.38.camel@localhost.localdomain>
	 <20050619001841.A7252@flint.arm.linux.org.uk>
	 <1119144048.7675.101.camel@localhost.localdomain>
	 <20050619100226.A6499@flint.arm.linux.org.uk>
	 <20050619101120.B6499@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Sun, 19 Jun 2005 18:12:38 +0100
Message-Id: <1119201158.7554.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-19 at 10:11 +0100, Russell King wrote:
> On Sun, Jun 19, 2005 at 10:02:26AM +0100, Russell King wrote:
> > On Sun, Jun 19, 2005 at 02:20:48AM +0100, Richard Purdie wrote:
> > > On Sun, 2005-06-19 at 00:18 +0100, Russell King wrote: 
> > > > Thinking about what's probably happening, I suspect all the ARM suspend
> > > > and resume code needs to be reworked to save more state.  I'll try to
> > > > cook up a patch tomorrow to fix it, but I'll need you to provide
> > > > feedback.
> > > 
> > > Ok, thanks. I'm happy to test any fixes/patches.
> > 
> > This should resolve the problem - we now rely on the stack pointer for
> > each CPU mode to remain constant throughout the running time of the
> > kernel, which includes across suspend/resume cycles.
> 
> Actually, this patch is probably an all-round better solution.

This patch (the simpler of the two using cpu_init()) allows the pxa to
suspend/resume happily with the git-arm-smp.patch applied.

Richard

