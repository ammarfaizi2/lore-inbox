Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268170AbUH2Q67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268170AbUH2Q67 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 12:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268218AbUH2Q5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 12:57:51 -0400
Received: from agminet04.oracle.com ([141.146.126.231]:26010 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S268212AbUH2Q5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 12:57:18 -0400
Message-ID: <41325F52.3010006@oracle.com>
Date: Sun, 29 Aug 2004 18:57:22 -0400
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Consulting Expert Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.9-rc1-bk5: CONFIG_FB_3DFX needs cfbfillrect and cfbcopyarea
Content-Type: multipart/mixed;
 boundary="------------040802080907080804050501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040802080907080804050501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

...otherwise build fails. Last kernel I built on my home machine was
  2.6.8-rc3-bk1, so I don't know where the issue was introduced. I ran
  a quick search and couldn't find any former reports.

Mini-patch attached.

--alessandro

  "I can tell by the lines on our faces / And the young can't understand
   That they look at me / When they look at themselves"
     (John Mellencamp, "Sweet Evening Breeze")

--------------040802080907080804050501
Content-Type: text/x-patch;
 name="tdfx.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tdfx.diff"

--- linux/drivers/video/Makefile	2004-08-29 14:28:18.000000000 -0400
+++ linux/drivers/video/Makefile-3dfx	2004-08-29 16:06:10.000000000 -0400
@@ -34,7 +34,7 @@
 obj-$(CONFIG_FB_CYBER2000)        += cyber2000fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_GBE)              += gbefb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_SGIVW)            += sgivwfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_3DFX)             += tdfxfb.o cfbimgblt.o
+obj-$(CONFIG_FB_3DFX)             += tdfxfb.o cfbimgblt.o cfbfillrect.o cfbcopyarea.o
 obj-$(CONFIG_FB_MAC)              += macfb.o macmodes.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
 obj-$(CONFIG_FB_HP300)            += hpfb.o cfbfillrect.o cfbimgblt.o
 obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o

--------------040802080907080804050501--
