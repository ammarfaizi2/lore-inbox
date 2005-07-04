Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVGDMgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVGDMgu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 08:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVGDMgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 08:36:49 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:6298 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S261659AbVGDMfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 08:35:46 -0400
Date: Mon, 4 Jul 2005 14:35:35 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH][Update] Kconfig changes 1b: s/menu/menuconfig/
In-Reply-To: <Pine.LNX.4.58.0506301152460.11960@be1.lrz>
Message-ID: <Pine.LNX.4.58.0507041427460.11818@be1.lrz>
References: <Pine.LNX.4.58.0506301152460.11960@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 1b: The easy stuff.

In many config submenus, the first menu option will enable the rest 
of the menu options. For these menus, It's appropriate to use the more 
convenient "menuconfig" keyword.

These are some missing changes from the first patch(es).
I don't know where they went missing.

This patch applies to .12 and .13-rc1.


--- x/fs/partitions/Kconfig	2005-07-04 13:50:38.000000000 +0200
+++ b/fs/partitions/Kconfig	2005-06-30 09:39:18.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Partition configuration
 #
-config PARTITION_ADVANCED
+menuconfig PARTITION_ADVANCED
 	bool "Advanced partition selection"
 	help
 	  Say Y here if you would like to use hard disks under Linux which
--- x/sound/oss/Kconfig	2005-07-04 13:50:55.000000000 +0200
+++ b/sound/oss/Kconfig	2005-06-29 16:49:05.000000000 +0200
@@ -1084,7 +1084,7 @@ config SOUND_TVMIXER
 
 config SOUND_KAHLUA
 	tristate "XpressAudio Sound Blaster emulation"
-	depends on SOUND_SB
+	depends on SOUND_SB && SOUND_PRIME
 
 config SOUND_ALI5455
 	tristate "ALi5455 audio support"
--- x/sound/oss/dmasound/Kconfig	2005-07-04 13:47:08.000000000 +0200
+++ b/sound/oss/dmasound/Kconfig	2005-06-29 16:45:48.000000000 +0200
@@ -56,3 +56,4 @@ config DMASOUND_Q40
 
 config DMASOUND
 	tristate
+	depends on SOUND
-- 
Top 100 things you don't want the sysadmin to say:
64. Do you really need your home directory to do any work?
