Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbUC2IOC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 03:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUC2IOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 03:14:01 -0500
Received: from ns.suse.de ([195.135.220.2]:42168 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262753AbUC2IMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 03:12:24 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc32: Fix sector_t definition with CONFIG_LBD
References: <1080541934.1210.5.camel@gaston>
	<20040328230351.1a0d0e9c.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 29 Mar 2004 10:08:36 +0200
In-Reply-To: <20040328230351.1a0d0e9c.akpm@osdl.org.suse.lists.linux.kernel>
Message-ID: <p7365co848r.fsf@nielsen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> >  sector_t depends on CONFIG_LBD but include/config.h may not be there
> >  thus causing interesting breakage in some places...
> 
> Nasty.
> 
> >  Here's the fix for ppc32 (problem found by Roman Zippel, other archs
> >  need a similar fix).
> 
> Three of them.
> 
>  25-akpm/include/asm-s390/types.h   |    2 ++
>  25-akpm/include/asm-sh/types.h     |    2 ++
>  25-akpm/include/asm-x86_64/types.h |    2 ++

Please use this change for x86-64 instead.

-Andi

diff -u linux-2.6.5rc2-amd64/include/asm-x86_64/types.h-o linux-2.6.5rc2-amd64/include/asm-x86_64/types.h
--- linux-2.6.5rc2-amd64/include/asm-x86_64/types.h-o	2004-03-21 21:11:54.000000000 +0100
+++ linux-2.6.5rc2-amd64/include/asm-x86_64/types.h	2004-03-29 04:44:24.000000000 +0200
@@ -48,10 +48,8 @@
 typedef u64 dma64_addr_t;
 typedef u64 dma_addr_t;
 
-#ifdef CONFIG_LBD
 typedef u64 sector_t;
 #define HAVE_SECTOR_T
-#endif
 
 #endif /* __ASSEMBLY__ */
 
