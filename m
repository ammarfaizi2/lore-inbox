Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264756AbSLLQxC>; Thu, 12 Dec 2002 11:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbSLLQxC>; Thu, 12 Dec 2002 11:53:02 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:9601 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S264756AbSLLQxA>; Thu, 12 Dec 2002 11:53:00 -0500
From: Thomas Schlichter <schlicht@rumms.uni-mannheim.de>
Message-ID: <1039712449.3df8c0c183dfe@rumms.uni-mannheim.de>
Date: Thu, 12 Dec 2002 18:00:49 +0100
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Pinning kernel memory
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I want to create a big area of unswappable, physical continuous kernel memory
for hardware testing purposes. Currently I allocate the memory using
alloc_pages(GFP_KERNEL, order) and after this I pin it using
SetPageReserved(page) for each page.

Is this acceptable, or may it happen that after the alloc_pages()-call the
kswapd begins to swap out this memory and just any other memory is pinned??
Do I perhaps have to lock the mm->page_table_lock and test each page before I
pin it?? If it is swapped out, how can I assure to get this page back swapped
in?

is SetPageReserved the right way to pin a memory page, or should
SetPageActive(page) or even LockPage(page) be used??

I hope anyone can help me...
Thank you!

Sincerely yours
  Thomas Schlichter
