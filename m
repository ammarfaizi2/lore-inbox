Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751916AbWFLMZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbWFLMZT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 08:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbWFLMZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 08:25:18 -0400
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:44203 "EHLO
	mail-gw2.sa.eol.hu") by vger.kernel.org with ESMTP id S1751915AbWFLMZQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 08:25:16 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <E1FplQT-0005yf-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Mon, 12 Jun 2006 14:21:49 +0200)
Subject: [PATCH 1/7] fuse: use MISC_MAJOR
References: <E1FplQT-0005yf-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FplTa-00060W-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 12 Jun 2006 14:25:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Engelhardt <jengelh@linux01.gwdg.de>

Have fuse.h use MISC_MAJOR rather than a hardcoded '10'.

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>
Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/include/linux/fuse.h
===================================================================
--- linux.orig/include/linux/fuse.h	2006-06-12 14:09:22.000000000 +0200
+++ linux/include/linux/fuse.h	2006-06-12 14:09:54.000000000 +0200
@@ -9,6 +9,7 @@
 /* This file defines the kernel interface of FUSE */
 
 #include <asm/types.h>
+#include <linux/major.h>
 
 /** Version number of this interface */
 #define FUSE_KERNEL_VERSION 7
@@ -20,7 +21,7 @@
 #define FUSE_ROOT_ID 1
 
 /** The major number of the fuse character device */
-#define FUSE_MAJOR 10
+#define FUSE_MAJOR MISC_MAJOR
 
 /** The minor number of the fuse character device */
 #define FUSE_MINOR 229
