Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263624AbUJ3HXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbUJ3HXc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 03:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUJ3HXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 03:23:32 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54277 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263624AbUJ3HX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 03:23:27 -0400
Date: Sat, 30 Oct 2004 09:22:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: mac@melware.de
Cc: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: RFC: [2.6 patch] Eicon: disable debuglib for modules
Message-ID: <20041030072256.GH4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a good reason why debuglib is enabled for modules?

If not, I'd propose the patch below to disable it.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/drivers/isdn/hardware/eicon/platform.h.old	2004-10-30 08:39:51.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/drivers/isdn/hardware/eicon/platform.h	2004-10-30 08:40:28.000000000 +0200
@@ -35,10 +35,8 @@
 
 #include "cardtype.h"
 
-/* activate debuglib for modules only */
-#ifndef MODULE
+/* disable debuglib */
 #define DIVA_NO_DEBUGLIB
-#endif
 
 #define DIVA_INIT_FUNCTION  __init
 #define DIVA_EXIT_FUNCTION  __exit

