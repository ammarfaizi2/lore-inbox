Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbTEGTRB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbTEGTQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:16:29 -0400
Received: from smtp0.libero.it ([193.70.192.33]:19174 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S264213AbTEGTPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:15:47 -0400
Date: Wed, 7 May 2003 18:31:34 +0300
To: linux-kernel@vger.kernel.org
Subject: PATCH 2.5.69 drivers/macintosh/adbhid.c && QUESTIONS
Message-ID: <20030507153134.GA344@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Daniele Pala <dandario@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a supid syntax error in adbhid.c
The question is: is there a PPC mantainer who i must send patches for PPC? or i just drop them here in the list?
There are other few errors in PPC related files that sometimes prevents the kernel from compiling...supid things, but
annoying...so who gets the PPC stuff?

Regards,
		Daniele Pala

drivers/macintosh/adbhid.c: In function `adbhid_keyboard_input':
drivers/macintosh/adbhid.c:137: too many arguments to function `adbhid_input_keycode'
drivers/macintosh/adbhid.c:139: too many arguments to function `adbhid_input_keycode'
drivers/macintosh/adbhid.c: At top level:
drivers/macintosh/adbhid.c:143: parse error before `pt_regs'
drivers/macintosh/adbhid.c: In function `adbhid_input_keycode':
drivers/macintosh/adbhid.c:144: number of arguments doesn't match prototype
drivers/macintosh/adbhid.c:87: prototype declaration
drivers/macintosh/adbhid.c:147: `keycode' undeclared (first use in this function)
drivers/macintosh/adbhid.c:147: (Each undeclared identifier is reported only once
drivers/macintosh/adbhid.c:147: for each function it appears in.)
drivers/macintosh/adbhid.c:152: `id' undeclared (first use in this function)
drivers/macintosh/adbhid.c:152: `regs' undeclared (first use in this function)
make[2]: *** [drivers/macintosh/adbhid.o] Error 1
make[1]: *** [drivers/macintosh] Error 2
make: *** [drivers] Error 2


--- linux-2.5.69/drivers/macintosh/adbhid.c	Sun Apr 20 04:51:22 2003
+++ adbhid.c	Mon May  5 20:15:44 2003
@@ -84,7 +84,7 @@
 
 static void adbhid_probe(void);
 
-static void adbhid_input_keycode(int, int, int);
+static void adbhid_input_keycode(int, int, int, struct pt_regs *);
 static void leds_done(struct adb_request *);
 
 static void init_trackpad(int id);
@@ -140,7 +140,7 @@
 }
 
 static void
-adbhid_input_keycode(int id, int keycode, int repeat, pt_regs *regs)
+adbhid_input_keycode(int id, int keycode, int repeat, struct pt_regs *regs)
 {
 	int up_flag;
 



