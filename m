Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965137AbWEaVx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965137AbWEaVx1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbWEaVx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:53:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38298 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965137AbWEaVx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:53:26 -0400
Subject: [PATCH Trivial] Wrong syntax: instead of bool, it was written
	boolean
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
Content-Type: text/plain
Date: Wed, 31 May 2006 18:53:15 -0300
Message-Id: <1149112395.23919.4.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab  <mchehab@infradead.org>

Wrong syntax: instead of bool, it was written boolean on Kconfig on V4L1
and V4L1_COMPAT.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff -upNr oldtree/drivers/media/Kconfig linux/drivers/media/Kconfig
--- oldtree/drivers/media/Kconfig	2006-05-31 18:35:40.000000000 -0300
+++ linux/drivers/media/Kconfig	2006-05-31 18:35:33.000000000 -0300
@@ -25,7 +25,7 @@ config VIDEO_DEV
 	  module will be called videodev.
 
 config VIDEO_V4L1
-	boolean "Enable Video For Linux API 1 (DEPRECATED)"
+	bool "Enable Video For Linux API 1 (DEPRECATED)"
 	depends on VIDEO_DEV
 	select VIDEO_V4L1_COMPAT
 	default y
@@ -36,7 +36,7 @@ config VIDEO_V4L1
 	  If you are unsure as to whether this is required, answer Y.
 
 config VIDEO_V4L1_COMPAT
-	boolean "Enable Video For Linux API 1 compatible Layer"
+	bool "Enable Video For Linux API 1 compatible Layer"
 	depends on VIDEO_DEV
 	default y
 	---help---


