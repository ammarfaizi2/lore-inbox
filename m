Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVFSBVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVFSBVE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 21:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVFSBVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 21:21:04 -0400
Received: from tim.rpsys.net ([194.106.48.114]:60857 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262216AbVFSBUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 21:20:55 -0400
Subject: Re: 2.6.12-rc6-mm1
From: Richard Purdie <rpurdie@rpsys.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050619001841.A7252@flint.arm.linux.org.uk>
References: <20050607042931.23f8f8e0.akpm@osdl.org>
	 <1119134359.7675.38.camel@localhost.localdomain>
	 <20050619001841.A7252@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Sun, 19 Jun 2005 02:20:48 +0100
Message-Id: <1119144048.7675.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-19 at 00:18 +0100, Russell King wrote: 
> On Sat, Jun 18, 2005 at 11:39:18PM +0100, Richard Purdie wrote:
> > On Tue, 2005-06-07 at 04:29 -0700, Andrew Morton wrote:
> > > +git-arm-smp.patch
> > > 
> > >  ARM git trees
> > 
> > The arm pxa255 based Zaurus won't resume from a suspend with the patches
> > from the above tree applied. The suspend looks normal and gets at least
> > as far as pxa_pm_enter(). After that, the device appears to be dead and
> > needs a battery removal to reset. I'm unsure if it actually suspends and
> > is failing to resume or is crashing in the latter suspend stages.
> 
> <grumble>Well, its a bit late for this since (a) stuff has rapidly
> moved on at rmk towers since 2.6.12 was released this morning, and
> (b) I've just asked Linus to pull this.</grumble>

Please don't underestimate the time it takes to wade through all the
patches in the -mm tree, find the one causing the breakage, investigate
the patch and report it to the person concerned. I'm doing the Zaurus
work in my spare time and don't get paid for it. Just reflashing and
booting a new kernel probably takes ~15mins on the Zaurus.  The
copy/clearpage problem took a complete weekend to track down (as it was
showing up randomly) and then needed further evenings to debug your
patch which is a large chunk of my free time. The Checked-By: line
didn't quite give the full picture.

I realise its taken me a while to find enough time to test/debug this
kernel but as least you now know there's a problem...

> Thinking about what's probably happening, I suspect all the ARM suspend
> and resume code needs to be reworked to save more state.  I'll try to
> cook up a patch tomorrow to fix it, but I'll need you to provide
> feedback.

Ok, thanks. I'm happy to test any fixes/patches.

> Please note that you may see other ARM breakage over the next month
> or so - I'm going to be concentrating on merging ARM SMP support,
> and whatever bashing other people like yourself can give the kernel
> will help ensure that problems are picked up quickly.

In order to assist with that, can you publish these patches somewhere?
That way, I can apply them against a known good Zaurus kernel tree and
know straight away if they break anything (diff/patch format would be
preferable as my Zaurus trees are all patch based).

On a positive note, something in the later 2.6.12-rc kernels has made a
massive difference to the speed on the Zaurus - I suspect the removal of
the preempt locks on copy/clearpage. It boots up ~1.5x faster and the
speed gain will make a lot of people very happy :)

Richard

