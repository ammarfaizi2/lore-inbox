Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267734AbUGaEAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267734AbUGaEAA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 00:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267905AbUGaD77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 23:59:59 -0400
Received: from pxy2allmi.all.mi.charter.com ([24.247.15.40]:55032 "EHLO
	proxy2-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S267670AbUGaD6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 23:58:41 -0400
Message-ID: <410B18DF.1010003@quark.didntduck.org>
Date: Fri, 30 Jul 2004 23:58:23 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040625
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove symbol_is()
Content-Type: multipart/mixed;
 boundary="------------040005030006000808010003"
X-Charter-Information: 
X-Charter-Scan: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040005030006000808010003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Remove the unused symbol_is() macro.

--
				Brian Gerst

--------------040005030006000808010003
Content-Type: text/plain;
 name="symbol_is-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="symbol_is-1"

diff -urN linux-2.6.8-rc2-bk/kernel/module.c linux/kernel/module.c
--- linux-2.6.8-rc2-bk/kernel/module.c	2004-07-18 12:27:55.000000000 -0400
+++ linux/kernel/module.c	2004-07-30 23:45:30.601452512 -0400
@@ -51,9 +51,6 @@
 /* If this is set, the section belongs in the init part of the module */
 #define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))
 
-#define symbol_is(literal, string)				\
-	(strcmp(MODULE_SYMBOL_PREFIX literal, (string)) == 0)
-
 /* Protects module list */
 static spinlock_t modlist_lock = SPIN_LOCK_UNLOCKED;
 

--------------040005030006000808010003--
