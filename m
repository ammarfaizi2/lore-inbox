Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264689AbSIWBzb>; Sun, 22 Sep 2002 21:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264701AbSIWBzb>; Sun, 22 Sep 2002 21:55:31 -0400
Received: from spy.suspicious.org ([64.6.188.66]:62327 "EHLO
	spy.suspicious.org") by vger.kernel.org with ESMTP
	id <S264689AbSIWBza>; Sun, 22 Sep 2002 21:55:30 -0400
Date: Sun, 22 Sep 2002 22:20:29 -0500
From: phil <phil@research.suspicious.org>
To: linux-kernel@vger.kernel.org
Subject: tridentfb.c, kernel 2.5.38, compile error
Message-Id: <20020922222029.54ae9967.phil@research.suspicious.org>
Organization: research.suspicious.org
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this happens on compile:

gcc -Wp,-MD,./.tridentfb.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -I/usr/src/linux/arch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=tridentfb   -c -o tridentfb.o tridentfb.c
tridentfb.c:64: field `gen' has incomplete type
tridentfb.c: In function `trident_set_disp':
tridentfb.c:1054: dereferencing pointer to incomplete type
tridentfb.c: At top level:
tridentfb.c:1086: variable `trident_hwswitch' has initializer but incomplete type
tridentfb.c:1087: warning: excess elements in struct initializer
tridentfb.c:1087: warning: (near initialization for `trident_hwswitch')
tridentfb.c:1088: warning: excess elements in struct initializer
tridentfb.c:1088: warning: (near initialization for `trident_hwswitch')
tridentfb.c:1089: warning: excess elements in struct initializer
tridentfb.c:1089: warning: (near initialization for `trident_hwswitch')
tridentfb.c:1090: warning: excess elements in struct initializer
tridentfb.c:1090: warning: (near initialization for `trident_hwswitch')
tridentfb.c:1091: warning: excess elements in struct initializer
tridentfb.c:1091: warning: (near initialization for `trident_hwswitch')
tridentfb.c:1092: warning: excess elements in struct initializer
tridentfb.c:1092: warning: (near initialization for `trident_hwswitch')
tridentfb.c:1093: warning: excess elements in struct initializer
tridentfb.c:1093: warning: (near initialization for `trident_hwswitch')
tridentfb.c:1094: warning: excess elements in struct initializer
tridentfb.c:1094: warning: (near initialization for `trident_hwswitch')
tridentfb.c:1095: warning: excess elements in struct initializer
tridentfb.c:1095: warning: (near initialization for `trident_hwswitch')
tridentfb.c:1097: warning: excess elements in struct initializer
tridentfb.c:1097: warning: (near initialization for `trident_hwswitch')
tridentfb.c: In function `tridentfb_init':
tridentfb.c:1204: `fbgen_switch' undeclared (first use in this function)
tridentfb.c:1204: (Each undeclared identifier is reported only once
tridentfb.c:1204: for each function it appears in.)
tridentfb.c:1205: `fbgen_update_var' undeclared (first use in this function)
tridentfb.c:1228: warning: implicit declaration of function `fbgen_get_var'
tridentfb.c:1230: warning: implicit declaration of function `fbgen_set_disp'
tridentfb.c: At top level:
tridentfb.c:1289: unknown field `fb_get_fix' specified in initializer
tridentfb.c:1289: `fbgen_get_fix' undeclared here (not in a function)
tridentfb.c:1289: initializer element is not constant
tridentfb.c:1289: (near initialization for `tridentfb_ops.owner')
tridentfb.c:1290: unknown field `fb_get_var' specified in initializer
tridentfb.c:1290: `fbgen_get_var' undeclared here (not in a function)
tridentfb.c:1290: initializer element is not constant
tridentfb.c:1290: (near initialization for `tridentfb_ops.fb_open')
tridentfb.c:1291: `fbgen_set_var' undeclared here (not in a function)
tridentfb.c:1291: initializer element is not constant
tridentfb.c:1291: (near initialization for `tridentfb_ops.fb_set_var')
tridentfb.c:1292: `fbgen_get_cmap' undeclared here (not in a function)
tridentfb.c:1292: initializer element is not constant
tridentfb.c:1292: (near initialization for `tridentfb_ops.fb_get_cmap')
tridentfb.c:1293: `fbgen_set_cmap' undeclared here (not in a function)
tridentfb.c:1293: initializer element is not constant
tridentfb.c:1293: (near initialization for `tridentfb_ops.fb_set_cmap')
tridentfb.c:1295: `fbgen_pan_display' undeclared here (not in a function)
tridentfb.c:1295: initializer element is not constant
tridentfb.c:1295: (near initialization for `tridentfb_ops.fb_pan_display')
tridentfb.c:1296: initializer element is not constant
tridentfb.c:1296: (near initialization for `tridentfb_ops')
tridentfb.c:1296: initializer element is not constant
tridentfb.c:1296: (near initialization for `tridentfb_ops')
tridentfb.c:1296: initializer element is not constant
tridentfb.c:1296: (near initialization for `tridentfb_ops')
tridentfb.c:1296: initializer element is not constant
tridentfb.c:1296: (near initialization for `tridentfb_ops')
make[2]: *** [tridentfb.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/video'
make[1]: *** [video] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [drivers] Error 2


