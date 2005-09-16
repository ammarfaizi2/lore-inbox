Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161057AbVIPKVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057AbVIPKVw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 06:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161156AbVIPKVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 06:21:52 -0400
Received: from ozlabs.org ([203.10.76.45]:17331 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161057AbVIPKVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 06:21:52 -0400
Date: Fri, 16 Sep 2005 20:17:00 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc1-mm1
Message-ID: <20050916101700.GB14962@krispykreme>
References: <20050916022319.12bf53f3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050916022319.12bf53f3.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 02:23:19AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc1/2.6.14-rc1-mm1/

Builds and boots on ppc64 (POWER5) with the following patch, I forgot to
include siginfo.h when I added data breakpoint support. We must include
it in a round-a-bout way in mainline.

Signed-off-by: Anton Blanchard <anton@samba.org>

Index: linux-2.6-test/arch/ppc64/mm/fault.c
===================================================================
--- linux-2.6-test.orig/arch/ppc64/mm/fault.c	2005-09-16 20:13:05.000000000 +1000
+++ linux-2.6-test/arch/ppc64/mm/fault.c	2005-09-16 20:13:47.000000000 +1000
@@ -38,6 +38,7 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/kdebug.h>
+#include <asm/siginfo.h>
 
 /*
  * Check whether the instruction at regs->nip is a store using
