Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVDWAKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVDWAKv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 20:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVDWAKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 20:10:50 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27153 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261392AbVDWAJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 20:09:01 -0400
Date: Sat, 23 Apr 2005 02:08:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/nls/nls_base.c: make a variable static
Message-ID: <20050423000857.GO4355@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global variable static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm3-full/fs/nls/nls_base.c.old	2005-04-21 00:10:59.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/nls/nls_base.c	2005-04-21 00:11:09.000000000 +0200
@@ -243,7 +243,7 @@
 	module_put(nls->owner);
 }
 
-wchar_t charset2uni[256] = {
+static wchar_t charset2uni[256] = {
 	/* 0x00*/
 	0x0000, 0x0001, 0x0002, 0x0003,
 	0x0004, 0x0005, 0x0006, 0x0007,

