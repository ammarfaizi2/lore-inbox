Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTEVWNZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 18:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTEVWNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 18:13:25 -0400
Received: from hera.cwi.nl ([192.16.191.8]:44498 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263364AbTEVWNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 18:13:23 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 23 May 2003 00:26:25 +0200 (MEST)
Message-Id: <UTC200305222226.h4MMQP519152.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       torvalds@transmeta.com
Subject: [patch] isa_writeb args interchanged
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/scsi/g_NCR5380.h b/drivers/scsi/g_NCR5380.h
--- a/drivers/scsi/g_NCR5380.h	Thu May 22 13:17:01 2003
+++ b/drivers/scsi/g_NCR5380.h	Fri May 23 01:23:21 2003
@@ -102,7 +102,7 @@
 #define NCR5380_region_size 0x3a00
 
 #define NCR5380_read(reg) isa_readb(NCR5380_map_name + NCR53C400_mem_base + (reg))
-#define NCR5380_write(reg, value) isa_writeb(NCR5380_map_name + NCR53C400_mem_base + (reg), value)
+#define NCR5380_write(reg, value) isa_writeb(value, NCR5380_map_name + NCR53C400_mem_base + (reg))
 #endif
 
 #define NCR5380_implementation_fields \
