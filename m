Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261976AbSJHKje>; Tue, 8 Oct 2002 06:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261944AbSJHKje>; Tue, 8 Oct 2002 06:39:34 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:15345 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261933AbSJHKj3>; Tue, 8 Oct 2002 06:39:29 -0400
Date: Tue, 8 Oct 2002 12:45:05 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: akpm@zip.com.au, <Martin.Bligh@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: 2.5.41: i386/mm/discontig.c doesn't compile with CONFIG_HIGHMEM
Message-ID: <Pine.NEB.4.44.0210081241140.8340-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI:

The compilation of arch/i386/mm/discontig.c fails in both 2.5.41 and
2.5.41-ac1 with the following error when CONFIG_HIGHMEM is enabled:

<--  snip  -->

...
  gcc -Wp,-MD,arch/i386/mm/.discontig.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
-DKBUILD_BASENAME=discontig   -c -o arch/i386/mm/discontig.o
arch/i386/mm/discontig.c
arch/i386/mm/discontig.c: In function `set_highmem_pages_init':
arch/i386/mm/discontig.c:261: structure has no member named `size'
arch/i386/mm/discontig.c:258: warning: `node_high_size' might be used
uninitialized in this function
make[1]: *** [arch/i386/mm/discontig.o] Error 1
make: *** [arch/i386/mm] Error 2

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


