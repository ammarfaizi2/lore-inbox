Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265132AbTFEUzU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbTFEUyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:54:14 -0400
Received: from smtp2.libero.it ([193.70.192.52]:20979 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S265132AbTFEUxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:53:17 -0400
Date: Fri, 1 Jan 1904 02:51:54 +0100
From: Daniele Pala <dandario@libero.it>
To: linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org
Subject: [2.5.70][PPC] Small change to config
Message-ID: <19040101015154.GA346@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since "control" and "platinum" display support doesn't compile if /dev/nvram suppor is selected as a module, here's this
small patch. The problem is that the suppor for /dev/nvram is asked after the "control" and "platinum" support...
Cheers,
	Daniele


--- a/drivers/video/Kconfig	Fri Jan  1 02:39:17 1904
+++ b/drivers/video/Kconfig	Fri Jan  1 02:42:54 1904
@@ -242,14 +242,14 @@
 
 config FB_CONTROL
 	bool "Apple \"control\" display support"
-	depends on FB && PPC && ALL_PPC
+	depends on FB && PPC && ALL_PPC && NVRAM=y
 	help
 	  This driver supports a frame buffer for the graphics adapter in the
 	  Power Macintosh 7300 and others.
 
 config FB_PLATINUM
 	bool "Apple \"platinum\" display support"
-	depends on FB && PPC && ALL_PPC
+	depends on FB && PPC && ALL_PPC && NVRAM=y
 	help
 	  This driver supports a frame buffer for the "platinum" graphics
 	  adapter in some Power Macintoshes.
