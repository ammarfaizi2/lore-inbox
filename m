Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbVKVFTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVKVFTN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 00:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbVKVFTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 00:19:13 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:21724 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932259AbVKVFTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 00:19:12 -0500
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Jun Komuro <komurojun-mbn@nifty.com>
Subject: [PATCH 3/5] Remove custom NO_IRQ definition
Message-Id: <E1EeQYe-00055q-MM@localhost.localdomain>
Date: Tue, 22 Nov 2005 00:19:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pd6729.c had its own definition of NO_IRQ; remove it.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

---

 drivers/pcmcia/pd6729.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

applies-to: 0c117e1538dfea89f05786a658b0eb4ee39cb147
be537724d2b113c7b1e3634d074bb1a336446a32
diff --git a/drivers/pcmcia/pd6729.c b/drivers/pcmcia/pd6729.c
index 20642f0..63391cf 100644
--- a/drivers/pcmcia/pd6729.c
+++ b/drivers/pcmcia/pd6729.c
@@ -39,10 +39,6 @@ MODULE_AUTHOR("Jun Komuro <komurojun-mbn
  */
 #define to_cycles(ns)	((ns)/120)
 
-#ifndef NO_IRQ
-#define NO_IRQ	((unsigned int)(0))
-#endif
-
 /*
  * PARAMETERS
  *  irq_mode=n
---
0.99.8.GIT
