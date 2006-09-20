Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751571AbWITOta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbWITOta (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 10:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbWITOta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 10:49:30 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:6051 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751343AbWITOt3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 10:49:29 -0400
From: Christian Borntraeger <borntrae@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] Fix bytes <-> kilobytes  typo in Kconfig for ramdisk
Date: Wed, 20 Sep 2006 16:49:25 +0200
User-Agent: KMail/1.9.3
Cc: trivial@kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609201649.25868.borntrae@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is a small fix for a typo in Kconfig. The default value for the block 
size is 1024 bytes not 1024 kilobytes.

Signed-off-by: Christian Borntraeger <borntrae@de.ibm.com>
----

 Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

----

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index b5382ce..5f5d08d 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -405,7 +405,7 @@ config BLK_DEV_RAM_BLOCKSIZE
 	depends on BLK_DEV_RAM
 	default "1024"
 	help
-	  The default value is 1024 kilobytes.  PAGE_SIZE is a much more
+	  The default value is 1024 bytes.  PAGE_SIZE is a much more
 	  efficient choice however.  The default is kept to ensure initrd
 	  setups function - apparently needed by the rd_load_image routine
 	  that supposes the filesystem in the image uses a 1024 blocksize.


-- 
Mit freundlichen Grüßen / Best Regards

Christian Borntraeger
Linux Software Engineer zSeries Linux & Virtualization
