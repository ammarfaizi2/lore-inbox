Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbTENOfD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 10:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbTENOev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 10:34:51 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:31197 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262348AbTENOeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 10:34:46 -0400
Date: Wed, 14 May 2003 16:47:28 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>, Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       Franco Venturi <fventuri@mediaone.net>
Subject: 2.5.69-mm5: sb1000.c: undefined reference to `alloc_netdev'
Message-ID: <20030514144727.GG1346@fs.tum.de>
References: <20030514012947.46b011ff.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514012947.46b011ff.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the following compile error comes from Linus' tree:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/net/.sb1000.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=k6 -Iinclude/asm-i386/mach-default -nostdinc 
-iwithprefix include    -DKBUILD_BASENAME=sb1000 -DKBUILD_MODNAME=sb1000 -c -o 
drivers/net/sb1000.o drivers/net/sb1000.c
drivers/net/sb1000.c: In function `sb1000_probe_one':
drivers/net/sb1000.c:191: warning: implicit declaration of function 
`alloc_netdev'
drivers/net/sb1000.c:191: warning: assignment makes pointer from integer 
without a cast
drivers/net/sb1000.c:154: warning: `dev' might be used uninitialized in 
this function
...
... --end-group  -o .tmp_vmlinux1
drivers/built-in.o(.text+0x22e7b5): In function `sb1000_probe_one':
: undefined reference to `alloc_netdev'
...
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

