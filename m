Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWIDSl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWIDSl5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 14:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWIDSl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 14:41:57 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:52749 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751450AbWIDSl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 14:41:56 -0400
Date: Mon, 4 Sep 2006 20:41:52 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] mm/memory_hotplug.c must #include <linux/cpuset.h>
Message-ID: <20060904184152.GX4416@stusta.de>
References: <20060901015818.42767813.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060901015818.42767813.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile error:

<--  snip  -->

...
  CC      mm/memory_hotplug.o
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/mm/memory_hotplug.c: In function ‘add_memory’:
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/mm/memory_hotplug.c:286: error: implicit declaration of function ‘cpuset_track_online_nodes’
make[2]: *** [mm/memory_hotplug.o] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc5-mm1/mm/memory_hotplug.c.old	2006-09-04 20:23:30.000000000 +0200
+++ linux-2.6.18-rc5-mm1/mm/memory_hotplug.c	2006-09-04 20:23:48.000000000 +0200
@@ -22,6 +22,7 @@
 #include <linux/highmem.h>
 #include <linux/vmalloc.h>
 #include <linux/ioport.h>
+#include <linux/cpuset.h>
 
 #include <asm/tlbflush.h>
 

