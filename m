Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266443AbUFQKNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266443AbUFQKNR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 06:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266444AbUFQKNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 06:13:17 -0400
Received: from [203.178.140.15] ([203.178.140.15]:28677 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S266443AbUFQKM7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 06:12:59 -0400
Date: Thu, 17 Jun 2004 19:13:56 +0900 (JST)
Message-Id: <20040617.191356.62693754.yoshfuji@linux-ipv6.org>
To: geert@linux-m68k.org, davem@redhat.com
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, yoshfuji@linux-ipv6.org
Subject: Re: ip6_tables warning
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.GSO.4.58.0406171139020.22919@waterleaf.sonytel.be>
References: <20040616183343.GA9940@logos.cnet>
	<Pine.GSO.4.58.0406171139020.22919@waterleaf.sonytel.be>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.58.0406171139020.22919@waterleaf.sonytel.be> (at Thu, 17 Jun 2004 12:06:17 +0200 (MEST)), Geert Uytterhoeven <geert@linux-m68k.org> says:

> This is not a new problem, but I never bothered to report it before:
> 
> | ip6_tables.c: In function `tcp_match':
> | ip6_tables.c:1596: warning: implicit declaration of function `ipv6_skip_exthdr'
> It needs to include <net/ipv6.h> to kill the warning.

Here it is.

===== net/ipv6/netfilter/ip6_tables.c 1.17 vs edited =====
--- 1.17/net/ipv6/netfilter/ip6_tables.c	2004-06-07 12:13:18 +09:00
+++ edited/net/ipv6/netfilter/ip6_tables.c	2004-06-17 19:11:08 +09:00
@@ -20,6 +20,7 @@
 #include <linux/udp.h>
 #include <linux/icmpv6.h>
 #include <net/ip.h>
+#include <net/ipv6.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 #include <linux/proc_fs.h>

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
