Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263320AbUJ2N1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263320AbUJ2N1p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 09:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbUJ2N1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 09:27:44 -0400
Received: from mail.renesas.com ([202.234.163.13]:39573 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S263320AbUJ2N0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 09:26:31 -0400
Date: Fri, 29 Oct 2004 22:26:15 +0900 (JST)
Message-Id: <20041029.222615.1025206547.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc1] [m32r] Remove old ELF relocation types
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Remove old relocation type definitions from include/asm-m32r/elf.h.
These ELF relocations are obsolete and no longer used.

	* include/asm-m32r/elf.h:
	- Remove old relocation types.

Regards.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 include/asm-m32r/elf.h |   39 ---------------------------------------
 1 files changed, 39 deletions(-)

--- a/include/asm-m32r/elf.h	2004-10-29 19:58:03.000000000 +0900
+++ b/include/asm-m32r/elf.h	2004-10-29 21:57:23.000000000 +0900
@@ -24,47 +24,9 @@
 #define	R_M32R_HI16_SLO		8
 #define	R_M32R_LO16		9
 #define	R_M32R_SDA16		10
-#ifdef OLD_TYPE
-#define	R_M32R_GOT24		11
-#define	R_M32R_26_PLTREL	12
-#define	R_M32R_GOT16_HI_ULO	13
-#define	R_M32R_GOT16_HI_SLO	14
-#define	R_M32R_GOT16_LO		15
-#define	R_M32R_GOTPC24		16
-#define	R_M32R_COPY		17
-#define	R_M32R_GLOB_DAT		18
-#define	R_M32R_JMP_SLOT		19
-#define	R_M32R_RELATIVE		20
-#define	R_M32R_GNU_VTINHERIT	21
-#define	R_M32R_GNU_VTENTRY	22
-
-#define R_M32R_16_RELA		R_M32R_16
-#define R_M32R_32_RELA		R_M32R_32
-#define R_M32R_24_RELA		R_M32R_24
-#define R_M32R_10_PCREL_RELA	R_M32R_10_PCREL
-#define R_M32R_18_PCREL_RELA	R_M32R_18_PCREL
-#define R_M32R_26_PCREL_RELA	R_M32R_26_PCREL
-#define R_M32R_HI16_ULO_RELA	R_M32R_HI16_ULO
-#define R_M32R_HI16_SLO_RELA	R_M32R_HI16_SLO
-#define R_M32R_LO16_RELA	R_M32R_LO16
-#define R_M32R_SDA16_RELA	R_M32R_SDA16
-#else /* not OLD_TYPE */
 #define	R_M32R_GNU_VTINHERIT	11
 #define	R_M32R_GNU_VTENTRY	12
 
-#define	R_M32R_GOT24_SAMPLE		11 /* comflict */
-#define	R_M32R_26_PLTREL_SAMPLE	12 /* comflict */
-#define	R_M32R_GOT16_HI_ULO_SAMPLE	13
-#define	R_M32R_GOT16_HI_SLO_SAMPLE	14
-#define	R_M32R_GOT16_LO_SAMPLE		15
-#define	R_M32R_GOTPC24_SAMPLE		16
-#define	R_M32R_COPY_SAMPLE		17
-#define	R_M32R_GLOB_DAT_SAMPLE		18
-#define	R_M32R_JMP_SLOT_SAMPLE		19
-#define	R_M32R_RELATIVE_SAMPLE		20
-#define	R_M32R_GNU_VTINHERIT_SAMPLE	21
-#define	R_M32R_GNU_VTENTRY_SAMPLE	22
-
 #define R_M32R_16_RELA		33
 #define R_M32R_32_RELA		34
 #define R_M32R_24_RELA		35
@@ -92,7 +54,6 @@
 #define R_M32R_GOTPC_HI_ULO	59
 #define R_M32R_GOTPC_HI_SLO	60
 #define R_M32R_GOTPC_LO		61
-#endif /* not OLD_TYPE */
 
 #define R_M32R_NUM		256
 
--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
