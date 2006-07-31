Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWGaN4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWGaN4M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 09:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWGaN4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 09:56:12 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:44030 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1750825AbWGaN4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 09:56:10 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 5/6] AVR32: Use linux/pfn.h
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Mon, 31 Jul 2006 15:55:59 +0200
Message-Id: <11543541603922-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11543541601135-git-send-email-hskinnemoen@atmel.com>
References: <1154354160566-git-send-email-hskinnemoen@atmel.com> <11543541601753-git-send-email-hskinnemoen@atmel.com> <11543541602148-git-send-email-hskinnemoen@atmel.com> <11543541601135-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As pointed out by Dave Hansen, we should really use linux/pfn.h
instead of our own PFN_UP/PFN_DOWN/PFN_PHYS definitions.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/mm/init.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/avr32/mm/init.c b/arch/avr32/mm/init.c
index 7bbbd7e..e4b6707 100644
--- a/arch/avr32/mm/init.c
+++ b/arch/avr32/mm/init.c
@@ -14,6 +14,7 @@ #include <linux/initrd.h>
 #include <linux/mmzone.h>
 #include <linux/bootmem.h>
 #include <linux/pagemap.h>
+#include <linux/pfn.h>
 #include <linux/nodemask.h>
 
 #include <asm/page.h>
@@ -90,10 +91,6 @@ static void __init print_memory_map(cons
 	}
 }
 
-#define PFN_UP(x)	(((x) + PAGE_SIZE - 1) >> PAGE_SHIFT)
-#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
-#define PFN_PHYS(x)	((x) << PAGE_SHIFT)
-
 #define MAX_LOWMEM	HIGHMEM_START
 #define MAX_LOWMEM_PFN	PFN_DOWN(MAX_LOWMEM)
 
-- 
1.4.0

