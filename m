Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbWLAP3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbWLAP3M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030608AbWLAP3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:29:11 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:51463 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1030391AbWLAP3J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:29:09 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] parisc pdc parenthesis fix
Date: Fri, 1 Dec 2006 16:28:44 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011628.44857.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch fixes removes an extra parenthesis in PAT_GET_MOD_PAGES() macro code.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 include/asm-parisc/pdc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.4.34-pre6-a/include/asm-parisc/pdc.h	2003-06-13 16:51:38.000000000 +0200
+++ linux-2.4.34-pre6-b/include/asm-parisc/pdc.h	2006-12-01 12:01:46.000000000 +0100
@@ -1000,7 +1000,7 @@ int pdc_pat_pd_get_addr_map(unsigned lon
 #define PAT_GET_ENTITY(value)	(((value) >> 56) & 0xffUL)
 #define PAT_GET_DVI(value)	(((value) >> 48) & 0xffUL)
 #define PAT_GET_IOC(value)	(((value) >> 40) & 0xffUL)
-#define PAT_GET_MOD_PAGES(value)(((value) & 0xffffffUL)
+#define PAT_GET_MOD_PAGES(value) ((value) & 0xffffffUL)
 
 #else /* !__LP64__ */
 /* No PAT support for 32-bit kernels...sorry */


-- 
Regards,

	Mariusz Kozlowski
