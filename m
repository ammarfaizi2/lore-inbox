Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265039AbSJaAPM>; Wed, 30 Oct 2002 19:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265040AbSJaAPL>; Wed, 30 Oct 2002 19:15:11 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:43752 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265039AbSJaAPJ>; Wed, 30 Oct 2002 19:15:09 -0500
Date: Thu, 31 Oct 2002 01:21:31 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: K S Sreeram <sreeram@tachyontech.net>, <alan@redhat.com>,
       <linux-kernel@vger.kernel.org>,
       <intermezzo-discuss@lists.sourceforge.net>, <braam@clusterfs.com>
Subject: [patch] fix intermezzo compile in 2.4.20-rc1
Message-ID: <Pine.NEB.4.44.0210310104010.20835-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got the following error at the final linking of 2.4.20-rc1:

<--   snip  -->

...
        -o vmlinux
fs/fs.o(.text+0x53bc3): In function `presto_free_cache':
: undefined reference to `presto_dentry_slab'
make: *** [vmlinux] Error 1

<--  snip  -->


K S Sreeram <sreeram@tachyontech.net> proposed the following a week ago:


--- linux-2.4.19-full/fs/intermezzo/dcache.c.old	2002-10-31 01:03:12.000000000 +0100
+++ linux-2.4.19-full/fs/intermezzo/dcache.c	2002-10-31 01:03:36.000000000 +0100
@@ -48,7 +48,7 @@

 #include <linux/intermezzo_fs.h>

-static kmem_cache_t * presto_dentry_slab;
+kmem_cache_t * presto_dentry_slab;

 /* called when a cache lookup succeeds */
 static int presto_d_revalidate(struct dentry *de, int flag)


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed






