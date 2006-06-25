Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWFYQjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWFYQjl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 12:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWFYQjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 12:39:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:35734 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751166AbWFYQjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 12:39:41 -0400
Date: Sun, 25 Jun 2006 18:39:30 +0200
From: Nick Piggin <npiggin@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: [patch] 2.6.17: lockless pagecache
Message-ID: <20060625163930.GB3006@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated lockless pagecache patchset available here:

ftp://ftp.kernel.org/pub/linux/kernel/people/npiggin/patches/lockless/2.6.17/lockless.patch.gz

This should hopefully be my last release using the old (2.6.17)
indirect radix-tree, and I'll switch to the direct radix-tree in
future.

Changes since last release:
- lots of radix-tree cleanups and bugs fixed
- radix-tree tag lookups may be lockless
- added some missing memory barriers
- lockless pagevec_lookup_tag

The last item allowed me to remove the last few read-lockers,
which is nice.

