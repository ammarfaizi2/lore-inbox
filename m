Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129552AbQKUQe6>; Tue, 21 Nov 2000 11:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129835AbQKUQes>; Tue, 21 Nov 2000 11:34:48 -0500
Received: from sparrow.ists.dartmouth.edu ([129.170.249.49]:36743 "EHLO
	sparrow.websense.net") by vger.kernel.org with ESMTP
	id <S129625AbQKUQem>; Tue, 21 Nov 2000 11:34:42 -0500
Date: Tue, 21 Nov 2000 11:03:06 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
To: "Cox, Alan -- Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        Alan Cox <alan@redhat.com>
cc: ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: CC=kgcc incomplete in 2.4.0-test11-ac1
Message-ID: <Pine.LNX.4.30.0011211058200.1207-100000@sparrow.websense.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, Alan,
	A kernel build with your latest prepatch still seems to use gcc
to compile some of the auxiliary tools:

gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o scripts/mkdep scripts/mkdep.c
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer gentbl.c -o gentbl -lm
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o scripts/split-include scripts/split-include.c
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o conmakehash conmakehash.c
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o gen-devlist gen-devlist.c
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o tools/build tools/build.c -I/usr/src/linux-2.4.0/include

	Do any of the above tools need to use kgcc as well, or is gcc
likely to work just fine?
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"Nynex.  Iroquois for Moron"
	-- A well-known Linux kernel hacker.
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, named2hosts,
and ipfwadm2ipchains are at:                http://www.pobox.com/~wstearns
LinuxMonth; articles for Linux Enthusiasts! http://www.linuxmonth.com
--------------------------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
