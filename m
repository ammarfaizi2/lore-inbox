Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263267AbSKEJ2a>; Tue, 5 Nov 2002 04:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264736AbSKEJ23>; Tue, 5 Nov 2002 04:28:29 -0500
Received: from kryton.mki.bz ([195.58.191.168]:44702 "EHLO mx0.mki.bz")
	by vger.kernel.org with ESMTP id <S263267AbSKEJ22>;
	Tue, 5 Nov 2002 04:28:28 -0500
Date: Tue, 5 Nov 2002 10:35:01 +0100 (CET)
From: Michael Kummer <michael@kummer.cc>
Reply-To: michael@kummer.cc
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.46 (compile error)
In-Reply-To: <1036477834.31982.0.camel@rth.ninka.net>
Message-ID: <Pine.LNX.4.44.0211051032580.246-100000@epo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

after issuing a "make bzImage":

gcc -Wp,-MD,drivers/message/i2o/.i2o_pci.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4 -Iarch/i386/mach-generic -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=i2o_pci   -c -o
drivers/message/i2o/i2o_pci.o drivers/message/i2o/i2o_pci.c
drivers/message/i2o/i2o_pci.c: In function `i2o_pci_core_attach':
drivers/message/i2o/i2o_pci.c:371: warning: implicit declaration of
function `i2o_sys_init'
  gcc -Wp,-MD,drivers/message/i2o/.i2o_core.o.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4 -Iarch/i386/mach-generic -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=i2o_core   -c -o
drivers/message/i2o/i2o_core.o drivers/message/i2o/i2o_core.c
  gcc -Wp,-MD,drivers/message/i2o/.i2o_config.o.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4 -Iarch/i386/mach-generic -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=i2o_config   -c -o
drivers/message/i2o/i2o_config.o drivers/message/i2o/i2o_config.c
  gcc -Wp,-MD,drivers/message/i2o/.i2o_block.o.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4 -Iarch/i386/mach-generic -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=i2o_block   -c -o
drivers/message/i2o/i2o_block.o drivers/message/i2o/i2o_block.c
drivers/message/i2o/i2o_block.c: In function `i2o_block_init':
drivers/message/i2o/i2o_block.c:1672: warning: implicit declaration of
function `BLK_DEFAULT_QUEUE'
drivers/message/i2o/i2o_block.c:1672: warning: passing arg 1 of
`blk_cleanup_queue' makes pointer from integer without a cast
  gcc -Wp,-MD,drivers/message/i2o/.i2o_lan.o.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4 -Iarch/i386/mach-generic -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=i2o_lan   -c -o
drivers/message/i2o/i2o_lan.o drivers/message/i2o/i2o_lan.c
drivers/message/i2o/i2o_lan.c:28: #error Please convert me to
Documentation/DMA-mapping.txt
drivers/message/i2o/i2o_lan.c:119: parse error before `struct'
drivers/message/i2o/i2o_lan.c: In function `i2o_lan_receive_post_reply':
drivers/message/i2o/i2o_lan.c:385: `run_i2o_post_buckets_task' undeclared
(first use in this function)
drivers/message/i2o/i2o_lan.c:385: (Each undeclared identifier is reported
only once
drivers/message/i2o/i2o_lan.c:385: for each function it appears in.)
drivers/message/i2o/i2o_lan.c: In function `i2o_lan_register_device':
drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
drivers/message/i2o/i2o_lan.c:1407: structure has no member named `sync'
make[3]: *** [drivers/message/i2o/i2o_lan.o] Error 1
make[2]: *** [drivers/message/i2o] Error 2
make[1]: *** [drivers/message] Error 2
make: *** [drivers] Error 2


-----------
Reading specs from /usr/lib/gcc-lib/i386-slackware-linux/2.95.3/specs
gcc version 2.95.3 20010315 (release)

GNU Make 3.80

binutils-2.13.90.0.10

-- 
best regards


Michael Kummer

--
Michael Kummer - [A]ustrian [E]lite [S]printer
Lieferinger-Hauptstrasse 47 - A 5020 Salzburg
Mobile: +43 664 3333995
EMail: michael@kummer.cc
Web: http://www.sprinter.cc


