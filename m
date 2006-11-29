Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758956AbWK2XOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758956AbWK2XOu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758960AbWK2XOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:14:50 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:23821 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1758956AbWK2XOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:14:49 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: gibbs@btc.adaptec.com
Subject: [PATCH] scsi: sic7xxx stray bracket fix
Date: Thu, 30 Nov 2006 00:14:18 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611300014.18439.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	Unused macro. Better to have it fixed though.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/scsi/aic7xxx/aic79xx_pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-rc6-mm2-a/drivers/scsi/aic7xxx/aic79xx_pci.c	2006-11-16 05:03:40.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/drivers/scsi/aic7xxx/aic79xx_pci.c	2006-11-29 15:20:01.000000000 +0100
@@ -88,7 +88,7 @@ ahd_compose_id(u_int device, u_int vendo
 
 #define SUBID_9005_LEGACYCONN_FUNC(id) ((id) & 0x20)
 
-#define SUBID_9005_SEEPTYPE(id) ((id) & 0x0C0) >> 6)
+#define SUBID_9005_SEEPTYPE(id) (((id) & 0x0C0) >> 6)
 #define		SUBID_9005_SEEPTYPE_NONE	0x0
 #define		SUBID_9005_SEEPTYPE_4K		0x1
 


-- 
Regards,

	Mariusz Kozlowski
