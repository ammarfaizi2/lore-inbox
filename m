Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265124AbUGZKUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265124AbUGZKUX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 06:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265138AbUGZKUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 06:20:23 -0400
Received: from cantor.suse.de ([195.135.220.2]:3008 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265124AbUGZKUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 06:20:19 -0400
Date: Mon, 26 Jul 2004 12:15:02 +0200
From: Olaf Hering <olh@suse.de>
To: perex@suse.cz, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Olaf Hering <olh@suse.de>
Subject: [PATCH] snd-powermac requires i2c
Message-ID: <20040726101502.GC24539@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The alsa driver for powermacs requires i2c support.

Signed-off-by: Olaf Hering <olh@suse.de>

diff -purN linux-2.6.8-rc2-bk2.orig/sound/ppc/Kconfig linux-2.6.8-rc2-bk2.powerbook/sound/ppc/Kconfig
--- linux-2.6.8-rc2-bk2.orig/sound/ppc/Kconfig	2004-06-16 05:19:22.000000000 +0000
+++ linux-2.6.8-rc2-bk2.powerbook/sound/ppc/Kconfig	2004-07-25 08:46:26.000000000 +0000
@@ -3,9 +3,12 @@
 menu "ALSA PowerMac devices"
 	depends on SND!=n && PPC
 
+comment "ALSA PowerMac requires I2C"
+	depends on SND && I2C=n
+
 config SND_POWERMAC
 	tristate "PowerMac (AWACS, DACA, Burgundy, Tumbler, Keywest)"
-	depends on SND
+	depends on SND && I2C
 	select SND_PCM
 
 endmenu

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
