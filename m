Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267322AbSLKWV6>; Wed, 11 Dec 2002 17:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267323AbSLKWV6>; Wed, 11 Dec 2002 17:21:58 -0500
Received: from air-2.osdl.org ([65.172.181.6]:4224 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S267322AbSLKWV5>;
	Wed, 11 Dec 2002 17:21:57 -0500
Date: Wed, 11 Dec 2002 14:29:44 -0800
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.5.51] Remove compile warning from  drivers/ide/pci/generic.h
Message-ID: <20021211222943.GB1067@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added and #if/#endif pair to "remove" the un-used unknown_chipset declaration.

Comments in generic.c indicate that unknow_chipset this will be used again
in the future.

diff -Nru a/drivers/ide/pci/generic.h b/drivers/ide/pci/generic.h
--- a/drivers/ide/pci/generic.h	Wed Dec 11 13:41:51 2002
+++ b/drivers/ide/pci/generic.h	Wed Dec 11 13:41:51 2002
@@ -135,6 +135,7 @@
 	}
 };
 
+#if 0
 static ide_pci_device_t unknown_chipset[] __devinitdata = {
 	{	/* 0 */
 		.vendor		= 0,
@@ -157,5 +158,6 @@
 	}
 
 };
+#endif
 
 #endif /* IDE_GENERIC_H */

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
