Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264452AbTK0IdY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 03:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264453AbTK0IdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 03:33:24 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:28166 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S264452AbTK0IdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 03:33:20 -0500
Date: Thu, 27 Nov 2003 17:33:20 +0900 (JST)
Message-Id: <20031127.173320.19253188.yoshfuji@linux-ipv6.org>
To: felipe_alfaro@linuxmail.org
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH 2.6]: IPv6: strcpy -> strlcpy
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <1069920883.2476.1.camel@teapot.felipe-alfaro.com>
References: <1069920883.2476.1.camel@teapot.felipe-alfaro.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1069920883.2476.1.camel@teapot.felipe-alfaro.com> (at Thu, 27 Nov 2003 09:14:44 +0100), Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> says:

> Attached is a patch against 2.6.0-test11 to convert all strcpy() calls
> to their corresponding strlcpy() for IPv6. Compiled and tested.

I don't like this coding style.

diff -uNr linux-2.6.0-test11.orig/net/ipv6/ip6_tunnel.c linux-2.6.0-test11/net/ipv6/ip6_tunnel.c
--- linux-2.6.0-test11.orig/net/ipv6/ip6_tunnel.c	2003-11-26 21:42:56.000000000 +0100
+++ linux-2.6.0-test11/net/ipv6/ip6_tunnel.c	2003-11-27 00:27:09.000000000 +0100
-	strcpy(t->parms.name, dev->name);
+	strlcpy(t->parms.name, dev->name, IFNAMSIZ);
                                          sizeof(t->parms.name)

or something like that.

--yoshfuji
