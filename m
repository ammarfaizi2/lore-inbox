Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262707AbREaQYf>; Thu, 31 May 2001 12:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263021AbREaQY0>; Thu, 31 May 2001 12:24:26 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:16646 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S262707AbREaQYL>; Thu, 31 May 2001 12:24:11 -0400
Date: Thu, 31 May 2001 12:24:44 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@vesta.nine.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] for Matrox FB config help
Message-ID: <Pine.LNX.4.33.0105311219030.20239-100000@vesta.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This patch moves the sentence about multihead support where it belongs,
i.e. to CONFIG_FB_MATROX_MULTIHEAD, and removes it where it's meaningless,
i.e. from CONFIG_FB_MATROX_MAVEN and CONFIG_FB_MATROX_G450.

The patch is against 2.4.5-ac5.

____________________________
--- linux.orig/Documentation/Configure.help
+++ linux/Documentation/Configure.help
@@ -3503,9 +3503,6 @@
   too. You can use only some font widths, as the driver uses generic
   painting procedures (the secondary head does not use acceleration
   engine).
-
-  There is no need for enabling 'Matrox multihead support' if you have
-  only one Matrox card in the box.

 Matrox G450 second head support
 CONFIG_FB_MATROX_G450
@@ -3528,9 +3525,6 @@
   painting procedures (the secondary head does not use acceleration
   engine).

-  There is no need for enabling 'Matrox multihead support' if you have
-  only one Matrox card in the box.
-
 Matrox unified driver multihead support
 CONFIG_FB_MATROX_MULTIHEAD
   Say Y here if you have more than one (supported) Matrox device in
@@ -3545,6 +3539,9 @@
   with insmod, supplying the parameter "dev=N" where N is 0, 1, etc.
   for the different Matrox devices. This method is slightly faster but
   uses 40 KB of kernel memory per Matrox card.
+
+  There is no need for enabling 'Matrox multihead support' if you have
+  only one Matrox card in the box.

 MDA text console (dual-headed)
 CONFIG_MDA_CONSOLE
____________________________

-- 
Regards,
Pavel Roskin

