Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265950AbUAEWhU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265849AbUAEWft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:35:49 -0500
Received: from elpis.telenet-ops.be ([195.130.132.40]:1213 "EHLO
	elpis.telenet-ops.be") by vger.kernel.org with ESMTP
	id S265985AbUAEWdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:33:51 -0500
Date: Mon, 5 Jan 2004 23:33:13 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0-rc1 - Watchdog patches (part 2)
Message-ID: <20040105233313.A19985@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andrew,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog

This will update the following files:

 drivers/char/watchdog/acquirewdt.c   |    2 +-
 drivers/char/watchdog/alim1535_wdt.c |    4 ++--
 drivers/char/watchdog/amd7xx_tco.c   |    2 +-
 drivers/char/watchdog/sbc60xxwdt.c   |    2 +-
 drivers/char/watchdog/w83877f_wdt.c  |    2 +-
 drivers/char/watchdog/wafer5823wdt.c |    2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

through these ChangeSets:

<wim@iguana.be> (04/01/03 1.1577)
   [WATCHDOG] 2.6.0-rc1 spelling-fixes-whether.patch
   
   Spelling fixes - whether

<akpm@osdl.org> (04/01/05 1.1578)
   [WATCHDOG] 2.6.0-rc1 amd7xx_tco.c-nowayout.patch
   
   Fix compile error in amd7xx_tco.c after latest nowayout change


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/acquirewdt.c b/drivers/char/watchdog/acquirewdt.c
--- a/drivers/char/watchdog/acquirewdt.c	Mon Jan  5 23:25:17 2004
+++ b/drivers/char/watchdog/acquirewdt.c	Mon Jan  5 23:25:17 2004
@@ -100,7 +100,7 @@
 			 * five months ago... */
 			expect_close = 0;
 
-			/* scan to see wether or not we got the magic character */
+			/* scan to see whether or not we got the magic character */
 			for (i = 0; i != count; i++) {
 				char c;
 				if (get_user(c, buf + i))
diff -Nru a/drivers/char/watchdog/alim1535_wdt.c b/drivers/char/watchdog/alim1535_wdt.c
--- a/drivers/char/watchdog/alim1535_wdt.c	Mon Jan  5 23:25:17 2004
+++ b/drivers/char/watchdog/alim1535_wdt.c	Mon Jan  5 23:25:17 2004
@@ -153,7 +153,7 @@
 			 * five months ago... */
 			ali_expect_release = 0;
 
-			/* scan to see wether or not we got the magic character */
+			/* scan to see whether or not we got the magic character */
 			for (i = 0; i != len; i++) {
 				char c;
 				if(get_user(c, data+i))
@@ -402,7 +402,7 @@
 
 	spin_lock_init(&ali_lock);
 
-	/* Check wether or not the hardware watchdog is there */
+	/* Check whether or not the hardware watchdog is there */
 	if (ali_find_watchdog() != 0) {
 		return -ENODEV;
 	}
diff -Nru a/drivers/char/watchdog/sbc60xxwdt.c b/drivers/char/watchdog/sbc60xxwdt.c
--- a/drivers/char/watchdog/sbc60xxwdt.c	Mon Jan  5 23:25:17 2004
+++ b/drivers/char/watchdog/sbc60xxwdt.c	Mon Jan  5 23:25:17 2004
@@ -183,7 +183,7 @@
 			 * five months ago... */
 			wdt_expect_close = 0;
 
-			/* scan to see wether or not we got the magic character */
+			/* scan to see whether or not we got the magic character */
 			for(ofs = 0; ofs != count; ofs++)
 			{
 				char c;
diff -Nru a/drivers/char/watchdog/w83877f_wdt.c b/drivers/char/watchdog/w83877f_wdt.c
--- a/drivers/char/watchdog/w83877f_wdt.c	Mon Jan  5 23:25:17 2004
+++ b/drivers/char/watchdog/w83877f_wdt.c	Mon Jan  5 23:25:17 2004
@@ -205,7 +205,7 @@
 			 * five months ago... */
 			wdt_expect_close = 0;
 
-			/* scan to see wether or not we got the magic character */
+			/* scan to see whether or not we got the magic character */
 			for(ofs = 0; ofs != count; ofs++)
 			{
 				char c;
diff -Nru a/drivers/char/watchdog/wafer5823wdt.c b/drivers/char/watchdog/wafer5823wdt.c
--- a/drivers/char/watchdog/wafer5823wdt.c	Mon Jan  5 23:25:17 2004
+++ b/drivers/char/watchdog/wafer5823wdt.c	Mon Jan  5 23:25:17 2004
@@ -109,7 +109,7 @@
 			/* In case it was set long ago */
 			expect_close = 0;
 
-			/* scan to see wether or not we got the magic character */
+			/* scan to see whether or not we got the magic character */
 			for (i = 0; i != count; i++) {
 				char c;
 				if (get_user(c, buf + i))
diff -Nru a/drivers/char/watchdog/amd7xx_tco.c b/drivers/char/watchdog/amd7xx_tco.c
--- a/drivers/char/watchdog/amd7xx_tco.c	Mon Jan  5 23:25:38 2004
+++ b/drivers/char/watchdog/amd7xx_tco.c	Mon Jan  5 23:25:38 2004
@@ -253,7 +253,7 @@
 		return -ESPIPE;
 
 	if (len) {
-		if (!nowayout)
+		if (!nowayout) {
 			size_t i;
 			char c;
 			expect_close = 0;
