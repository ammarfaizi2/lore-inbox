Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVAaMrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVAaMrj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 07:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVAaMri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 07:47:38 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62215 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261175AbVAaMpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 07:45:47 -0500
Date: Mon, 31 Jan 2005 13:45:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: fuganti@netbank.com.br, Zwane Mwaikambo <zwane@commfireservices.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/watchdog/: make some code static
Message-ID: <20050131124543.GH18316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/watchdog/machzwd.c   |    2 +-
 drivers/char/watchdog/sc1200wdt.c |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.11-rc2-mm2-full/drivers/char/watchdog/machzwd.c.old	2005-01-31 13:07:19.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/watchdog/machzwd.c	2005-01-31 13:07:27.000000000 +0100
@@ -488,7 +488,7 @@
 }
 
 
-void __exit zf_exit(void)
+static void __exit zf_exit(void)
 {
 	zf_timer_off();
 
--- linux-2.6.11-rc2-mm2-full/drivers/char/watchdog/sc1200wdt.c.old	2005-01-31 13:07:48.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/watchdog/sc1200wdt.c	2005-01-31 13:08:26.000000000 +0100
@@ -74,9 +74,9 @@
 static int timeout = 1;
 static int io = -1;
 static int io_len = 2;		/* for non plug and play */
-struct semaphore open_sem;
+static struct semaphore open_sem;
 static char expect_close;
-spinlock_t sc1200wdt_lock;	/* io port access serialisation */
+static spinlock_t sc1200wdt_lock;	/* io port access serialisation */
 
 #if defined CONFIG_PNP
 static int isapnp = 1;
@@ -335,7 +335,7 @@
 
 #if defined CONFIG_PNP
 
-struct pnp_device_id scl200wdt_pnp_devices[] = {
+static struct pnp_device_id scl200wdt_pnp_devices[] = {
 	/* National Semiconductor PC87307/PC97307 watchdog component */
 	{.id = "NSC0800", .driver_data = 0},
 	{.id = ""},

