Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbULOKxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbULOKxO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 05:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbULOKwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 05:52:46 -0500
Received: from mail.renesas.com ([202.234.163.13]:62870 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262320AbULOKwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 05:52:36 -0500
Date: Wed, 15 Dec 2004 19:52:22 +0900 (JST)
Message-Id: <20041215.195222.304116763.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc3-mm1] m32r: Add new relocation types to elf.h
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch adds some new relocation types to include/asm-m32r/elf.h.
Please apply.

	* include/asm-m32r/elf.h:
	  Add relocations R_M32R_GOTOFF_HI_ULO, R_M32R_GOTOFF_HI_SLO, and
	  R_M32R_GOTOFF_LO. These relocations are required to implement
	  GOTOFF support for m32r.

Regards,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 include/asm-m32r/elf.h |    3 +++
 1 files changed, 3 insertions(+)


diff -ruNp a/include/asm-m32r/elf.h b/include/asm-m32r/elf.h
--- a/include/asm-m32r/elf.h	2004-12-06 09:41:31.000000000 +0900
+++ b/include/asm-m32r/elf.h	2004-12-15 17:54:15.000000000 +0900
@@ -54,6 +54,9 @@
 #define R_M32R_GOTPC_HI_ULO	59
 #define R_M32R_GOTPC_HI_SLO	60
 #define R_M32R_GOTPC_LO		61
+#define R_M32R_GOTOFF_HI_ULO	62
+#define R_M32R_GOTOFF_HI_SLO	63
+#define R_M32R_GOTOFF_LO	64
 
 #define R_M32R_NUM		256
 

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
