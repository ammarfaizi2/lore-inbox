Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbVHYV4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbVHYV4u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 17:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVHYV4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 17:56:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36293 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S964879AbVHYV4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 17:56:49 -0400
Date: Thu, 25 Aug 2005 22:59:48 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, mporter@kernel.crashing.org
Subject: [PATCH] bogus iounmap() in emac
Message-ID: <20050825215948.GW9322@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Dumb typo: iounmap(&local_pointer_variable).

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-m68k-adb.patch/drivers/net/ibm_emac/ibm_emac_core.c RC13-rc7-emac-iounmap/drivers/net/ibm_emac/ibm_emac_core.c
--- RC13-rc7-m68k-adb.patch/drivers/net/ibm_emac/ibm_emac_core.c	2005-08-24 01:58:29.000000000 -0400
+++ RC13-rc7-emac-iounmap/drivers/net/ibm_emac/ibm_emac_core.c	2005-08-25 00:54:21.000000000 -0400
@@ -1253,7 +1253,7 @@
 		 TAH_MR_CVR | TAH_MR_ST_768 | TAH_MR_TFS_10KB | TAH_MR_DTFP |
 		 TAH_MR_DIG);
 
-	iounmap(&tahp);
+	iounmap(tahp);
 
 	return 0;
 }
