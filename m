Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbVLFNQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbVLFNQm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 08:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbVLFNQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 08:16:42 -0500
Received: from mail.renesas.com ([202.234.163.13]:60332 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1751500AbVLFNQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 08:16:42 -0500
Date: Tue, 06 Dec 2005 22:16:37 +0900 (JST)
Message-Id: <20051206.221637.1046808625.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Sugai.Naoto@ak.MitsubishiElectric.co.jp,
       takata@linux-m32r.org
Subject: [PATCH 2.6.15-rc5] m32r: trivial fix to remove unused instructions
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A trivial fix to remove unused instructions.
Please apply.

Signed-off-by: Naoto Sugai <Sugai.Naoto@ak.MitsubishiElectric.co.jp>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/entry.S |    2 --
 1 file changed, 2 deletions(-)

Index: linux-2.6.15-rc5/arch/m32r/kernel/entry.S
===================================================================
--- linux-2.6.15-rc5.orig/arch/m32r/kernel/entry.S	2005-12-04 14:10:42.000000000 +0900
+++ linux-2.6.15-rc5/arch/m32r/kernel/entry.S	2005-12-05 14:55:49.768176440 +0900
@@ -651,8 +651,6 @@ ENTRY(rie_handler)
 /* void rie_handler(int error_code) */
 	SWITCH_TO_KERNEL_STACK
 	SAVE_ALL
-	mvfc	r0, bpc
-	ld	r1, @r0
 	ldi	r1, #0x20			; error_code
 	mv	r0, sp				; pt_regs
 	bl	do_rie_handler

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
