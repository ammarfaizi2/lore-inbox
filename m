Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261347AbRFCDsI>; Sat, 2 Jun 2001 23:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261786AbRFCDrs>; Sat, 2 Jun 2001 23:47:48 -0400
Received: from mail.mesatop.com ([208.164.122.9]:59143 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S261347AbRFCDrl>;
	Sat, 2 Jun 2001 23:47:41 -0400
Content-Type: text/plain;
  charset="windows-1251"
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.5-ac7 fix for rivers/net/wireless/Config.in problem
Date: Sat, 2 Jun 2001 21:43:04 -0600
X-Mailer: KMail [version 1.2]
Cc: alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Message-Id: <01060221430401.19545@localhost.localdomain>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following error from make xconfig:

drivers/net/wireless/Config.in: 5: can't handle dep_bool/dep_mbool/dep_tristate condition
make[1]: *** [kconfig.tk] Error 1

Here is a little micro patch to change the dep_tristate into a plain vanilla tristate.

Steven

--- linux/drivers/net/wireless/Config.in.ac7    Sat Jun  2 21:27:18 2001
+++ linux/drivers/net/wireless/Config.in        Sat Jun  2 21:32:59 2001
@@ -2,7 +2,7 @@
 # Wireless LAN device configuration
 #
 
-dep_tristate '  Cisco/Aironet 34X/35X/4500/4800 ISA and PCI cards' CONFIG_AIRO
+   tristate '  Cisco/Aironet 34X/35X/4500/4800 ISA and PCI cards' CONFIG_AIRO
 
 if [ "$CONFIG_ALL_PPC" = "y" ]; then
    tristate '  Apple Airport support (built-in)' CONFIG_APPLE_AIRPORT
