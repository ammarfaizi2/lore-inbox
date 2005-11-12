Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbVKLEp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbVKLEp7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 23:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbVKLEp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 23:45:59 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:53464 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751318AbVKLEp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 23:45:58 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: mike.miller@hp.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] Silence warning in cciss_scsi
Date: Sat, 12 Nov 2005 15:45:45 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <rosan15j71pmfict4ue7hgtdh85cqc5bl2@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

From: Grant Coady <gcoady@gmail.com>

Silence warning due to all callers being commented out:
drivers/block/cciss_scsi.c:264: warning: `print_bytes' defined but not used
drivers/block/cciss_scsi.c:298: warning: `print_cmd' defined but not used

compile tested with allmodconfig

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 cciss_scsi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15-rc1a/drivers/block/cciss_scsi.c~	2005-11-12 13:51:12.000000000 +1100
+++ linux-2.6.15-rc1a/drivers/block/cciss_scsi.c	2005-11-12 15:36:01.000000000 +1100
@@ -255,7 +255,7 @@
 #define DEVICETYPE(n) (n<0 || n>MAX_SCSI_DEVICE_CODE) ? \
 	"Unknown" : scsi_device_types[n]
 
-#if 1
+#if 0
 static int xmargin=8;
 static int amargin=60;
 
-- 
Thanks,
Grant.
