Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314584AbSGAP1N>; Mon, 1 Jul 2002 11:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315611AbSGAP1M>; Mon, 1 Jul 2002 11:27:12 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:16810
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S314584AbSGAP1L>; Mon, 1 Jul 2002 11:27:11 -0400
Date: Mon, 1 Jul 2002 08:29:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-mips@oss.sgi.com,
       linux-alpha@vger.kernel.org
Subject: [PATCH 2.4.19-rc1] Make sure drivers/input/Config.in goes before drivers/char/Config.in
Message-ID: <20020701152910.GD20920@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes drivers/input/Config.in always comes before drivers/char/Config.in.

Currently, alpha, mips and mips64 source drivers/input/Config.in after
drivers/char/Config.in.  But as noted in most of the other arches
config.in, drivers/input/Config.in must come before
drivers/char/Config.in for all depenancies to be worked out.  This adds
that comments to these arches as well as fixing the dependancy.

On the off chance that this is intentional, linux-mips and linux-alpha
are CC'ed as well.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== arch/alpha/config.in 1.15 vs edited =====
--- 1.15/arch/alpha/config.in	Sat May 25 19:37:06 2002
+++ edited/arch/alpha/config.in	Mon Jul  1 07:16:45 2002
@@ -362,6 +362,10 @@
 fi
 endmenu
 
+#
+# input before char - char/joystick depends on it. As does USB.
+#
+source drivers/input/Config.in
 source drivers/char/Config.in
 
 #source drivers/misc/Config.in
@@ -397,7 +401,6 @@
 endmenu
 
 source drivers/usb/Config.in
-source drivers/input/Config.in
 
 source net/bluetooth/Config.in
 
===== arch/mips/config.in 1.6 vs edited =====
--- 1.6/arch/mips/config.in	Thu Feb 28 06:57:19 2002
+++ edited/arch/mips/config.in	Mon Jul  1 07:17:22 2002
@@ -563,6 +563,10 @@
 fi
 endmenu
 
+#
+# input before char - char/joystick depends on it. As does USB.
+#
+source drivers/input/Config.in
 source drivers/char/Config.in
 
 source drivers/media/Config.in
@@ -628,7 +632,6 @@
 fi
 
 source drivers/usb/Config.in
-source drivers/input/Config.in
 
 mainmenu_option next_comment
 comment 'Kernel hacking'
===== arch/mips64/config.in 1.6 vs edited =====
--- 1.6/arch/mips64/config.in	Thu Feb 28 06:57:19 2002
+++ edited/arch/mips64/config.in	Mon Jul  1 07:17:38 2002
@@ -284,6 +284,10 @@
 fi
 endmenu
 
+#
+# input before char - char/joystick depends on it. As does USB.
+#
+source drivers/input/Config.in
 source drivers/char/Config.in
 
 #source drivers/misc/Config.in
@@ -325,7 +329,6 @@
 fi
 
 source drivers/usb/Config.in
-source drivers/input/Config.in
 
 mainmenu_option next_comment
 comment 'Kernel hacking'
