Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132616AbRC1Xhe>; Wed, 28 Mar 2001 18:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132615AbRC1XhS>; Wed, 28 Mar 2001 18:37:18 -0500
Received: from mailo.vtcif.telstra.com.au ([202.12.144.17]:60642 "EHLO
	mailo.vtcif.telstra.com.au") by vger.kernel.org with ESMTP
	id <S132608AbRC1XhI>; Wed, 28 Mar 2001 18:37:08 -0500
From: Allan Duncan <b372050@vus068.trl.telstra.com.au>
Message-Id: <200103282334.JAA14009@vus068.trl.telstra.com.au>
Subject: 2.4.3-pre8 fails with IPX module
To: linux-kernel@vger.kernel.org
Date: Thu, 29 Mar 101 09:34:41 +1000 (EST)
X-Mailer: ELM [version 2.4 PL23]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have tried a compile of the latest test release, and it breaks on the
IPX bits.  Pre7 was OK.  I've got modutils 2.4.2, so it isn't that.
Here is the compile log:

make -C ipx modules
make[2]: Entering directory `/usr/src/lx-2.4.3p8/net/ipx'
gcc -D__KERNEL__ -I/usr/src/lx-2.4.3p8/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE   -DEXPORT_SYMTAB -c af_ipx.c
af_ipx.c: In function `ipxrtr_route_packet':
af_ipx.c:1545: warning: passing arg 4 of `sock_alloc_send_skb' makes integer from pointer without a cast
af_ipx.c:1545: too few arguments to function `sock_alloc_send_skb'
af_ipx.c: At top level:
af_ipx.c:2534: unknown field `sendpage' specified in initializer
af_ipx.c:2534: `sock_no_sendpage' undeclared here (not in a function)
af_ipx.c:2534: warning: excess elements in struct initializer
af_ipx.c:2534: warning: (near initialization for `ipx_dgram_ops')
make[2]: *** [af_ipx.o] Error 1
make[2]: Leaving directory `/usr/src/lx-2.4.3p8/net/ipx'
make[1]: *** [_modsubdir_ipx] Error 2
make[1]: Leaving directory `/usr/src/lx-2.4.3p8/net'
make: *** [_mod_net] Error 2


For any queries mail to allan.d@bigpond.com - I could handle a digest but
the list is too busy.

-- 
Allan Duncan  b372050@vus068.trl.telstra.com.au  (+613) 9253 6708, Fax 9253 6775
