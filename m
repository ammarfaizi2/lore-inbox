Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129778AbQLUHx6>; Thu, 21 Dec 2000 02:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129912AbQLUHxs>; Thu, 21 Dec 2000 02:53:48 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:54020 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S129778AbQLUHxd>; Thu, 21 Dec 2000 02:53:33 -0500
Message-ID: <3A41AFD6.D1DDA78F@Hell.WH8.TU-Dresden.De>
Date: Thu, 21 Dec 2000 08:23:02 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13-pre3 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Make drivers/media compile as modules
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

The Makefile changes broke compiling drivers/media, such as bttv,
as kernel modules. Below is the patch against test13-pre3 to fix it.

Please apply.

-Udo.

--- /sources/linux/drivers/media/Makefile       Thu Dec 21 08:17:17 2000
+++ /usr/src/linux/drivers/media/Makefile       Thu Dec 21 08:15:55 2000
@@ -10,8 +10,10 @@
 #
 
 subdir-y     := video radio
+subdir-m     := video radio
 
 O_TARGET     := media.o
 obj-y        := $(join $(subdir-y),$(subdir-y:%=/%.o))
+obj-m        := $(join $(subdir-m),$(subdir-m:%=/%.o))
 
 include $(TOPDIR)/Rules.make
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
