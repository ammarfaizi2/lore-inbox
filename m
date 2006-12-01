Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030898AbWLAPje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030898AbWLAPje (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030903AbWLAPje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:39:34 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:23048 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1030898AbWLAPjd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:39:33 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] byteorder swab parenthesis fix
Date: Fri, 1 Dec 2006 16:39:08 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011639.08553.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch fixes byteorder swab 24 macro parenthesis. 

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 include/linux/byteorder/swab.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.4.34-pre6-a/include/linux/byteorder/swab.h	2006-12-01 11:46:06.000000000 +0100
+++ linux-2.4.34-pre6-b/include/linux/byteorder/swab.h	2006-12-01 11:56:13.000000000 +0100
@@ -68,7 +68,7 @@
 #define ___constant_swab24(x) \
 	((__u32)( \
 		(((__u32)(x) & (__u32)0x000000ffU) << 16) | \
-		(((__u32)(x) & (__u32)0x0000ff00U)	  | \
+		(((__u32)(x) & (__u32)0x0000ff00U))	  | \
 		(((__u32)(x) & (__u32)0x00ff0000U) >> 16) ))
 #define ___constant_swab32(x) \
 	((__u32)( \


-- 
Regards,

	Mariusz Kozlowski
