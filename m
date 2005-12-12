Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbVLLNGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVLLNGO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 08:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbVLLNGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 08:06:14 -0500
Received: from mail.renesas.com ([202.234.163.13]:47002 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1751150AbVLLNGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 08:06:13 -0500
Date: Mon, 12 Dec 2005 22:06:09 +0900 (JST)
Message-Id: <20051212.220609.783374801.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, fujiwara@linux-m32r.org,
       takata@linux-m32r.org
Subject: [PATCH 2.6.15-rc5-mm2] m32r: Add pm_power_off() for build fix
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds pm_power_off() for build fix of arch/m32r/kernel/process.c.
Please apply.

Thanks,

Signed-off-by: Hayato Fujiwara <fujiwara@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/process.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6.15-rc5-mm2/arch/m32r/kernel/process.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/arch/m32r/kernel/process.c	2005-12-12 18:53:20.517848048 +0900
+++ linux-2.6.15-rc5-mm2/arch/m32r/kernel/process.c	2005-12-12 21:05:09.826915968 +0900
@@ -50,6 +50,10 @@ unsigned long thread_saved_pc(struct tas
  * Powermanagement idle function, if any..
  */
 void (*pm_idle)(void) = NULL;
+EXPORT_SYMBOL(pm_idle);
+
+void (*pm_power_off)(void) = NULL;
+EXPORT_SYMBOL(pm_power_off);
 
 void disable_hlt(void)
 {

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
