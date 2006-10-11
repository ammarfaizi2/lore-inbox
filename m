Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161411AbWJKVXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161411AbWJKVXr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161512AbWJKVXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:23:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:18848 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161418AbWJKVGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:06:46 -0400
Date: Wed, 11 Oct 2006 14:06:21 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Woodhouse <dwmw2@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 34/67] Fix v850 exported headers
Message-ID: <20061011210621.GI16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="0012-Fix-v850-exported-headers.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: David Woodhouse <dwmw2@infradead.org>

Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/asm-v850/page.h  |    7 ++++---
 include/asm-v850/param.h |    4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

--- linux-2.6.18.orig/include/asm-v850/page.h
+++ linux-2.6.18/include/asm-v850/page.h
@@ -14,6 +14,8 @@
 #ifndef __V850_PAGE_H__
 #define __V850_PAGE_H__
 
+#ifdef __KERNEL__
+
 #include <asm/machdep.h>
 
 
@@ -32,7 +34,6 @@
 #endif
 
 
-#ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
 #define STRICT_MM_TYPECHECKS
@@ -122,9 +123,9 @@ typedef unsigned long pgprot_t;
 #define __va(x)		     ((void *)__phys_to_virt ((unsigned long)(x)))
 
 
-#endif /* KERNEL */
-
 #include <asm-generic/memory_model.h>
 #include <asm-generic/page.h>
 
+#endif /* KERNEL */
+
 #endif /* __V850_PAGE_H__ */
--- linux-2.6.18.orig/include/asm-v850/param.h
+++ linux-2.6.18/include/asm-v850/param.h
@@ -14,8 +14,6 @@
 #ifndef __V850_PARAM_H__
 #define __V850_PARAM_H__
 
-#include <asm/machdep.h>	/* For HZ */
-
 #define EXEC_PAGESIZE	4096
 
 #ifndef NOGROUP
@@ -25,6 +23,8 @@
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
 
 #ifdef __KERNEL__
+#include <asm/machdep.h>	/* For HZ */
+
 # define USER_HZ	100
 # define CLOCKS_PER_SEC	USER_HZ
 #endif

--
