Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264616AbSJWKn4>; Wed, 23 Oct 2002 06:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264708AbSJWKn4>; Wed, 23 Oct 2002 06:43:56 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:26602 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264616AbSJWKnz>; Wed, 23 Oct 2002 06:43:55 -0400
Date: Wed, 23 Oct 2002 12:50:01 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: dhowells@redhat.com
cc: linux-kernel@vger.kernel.org, <trivial@rustcorp.com.au>
Subject: [2.5 patch] Allow the static compilation of AFS
Message-ID: <Pine.NEB.4.44.0210231245090.14144-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



AFS in 2.5.44 has the bug that nothing gets compiled when you select to
compile it statically into the kernel. The following patch fixes this:


--- linux-2.5.44-full/fs/afs/Makefile.old	2002-10-23 12:37:28.000000000 +0200
+++ linux-2.5.44-full/fs/afs/Makefile	2002-10-23 12:37:52.000000000 +0200
@@ -25,7 +25,7 @@

 #	cache.o

-obj-m  := kafs.o
+obj-$(CONFIG_AFS_FS)  := kafs.o

 # superfluous for 2.5, but needed for 2.4..
 ifeq "$(VERSION).$(PATCHLEVEL)" "2.4"


cu
Adrian

-- 

               "Is there not promise of rain?" Ling Tan asked suddenly out
                of the darkness. There had been need of rain for many days.
               "Only a promise," Lao Er said.
                                               Pearl S. Buck - Dragon Seed





