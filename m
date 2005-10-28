Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030575AbVJ1TYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030575AbVJ1TYP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 15:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030635AbVJ1TYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 15:24:15 -0400
Received: from mail22.bluewin.ch ([195.186.19.66]:35503 "EHLO
	mail22.bluewin.ch") by vger.kernel.org with ESMTP id S1030575AbVJ1TYO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 15:24:14 -0400
Date: Fri, 28 Oct 2005 15:23:57 -0400
To: akpm@osdl.org
Cc: starvik@axis.com, linux-kernel@vger.kernel.org
Subject: [PATCH] cris: printk() duplicate declaration
Message-ID: <20051028192357.GA25468@krypton>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

printk() already declared in include/linux/kernel.h so squish the
duplication. Besides, no printk() usage here. Bye bye.

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>

---

 include/asm-cris/semaphore.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

af22c47edbda2849b30f0b202c7937a25dc2e2b7
diff --git a/include/asm-cris/semaphore.h b/include/asm-cris/semaphore.h
--- a/include/asm-cris/semaphore.h
+++ b/include/asm-cris/semaphore.h
@@ -18,8 +18,6 @@
  * CRIS semaphores, implemented in C-only so far. 
  */
 
-int printk(const char *fmt, ...);
-
 struct semaphore {
 	atomic_t count;
 	atomic_t waking;
