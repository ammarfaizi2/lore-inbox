Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVGZO6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVGZO6s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 10:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVGZO44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 10:56:56 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14341 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261825AbVGZOzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 10:55:06 -0400
Date: Tue, 26 Jul 2005 16:54:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/linux/dcookies.h: dummy functions must be "static inline"
Message-ID: <20050726145457.GP3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want these to be global functions.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

