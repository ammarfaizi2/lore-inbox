Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280938AbRKYRXB>; Sun, 25 Nov 2001 12:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280951AbRKYRWv>; Sun, 25 Nov 2001 12:22:51 -0500
Received: from ns1.cfcc.cc.fl.us ([150.176.253.67]:27836 "EHLO
	ns1.cfcc.cc.fl.us") by vger.kernel.org with ESMTP
	id <S280938AbRKYRWi>; Sun, 25 Nov 2001 12:22:38 -0500
Date: Sun, 25 Nov 2001 12:16:42 -0500
From: Mike Bennett <mbennett@ns1.cfcc.cc.fl.us>
To: linux-kernel@vger.kernel.org
Subject: 2.4.16pre1 build fails in ipv4
Message-ID: <20011125121641.A7092@cfcc.cc.fl.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried a couple times now, with the last attempt being a
complete untar 2.4.15, apply .16pre1 patch from scratch. Each
build results in the following error. Is anyone else seeing
this, or have a patch for it?  Thanks!!

make[3]: Entering directory
`/usr/local/src/linux-2.4.16pre1/net/ipv4'
gcc -D__KERNEL__ -I/usr/local/src/linux-2.4.16pre1/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=i686    -c -o utils.o
utils.c
gcc -D__KERNEL__ -I/usr/local/src/linux-2.4.16pre1/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=i686    -c -o route.o
route.c
route.c: In function `ip_route_input_slow':
route.c:1382: structure has no member named `r'
route.c:1383: warning: implicit declaration of function
`fib_rules_policy'
route.c:1386: warning: implicit declaration of function
`fib_rules_map_destination'
make[3]: *** [route.o] Error 1
make[3]: Leaving directory
`/usr/local/src/linux-2.4.16pre1/net/ipv4'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory
`/usr/local/src/linux-2.4.16pre1/net/ipv4'
make[1]: *** [_subdir_ipv4] Error 2
make[1]: Leaving directory
`/usr/local/src/linux-2.4.16pre1/net'
make: *** [_dir_net] Error 2
Exit 2

