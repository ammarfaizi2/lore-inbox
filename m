Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758883AbWK2Wfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758883AbWK2Wfk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758878AbWK2Wfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:35:40 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:57870 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1758883AbWK2Wfj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:35:39 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: linux-kernel@vger.kernel.org
Subject: net: sk98lin bracket question
Date: Wed, 29 Nov 2006 23:35:07 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200611292335.08563.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	Somewhere below is either one extra or one missing bracket. Any idea how to fix that?

Is the patch below correct?

--- linux-2.6.19-rc6-mm2-a/drivers/net/sk98lin/skgesirq.c	2006-11-16 05:03:40.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/drivers/net/sk98lin/skgesirq.c	2006-11-29 23:32:02.000000000 +0100
@@ -1319,7 +1319,7 @@ SK_BOOL	AutoNeg)	/* Is Auto-negotiation 
 	SkXmPhyRead(pAC, IoC, Port, PHY_BCOM_INT_STAT, &Isrc);
 
 #ifdef xDEBUG
-	if ((Isrc & ~(PHY_B_IS_HCT | PHY_B_IS_LCT) ==
+	if ((Isrc & ~(PHY_B_IS_HCT | PHY_B_IS_LCT)) ==
 		(PHY_B_IS_SCR_S_ER | PHY_B_IS_RRS_CHANGE | PHY_B_IS_LRS_CHANGE)) {
 
 		SK_U32	Stat1, Stat2, Stat3;


PS. Who is the maintainer of this driver?

-- 
Regards,

	Mariusz Kozlowski
