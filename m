Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751530AbVLFAfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbVLFAfp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbVLFAfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:35:32 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:27598
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751530AbVLFAee
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:34:34 -0500
Message-Id: <20051206000153.397967000@tglx.tec.linutronix.de>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
Date: Tue, 06 Dec 2005 01:01:31 +0100
From: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rostedt@goodmis.org, johnstul@us.ibm.com,
       zippel@linux-m86k.org, mingo@elte.hu
Subject: [patch 05/21] Export deinlined mktime
Content-Disposition: inline; filename=deinline-mktime-export.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Andrew Morton <akpm@osdl.org>

This is now uninlined, but some modules use it.

Make it a non-GPL export, since the inlined mktime() was also available that
way.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/time.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-2.6.15-rc5/kernel/time.c
===================================================================
--- linux-2.6.15-rc5.orig/kernel/time.c
+++ linux-2.6.15-rc5/kernel/time.c
@@ -597,6 +597,8 @@ mktime(const unsigned int year0, const u
 	)*60 + sec; /* finally seconds */
 }
 
+EXPORT_SYMBOL(mktime);
+
 /**
  * set_normalized_timespec - set timespec sec and nsec parts and normalize
  *

--

