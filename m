Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265332AbSJXHRn>; Thu, 24 Oct 2002 03:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265333AbSJXHRn>; Thu, 24 Oct 2002 03:17:43 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:39180 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S265332AbSJXHRm>; Thu, 24 Oct 2002 03:17:42 -0400
Date: Thu, 24 Oct 2002 16:23:55 +0900 (JST)
Message-Id: <20021024.162355.127875447.yoshfuji@linux-ipv6.org>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
CC: pekkas@netcore.fi, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Sysctl for ICMPv6 Rate Limitation
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.LNX.4.44.0210240858060.8872-100000@netcore.fi>
References: <20021024.145551.130454003.yoshfuji@linux-ipv6.org>
	<Pine.LNX.4.44.0210240858060.8872-100000@netcore.fi>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0210240858060.8872-100000@netcore.fi> (at Thu, 24 Oct 2002 08:59:16 +0300 (EEST)), Pekka Savola <pekkas@netcore.fi> says:

> > > Does this rate-limit all ICMPv6 packets or just ICMPv6 error messages (as 
> > > specified in ICMPv6 specifications).
> > > 
> > > If all, I believe the default of rate-limiting everything is unacceptable.
> > 
> > This patch just adds sysctl.  It is my documentation error...
> > is s/ICMPv6 packets/ICMPv6 error packets/ ok?
> > 
> > (I need to do s/100/HZ/, too; This also lives in ICMP(v4)).
> 
> That change fine with me, thanks.

Please apply the following patch on top of the previous 
"Sysctl for ICMPv6 Rate Limitation" patch.  Thanks.

Index: Documentation/networking/ip-sysctl.txt
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/Documentation/networking/ip-sysctl.txt,v
retrieving revision 1.1.1.1.44.1
retrieving revision 1.1.1.1.44.1.2.2
diff -u -r1.1.1.1.44.1 -r1.1.1.1.44.1.2.2
--- Documentation/networking/ip-sysctl.txt	23 Oct 2002 17:50:19 -0000	1.1.1.1.44.1
+++ Documentation/networking/ip-sysctl.txt	24 Oct 2002 07:03:46 -0000	1.1.1.1.44.1.2.2
@@ -316,7 +316,7 @@
 	Limit the maximal rates for sending ICMP packets whose type matches
 	icmp_ratemask (see below) to specific targets.
 	0 to disable any limiting, otherwise the maximal rate in jiffies(1)
-	Default: 100
+	Default: HZ
 
 icmp_ratemask - INTEGER
 	Mask made of ICMP types for which rates are being limited.
@@ -562,9 +562,9 @@
 
 icmp/*:
 ratelimit - INTEGER
-	Limit the maximal rates for sending ICMPv6 packets.
+	Limit the maximal rates for sending ICMPv6 error packets.
 	0 to disable any limiting, otherwise the maximal rate in jiffies(1)
-	Default: 100
+	Default: HZ
 
 IPv6 Update by:
 Pekka Savola <pekkas@netcore.fi>

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
