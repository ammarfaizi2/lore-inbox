Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312417AbSCURV6>; Thu, 21 Mar 2002 12:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312410AbSCURVi>; Thu, 21 Mar 2002 12:21:38 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:6275 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S312397AbSCURVU>; Thu, 21 Mar 2002 12:21:20 -0500
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel@vger.kernel.org
cc: linux-alpha@vger.kernel.org
Subject: [PATCH] Needed to get 2.5.7 to compile and link on Alpha [1/10]
Message-Id: <E16o6CB-0005Ny-00@lightning.hereintown.net>
Date: Thu, 21 Mar 2002 12:17:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is probally the Wrong Thing to do, but making pgalloc.h include 
highmem.h instead of the other way around, thus breaking at least the
Alpha and Sparc64 platforms wasn't much less Wrong.

-Chris 


--- linux-2.5.7/include/linux/highmem.h~	Wed Mar 20 11:09:42 2002
+++ linux-2.5.7/include/linux/highmem.h	Wed Mar 20 15:55:49 2002
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/bio.h>
 #include <linux/fs.h>
+#include <asm/pgalloc.h>
 
 #ifdef CONFIG_HIGHMEM
 
