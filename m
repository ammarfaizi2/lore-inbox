Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWCJPSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWCJPSN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 10:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWCJPSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 10:18:13 -0500
Received: from ns.suse.de ([195.135.220.2]:1410 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750750AbWCJPSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 10:18:12 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Cc: Nick Piggin <npiggin@suse.de>
Message-Id: <20060207021822.10002.30448.sendpatchset@linux.site>
Subject: A lockless pagecache for Linux
Date: Fri, 10 Mar 2006 16:18:09 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was waiting for 2.6.16 before releasing my patchset, but that got
boring.

ftp://ftp.kernel.org/pub/linux/kernel/people/npiggin/patches/lockless/2.6.16-rc5/

Now I've used some clever subject lines on the subsequent patches
to make you think this isn't a big deal. Actually there are about
36 other "prep" patches before those, and PageReserved removal before
that (which are luckily now mostly in -mm or -linus, respectively).
What's more, there aren't 3 lockless pagecache patches, there are
5 -- but the last two are optimisations.

I'm writing some stuff about these patches, and I've uploaded a
**draft** chapter on the RCU radix-tree, 'radix-intro.pdf' in above
directory (note the bibliography didn't make it -- but thanks Paul
McKenney!)

If anyone would like to test or review it, I would be very happy.
Suggestions to the code or document would be very welcome... but
I'm still hoping nobody spots a fundamental flaw until after OLS.

Rollup of prep patches (5 posted patches apply to the top of this):
2.6.16-rc5-git14-prep.patch.gz

Rollup of prep+lockless patches (includes the 5 posted patches):
2.6.16-rc5-git14-lockless.patch.gz

Note: anyone interested in benchmarking should test prep+rollup vs
prep rather than vs mainline if possible, because there are various
other optimisations in prep.

Thanks,
Nick
