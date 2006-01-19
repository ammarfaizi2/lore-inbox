Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161293AbWASTWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161293AbWASTWr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161306AbWASTWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:22:47 -0500
Received: from ns1.suse.de ([195.135.220.2]:41398 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161293AbWASTWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:22:46 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <20060119192131.11913.27564.sendpatchset@linux.site>
Subject: [patch 0/6] mm: optimisations and page ref simplifications
Date: Thu, 19 Jan 2006 20:22:42 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the following patchset (against 2.6.16-rc1-git2), patches 1-4 reduce
the number of locks and atomic operations required in some critical page
manipulation paths.

Patches 5 and 6 help simplify some tricky race avoidance code at the
cost of possibly a very minor performance hit in page reclaim on some
architectures. If they need any more justification they will be needed
for lockless pagecache.

Do these look OK?

Thanks,
Nick

