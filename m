Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUKHJqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUKHJqq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 04:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbUKHJcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 04:32:16 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:21982 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261807AbUKHJEI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 04:04:08 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 8 Nov 2004 09:54:54 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] videodev2.h patchlet
Message-ID: <20041108085454.GA19377@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patchlet to videodev2.h brings in the "__user" definition
from linux/compiler.h, making it suitable for inclusion in both kernel
or user code.

Stelian.

Signed-off-by: Stelian Pop <stelian@popies.net>
Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 include/linux/videodev2.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 1.8/include/linux/videodev2.h	2004-07-12 10:01:15 +02:00
+++ edited/include/linux/videodev2.h	2004-10-21 19:12:18 +02:00
@@ -16,6 +16,7 @@
 #ifdef __KERNEL__
 #include <linux/time.h> /* need struct timeval */
 #endif
+#include <linux/compiler.h> /* need __user */
 
 /*
  *	M I S C E L L A N E O U S

-- 
#define printk(args...) fprintf(stderr, ## args)
