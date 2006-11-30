Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759173AbWK3ItF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759173AbWK3ItF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 03:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759175AbWK3ItF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 03:49:05 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:32015 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1759172AbWK3ItC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 03:49:02 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: 53c7xx brackets fix
Date: Thu, 30 Nov 2006 09:48:32 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611300948.32470.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch fixes brackets in two places.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/scsi/53c7xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.19-rc6-mm2-a/drivers/scsi/53c7xx.c	2006-11-16 05:03:40.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/drivers/scsi/53c7xx.c	2006-11-29 15:50:54.000000000 +0100
@@ -4400,7 +4400,7 @@ abort_connected (struct Scsi_Host *host)
  * account the current synchronous offset) 
  */
 
-    sstat = (NCR53c8x0_read8 (SSTAT2_REG);
+    sstat = NCR53c8x0_read8 (SSTAT2_REG);
     offset = OFFSET (sstat & SSTAT2_FF_MASK) >> SSTAT2_FF_SHIFT;
     phase = sstat & SSTAT2_PHASE_MASK;
 
@@ -5423,7 +5423,7 @@ insn_to_offset (Scsi_Cmnd *cmd, u32 *ins
     	    	     --buffers, offset += segment->length, ++segment)
 #if 0
 		    printk("scsi%d: comparing 0x%p to 0x%p\n", 
-			cmd->device->host->host_no, saved, page_address(segment->page+segment->offset);
+			cmd->device->host->host_no, saved, page_address(segment->page+segment->offset));
 #else
 		    ;
 #endif


-- 
Regards,

	Mariusz Kozlowski
