Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267163AbTBDJIf>; Tue, 4 Feb 2003 04:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267178AbTBDJIf>; Tue, 4 Feb 2003 04:08:35 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:8974 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S267163AbTBDJIf>; Tue, 4 Feb 2003 04:08:35 -0500
Message-ID: <3E3F857A.5C55A6E3@aitel.hist.no>
Date: Tue, 04 Feb 2003 10:18:50 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.59 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59-mm8 compile error in tcp_ipv6.c
References: <20030203233156.39be7770.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mm8 gave me this error. mm6 didn't have this problem.  _I haven't
looked at mm7.  

  gcc -Wp,-MD,net/ipv6/.tcp_ipv6.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686
-Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=tcp_ipv6 -DKBUILD_MODNAME=ipv6
-c -o net/ipv6/tcp_ipv6.o net/ipv6/tcp_ipv6.c
net/ipv6/tcp_ipv6.c:1750: conflicting types for `tcp_v6_xmit'
net/ipv6/tcp_ipv6.c:63: previous declaration of `tcp_v6_xmit'
make[2]: *** [net/ipv6/tcp_ipv6.o] Error 1
make[1]: *** [net/ipv6] Error 2
make: *** [net] Error 2


Helge Hafting
