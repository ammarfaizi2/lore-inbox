Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936461AbWLAOrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936461AbWLAOrk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936508AbWLAOrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:47:40 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:58117 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S936461AbWLAOrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:47:39 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] scsi 53c7xx parenthesis fix
Date: Fri, 1 Dec 2006 15:47:14 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011547.14255.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	Tis patch removes an extra parenthesis in abort_connected() code.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/scsi/53c7xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.4.34-pre6-a/drivers/scsi/53c7xx.c	2004-02-18 14:36:31.000000000 +0100
+++ linux-2.4.34-pre6-b/drivers/scsi/53c7xx.c	2006-12-01 12:22:28.000000000 +0100
@@ -4409,7 +4409,7 @@ abort_connected (struct Scsi_Host *host)
  * account the current synchronous offset) 
  */
 
-    sstat = (NCR53c8x0_read8 (SSTAT2_REG);
+    sstat = NCR53c8x0_read8 (SSTAT2_REG);
     offset = OFFSET (sstat & SSTAT2_FF_MASK) >> SSTAT2_FF_SHIFT;
     phase = sstat & SSTAT2_PHASE_MASK;
 


-- 
Regards,

	Mariusz Kozlowski
