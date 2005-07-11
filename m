Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbVGKBYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVGKBYM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 21:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVGKBYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 21:24:11 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:17897 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262176AbVGKBYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 21:24:10 -0400
Date: Sun, 10 Jul 2005 17:36:34 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] hardirq uses preempt
Message-Id: <20050710173634.1e4005d4.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

hardirq.h uses preempt_count() from preempt.h

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 include/linux/hardirq.h |    1 +
 1 files changed, 1 insertion(+)

diff -Naurp linux-2613-rc2/include/linux/hardirq.h~hardirq-uses-preempt linux-2613-rc2/include/linux/hardirq.h
--- linux-2613-rc2/include/linux/hardirq.h~hardirq-uses-preempt	2005-06-17 12:48:29.000000000 -0700
+++ linux-2613-rc2/include/linux/hardirq.h	2005-07-10 16:18:39.000000000 -0700
@@ -2,6 +2,7 @@
 #define LINUX_HARDIRQ_H
 
 #include <linux/config.h>
+#include <linux/preempt.h>
 #include <linux/smp_lock.h>
 #include <asm/hardirq.h>
 #include <asm/system.h>


---
