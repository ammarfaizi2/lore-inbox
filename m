Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286184AbSAEA4F>; Fri, 4 Jan 2002 19:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286179AbSAEAz4>; Fri, 4 Jan 2002 19:55:56 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:11193 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S286177AbSAEAzm>;
	Fri, 4 Jan 2002 19:55:42 -0500
Date: Sat, 5 Jan 2002 01:51:41 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200201050051.BAA16036@harpo.it.uu.se>
To: axboe@suse.de, torvalds@transmeta.com
Subject: 2.5.2-pre performance degradation on an old 486
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When running 2.5.2-pre7 on my old for-testing-only 486(*),
file-system accesses seem to come in distinct bursts preceded
by lengthy pauses. Overall performance is down quite significantly
compared to 2.4.18pre1 and 2.2.20pre2. To measure it I ran two
simple tests:

Test 1: time to boot the kernel, from hitting enter at the LILO
prompt to getting a login prompt
Test 2: time to "rm -rf" a clean linux-2.4.17 source tree, using
the newly booted kernel (no other access to the tree before that,
so it wasn't cached in any way, and the machine was otherwise idle)

		Test 1		Test 2
2.2.21pre2:	71 sec		 75 sec
2.4.18pre1:	64 sec		 72 sec
2.5.2-pre7:	97 sec		251 sec

I haven't noticed any slowdowns on my other boxes, so I didn't
do any measurements on them. On the 486 it's very very obvious.

/Mikael

(*) 100MHz 486DX4, 28MB ram, no L2 cache, two old and slow IDE disks,
small custom no-nonsense RedHat 7.2, kernels compiled with gcc 2.95.3.
