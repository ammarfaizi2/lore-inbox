Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318214AbSHDTMk>; Sun, 4 Aug 2002 15:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318217AbSHDTLQ>; Sun, 4 Aug 2002 15:11:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41735 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318208AbSHDTLN>; Sun, 4 Aug 2002 15:11:13 -0400
To: Al Viro <viro@math.psu.edu>
CC: <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 1: 2.5.30-partitions
Message-Id: <E17bQpu-0001qC-00@flint.arm.linux.org.uk>
Date: Sun, 04 Aug 2002 20:14:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has been verified to apply cleanly to 2.5.30

This patch prevents the following build warning:

check.c: In function `check_partition':
check.c:356: warning: implicit declaration of function `kmalloc'
check.c:356: warning: assignment makes pointer from integer without a cast

 fs/partitions/check.c |    1 +
 1 files changed, 1 insertion

--- orig/fs/partitions/check.c	Fri Aug  2 21:13:36 2002
+++ linux/fs/partitions/check.c	Sun Aug  4 13:08:42 2002
@@ -18,6 +18,7 @@
 #include <linux/blk.h>
 #include <linux/buffer_head.h>	/* for invalidate_bdev() */
 #include <linux/kmod.h>
+#include <linux/slab.h>
 
 #include "check.h"
 
