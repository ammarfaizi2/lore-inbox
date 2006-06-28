Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932823AbWF1PMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932823AbWF1PMF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 11:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932824AbWF1PMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 11:12:05 -0400
Received: from www.osadl.org ([213.239.205.134]:16606 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932823AbWF1PME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 11:12:04 -0400
Subject: [PATCH] Fix plist include dependency
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 17:14:07 +0200
Message-Id: <1151507648.25491.526.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plist.h uses container_of, which is defined in kernel.h.
Include kernel.h in plist.h as the kernel.h include does not longer
happen automatically on all architectures.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff --git a/include/linux/plist.h b/include/linux/plist.h
index 3404fae..b95818a 100644
--- a/include/linux/plist.h
+++ b/include/linux/plist.h
@@ -73,6 +73,7 @@
 #ifndef _LINUX_PLIST_H_
 #define _LINUX_PLIST_H_
 
+#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/spinlock_types.h>
 


