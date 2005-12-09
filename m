Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbVLIST4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbVLIST4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbVLIST4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:19:56 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:28108 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964847AbVLISTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 13:19:55 -0500
Message-Id: <20051209182053.654088000@localhost>
References: <20051209180414.872465000@localhost>
Date: Fri, 09 Dec 2005 19:04:16 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Arnd Bergmann <arndb@de.ibm.com>
Subject: [PATCH 2/8] spufs: trivial compile fix
Content-Disposition: inline; filename=spufs-build-fix.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of my last patches contained a broken line
from splitting out some other changes, this
restores a working version.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/sched.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/sched.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/sched.c
@@ -45,7 +45,7 @@
 #include <asm/spu_csa.h>
 #include "spufs.h"
 
-#define SPU_MIN_TIMESLICE 	(100 * HZ / 1000))
+#define SPU_MIN_TIMESLICE 	(100 * HZ / 1000)
 
 #define SPU_BITMAP_SIZE (((MAX_PRIO+BITS_PER_LONG)/BITS_PER_LONG)+1)
 struct spu_prio_array {

--

