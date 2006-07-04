Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWGDPlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWGDPlH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 11:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWGDPlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 11:41:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:13116 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932177AbWGDPkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 11:40:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=Q5/1SVaE+YL/llfL/dgQH7RwfhDpsWKe5ufxniVEOTLGG80bhQ35QyGU+s3/BfUnVp51VMQofE3jZovAix25TzLP3uzLXro1QQ6XqGVEuPIje0iSLajQW/kkB/EwrTdHUQR/p8MA/yAfyk95OvMkBFoyAenfkrx55k+tx9WJYjE=
Message-ID: <44AA8D23.80002@innova-card.com>
Date: Tue, 04 Jul 2006 17:45:39 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Franck <vagabon.xyz@gmail.com>
Subject: [PATCH 5/7] bootmem: remove useless headers inclusions
References: <44AA89D2.8010307@innova-card.com>
In-Reply-To: <44AA89D2.8010307@innova-card.com>
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
1.4.1.g35c6

