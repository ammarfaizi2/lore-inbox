Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbVHTEHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbVHTEHb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 00:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbVHTEHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 00:07:31 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11013 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030204AbVHTEHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 00:07:30 -0400
Date: Sat, 20 Aug 2005 06:07:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: pavel@suse.cz
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] simplify SOFTWARE_SUSPEND dependencies
Message-ID: <20050820040723.GN3615@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch expresses the same dependencies in a more simple way.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc6-mm1-full/kernel/power/Kconfig.old	2005-08-20 06:02:49.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/kernel/power/Kconfig	2005-08-20 06:03:13.000000000 +0200
@@ -28,7 +28,7 @@
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend"
-	depends on EXPERIMENTAL && PM && SWAP && ((X86 && SMP) || ((FVR || PPC32 || X86) && !SMP))
+	depends on EXPERIMENTAL && PM && SWAP && (X86 || ((FVR || PPC32) && !SMP))
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need APM.

