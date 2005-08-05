Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263094AbVHETC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263094AbVHETC7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 15:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbVHETC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 15:02:27 -0400
Received: from ns.suse.de ([195.135.220.2]:6596 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262718AbVHETAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 15:00:08 -0400
Date: Fri, 5 Aug 2005 21:00:06 +0200
From: Olaf Hering <olh@suse.de>
To: Benoit Boissinot <bboissin@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] implicit declaration of function `page_cache_release'
Message-ID: <20050805190006.GA6747@suse.de>
References: <20050708150313.GA30373@suse.de> <40f323d005080511516a81a7d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40f323d005080511516a81a7d6@mail.gmail.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Aug 05, Benoit Boissinot wrote:

> On 7/8/05, Olaf Hering <olh@suse.de> wrote:
> > 
> > In file included from include2/asm/tlb.h:31,
> >                  from linux-2.6.13-rc2-olh/arch/ppc64/kernel/pSeries_lpar.c:37:
> > linux-2.6.13-rc2-olh/include/asm-generic/tlb.h: In function `tlb_flush_mmu':
> > linux-2.6.13-rc2-olh/include/asm-generic/tlb.h:77: warning: implicit declaration of function `release_pages'
> > linux-2.6.13-rc2-olh/include/asm-generic/tlb.h: In function `tlb_remove_page':
> > linux-2.6.13-rc2-olh/include/asm-generic/tlb.h:117: warning: implicit declaration of function `page_cache_release'
> > 
> This went in 2.6.13-rc3 (commit
> 542d1c88bd7f73e2e59d41b12e4a9041deea89e4), and broke sparc compilation
> because of the following circular dependency:
> asm-sparc/pgtable include linux/swap.h

Why does it need swap.h? Do the users of pgtable.h rely on swap.h?
