Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131426AbRC0Qwx>; Tue, 27 Mar 2001 11:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131446AbRC0Qwd>; Tue, 27 Mar 2001 11:52:33 -0500
Received: from dexter.allieddomecq.ro ([212.93.128.30]:34564 "HELO
	mail.allieddomecq.ro") by vger.kernel.org with SMTP
	id <S131426AbRC0Qwa>; Tue, 27 Mar 2001 11:52:30 -0500
Date: Tue, 27 Mar 2001 19:53:18 +0300 (EEST)
From: Robert-Velisav MICIOVICI <roby@dexter.allieddomecq.ro>
To: linux-kernel@vger.kernel.org
Subject: 2.4.3-pre8: IPX not building
Message-ID: <Pine.LNX.4.21md.0103271844240.5513-100000@dexter.allieddomecq.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Just a build problem report.


gcc -D__KERNEL__ -I/usr/src/linux-2.4.3-pre8/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer
-fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
-march=athlon  -DMODULE -DMODVERSIONS -include
/usr/src/linux-2.4.3-pre8/include/linux/modversions.h   -c -o
ip6table_mangle.o ip6table_mangle.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.3-pre8/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer
-fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
-march=athlon  -DMODULE -DMODVERSIONS -include
/usr/src/linux-2.4.3-pre8/include/linux/modversions.h   -c -o
ip6t_MARK.o ip6t_MARK.c
make[2]: Leaving directory /usr/src/linux-2.4.3-pre8/net/ipv6/netfilter'
make -C ipx modules
make[2]: Entering directory /usr/src/linux-2.4.3-pre8/net/ipx'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.3-pre8/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer
-fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
-march=athlon  -DMODULE -DMODVERSIONS -include
/usr/src/linux-2.4.3-pre8/include/linux/modversions.h   -DEXPORT_SYMTAB
-c af_ipx.c
af_ipx.c: In function   pxrtr_route_packet':
af_ipx.c:1545: warning: passing arg 4 of `sock_alloc_send_skb_R7094cf19'
makes integer from pointer without a cast
af_ipx.c:1545: too few arguments to function
`sock_alloc_send_skb_R7094cf19'
af_ipx.c: At top level:
af_ipx.c:2534: unknown field `sendpage' specified in initializer
af_ipx.c:2534: `sock_no_sendpage' undeclared here (not in a function)
af_ipx.c:2534: warning: excess elements in struct initializer
af_ipx.c:2534: warning: (near initialization for        px_dgram_ops')
make[2]: *** [af_ipx.o] Error 1
make[2]: Leaving directory /usr/src/linux-2.4.3-pre8/net/ipx'
make[1]: *** [_modsubdir_ipx] Error 2
make[1]: Leaving directory /usr/src/linux-2.4.3-pre8/net'
make: *** [_mod_net] Error 2
[root@bigfoot linux-2.4.3-pre8]#




Best regards to you kernel-wizzards!


