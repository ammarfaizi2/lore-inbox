Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTLVSOk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 13:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbTLVSOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 13:14:39 -0500
Received: from smtp1.libero.it ([193.70.192.51]:18416 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S262805AbTLVSOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 13:14:37 -0500
From: Flameeyes <dgp85@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Sidewinder debug information
Date: Mon, 22 Dec 2003 19:18:53 +0000
User-Agent: KMail/1.5.94
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dO05/Vuzurt6vZ3"
Message-Id: <200312221918.53891.dgp85@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_dO05/Vuzurt6vZ3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
with 2.6.0 kernel, I have some troubles with sidewinder support.
It works perfectly, but when using it, the kernel log is fullfilled by
messages like these:

sidewinder.c: Read 5 triplets. [77773]
sidewinder.c: Read 5 triplets. [77773]

so dmesg command it's useless.
With the attached patch the SWDEBUG is removed and the messages aren't
printed.

-- 
Flameeyes <dgp85@users.sourceforge.net>
You can find LIRC for 2.6 kernels at
http://flameeyes.web.ctonet.it/

--Boundary-00=_dO05/Vuzurt6vZ3
Content-Type: text/x-diff;
  charset="us-ascii";
  name="sidewinder-debug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sidewinder-debug.diff"

--- linux/drivers/input/joystick/sidewinder.c.orig	2003-12-22 19:05:48.147132360 +0000
+++ linux/drivers/input/joystick/sidewinder.c	2003-12-22 19:05:54.770125512 +0000
@@ -45,8 +45,6 @@ MODULE_LICENSE("GPL");
  * as well as break everything.
  */
 
-#define SW_DEBUG
-
 #define SW_START	400	/* The time we wait for the first bit [400 us] */
 #define SW_STROBE	45	/* Max time per bit [45 us] */
 #define SW_TIMEOUT	4000	/* Wait for everything to settle [4 ms] */

--Boundary-00=_dO05/Vuzurt6vZ3--
