Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVCTTYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVCTTYG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 14:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVCTTYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 14:24:06 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33029 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261175AbVCTTYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 14:24:02 -0500
Date: Sun, 20 Mar 2005 20:24:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386/x86_64 early_printk.c: make early_serial_base static
Message-ID: <20050320192400.GO4449@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global variable static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-mm4-full/arch/x86_64/kernel/early_printk.c.old	2005-03-20 19:46:41.000000000 +0100
+++ linux-2.6.11-mm4-full/arch/x86_64/kernel/early_printk.c	2005-03-20 19:46:49.000000000 +0100
@@ -60,7 +60,7 @@
 
 /* Serial functions loosely based on a similar package from Klaus P. Gerlicher */ 
 
-int early_serial_base = 0x3f8;  /* ttyS0 */ 
+static int early_serial_base = 0x3f8;  /* ttyS0 */ 
 
 #define XMTRDY          0x20
 

