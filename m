Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751527AbWCTElR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbWCTElR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 23:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWCTElF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 23:41:05 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:59151 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1751497AbWCTElC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 23:41:02 -0500
Date: Mon, 20 Mar 2006 04:40:46 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
       linux-mtd@lists.infradead.org
Subject: [PATCH 10/12] [MTD] LASAT depends on MTD_CFI
Message-ID: <20060320044046.GJ20416@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320043802.GA20389@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following difference was found between the mainline and linux-mips
kernel.  LASAT depends on MTD_CFI.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- linux-2.6/drivers/mtd/maps/Kconfig	2006-03-05 19:35:04.000000000 +0000
+++ mips.git/drivers/mtd/maps/Kconfig	2006-03-05 18:51:15.000000000 +0000
@@ -200,8 +200,8 @@
 	  Support for the flash chip on Tsunami TIG bus.
 
 config MTD_LASAT
-	tristate "Flash chips on LASAT board"
-	depends on LASAT
+	tristate "LASAT flash device"
+	depends on LASAT && MTD_CFI
 	help
 	  Support for the flash chips on the Lasat 100 and 200 boards.
 

-- 
Martin Michlmayr
http://www.cyrius.com/
