Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266761AbSLPPsG>; Mon, 16 Dec 2002 10:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266774AbSLPPsG>; Mon, 16 Dec 2002 10:48:06 -0500
Received: from stingr.net ([212.193.32.15]:45834 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S266761AbSLPPsF>;
	Mon, 16 Dec 2002 10:48:05 -0500
Date: Mon, 16 Dec 2002 18:56:00 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap15b for 2.4.20-ac2
Message-ID: <20021216155600.GC2496@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It works for me (tm)

http://stingr.net/l/rmap15b-for-2.4.20-ac2.gz

 arch/i386/config.in               |    1 
 arch/i386/kernel/vm86.c           |    8 
 arch/i386/mm/Makefile             |    2 
 arch/i386/mm/fault.c              |    2 
 arch/i386/mm/init.c               |   56 -
 arch/i386/mm/ioremap.c            |    2 
 arch/i386/mm/pageattr.c           |    2 
 arch/i386/mm/pgtable.c            |  226 +++++++
 drivers/char/drm/drm_proc.h       |    3 
 drivers/sgi/char/graphics.c       |    7 
 fs/buffer.c                       |   25 
 fs/exec.c                         |    7 
 fs/proc/array.c                   |    5 
 fs/proc/proc_misc.c               |   12 
 include/asm-generic/rmap.h        |   47 +
 include/asm-i386/fixmap.h         |    7 
 include/asm-i386/highmem.h        |   14 
 include/asm-i386/kmap_types.h     |    3 
 include/asm-i386/page.h           |    8 
 include/asm-i386/pgalloc.h        |  138 ----
 include/asm-i386/pgtable-2level.h |    6 
 include/asm-i386/pgtable-3level.h |   13 
 include/asm-i386/pgtable.h        |   37 +
 include/asm-i386/rmap.h           |   14 
 include/linux/brlock.h            |    2 
 include/linux/highmem.h           |    1 
 include/linux/list.h              |    3 
 include/linux/mm.h                |   92 ++-
 include/linux/mm_inline.h         |  188 +++++-
 include/linux/mmzone.h            |   20 
 include/linux/module.h            |    5 
 include/linux/pagemap.h           |    1 
 include/linux/swap.h              |   20 
 mm/filemap.c                      |   60 +-
 mm/memory.c                       |  182 ++++--
 mm/mprotect.c                     |    6 
 mm/mremap.c                       |   79 ++
 mm/page_alloc.c                   |  104 ++-
 mm/rmap.c                         |  373 +++++++++----
 mm/swap.c                         |  106 ++-
 mm/swapfile.c                     |    5 
 mm/vmalloc.c                      |    4 
 mm/vmscan.c                       | 1080 ++++++++++++++++++++++++--------------
 43 files changed, 2062 insertions(+), 914 deletions(-)



-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
