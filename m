Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVGaW3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVGaW3V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 18:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVGaW1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 18:27:34 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25611 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262005AbVGaW0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 18:26:15 -0400
Date: Mon, 1 Aug 2005 00:26:13 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: John Levon <levon@movementarian.org>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/linux/dcookies.h: dummy functions must be "static inline"
Message-ID: <20050731222613.GO3608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want these to be global functions.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 26 Jul 2005

--- linux-2.6.13-rc3-mm1-full/include/linux/dcookies.h.old	2005-07-26 11:15:22.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/include/linux/dcookies.h	2005-07-26 11:15:38.000000000 +0200
@@ -48,12 +48,12 @@
 
 #else
 
-struct dcookie_user * dcookie_register(void)
+static inline struct dcookie_user * dcookie_register(void)
 {
 	return NULL;
 }
 
-void dcookie_unregister(struct dcookie_user * user)
+static inline void dcookie_unregister(struct dcookie_user * user)
 {
 	return;
 }

