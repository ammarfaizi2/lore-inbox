Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbTBKPkx>; Tue, 11 Feb 2003 10:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265077AbTBKPkx>; Tue, 11 Feb 2003 10:40:53 -0500
Received: from franka.aracnet.com ([216.99.193.44]:15593 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264984AbTBKPkw>; Tue, 11 Feb 2003 10:40:52 -0500
Date: Tue, 11 Feb 2003 07:50:33 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 335] New: sb_card.c compile error
Message-ID: <81150000.1044978633@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=335

           Summary: sb_card.c compile error
    Kernel Version: 2.5.60
            Status: NEW
          Severity: low
             Owner: bugme-janitors@lists.osdl.org
         Submitter: corporal_pisang@counter-strike.com.my


Compile error:

make -f scripts/Makefile.build obj=sound/oss
  gcc -Wp,-MD,sound/oss/.sb_card.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE
-DKBUILD_BASENAME=sb_card -DKBUILD_MODNAME=sb -c -o
sound/oss/.tmp_sb_card.o sound/oss/sb_card.c sound/oss/sb_card.c: In
function `activate_dev':
sound/oss/sb_card.c:744: structure has no member named `active'
sound/oss/sb_card.c:747: structure has no member named `activate'
sound/oss/sb_card.c:750: structure has no member named `deactivate'
sound/oss/sb_card.c: In function `sb_init':
sound/oss/sb_card.c:761: warning: implicit declaration of function
`isapnp_find_dev' sound/oss/sb_card.c:761: warning: assignment makes
pointer from integer without a cast
sound/oss/sb_card.c:764: structure has no member named `prepare'
sound/oss/sb_card.c:791: warning: assignment makes pointer from integer
without a cast
sound/oss/sb_card.c:792: structure has no member named `prepare'
sound/oss/sb_card.c:821: warning: assignment makes pointer from integer
without a cast
sound/oss/sb_card.c:823: structure has no member named `prepare'
sound/oss/sb_card.c: In function `sb_isapnp_probe':
sound/oss/sb_card.c:893: warning: implicit declaration of function
`isapnp_find_card'
sound/oss/sb_card.c:896: warning: assignment makes pointer from integer
without a cast
sound/oss/sb_card.c: In function `cleanup_sb':
sound/oss/sb_card.c:1007: structure has no member named `deactivate'
sound/oss/sb_card.c:1009: structure has no member named `deactivate'
sound/oss/sb_card.c:1011: structure has no member named `deactivate'
make[2]: *** [sound/oss/sb_card.o] Error 1
make[1]: *** [sound/oss] Error 2
make: *** [sound] Error 2


