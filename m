Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264529AbUEaEAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264529AbUEaEAv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 00:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUEaEAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 00:00:51 -0400
Received: from [203.178.140.15] ([203.178.140.15]:51206 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S264529AbUEaEAd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 00:00:33 -0400
Date: Mon, 31 May 2004 13:01:06 +0900 (JST)
Message-Id: <20040531.130106.109802314.yoshfuji@linux-ipv6.org>
To: bryan@nerdvest.com
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Linux 2.4.27-pre4
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <40BAA82A.4040105@nerdvest.com>
References: <20040530205602.GA18637@logos.cnet>
	<40BAA82A.4040105@nerdvest.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Mon_May_31_13:01:06_2004_233)--"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Next_Part(Mon_May_31_13:01:06_2004_233)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

In article <40BAA82A.4040105@nerdvest.com> (at Sun, 30 May 2004 22:36:10 -0500), Bryan Andersen <bryan@nerdvest.com> says:

> Error in ipv4 net code, config attached.
> 
> gcc-3.2 -D__KERNEL__ -I/usr/src/linux-2.4.27-pre4/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon
> -nostdinc -iwithprefix include -DKBUILD_BASENAME=tcp_input  -c -o 
> tcp_input.o tcp_input.c
> tcp_input.c: In function `tcp_rcv_space_adjust':
> tcp_input.c:479: structure has no member named `sk_rcvbuf'
> tcp_input.c:480: structure has no member named `sk_rcvbuf'

Thanks. Patch is available. Please try this patch.

--yoshfuji
----Next_Part(Mon_May_31_13:01:06_2004_233)--
Content-Type: Message/Rfc822
Content-Transfer-Encoding: 7bit

Return-Path: <netdev-bounce@oss.sgi.com>
Delivered-To: yoshfuji@yue.st-paulia.net
Received: from sapphire (unknown [203.178.140.14])
	by yue.st-paulia.net (Postfix) with ESMTP id 969D233CE6
	for <yoshfuji@yue.st-paulia.net>; Mon, 31 May 2004 06:57:55 +0900 (JST)
Received: by sapphire (Postfix)
	id 8593E23CFB; Mon, 31 May 2004 06:57:38 +0900 (JST)
Delivered-To: yoshfuji@cerberus.st-paulia.net
Received: from linux6.nezu.wide.ad.jp (linux6.nezu.wide.ad.jp [203.178.142.218])
	by sapphire (Postfix) with ESMTP id E906623CF8
	for <yoshfuji@cerberus.st-paulia.net>; Mon, 31 May 2004 06:57:37 +0900 (JST)
Received: from oss.sgi.com (oss.sgi.com [192.48.159.27])
	by linux6.nezu.wide.ad.jp (8.12.3/8.12.3/Debian-6.6) with ESMTP id i4ULv9a3019999
	for <yoshfuji@linux-ipv6.org>; Mon, 31 May 2004 06:57:09 +0900
Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.10/8.12.9) with ESMTP id i4ULv7gi008621;
	Sun, 30 May 2004 14:57:08 -0700
Received: with ECARTIS (v1.0.0; list netdev); Sun, 30 May 2004 14:55:09 -0700 (PDT)
Received: from aun.it.uu.se (root@aun.it.uu.se [130.238.12.36])
	by oss.sgi.com (8.12.10/8.12.9) with SMTP id i4ULsvgi008164
	for <netdev@oss.sgi.com>; Sun, 30 May 2004 14:54:59 -0700
Received: from harpo.it.uu.se (daemon@harpo.it.uu.se [130.238.12.34])
	by aun.it.uu.se (8.12.11/8.12.10) with ESMTP id i4ULsoWj017720;
	Sun, 30 May 2004 23:54:50 +0200 (MEST)
Received: (from mikpe@localhost)
	by harpo.it.uu.se (8.12.10+Sun/8.12.10) id i4ULso3l014496;
	Sun, 30 May 2004 23:54:50 +0200 (MEST)
Date: Sun, 30 May 2004 23:54:50 +0200 (MEST)
Message-Id: <200405302154.i4ULso3l014496@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com
Subject: [PATCH][2.4.27-pre4] tcp_input.c compile-time error
Cc: davem@redhat.com, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com
X-archive-position: 5484
X-ecartis-version: Ecartis v1.0.0
Sender: netdev-bounce@oss.sgi.com
Errors-To: netdev-bounce@oss.sgi.com
X-original-sender: mikpe@csd.uu.se
Precedence: bulk
X-list: netdev

net/ipv4/tcp_input.c in 2.4.27-pre4 fails to compile:

tcp_input.c: In function `tcp_rcv_space_adjust':
tcp_input.c:479: error: structure has no member named `sk_rcvbuf'
tcp_input.c:480: error: structure has no member named `sk_rcvbuf'
make[3]: *** [tcp_input.o] Error 1

The patch below appears to fix this problem, although some netdev
person should probably check it.

/Mikael

diff -ruN linux-2.4.27-pre4/net/ipv4/tcp_input.c linux-2.4.27-pre4.tcp_input-fix/net/ipv4/tcp_input.c
--- linux-2.4.27-pre4/net/ipv4/tcp_input.c	2004-05-30 23:18:16.000000000 +0200
+++ linux-2.4.27-pre4.tcp_input-fix/net/ipv4/tcp_input.c	2004-05-30 23:45:52.000000000 +0200
@@ -476,8 +476,8 @@
 				  16 + sizeof(struct sk_buff));
 			space *= rcvmem;
 			space = min(space, sysctl_tcp_rmem[2]);
-			if (space > sk->sk_rcvbuf)
-				sk->sk_rcvbuf = space;
+			if (space > sk->rcvbuf)
+				sk->rcvbuf = space;
 		}
 	}
 	


----Next_Part(Mon_May_31_13:01:06_2004_233)----
