Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273819AbRIRDbh>; Mon, 17 Sep 2001 23:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273820AbRIRDb1>; Mon, 17 Sep 2001 23:31:27 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:52229 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273819AbRIRDbW>; Mon, 17 Sep 2001 23:31:22 -0400
Date: Mon, 17 Sep 2001 23:07:20 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>
Subject: 2.4.10-pre11 VM testing
Message-ID: <Pine.LNX.4.21.0109172303550.7032-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

2GB machine, lots of swap free, running "fillmem 2000" (2GB) from memtest
gives me:

Sep 18 00:25:13 matrix kernel: __alloc_pages: 0-order allocation failed
(gfp=0x1d2/0) from c012c3be
Sep 18 00:25:13 matrix kernel: VM: killing process setiathome
Sep 18 00:25:17 matrix PAM_pwdb[1012]: (su) session opened for user root
by marcelo(uid=719)
Sep 18 00:25:53 matrix kernel: __alloc_pages: 0-order allocation failed
(gfp=0x1d2/0) from c012c3be
Sep 18 00:25:53 matrix kernel: VM: killing process setiathome
Sep 18 00:25:57 matrix kernel: __alloc_pages: 0-order allocation failed
(gfp=0x1d2/0) from c012c3be
Sep 18 00:25:57 matrix kernel: VM: killing process cat
Sep 18 00:26:00 matrix kernel: __alloc_pages: 0-order allocation failed
(gfp=0x1d2/0) from c012c3be
Sep 18 00:26:05 matrix kernel: __alloc_pages: 0-order allocation failed
(gfp=0x1d2/0) from c012c3be
Sep 18 00:26:05 matrix kernel: VM: killing process sh
Sep 18 00:26:38 matrix kernel: __alloc_pages: 0-order allocation failed
(gfp=0x1d2/0) from c012c3be

	total:    used:    free:  shared: buffers:  cached:
Mem:  2061881344 2058424320  3457024        0   139264  3448832
Swap: 2632036352  7020544 2625015808
MemTotal:      2013556 kB
MemFree:          3376 kB
MemShared:           0 kB
Buffers:           136 kB
Cached:           2808 kB
SwapCached:        560 kB
Active:           2588 kB
Inactive:          916 kB
HighTotal:     1130496 kB
HighFree:         1024 kB
LowTotal:       883060 kB
LowFree:          2352 kB
SwapTotal:     2570348 kB
SwapFree:      2563492 kB



Complete lockup if I try to test the VM more intensively.

