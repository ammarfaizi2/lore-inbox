Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbVGVVf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVGVVf1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 17:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVGVVf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 17:35:26 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33546 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262242AbVGVVfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 17:35:19 -0400
Date: Fri, 22 Jul 2005 23:35:12 +0200
From: Adrian Bunk <bunk@stusta.de>
To: kkeil@suse.de, kai.germaschewski@gmx.de
Cc: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/isdn/hisax/l3dss1.c: fix warning with -Wundef
Message-ID: <20050722213512.GT3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following warning with -Wundef:

<--  snip  -->

...
  CC      drivers/isdn/hisax/l3dss1.o
drivers/isdn/hisax/l3dss1.c:356:5: warning: "HISAX_DE_AOC" is not defined
...

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm1-full/drivers/isdn/hisax/l3dss1.c.old	2005-07-22 18:20:59.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/drivers/isdn/hisax/l3dss1.c	2005-07-22 18:21:42.000000000 +0200
@@ -353,7 +353,7 @@
 			         { l3dss1_dummy_invoke(st, cr, id, ident, p, nlen);
                                    return;
                                  } 
-#if HISAX_DE_AOC
+#ifdef HISAX_DE_AOC
 			{
 
 #define FOO1(s,a,b) \

