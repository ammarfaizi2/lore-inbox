Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269508AbUIROdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269508AbUIROdQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 10:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269518AbUIROdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 10:33:16 -0400
Received: from cantor.suse.de ([195.135.220.2]:4231 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269508AbUIROdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 10:33:08 -0400
Date: Sat, 18 Sep 2004 16:29:16 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH] joydump needs gameport
Message-ID: <20040918142916.GA16203@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


joydump needs gameport:

WARNING: lib/modules/2.6.9-rc2-bk4/kernel/drivers/input/joystick/joydump.ko needs unknown symbol gameport_register_device
WARNING: lib/modules/2.6.9-rc2-bk4/kernel/drivers/input/joystick/joydump.ko needs unknown symbol gameport_unregister_device
WARNING: lib/modules/2.6.9-rc2-bk4/kernel/drivers/input/joystick/joydump.ko needs unknown symbol gameport_open
WARNING: lib/modules/2.6.9-rc2-bk4/kernel/drivers/input/joystick/joydump.ko needs unknown symbol gameport_close


--- ./drivers/input/joystick/Kconfig.orig	2004-09-18 16:14:49.734444000 +0200
+++ ./drivers/input/joystick/Kconfig	2004-09-18 16:26:29.458176128 +0200
@@ -249,7 +249,7 @@ config JOYSTICK_AMIGA
 
 config JOYSTICK_JOYDUMP
 	tristate "Gameport data dumper"
-	depends on INPUT && INPUT_JOYSTICK
+	depends on INPUT && INPUT_JOYSTICK && GAMEPORT
 	help
 	  Say Y here if you want to dump data from your joystick into the system
 	  log for debugging purposes. Say N if you are making a production


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
