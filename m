Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266915AbSKOW5j>; Fri, 15 Nov 2002 17:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266924AbSKOW5j>; Fri, 15 Nov 2002 17:57:39 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:57033 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266915AbSKOW5h>; Fri, 15 Nov 2002 17:57:37 -0500
Date: Sat, 16 Nov 2002 00:04:26 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, braam@clusterfs.com,
       intermezzo-discuss@lists.sourceforge.net
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-rc2
Message-ID: <20021115230426.GC10408@fs.tum.de>
References: <Pine.LNX.4.44L.0211151309400.11268-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0211151309400.11268-100000@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following error at the final linking of 2.4.20-rc2:

<--   snip  -->

...
        -o vmlinux
fs/fs.o(.text+0x53bc3): In function `presto_free_cache':
: undefined reference to `presto_dentry_slab'
make: *** [vmlinux] Error 1

<--  snip  -->


K S Sreeram <sreeram@tachyontech.net> proposed the following patch two
weeks ago:

--- a/fs/intermezzo/dcache.c	Mon Oct 21 10:56:57 2002
+++ b/fs/intermezzo/dcache.c	Mon Oct 21 10:56:57 2002
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

