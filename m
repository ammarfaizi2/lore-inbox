Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbTHWNdP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 09:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbTHWNdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 09:33:15 -0400
Received: from [203.145.184.221] ([203.145.184.221]:31243 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263430AbTHWNdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 09:33:13 -0400
Subject: [PATCH 2.6.0-test4] wait.h: fix spin_lock_irqrestore typo
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 23 Aug 2003 19:25:28 +0530
Message-Id: <1061646928.1141.33.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A small patch to fix a spin_lock typo in the macro add_wait_queue_cond

Vinay

--- linux-2.6.0-test4/include/linux/wait.h	2003-07-15 17:22:56.000000000 +0530
+++ linux-2.6.0-test4-nvk/include/linux/wait.h	2003-08-23 19:08:36.000000000 +0530
@@ -232,7 +232,7 @@
 			_raced = 1;				\
 			__remove_wait_queue((q), (wait));	\
 		}						\
-		spin_lock_irqrestore(&(q)->lock, flags);	\
+		spin_unlock_irqrestore(&(q)->lock, flags);	\
 		_raced;						\
 	})
 

