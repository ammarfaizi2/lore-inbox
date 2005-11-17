Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbVKQT3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbVKQT3n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbVKQT3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:29:43 -0500
Received: from silver.veritas.com ([143.127.12.111]:61983 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S964791AbVKQT3m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:29:42 -0500
Date: Thu, 17 Nov 2005 19:28:22 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] unpaged: PageReserved VM fixups
Message-ID: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Nov 2005 19:29:41.0321 (UTC) FILETIME=[41A63B90:01C5EBAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here come my fixups to the PageReserved removal in 2.6.15-rc1.
Diffed against 2.6.15-rc1-git5.  I hope they can be included in
2.6.15-rc2, but admit they've had had no real driver testing yet.
Please scrutinize and test!

Hugh

 arch/powerpc/kernel/vdso.c      |    3 
 arch/sparc/mm/generic.c         |    2 
 arch/sparc64/mm/generic.c       |    2 
 drivers/char/mem.c              |    2 
 include/linux/mm.h              |   24 -------
 include/linux/page-flags.h      |    4 -
 kernel/fork.c                   |    2 
 mm/fremap.c                     |   10 +--
 mm/madvise.c                    |    2 
 mm/memory.c                     |  128 +++++++++++++++++++++++++++-------------
 mm/mempolicy.c                  |    2 
 mm/mmap.c                       |   11 ---
 mm/mprotect.c                   |    8 --
 mm/msync.c                      |    4 -
 mm/page_alloc.c                 |   51 ++++++++++-----
 mm/rmap.c                       |   22 +++---
 mm/swap.c                       |    3 
 sound/usb/usx2y/usx2yhwdeppcm.c |    1 
 18 files changed, 149 insertions(+), 132 deletions(-)
