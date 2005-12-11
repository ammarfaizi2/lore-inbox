Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbVLKNPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbVLKNPe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 08:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbVLKNPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 08:15:34 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:4449 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751359AbVLKNPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 08:15:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lkwxSMl0S0AdwBlUWgwRiu6KOoxVyYLEszx9EMMIAUBy7XiphQf2CWbtbkhk+4ePu3LbnsgvovEtblKjmsVTr5tlQAIgtXNVVKuYhnVvSkHSCOQt6F/7bn1atnefplOuxhGqIL9VlwHkWRgBnHu2AR/7XGh0w6h0v27H+3Y1Id8=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [-mm PATCH] EDAC: make Kconfig defaults match recommendations in help text
Date: Sun, 11 Dec 2005 14:16:05 +0100
User-Agent: KMail/1.9
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512111416.05501.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"config EDAC" and "config EDAC_MM_EDAC" both state clearly that if the user
is unsure she should select "Y", yet the default for those options is "N".

This patch brings the default for the options into line with the
recommendation stated in the help text.

Please consider for inclusion.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/edac/Kconfig |    2 ++
 1 files changed, 2 insertions(+)

diff -U 7 linux-2.6.15-rc5-mm2-orig/drivers/edac/Kconfig linux-2.6.15-rc5-mm2/drivers/edac/Kconfig
--- linux-2.6.15-rc5-mm2-orig/drivers/edac/Kconfig	2005-12-11 13:53:26.000000000 +0100
+++ linux-2.6.15-rc5-mm2/drivers/edac/Kconfig	2005-12-11 14:04:06.000000000 +0100
@@ -7,14 +7,15 @@
 #
 
 menu 'EDAC - error detection and reporting (RAS)'
 
 config EDAC
 	tristate "EDAC core system error reporting"
 	depends on X86
+	default y
 	help
 	  EDAC is designed to report errors in the core system.
 	  These are low-level errors that are reported in the CPU or
 	  supporting chipset: memory errors, cache errors, PCI errors,
 	  thermal throttling, etc..  If unsure, select 'Y'.
 
 
@@ -29,14 +30,15 @@
 	  sub-system. You can insert module with "debug_level=x", current
 	  there're four debug levels (x=0,1,2,3 from low to high).
 	  Usually you should select 'N'.
 
 config EDAC_MM_EDAC
 	tristate "Main Memory EDAC (Error Detection And Correction) reporting"
 	depends on EDAC
+	default y
 	help
 	  Some systems are able to detect and correct errors in main
 	  memory.  EDAC can report statistics on memory error
 	  detection and correction (EDAC - or commonly referred to ECC
 	  errors).  EDAC will also try to decode where these errors
 	  occurred so that a particular failing memory module can be
 	  replaced.  If unsure, select 'Y'.



