Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270495AbVBEVQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270495AbVBEVQz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 16:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269873AbVBEVQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 16:16:55 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:30419 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S270495AbVBEVQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 16:16:34 -0500
Subject: [PATCH] Add missing configure calls to intel agp resume code.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: yust@anti-leasure.ru,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Content-Type: text/plain
Message-Id: <1107638334.6348.27.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sun, 06 Feb 2005 08:18:54 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Signed-off by: Nigel Cunningham <ncunningham@linuxmail.org>

-----Forwarded Message-----
From: Alex Yustasov <yust@anti-leasure.ru>
To: softwaresuspend-help@lists.berlios.de

Fix for resume on i850. Maybe for i855GM.

--- 2.6.10/drivers/char/agp/intel-agp.c.orig	2004-12-25 00:34:45 +0300
+++ 2.6.10/drivers/char/agp/intel-agp.c	2005-01-10 15:18:43 +0300
@@ -1727,12 +1727,16 @@
 
 	if (bridge->driver == &intel_generic_driver)
 		intel_configure();
+	else if (bridge->driver == &intel_850_driver)
+		intel_850_configure();
 	else if (bridge->driver == &intel_845_driver)
 		intel_845_configure();
 	else if (bridge->driver == &intel_830mp_driver)
 		intel_830mp_configure();
 	else if (bridge->driver == &intel_915_driver)
 		intel_i915_configure();
+	else if (bridge->driver == &intel_830_driver)
+		intel_i830_configure();
 
 	return 0;
 }
_______________________________________________
SoftwareSuspend-help mailing list
SoftwareSuspend-help@lists.berlios.de
http://lists.berlios.de/mailman/listinfo/softwaresuspend-help
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

