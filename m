Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVC0Otq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVC0Otq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 09:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVC0Otg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 09:49:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9741 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261710AbVC0Oe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 09:34:29 -0500
Date: Sun, 27 Mar 2005 16:34:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/i386/kernel/smp.c: remove a pointless "inline"
Message-ID: <20050327143428.GH4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All callers of send_IPI_mask_sequence are in other files, so marking it 
"inline" is quite pointless.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 13 Mar 2005

--- linux-2.6.11-mm3-full/arch/i386/kernel/smp.c.old	2005-03-13 04:28:29.000000000 +0100
+++ linux-2.6.11-mm3-full/arch/i386/kernel/smp.c	2005-03-13 04:28:42.000000000 +0100
@@ -189,7 +189,7 @@
 	local_irq_restore(flags);
 }
 
-inline void send_IPI_mask_sequence(cpumask_t mask, int vector)
+void send_IPI_mask_sequence(cpumask_t mask, int vector)
 {
 	unsigned long cfg, flags;
 	unsigned int query_cpu;
