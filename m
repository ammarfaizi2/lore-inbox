Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbULILHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbULILHd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 06:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbULILHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 06:07:32 -0500
Received: from holomorphy.com ([207.189.100.168]:19589 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261500AbULILH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 06:07:26 -0500
Date: Thu, 9 Dec 2004 03:07:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jbarnes@engr.sgi.com
Subject: Re: 2.6.10-rc2-mm4
Message-ID: <20041209110717.GX2714@holomorphy.com>
References: <20041130095045.090de5ea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041130095045.090de5ea.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 09:50:45AM -0800, Andrew Morton wrote:
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm4/
> - Various fixes and cleanups
> - A decent-sized x86_64 update.
> - x86_64 supports a fourth VM zone: ZONE_DMA32.  This may affect memory
>   reclaim, but shouldn't.
> +sys_stime-needs-a-compat-function.patch
> +sys_stime-needs-a-compat-function-fix.patch
> +sys_stime-needs-a-compat-function-fix-fix.patch
>  Add compat wrapper for sys_stime().  Clean up (and break) several other
>  things.

One of which is apparently ia64. The following adds the necessary define
for ia64 to actually use the compat sys_time() function.

and I seem to need a new SAL version again...
SGI SAL version 3.40
This kernel needs SGI SAL version >= 4.00
Kernel panic - not syncing: PROM version too old


-- wli

Index: mm4-2.6.10-rc2/include/asm-ia64/unistd.h
===================================================================
--- mm4-2.6.10-rc2.orig/include/asm-ia64/unistd.h	2004-12-09 02:17:11.460765881 -0800
+++ mm4-2.6.10-rc2/include/asm-ia64/unistd.h	2004-12-09 02:51:03.990037857 -0800
@@ -281,6 +281,7 @@
 # define __ARCH_WANT_SYS_OLDUMOUNT
 # define __ARCH_WANT_SYS_SIGPENDING
 # define __ARCH_WANT_SYS_SIGPROCMASK
+# define __ARCH_WANT_COMPAT_SYS_TIME
 #endif
 
 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)
