Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317954AbSGWEgV>; Tue, 23 Jul 2002 00:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317955AbSGWEgU>; Tue, 23 Jul 2002 00:36:20 -0400
Received: from zok.SGI.COM ([204.94.215.101]:61158 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S317954AbSGWEfZ>;
	Tue, 23 Jul 2002 00:35:25 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: [patch] 2.4.19-rc3 remove dead variable CONFIG_DRM_AGP.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Jul 2002 14:38:19 +1000
Message-ID: <8887.1027399099@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_AGP is defined as depending on CONFIG_DRM_AGP but that variable
is neither defined nor used.  This spurious dependency silently works
for make old/menuconfig, it breaks make xconfig.

Index: 18.102/drivers/char/Config.in
--- 18.102/drivers/char/Config.in Mon, 22 Jul 2002 11:29:07 +1000 kaos (linux-2.4/b/c/3_Config.in 1.2.1.1.4.12.1.2 644)
+++ 18.102(w)/drivers/char/Config.in Tue, 23 Jul 2002 12:31:28 +1000 kaos (linux-2.4/b/c/3_Config.in 1.2.1.1.4.12.1.2 644)
@@ -211,7 +211,7 @@ if [ "$CONFIG_FTAPE" != "n" ]; then
 fi
 endmenu
 
-dep_tristate '/dev/agpgart (AGP Support)' CONFIG_AGP $CONFIG_DRM_AGP
+tristate '/dev/agpgart (AGP Support)' CONFIG_AGP
 if [ "$CONFIG_AGP" != "n" ]; then
    bool '  Intel 440LX/BX/GX and I815/I830M/I840/I850 support' CONFIG_AGP_INTEL
    if [ "$CONFIG_IA64" != "n" ]; then

