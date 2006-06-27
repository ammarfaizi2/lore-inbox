Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWF0MuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWF0MuS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWF0MuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:50:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:20557 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1160993AbWF0Mtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:49:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=VBW9ncsm/tD6+cgkzAza7EAcABcEXxQ10nEYyX5t/hE7EVxKxpZG1hu4KLp/warSOH8u8s+dZ7c0xtxOic8B4YWXiM5UZKF1Drm05xWio93wNSUnuk+cjyxHreQzHv8mPT0x9SKIC9tQYBGjcHGfA0gT3UXmw+8oeJQQZRZsdNo=
Message-ID: <44A12A7C.3020808@innova-card.com>
Date: Tue, 27 Jun 2006 14:54:20 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Franck <vagabon.xyz@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Mel Gorman <mel@skynet.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/7] bootmem: remove useless headers inclusions
References: <449FDD02.2090307@innova-card.com> <1151344691.10877.44.camel@localhost.localdomain>
In-Reply-To: <1151344691.10877.44.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 include/linux/bootmem.h |    5 +----
 mm/bootmem.c            |   10 +++-------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
index f55719b..fe48c5e 100644
--- a/include/linux/bootmem.h
+++ b/include/linux/bootmem.h
@@ -4,11 +4,8 @@
 #ifndef _LINUX_BOOTMEM_H
 #define _LINUX_BOOTMEM_H
 
-#include <asm/pgtable.h>
-#include <asm/dma.h>
-#include <linux/cache.h>
-#include <linux/init.h>
 #include <linux/mmzone.h>
+#include <asm/dma.h>
 
 /*
  *  simple boot-time physical memory area allocator.
diff --git a/mm/bootmem.c b/mm/bootmem.c
index ac6a51c..86213da 100644
--- a/mm/bootmem.c
+++ b/mm/bootmem.c
@@ -8,17 +8,13 @@
  *  free memory collector. It's used to deal with reserved
  *  system memory and memory holes as well.
  */
-
-#include <linux/mm.h>
-#include <linux/kernel_stat.h>
-#include <linux/swap.h>
-#include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
-#include <linux/mmzone.h>
 #include <linux/module.h>
-#include <asm/dma.h>
+
+#include <asm/bug.h>
 #include <asm/io.h>
+
 #include "internal.h"
 
 /*
-- 
1.4.0.g64e8


