Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271701AbTG2PBR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 11:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271813AbTG2PBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 11:01:17 -0400
Received: from dsl-200-55-80-165.prima.net.ar ([200.55.80.165]:20100 "EHLO
	runner.matiu.com.ar") by vger.kernel.org with ESMTP id S271701AbTG2PBP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 11:01:15 -0400
Subject: Dell Keyboard patch
From: Matias Alejo Garcia <linux@matiu.com.ar>
To: vojtech@suse.cz
Cc: Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1059493920.1111.92.camel@runner>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 29 Jul 2003 11:52:01 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a trival patch por Dell Inpiron Notebooks, in order to have the
play and rew keys mapped to KEY_PLAYPAUSE and KEY_PREVIOUSSONG, and the
stop key mapped to KEY_STOPCD (instead of KEY_PLAYPAUSE).

In detail:

               keycode         keycode
scancode       before          after this patch
-----------------------------------------
287            0               KEY_PREVIOUSSONG	
309            KEY_PLAYPAUSE   KEY_STOPCD
375            0               KEY_PLAYPAUSE

It may help somebody.

matías


--- linux-2.6.0-test2/drivers/input/keyboard/atkbd.c	2003-07-29
11:22:50.000000000 -0400
+++ linux-2.6.0-test1-mg/drivers/input/keyboard/atkbd.c	2003-07-29
11:28:13.000000000 -0400
@@ -55,13 +55,13 @@
 	252,253,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 	254,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,255,
 	  0,  0, 92, 90, 85,  0,137,  0,  0,  0,  0, 91, 89,144,115,  0,
-	217,100,255,  0, 97,165,164,  0,156,  0,  0,140,115,  0,  0,125,
+	217,100,255,  0, 97,165,166,  0,156,  0,  0,140,115,  0,165,125,
 	173,114,  0,113,152,163,151,126,128,166,  0,140,  0,147,  0,127,
-	159,167,115,160,164,  0,  0,116,158,  0,150,166,  0,  0,  0,142,
+	159,167,115,160,166,  0,  0,116,158,  0,150,166,  0,  0,  0,142,
 	157,  0,114,166,168,  0,  0,  0,155,  0, 98,113,  0,163,  0,138,
 	226,  0,  0,  0,  0,  0,153,140,  0,255, 96,  0,  0,  0,143,  0,
 	133,  0,116,  0,143,  0,174,133,  0,107,  0,105,102,  0,  0,112,
-	110,111,108,112,106,103,  0,119,  0,118,109,  0, 99,104,119
+	110,111,108,112,106,103,164,119,  0,118,109,  0, 99,104,119
 };
 
 static unsigned char atkbd_set3_keycode[512] = {


