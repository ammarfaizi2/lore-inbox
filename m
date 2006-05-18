Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWERPNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWERPNS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWERPNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:13:18 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:46477 "EHLO
	fmmailgate01.web.de") by vger.kernel.org with ESMTP
	id S1751321AbWERPNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:13:17 -0400
Message-ID: <446C8BEE.2080807@web.de>
Date: Thu, 18 May 2006 16:59:58 +0200
From: "jens m. noedler" <noedler@web.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: trivial@kernel.org, ipw2100-devel@lists.sourceforge.net
Subject: [TRIVIAL] ipw2200: fix a gcc compile warning
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If one compiles the ipw2200 module without having CONFIG_IPW2200_DEBUG
set gcc will warn. This patch fixes the following warning and applies 
to 2.6.17-rc4-git6.

  CC [M]  drivers/net/wireless/ipw2200.o
drivers/net/wireless/ipw2200.c:50: Warnung: `debug' defined but not used

Kind regards, Jens Nödler


Signed-off-by: jens m. noedler <noedler@web.de>

---

--- drivers/net/wireless/ipw2200.c.orig 2006-05-18 16:26:39.000000000 +0200
+++ drivers/net/wireless/ipw2200.c      2006-05-18 16:26:58.000000000 +0200
@@ -45,8 +45,11 @@ MODULE_VERSION(DRV_VERSION);
 MODULE_AUTHOR(DRV_COPYRIGHT);
 MODULE_LICENSE("GPL");

-static int cmdlog = 0;
+#ifdef CONFIG_IPW2200_DEBUG
 static int debug = 0;
+#endif
+
+static int cmdlog = 0;
 static int channel = 0;
 static int mode = 0;


-- 
jens m. noedler
  noedler@web.de
  pgp: 0x9f0920bb
  http://noedler.de
