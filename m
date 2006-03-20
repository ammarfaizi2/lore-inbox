Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751548AbWCTEmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbWCTEmx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 23:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWCTEk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 23:40:59 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:57615 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1751519AbWCTEkv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 23:40:51 -0500
Date: Mon, 20 Mar 2006 04:40:36 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
       linux-mtd@lists.infradead.org
Subject: [PATCH 9/12] [MTD] Fix #else directive in the docprobe driver
Message-ID: <20060320044036.GI20416@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320043802.GA20389@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following difference was found between the mainline and linux-mips
kernel.  Fix the #else directive in the docprobe driver, and change
some space to tabs for consistency.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- linux-2.6/drivers/mtd/devices/docprobe.c	2006-03-05 19:35:04.000000000 +0000
+++ mips.git/drivers/mtd/devices/docprobe.c	2006-03-05 18:51:15.000000000 +0000
@@ -84,10 +84,10 @@
 	0xe4000000,
 #elif defined(CONFIG_MOMENCO_OCELOT)
 	0x2f000000,
-        0xff000000,
+	0xff000000,
 #elif defined(CONFIG_MOMENCO_OCELOT_G) || defined (CONFIG_MOMENCO_OCELOT_C)
-        0xff000000,
-##else
+	0xff000000,
+#else
 #warning Unknown architecture for DiskOnChip. No default probe locations defined
 #endif
 	0xffffffff };

-- 
Martin Michlmayr
http://www.cyrius.com/
