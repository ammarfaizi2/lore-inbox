Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVA2RIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVA2RIh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 12:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVA2RIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 12:08:37 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37128 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261437AbVA2RIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 12:08:10 -0500
Date: Sat, 29 Jan 2005 18:08:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mark the mcd cdrom driver as BROKEN
Message-ID: <20050129170803.GA28047@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The mcd driver drives only very old hardware (some single and double 
speed CD drives that were connected either via the soundcard or a 
special ISA card), and the mcdx driver offers more functionality for the 
same hardware.

My plan is to mark MCD as broken in 2.6.11 and if noone complains 
completely remove this driver some time later.


Signed-off-by: Adrian Bunk <bunk@stusta.de>


--- linux-2.6.11-rc2-mm1-full/drivers/cdrom/Kconfig.old	2005-01-29 17:12:26.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/cdrom/Kconfig	2005-01-29 17:12:50.000000000 +0100
@@ -105,7 +105,7 @@
 
 config MCD
 	tristate "Mitsumi (standard) [no XA/Multisession] CDROM support"
-	depends on CD_NO_IDESCSI
+	depends on CD_NO_IDESCSI && BROKEN
 	---help---
 	  This is the older of the two drivers for the older Mitsumi models
 	  LU-005, FX-001 and FX-001D. This is not the right driver for the

