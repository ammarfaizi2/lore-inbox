Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVARWlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVARWlF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 17:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVARWlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 17:41:05 -0500
Received: from dsl-203-33-161-112.NSW.netspace.net.au ([203.33.161.112]:57007
	"EHLO localhost") by vger.kernel.org with ESMTP id S261454AbVARWlA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 17:41:00 -0500
Subject: [PATCH] enable-aver771-ir-remote
From: Kared <kared@kared.net>
Reply-To: kared@kared.net
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106088061.5123.34.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 19 Jan 2005 09:41:01 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The case statment which describes which mask and set of codes to use for
the Avermedia 771 digital tuner card ir-remote control are commented
out. Perhaps it was assumed this would be the same as the 761 but was
commented out as it was untested? Removing the comment makes my remote
work perfectly. Not sure who maintains this file, Patch below.



enable-aver771-remote.patch:


diff -ur linux-2.6.11-rc1.orig/drivers/media/video/ir-kbd-gpio.c
linux-2.6.11-rc1/drivers/media/video/ir-kbd-gpio.c
--- linux-2.6.11-rc1.orig/drivers/media/video/ir-kbd-gpio.c    
2005-01-12 15:01:29.000000000 +1100
+++ linux-2.6.11-rc1/drivers/media/video/ir-kbd-gpio.c  2005-01-19
09:30:59.000000000 +1100
@@ -366,7 +366,7 @@
                break;
 
        case BTTV_AVDVBT_761:
-       /* case BTTV_AVDVBT_771: */
+       case BTTV_AVDVBT_771:
                ir_codes         = ir_codes_avermedia_dvbt;
                ir->mask_keycode = 0x0f00c0;
                ir->mask_keydown = 0x000020;




-- 
Jared Kells
kared@kared.net
http://www.kared.net
