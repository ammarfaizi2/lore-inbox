Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265063AbUFRJke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265063AbUFRJke (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 05:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUFRJkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 05:40:33 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:8895 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265087AbUFRJkP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 05:40:15 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 18 Jun 2004 11:24:28 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: ir-common update
Message-ID: <20040618092428.GA23903@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

Some minor changes for the ir-common module:  Update for the RC5
keytable and increase the IR_KEYTAB_SIZE #define.

  Gerd

diff -up linux-2.6.7/drivers/media/common/ir-common.c linux/drivers/media/common/ir-common.c
--- linux-2.6.7/drivers/media/common/ir-common.c	2004-06-17 10:30:08.000000000 +0200
+++ linux/drivers/media/common/ir-common.c	2004-06-17 13:47:59.151391710 +0200
@@ -75,6 +75,8 @@ IR_KEYTAB_TYPE ir_codes_rc5_tv[IR_KEYTAB
 	[ 0x35 ] = KEY_PLAY,            // play
 	[ 0x36 ] = KEY_STOP,            // stop
 	[ 0x37 ] = KEY_RECORD,          // recording
+	[ 0x3c ] = KEY_TEXT,            // teletext submode (Japan: 12)
+	[ 0x3d ] = KEY_SUSPEND,         // system standby
 
 #if 0 /* FIXME */
 	[ 0x0a ] = KEY_RESERVED,        // 1/2/3 digits (japan: 10)
@@ -106,8 +108,6 @@ IR_KEYTAB_TYPE ir_codes_rc5_tv[IR_KEYTAB
 	[ 0x39 ] = KEY_RESERVED,        // external 2
 	[ 0x3a ] = KEY_RESERVED,        // PIP display mode
 	[ 0x3b ] = KEY_RESERVED,        // view data mode / advance
-	[ 0x3c ] = KEY_RESERVED,        // teletext submode (Japan: 12)
-	[ 0x3d ] = KEY_RESERVED,        // system standby
 	[ 0x3e ] = KEY_RESERVED,        // crispener on/off
 	[ 0x3f ] = KEY_RESERVED,        // system select
 #endif
diff -up linux-2.6.7/include/media/ir-common.h linux/include/media/ir-common.h
--- linux-2.6.7/include/media/ir-common.h	2004-06-17 10:30:48.000000000 +0200
+++ linux/include/media/ir-common.h	2004-06-17 13:47:59.153391334 +0200
@@ -27,7 +27,7 @@
 #define IR_TYPE_OTHER  99
 
 #define IR_KEYTAB_TYPE	u32
-#define IR_KEYTAB_SIZE	64  // enougth for rc5, probably need more some day ...
+#define IR_KEYTAB_SIZE	128  // enougth for rc5, probably need more some day ...
 
 #define IR_KEYCODE(tab,code)	(((unsigned)code < IR_KEYTAB_SIZE) \
 				 ? tab[code] : KEY_RESERVED)

-- 
Smoking Crack Organization
