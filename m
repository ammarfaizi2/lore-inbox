Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269966AbUJNEhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269966AbUJNEhT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 00:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269967AbUJNEhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 00:37:19 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:53120 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269966AbUJNEhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 00:37:17 -0400
Date: Thu, 14 Oct 2004 13:42:53 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: 2.6.9-rc4-mm1
In-reply-to: <20041011032502.299dc88d.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <416E03CD.8080701@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.3)
 Gecko/20040910
References: <20041011032502.299dc88d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew

I need this patch for compiling 2.6.9-rc4-mm1 on my ia64 box (tiger4).
I don't know this patch is enough good or not.

Kame <kamezawa.hiroyu@jp.fujitsu.com>

Additonal Info:
gcc version is 3.2.3.
CONFIG_IA64_GENERIC=y

---

  linux-2.6.9-rc4-mm1-kamezawa/include/asm-ia64/machvec.h      |    8 ++++----
  linux-2.6.9-rc4-mm1-kamezawa/include/asm-ia64/machvec_init.h |    1 +
  2 files changed, 5 insertions(+), 4 deletions(-)

diff -puN include/asm-ia64/machvec.h~ia64_compile include/asm-ia64/machvec.h
--- linux-2.6.9-rc4-mm1/include/asm-ia64/machvec.h~ia64_compile	2004-10-14 10:24:41.318281363 +0900
+++ linux-2.6.9-rc4-mm1-kamezawa/include/asm-ia64/machvec.h	2004-10-14 10:29:05.813395311 +0900
@@ -63,10 +63,10 @@ typedef void ia64_mv_outb_t (unsigned ch
  typedef void ia64_mv_outw_t (unsigned short, unsigned long);
  typedef void ia64_mv_outl_t (unsigned int, unsigned long);
  typedef void ia64_mv_mmiowb_t (void);
-typedef unsigned char ia64_mv_readb_t (void *);
-typedef unsigned short ia64_mv_readw_t (void *);
-typedef unsigned int ia64_mv_readl_t (void *);
-typedef unsigned long ia64_mv_readq_t (void *);
+typedef unsigned char ia64_mv_readb_t (const volatile void *);
+typedef unsigned short ia64_mv_readw_t (const volatile void *);
+typedef unsigned int ia64_mv_readl_t (const volatile void *);
+typedef unsigned long ia64_mv_readq_t (const volatile void *);
  typedef unsigned char ia64_mv_readb_relaxed_t (void *);
  typedef unsigned short ia64_mv_readw_relaxed_t (void *);
  typedef unsigned int ia64_mv_readl_relaxed_t (void *);
diff -puN include/asm-ia64/machvec_init.h~ia64_compile include/asm-ia64/machvec_init.h
--- linux-2.6.9-rc4-mm1/include/asm-ia64/machvec_init.h~ia64_compile	2004-10-14 11:10:44.690317824 +0900
+++ linux-2.6.9-rc4-mm1-kamezawa/include/asm-ia64/machvec_init.h	2004-10-14 11:11:06.924692552 +0900
@@ -1,3 +1,4 @@
+#include <asm/io.h>
  #include <asm/machvec.h>

  extern ia64_mv_send_ipi_t ia64_send_ipi;

_

