Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbTBXHTO>; Mon, 24 Feb 2003 02:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbTBXHTO>; Mon, 24 Feb 2003 02:19:14 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:3084 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S261173AbTBXHTN>; Mon, 24 Feb 2003 02:19:13 -0500
Date: Mon, 24 Feb 2003 16:29:11 +0900 (JST)
Message-Id: <20030224.162911.826686204.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, kuznet@ms2.inr.ac.ru,
       usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Functions Clean-up
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030224.161815.511623971.yoshfuji@linux-ipv6.org>
References: <20030224.125702.13403857.yoshfuji@linux-ipv6.org>
	<20030223.225426.28829614.davem@redhat.com>
	<20030224.161815.511623971.yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030224.161815.511623971.yoshfuji@linux-ipv6.org> (at Mon, 24 Feb 2003 16:18:15 +0900 (JST)), YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> says:

> In article <20030223.225426.28829614.davem@redhat.com> (at Sun, 23 Feb 2003 22:54:26 -0800 (PST)), "David S. Miller" <davem@redhat.com> says:
> 
> > Hideaki-san, do you try to compile the patches you send
> > to me?  :-)
> 
> sorry, I had compiled with wrong options... :-p
> just a moment, please...

Please apply this patch on top of the previous patch.
Sorry for the mess.

Index: net/ipv6/route.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/route.c,v
retrieving revision 1.1.1.6.12.1
retrieving revision 1.1.1.6.12.2
diff -u -r1.1.1.6.12.1 -r1.1.1.6.12.2
--- net/ipv6/route.c	23 Feb 2003 17:40:42 -0000	1.1.1.6.12.1
+++ net/ipv6/route.c	24 Feb 2003 07:10:02 -0000	1.1.1.6.12.2
@@ -580,7 +580,7 @@
 	int b = plen&0x7;
 	int o = plen>>3;
 
-	memcpy(prefix, addr, o);
+	memcpy(pfx, addr, o);
 	if (o < 16)
 		memset(pfx->s6_addr + o, 0, 16 - o);
 	if (b != 0)

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
