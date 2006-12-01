Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936422AbWLAPQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936422AbWLAPQr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936452AbWLAPQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:16:47 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:61702 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S936422AbWLAPQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:16:46 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] video sis parenthesis fix
Date: Fri, 1 Dec 2006 16:16:21 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011616.22134.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch removes an extra parenthesis in SetOEMLCDData() code.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/video/sis/init301.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.4.34-pre6-a/drivers/video/sis/init301.c	2004-08-08 01:26:05.000000000 +0200
+++ linux-2.4.34-pre6-b/drivers/video/sis/init301.c	2006-12-01 12:29:13.000000000 +0100
@@ -11679,7 +11679,7 @@ SetOEMLCDData(SiS_Private *SiS_Pr, PSIS_
   UCHAR  *ROMAddr = HwInfo->pjVirtualRomBase;
   USHORT index,temp;
 
-  if((SiS_Pr->SiS_UseROM) {
+  if (SiS_Pr->SiS_UseROM) {
      if(!(ROMAddr[0x237] & 0x01)) return;
      if(!(ROMAddr[0x237] & 0x04)) return;
      /* No rom pointer in BIOS header! */


-- 
Regards,

	Mariusz Kozlowski
