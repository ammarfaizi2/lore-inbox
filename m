Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264942AbTFQUgF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 16:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264944AbTFQUfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 16:35:38 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:30677 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264942AbTFQUfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 16:35:25 -0400
Date: Tue, 17 Jun 2003 22:49:12 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: timofeev@granch.ru
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: 2.5.72: sbni.c doesn't compile with gcc 3.3
Message-ID: <20030617204911.GE29247@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/wan/sbni.c in 2.5.72 doesn't compile with gcc 3.3, 
compilation with gcc 2.95 works.

The error message is:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/net/wan/.sbni.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=sbni -DKBUILD_MODNAME=sbni -c -o 
drivers/net/wan/sbni.o drivers/net/wan/sbni.c
drivers/net/wan/sbni.c: In function `sbni_pci_probe':
drivers/net/wan/sbni.c:280: warning: passing arg 1 of 
`pci_request_region' makes pointer from integer without a cast
drivers/net/wan/sbni.c:283: warning: `check_region' is deprecated 
(declared at include/linux/ioport.h:116)
drivers/net/wan/sbni.c: In function `calc_crc32':
drivers/net/wan/sbni.c:1552: error: asm-specifier for variable `_crc' 
conflicts with asm clobber list
make[3]: *** [drivers/net/wan/sbni.o] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

