Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVAaMti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVAaMti (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 07:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVAaMti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 07:49:38 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:8968 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261174AbVAaMsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 07:48:30 -0500
Date: Mon, 31 Jan 2005 13:48:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/mwave/smapi.c: small cleanups
Message-ID: <20050131124827.GI18316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make the needlessly global function smapi_request static
- #if 0 the currently unused function SmapiQuerySystemID

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/mwave/smapi.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

--- linux-2.6.11-rc2-mm2-full/drivers/char/mwave/smapi.c.old	2005-01-31 13:19:34.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/mwave/smapi.c	2005-01-31 13:24:29.000000000 +0100
@@ -54,11 +54,11 @@
 static unsigned short g_usSmapiPort = 0;
 
 
-int smapi_request(unsigned short inBX, unsigned short inCX,
-                  unsigned short inDI, unsigned short inSI,
-                  unsigned short *outAX, unsigned short *outBX,
-                  unsigned short *outCX, unsigned short *outDX,
-                  unsigned short *outDI, unsigned short *outSI)
+static int smapi_request(unsigned short inBX, unsigned short inCX,
+			 unsigned short inDI, unsigned short inSI,
+			 unsigned short *outAX, unsigned short *outBX,
+			 unsigned short *outCX, unsigned short *outDX,
+			 unsigned short *outDI, unsigned short *outSI)
 {
 	unsigned short myoutAX = 2, *pmyoutAX = &myoutAX;
 	unsigned short myoutBX = 3, *pmyoutBX = &myoutBX;
@@ -511,8 +511,8 @@
 	return bRC;
 }
 
-
-int SmapiQuerySystemID(void)
+#if 0
+static int SmapiQuerySystemID(void)
 {
 	int bRC = -EIO;
 	unsigned short usAX = 0xffff, usBX = 0xffff, usCX = 0xffff,
@@ -531,7 +531,7 @@
 
 	return bRC;
 }
-
+#endif  /*  0  */
 
 int smapi_init(void)
 {

