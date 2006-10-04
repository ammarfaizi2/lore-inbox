Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWJDX0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWJDX0y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 19:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWJDX0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 19:26:32 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:22913 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751226AbWJDX0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 19:26:30 -0400
Message-Id: <20061004232454.688507000@linux-m68k.org>
References: <20061004232414.730831000@linux-m68k.org>
User-Agent: quilt/0.45-1
Date: Thu, 05 Oct 2006 01:24:15 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] provide tickadj define
Content-Disposition: inline; filename=tickadj_define
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a tickadj compatibility define for archs still using it.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---
 include/linux/timex.h |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/include/linux/timex.h
===================================================================
--- linux-2.6.orig/include/linux/timex.h
+++ linux-2.6/include/linux/timex.h
@@ -293,6 +293,9 @@ extern void second_overflow(void);
 extern void update_ntp_one_tick(void);
 extern int do_adjtimex(struct timex *);
 
+/* Don't use! Compatibility define for existing users. */
+#define tickadj	(500/HZ ? : 1)
+
 #endif /* KERNEL */
 
 #endif /* LINUX_TIMEX_H */

--

