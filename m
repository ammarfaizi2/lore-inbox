Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262734AbVCWRLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbVCWRLv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 12:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbVCWRLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 12:11:51 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:39916 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262734AbVCWRL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 12:11:26 -0500
Date: Wed, 23 Mar 2005 17:10:15 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: akpm@osdl.org, davem@davemloft.net, tony.luck@intel.com,
       benh@kernel.crashing.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] freepgt: free_pgtables shakeup
Message-ID: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the recut of those patches, including David Miller's vital fixes.
I'm addressing these to Nick rather than Andrew, because they're perhaps
not fit for -mm until more testing done and the x86_64 32-bit vdso issue
handled.  I'm unlikely to be responsive until next week, sorry: over to
you, Nick - thanks.

Hugh

 arch/i386/mm/hugetlbpage.c    |   11 --
 arch/i386/mm/pgtable.c        |    2 
 arch/ia64/mm/hugetlbpage.c    |   60 ++++---------
 arch/ppc64/mm/hugetlbpage.c   |   47 ----------
 include/asm-generic/pgtable.h |    8 -
 include/asm-ia64/page.h       |    2 
 include/asm-ia64/pgtable.h    |   30 ------
 include/asm-ia64/processor.h  |    8 -
 include/asm-ppc64/pgtable.h   |   12 +-
 include/asm-ppc64/processor.h |    4 
 include/asm-s390/processor.h  |    2 
 include/asm-sparc64/pgtable.h |   15 ---
 include/linux/hugetlb.h       |    6 -
 include/linux/mm.h            |   14 +--
 mm/memory.c                   |  190 ++++++++++++++++++++++++++++++------------
 mm/mmap.c                     |  139 ++++++++----------------------
 16 files changed, 226 insertions(+), 324 deletions(-)
