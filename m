Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266320AbTAJVnX>; Fri, 10 Jan 2003 16:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266359AbTAJVnX>; Fri, 10 Jan 2003 16:43:23 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:32521
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266320AbTAJVnW>; Fri, 10 Jan 2003 16:43:22 -0500
Date: Fri, 10 Jan 2003 16:53:06 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch][2.5.56] fix compile error mm/slab.c __slab_error
Message-ID: <Pine.LNX.4.50.0301101643570.9169-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mm/slab.c: In function `slab_destroy':
mm/slab.c:803: warning: passing arg 1 of `__slab_error' discards qualifiers from pointer target type

Index: linux-2.5.56/mm/slab.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.56/mm/slab.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 slab.c
--- linux-2.5.56/mm/slab.c	10 Jan 2003 21:23:45 -0000	1.1.1.1
+++ linux-2.5.56/mm/slab.c	10 Jan 2003 21:41:17 -0000
@@ -502,7 +502,7 @@

 #define slab_error(cachep, msg) __slab_error(__FUNCTION__, cachep, msg)

-static void __slab_error(char *function, kmem_cache_t *cachep, char *msg)
+static void __slab_error(const char *function, kmem_cache_t *cachep, char *msg)
 {
 	printk(KERN_ERR "slab error in %s(): cache `%s': %s\n",
 		function, cachep->name, msg);

-- 
function.linuxpower.ca
