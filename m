Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTIRXfR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 19:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbTIRXfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 19:35:17 -0400
Received: from hera.cwi.nl ([192.16.191.8]:29834 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262192AbTIRXfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 19:35:10 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 19 Sep 2003 01:34:59 +0200 (MEST)
Message-Id: <UTC200309182334.h8INYxg18389.aeb@smtp.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org, vojtech@suse.cz
Subject: [PATCH] fix keycode for rctrl in scancode set 3
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By mistake the keycode for right control in scancode set 3
was the same as that for right alt. This fixes that.

Andries

[2.6.0-test5]

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Wed Sep 10 23:42:06 2003
+++ b/drivers/input/keyboard/atkbd.c	Thu Sep 18 16:30:19 2003
@@ -70,7 +70,7 @@
 	134, 46, 45, 32, 18,  5,  4, 63,135, 57, 47, 33, 20, 19,  6, 64,
 	136, 49, 48, 35, 34, 21,  7, 65,137,100, 50, 36, 22,  8,  9, 66,
 	125, 51, 37, 23, 24, 11, 10, 67,126, 52, 53, 38, 39, 25, 12, 68,
-	113,114, 40, 84, 26, 13, 87, 99,100, 54, 28, 27, 43, 84, 88, 70,
+	113,114, 40, 84, 26, 13, 87, 99, 97, 54, 28, 27, 43, 84, 88, 70,
 	108,105,119,103,111,107, 14,110,  0, 79,106, 75, 71,109,102,104,
 	 82, 83, 80, 76, 77, 72, 69, 98,  0, 96, 81,  0, 78, 73, 55, 85,
 	 89, 90, 91, 92, 74,185,184,182,  0,  0,  0,125,126,127,112,  0,
