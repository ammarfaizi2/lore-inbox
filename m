Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269682AbTGJXH6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 19:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269683AbTGJXH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 19:07:58 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:16900 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S269682AbTGJXH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 19:07:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [2-LINER] Fix unknown scancode errors for Dell laptops
From: "James H. Cloos Jr." <cloos@jhcloos.com>
Date: 10 Jul 2003 19:22:30 -0400
Message-ID: <m3brw255mx.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With stock 2.5, some of the Dell Inspiron laptops give unknown
scancode printk()s from two of their seven multimedia keys.

The patch below fixes that by assigning otherwise unused values to
those two scan codes.

I'm running w/ it now w/o problems.  

-JimC

 drivers/input/keyboard/atkbd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Tue Jul  8 17:39:32 2003
+++ b/drivers/input/keyboard/atkbd.c	Tue Jul  8 17:39:32 2003
@@ -55,13 +55,13 @@
 	252,253,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 	254,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,255,
 	  0,  0, 92, 90, 85,  0,137,  0,  0,  0,  0, 91, 89,144,115,  0,
-	217,100,255,  0, 97,165,164,  0,156,  0,  0,140,115,  0,  0,125,
+	217,100,255,  0, 97,165,164,  0,156,  0,  0,140,115,  0,117,125,
 	173,114,  0,113,152,163,151,126,128,166,  0,140,  0,147,  0,127,
 	159,167,115,160,164,  0,  0,116,158,  0,150,166,  0,  0,  0,142,
 	157,  0,114,166,168,  0,  0,  0,155,  0, 98,113,  0,163,  0,138,
 	226,  0,  0,  0,  0,  0,153,140,  0,255, 96,  0,  0,  0,143,  0,
 	133,  0,116,  0,143,  0,174,133,  0,107,  0,105,102,  0,  0,112,
-	110,111,108,112,106,103,  0,119,  0,118,109,  0, 99,104,119
+	110,111,108,112,106,103,124,119,  0,118,109,  0, 99,104,119
 };
 
 static unsigned char atkbd_set3_keycode[512] = {

