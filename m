Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbVJKNSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbVJKNSV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 09:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbVJKNSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 09:18:21 -0400
Received: from mail.renesas.com ([202.234.163.13]:11932 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1750903AbVJKNST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 09:18:19 -0400
Date: Tue, 11 Oct 2005 22:18:14 +0900 (JST)
Message-Id: <20051011.221814.15266173.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: takata@linux-m32r.org, linux-kernel@vger.kernel.org, sugai@isl.melco.co.jp
Subject: [PATCH 2.6.14-rc2-mm2] m32r: remove unused instructions
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please remove unused instructions for debugging.

Signed-off-by: Naoto Sugai <sugai@isl.melco.co.jp>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/entry.S |    2 --
 1 file changed, 2 deletions(-)

Index: linux-2.6.14-rc2-mm2/arch/m32r/kernel/entry.S
===================================================================
--- linux-2.6.14-rc2-mm2.orig/arch/m32r/kernel/entry.S	2005-10-11 20:57:16.845941384 +0900
+++ linux-2.6.14-rc2-mm2/arch/m32r/kernel/entry.S	2005-10-11 21:08:43.027625912 +0900
@@ -653,8 +653,6 @@ ENTRY(rie_handler)
 	SAVE_ALL
 	mvfc	r0, bpc
 	ld	r1, @r0
-	seth	r0, #0xa0f0
-	st	r1, @r0
 	ldi	r1, #0x20			; error_code
 	mv	r0, sp				; pt_regs
 	bl	do_rie_handler

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
