Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130332AbQKGAVg>; Mon, 6 Nov 2000 19:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129600AbQKGAV2>; Mon, 6 Nov 2000 19:21:28 -0500
Received: from crds.chemie.unibas.ch ([131.152.105.107]:62983 "EHLO
	crds.chemie.unibas.ch") by vger.kernel.org with ESMTP
	id <S130332AbQKGAUu>; Mon, 6 Nov 2000 19:20:50 -0500
Date: Tue, 7 Nov 2000 01:20:36 +0100 (CET)
From: Tomasz Motylewski <motyl@stan.chemie.unibas.ch>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: ide-probe.c:400: `rtc_lock' undeclared and /lib/modules/..../build
Message-ID: <Pine.LNX.4.21.0011070059120.24007-100000@crds.chemie.unibas.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.2.18pre19:

/usr/bin/gcc272 -D__KERNEL__ -I/home/22/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer  -D__SMP__ -pipe
-fno-strength-reduce -m486 -malign-loops=2 -malign-jumps=2
-malign-functions=2 -DCPU=586   -c -o fork.o fork.c
ide-probe.c: In function `probe_cmos_for_drives':
ide-probe.c:400: `rtc_lock' undeclared (first use this function)
ide-probe.c:400: (Each undeclared identifier is reported only once
ide-probe.c:400: for each function it appears in.)


And , whose idea was that "make modules_install" should create
/lib/modules/..../build symlink to the kernel sources?
It really breakes depmod -a (modutils 2.3.11)(*)

Best regards,
--
Tomasz Motylewski

(*) I could find a workaround, but if it hits me, it will hit lots of other
people not reading linux-kernel regularly. In my opinion upgrading stable
kernels should work without any modifications to the existing system.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
