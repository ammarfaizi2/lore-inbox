Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130760AbQKQTbQ>; Fri, 17 Nov 2000 14:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130891AbQKQTbG>; Fri, 17 Nov 2000 14:31:06 -0500
Received: from sunik.pagi.pl ([212.69.64.193]:457 "EHLO sunik.pagi.pl")
	by vger.kernel.org with ESMTP id <S130886AbQKQTax>;
	Fri, 17 Nov 2000 14:30:53 -0500
Date: Fri, 17 Nov 2000 20:05:56 +0100 (CET)
From: Cezary Kaliszyk <kaliszyk@pagi.pl>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: BUG with no HOTPLUG set.
Message-ID: <Pine.Lnx.4.21.0011171951530.1303-100000@orka.wrzos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to compile 2.4.0test11pre6 without HOTPLUG make says:

gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686    -c -o dev.o dev.c
dev.c: In function `run_sbin_hotplug':
dev.c:2736: `hotplug_path' undeclared (first use in this function)
dev.c:2736: (Each undeclared identifier is reported only once
dev.c:2736: for each function it appears in.)
make[3]: *** [dev.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4/net/core'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4/net/core'
make[1]: *** [_subdir_core] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4/net'
make: *** [_dir_net] Error 2

It looks like /net/core/dev.c should add functions like run_sbin_hotplug
only if CONFIG_HOTPLUG is set.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
