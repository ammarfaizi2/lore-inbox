Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbUKFOx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUKFOx6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 09:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbUKFOx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 09:53:58 -0500
Received: from math.ut.ee ([193.40.5.125]:4334 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261396AbUKFOx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 09:53:56 -0500
Date: Sat, 6 Nov 2004 16:53:54 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ata.h undefined types in USB
Message-ID: <Pine.GSO.4.44.0411061639270.14682-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is todays BK on a x86:

  CC [M]  drivers/usb/storage/freecom.o
In file included from include/linux/hdreg.h:4,
                 from drivers/usb/storage/freecom.c:32:
include/linux/ata.h:197: error: parse error before "u32"
...
and so on for tens of lines.

The following patch helps here because ata.h uses these types:

===== include/linux/ata.h 1.19 vs edited =====
--- 1.19/include/linux/ata.h	2004-11-02 21:32:44 +02:00
+++ edited/include/linux/ata.h	2004-11-06 16:47:08 +02:00
@@ -24,6 +24,8 @@
 #ifndef __LINUX_ATA_H__
 #define __LINUX_ATA_H__

+#include <linux/types.h>
+
 /* defines only for the constants which don't work well as enums */
 #define ATA_DMA_BOUNDARY	0xffffUL
 #define ATA_DMA_MASK		0xffffffffULL


-- 
Meelis Roos (mroos@linux.ee)


