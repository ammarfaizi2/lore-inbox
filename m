Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWDDSy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWDDSy5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 14:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWDDSy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 14:54:57 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33039 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750802AbWDDSy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 14:54:56 -0400
Date: Tue, 4 Apr 2006 20:54:54 +0200
From: Adrian Bunk <bunk@stusta.de>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] video/aty/atyfb_base.c: fix an off-by-one error
Message-ID: <20060404185454.GW6529@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an obvious of-by-one error spotted by the Coverity 
checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc1-mm1-full/drivers/video/aty/atyfb_base.c.old	2006-04-04 20:20:18.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/drivers/video/aty/atyfb_base.c	2006-04-04 20:20:33.000000000 +0200
@@ -3400,7 +3400,7 @@ static int __devinit atyfb_pci_probe(str
 	struct atyfb_par *par;
 	int i, rc = -ENOMEM;
 
-	for (i = ARRAY_SIZE(aty_chips); i >= 0; i--)
+	for (i = ARRAY_SIZE(aty_chips) - 1; i >= 0; i--)
 		if (pdev->device == aty_chips[i].pci_id)
 			break;
 

