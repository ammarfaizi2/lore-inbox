Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbVCBJRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbVCBJRO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 04:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVCBJRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 04:17:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:30621 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262235AbVCBJRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 04:17:11 -0500
Subject: Missing 'noinline' and '__compiler_offsetof' for GCC4+
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 02 Mar 2005 09:16:47 +0000
Message-Id: <1109755008.19535.16.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point we'll want to create 'compiler-gcc4.h' but probably not
until it's going to be actually differ from 'compiler-gcc+.h'. Because
they only get out of date if they're not used by anyone...

--- linux-2.6.10/include/linux/compiler-gcc+.h~	2004-12-24 21:35:39.000000000 +0000
+++ linux-2.6.10/include/linux/compiler-gcc+.h	2005-03-01 15:49:47.000000000 +0000
@@ -13,4 +13,6 @@
 #define __attribute_used__	__attribute__((__used__))
 #define __attribute_pure__	__attribute__((pure))
 #define __attribute_const__	__attribute__((__const__))
+#define  noinline		__attribute__((noinline))
 #define __must_check 		__attribute__((warn_unused_result))
+#define __compiler_offsetof(a,b) __builtin_offsetof(a,b)


-- 
dwmw2

