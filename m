Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281214AbRKTSV5>; Tue, 20 Nov 2001 13:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281201AbRKTSVr>; Tue, 20 Nov 2001 13:21:47 -0500
Received: from mailb.telia.com ([194.22.194.6]:28690 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S281214AbRKTSVg>;
	Tue, 20 Nov 2001 13:21:36 -0500
Message-ID: <3BFA9F2D.98FB7F72@student.uu.se>
Date: Tue, 20 Nov 2001 19:21:33 +0100
From: Erik Jansson <erja9907@student.uu.se>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Compile problem in vmalloc.h
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I've looked and asked around for a while about this, but I can't seem to
find the answer. Maybe you know what's up.

I'm compiling a driver that's not part of the kernel tree (but it's GPL
anyway). It compiles nicely against the 2.4.8 kernel tree, but fails
with both 2.4.10 and 2.4.14. Those are the only ones that I've tried
though.

I'm using clean sources (nothing patched, make mrproper; make clean;
make config; make bzImage etc).

I'm using gcc version 2.95.4 20010902 (Debian prerelease).

The error I get looks like this:

gcc -c -o ./src/proc.o ./src/proc.c -D__KERNEL__ -DMODULE -O2 -Wall
-Wstrict-pro
totypes -Wpointer-arith -I /usr/src/linux/include  -DCAN_DEBUG
In file included from /usr/src/linux/include/asm/io.h:46,
                 from src/../include/main.h:11,
                 from ./src/proc.c:25:
/usr/src/linux/include/linux/vmalloc.h: In function `vmalloc':
/usr/src/linux/include/linux/vmalloc.h:35: `boot_cpu_data_Rsmp_0657d037'
undecla
red (first use in this function)
/usr/src/linux/include/linux/vmalloc.h:35: (Each undeclared identifier
is report
ed only once
/usr/src/linux/include/linux/vmalloc.h:35: for each function it appears
in.)
/usr/src/linux/include/linux/vmalloc.h: In function `vmalloc_dma':
/usr/src/linux/include/linux/vmalloc.h:44: `boot_cpu_data_Rsmp_0657d037'
undecla
red (first use in this function)
/usr/src/linux/include/linux/vmalloc.h: In function `vmalloc_32':
/usr/src/linux/include/linux/vmalloc.h:53: `boot_cpu_data_Rsmp_0657d037'
undecla
red (first use in this function)
make: *** [proc.o] Error 1

/Erik
