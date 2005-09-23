Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030385AbVIVOkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbVIVOkr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 10:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbVIVOkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 10:40:46 -0400
Received: from fell-1.agava.net ([81.177.7.143]:3849 "EHLO fell.agava.net")
	by vger.kernel.org with ESMTP id S1030384AbVIVOkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 10:40:46 -0400
Message-ID: <4334120E.7090002@kuzlit.ru>
Date: Fri, 23 Sep 2005 18:32:46 +0400
From: Victor <victor@kuzlit.ru>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fglrx-8.16.20, kernel 2.6.13-mm3
Content-Type: multipart/mixed;
 boundary="------------090206020105010502070308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090206020105010502070308
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit

This patch will help you to compile fglrx driver on mm kernel :-) I test 
it on 2.6.13-mm3, maybe it will work on others :-)

glxinfo|grep direct
return
direct rendering: yes

Best regards, Victor :-)

--------------090206020105010502070308
Content-Type: text/plain;
 name="fglrx-8.16.20-kernel-2.6.13-mm3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fglrx-8.16.20-kernel-2.6.13-mm3.patch"

--- firegl_public.c.orig	2005-08-16 20:13:33.000000000 +0400
+++ firegl_public.c	2005-09-23 17:25:49.000000000 +0400
@@ -121,7 +121,7 @@
 #endif
 
 #ifdef __x86_64__
-#include "asm/ioctl32.h"
+#include "linux/ioctl32.h"
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,2)
 #include "linux/syscalls.h"
 #endif
@@ -1425,7 +1425,7 @@
 
 int ATI_API_CALL __ke_verify_area(int type, const void * addr, unsigned long size)
 {
-    return verify_area(type, addr, size);
+    return access_ok(type, addr, size);
 }
 
 int ATI_API_CALL __ke_get_pci_device_info(__ke_pci_dev_t* dev, __ke_pci_device_info_t *pinfo)

--------------090206020105010502070308--
