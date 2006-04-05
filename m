Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWDEQcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWDEQcF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 12:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWDEQcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 12:32:05 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10506 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751256AbWDEQcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 12:32:04 -0400
Date: Wed, 5 Apr 2006 18:32:03 +0200
From: Adrian Bunk <bunk@stusta.de>
To: hjlipp@web.de, tilman@imap.cc
Cc: gigaset307x-common@lists.sourceforge.net, kkeil@suse.de,
       isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] ISDN_DRV_GIGASET should select, not depend on CRC_CCITT
Message-ID: <20060405163202.GF8673@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CRC_CCITT is an internal helper function that should be select'ed.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc1-mm1-full/drivers/isdn/gigaset/Kconfig.old	2006-04-05 17:42:54.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/drivers/isdn/gigaset/Kconfig	2006-04-05 17:43:07.000000000 +0200
@@ -3,7 +3,8 @@
 
 config ISDN_DRV_GIGASET
 	tristate "Siemens Gigaset support (isdn)"
-	depends on ISDN_I4L && CRC_CCITT
+	depends on ISDN_I4L
+	select CRC_CCITT
 	help
 	  Say m here if you have a Gigaset or Sinus isdn device.
 

