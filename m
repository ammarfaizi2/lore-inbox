Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVBUOtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVBUOtm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 09:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVBUOtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 09:49:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:42764 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261994AbVBUOsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 09:48:22 -0500
Date: Mon, 21 Feb 2005 15:48:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/sb1000.c: make some variables static
Message-ID: <20050221144818.GD3187@stusta.de>
References: <20050219000339.GI4337@stusta.de> <42193B44.1010203@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42193B44.1010203@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2005 at 08:37:08PM -0500, Jeff Garzik wrote:
> this patch eats formfeeds


Sorry, updated patch:


<--  snip  -->


This patch makes some needlessly global variables static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/sb1000.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/net/sb1000.c.old	2005-02-16 18:17:09.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/sb1000.c	2005-02-21 15:16:35.000000000 +0100
@@ -57,9 +57,9 @@
 #include <asm/uaccess.h>
 
 #ifdef SB1000_DEBUG
-int sb1000_debug = SB1000_DEBUG;
+static int sb1000_debug = SB1000_DEBUG;
 #else
-int sb1000_debug = 1;
+static int sb1000_debug = 1;
 #endif
 
 static const int SB1000_IO_EXTENT = 8;
@@ -252,7 +252,7 @@
  * SB1000 hardware routines to be used during open/configuration phases
  */
 
-const int TimeOutJiffies = (875 * HZ) / 100;
+static const int TimeOutJiffies = (875 * HZ) / 100;
 
 static inline void nicedelay(unsigned long usecs)
 {
@@ -363,7 +363,7 @@
 /*
  * SB1000 hardware routines to be used during frame rx interrupt
  */
-const int Sb1000TimeOutJiffies = 7 * HZ;
+static const int Sb1000TimeOutJiffies = 7 * HZ;
 
 /* Card Wait For Ready (to be used during frame rx) */
 static inline int

