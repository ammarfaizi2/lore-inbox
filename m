Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266726AbSKHCOF>; Thu, 7 Nov 2002 21:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266727AbSKHCOF>; Thu, 7 Nov 2002 21:14:05 -0500
Received: from 216-99-218-29.dsl.aracnet.com ([216.99.218.29]:51944 "EHLO
	dexter.groveronline.com") by vger.kernel.org with ESMTP
	id <S266726AbSKHCOE>; Thu, 7 Nov 2002 21:14:04 -0500
Date: Thu, 7 Nov 2002 18:20:39 -0800 (PST)
From: Andy Grover <agrover@groveronline.com>
To: marcelo@conectiva.com.br
cc: linux-kernel@vger.kernel.org, <acpi-devel@sourceforge.net>
Subject: [PATCH] Make ACPI unselectable in 2.4.20-rc1
Message-ID: <Pine.LNX.4.44.0211071811450.3860-100000@dexter.groveronline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

My plan is to start feeding you bits of ACPI changes after 2.4.20 is 
released. However, for 2.4.20, I'd like to make sure the really old code 
in 2.4.20 doesn't bite any casual kernel builders.

Please apply,

Thanks -- Andy

===== arch/i386/config.in 1.35 vs edited =====
--- 1.35/arch/i386/config.in	Mon Aug 19 06:23:29 2002
+++ edited/arch/i386/config.in	Thu Nov  7 18:08:09 2002
@@ -298,11 +298,12 @@
 bool 'Power Management support' CONFIG_PM
 
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-   dep_bool '  ACPI support' CONFIG_ACPI $CONFIG_PM
-   
-   if [ "$CONFIG_ACPI" != "n" ]; then
-      source drivers/acpi/Config.in
-   fi
+    comment '  ACPI support disabled temporarily'
+#   dep_bool '  ACPI support' CONFIG_ACPI $CONFIG_PM
+#   
+#   if [ "$CONFIG_ACPI" != "n" ]; then
+#      source drivers/acpi/Config.in
+#   fi
 fi
 
 dep_tristate '  Advanced Power Management BIOS support' CONFIG_APM $CONFIG_PM

