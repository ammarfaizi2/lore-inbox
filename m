Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267670AbUHENYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267670AbUHENYj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267674AbUHENYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:24:38 -0400
Received: from holomorphy.com ([207.189.100.168]:15299 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267670AbUHENYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:24:25 -0400
Date: Thu, 5 Aug 2004 06:24:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1
Message-ID: <20040805132422.GD14358@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040805031918.08790a82.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805031918.08790a82.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 03:19:18AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc3/2.6.8-rc3-mm1/
> - Added David Woodhouse's MTD tree to the "external trees" list
> - Dropped the staircase scheduler, mainly because the schedstats patch broke
>   it.
>   We learned quite a lot from having staircase in there.  Now it's time for
>   a new scheduler anyway.

Yet another "I forgot to #include <linux/profile.h>" gaffe.


Index: mm1-2.6.8-rc3/arch/sparc/kernel/sun4m_smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/sparc/kernel/sun4m_smp.c
+++ mm1-2.6.8-rc3/arch/sparc/kernel/sun4m_smp.c
@@ -16,6 +16,7 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
+#include <linux/profile.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
Index: mm1-2.6.8-rc3/arch/sparc/kernel/sun4d_smp.c
===================================================================
--- mm1-2.6.8-rc3.orig/arch/sparc/kernel/sun4d_smp.c
+++ mm1-2.6.8-rc3/arch/sparc/kernel/sun4d_smp.c
@@ -19,6 +19,7 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
+#include <linux/profile.h>
 
 #include <asm/ptrace.h>
 #include <asm/atomic.h>
