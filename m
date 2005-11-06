Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbVKFAYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbVKFAYG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 19:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbVKFAYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 19:24:06 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63500 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932237AbVKFAYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 19:24:05 -0500
Date: Sun, 6 Nov 2005 01:24:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: spyro@f2s.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/arm26/nwfpe/fpmodule.c: remove kernel 2.0 #ifdef
Message-ID: <20051106002403.GB3668@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an #ifdef for kernel 2.0 .


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 26 Feb 2004

--- linux-2.6.3-mm4/arch/arm26/nwfpe/fpmodule.c.old	2004-02-26 23:40:02.000000000 +0100
+++ linux-2.6.3-mm4/arch/arm26/nwfpe/fpmodule.c	2004-02-26 23:41:14.000000000 +0100
@@ -46,10 +46,9 @@
 
 #ifdef MODULE
 void fp_send_sig(unsigned long sig, PTASK p, int priv);
-#if LINUX_VERSION_CODE > 0x20115
+
 MODULE_AUTHOR("Scott Bambrough <scottb@rebel.com>");
 MODULE_DESCRIPTION("NWFPE floating point emulator");
-#endif
 
 #else
 #define fp_send_sig	send_sig
