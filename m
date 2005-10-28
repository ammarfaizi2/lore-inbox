Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751654AbVJ1TIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbVJ1TIq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 15:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbVJ1TIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 15:08:46 -0400
Received: from mail16.bluewin.ch ([195.186.19.63]:8641 "EHLO mail16.bluewin.ch")
	by vger.kernel.org with ESMTP id S1751653AbVJ1TIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 15:08:45 -0400
Date: Fri, 28 Oct 2005 15:08:11 -0400
To: akpm@osdl.org
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] arm: sema_count() removal
Message-ID: <20051028190811.GA21925@krypton>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sema_count() defined only for ARM but not used anywhere.

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>

---

 include/asm-arm/semaphore.h |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

45427c6a7e19359533fa6f29d5a963c722ce124b
diff --git a/include/asm-arm/semaphore.h b/include/asm-arm/semaphore.h
--- a/include/asm-arm/semaphore.h
+++ b/include/asm-arm/semaphore.h
@@ -47,11 +47,6 @@ static inline void init_MUTEX_LOCKED(str
 	sema_init(sem, 0);
 }
 
-static inline int sema_count(struct semaphore *sem)
-{
-	return atomic_read(&sem->count);
-}
-
 /*
  * special register calling convention
  */
