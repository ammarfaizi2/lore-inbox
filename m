Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbTIUNm0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 09:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbTIUNm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 09:42:26 -0400
Received: from [61.95.227.64] ([61.95.227.64]:19102 "EHLO gateway.gsecone.com")
	by vger.kernel.org with ESMTP id S262404AbTIUNmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 09:42:20 -0400
Subject: [PATCH 2.6.0-test5][OSS] ac97_plugin_ad1980.c: add missing
	__devexit
From: Vinay K Nallamothu <vinay.nallamothu@gsecone.com>
To: linux-sound@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Global Security One
Message-Id: <1064151788.4349.53.camel@lima.royalchallenge.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 21 Sep 2003 19:13:08 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warning:
sound/oss/ac97_plugin_ad1980.c:90: warning: initialization from incompatible pointer type

--- linux-2.6.0-test3/sound/oss/ac97_plugin_ad1980.c	2003-07-28 10:44:11.000000000 +0530
+++ linux-2.6.0-test3-nvk/sound/oss/ac97_plugin_ad1980.c	2003-08-10 19:36:14.000000000 +0530
@@ -28,6 +28,7 @@
 
 */
 
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -45,7 +46,7 @@
  *	use of the codec after the probe function.
  */
  
-static void ad1980_remove(struct ac97_codec *codec)
+static void __devexit ad1980_remove(struct ac97_codec *codec, struct ac97_driver *driver)
 {
 	/* Nothing to do in the simple example */
 }


