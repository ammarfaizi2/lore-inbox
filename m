Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262911AbUJ1K3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbUJ1K3t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 06:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbUJ1KZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 06:25:30 -0400
Received: from sd291.sivit.org ([194.146.225.122]:13719 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262964AbUJ1KRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 06:17:05 -0400
Date: Thu, 28 Oct 2004 12:18:31 +0200
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Gerd Knorr <kraxel@bytesex.org>
Subject: [PATCH] videodev2.h patchlet
Message-ID: <20041028101831.GK3893@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Gerd Knorr <kraxel@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patchlet to videodev2.h brings in the "__user" definition
from linux/compiler.h, making it suitable for inclusion in both kernel
or user code.

Stelian.

Signed-off-by: Stelian Pop <stelian@popies.net>

===== include/linux/videodev2.h 1.8 vs edited =====
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
Stelian Pop <stelian@popies.net>    
