Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbVHWVqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbVHWVqo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbVHWVpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:45:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22966 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932448AbVHWVpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:45:09 -0400
To: torvalds@osdl.org
Subject: [PATCH] (41/43) ad1980 makefile fix
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1E7gcu-0007Ff-Ih@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:48:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ac97_plugin_ad1980 should trigger build of ac97_codec

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-scsi-modular/sound/oss/Makefile RC13-rc6-git13-ad1980/sound/oss/Makefile
--- RC13-rc6-git13-scsi-modular/sound/oss/Makefile	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git13-ad1980/sound/oss/Makefile	2005-08-21 13:17:42.000000000 -0400
@@ -80,7 +80,7 @@
 obj-$(CONFIG_SOUND_IT8172)	+= ite8172.o ac97_codec.o
 obj-$(CONFIG_SOUND_FORTE)	+= forte.o ac97_codec.o
 
-obj-$(CONFIG_SOUND_AD1980)	+= ac97_plugin_ad1980.o
+obj-$(CONFIG_SOUND_AD1980)	+= ac97_plugin_ad1980.o ac97_codec.o
 obj-$(CONFIG_SOUND_WM97XX)	+= ac97_plugin_wm97xx.o
 
 ifeq ($(CONFIG_MIDI_EMU10K1),y)
