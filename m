Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269440AbTGJPme (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 11:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269415AbTGJPlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 11:41:11 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:18182 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S269400AbTGJPjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 11:39:35 -0400
Date: Fri, 11 Jul 2003 00:55:42 +0900 (JST)
Message-Id: <20030711.005542.04973601.yoshfuji@linux-ipv6.org>
To: cat@zip.com.au
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, pekkas@netcore.fi
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030710154302.GE1722@zip.com.au>
References: <20030710154302.GE1722@zip.com.au>
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

In article <20030710154302.GE1722@zip.com.au> (at Fri, 11 Jul 2003 01:43:03 +1000), CaT <cat@zip.com.au> says:

> With 2.4.21-pre2 I can get a nice tunnel going over my ppp connection
> and as such get ipv6 connectivity. I think went to 2.4.21 and then to
> 2.4.22-pre4 and bringing up the tunnel fails as follows:
:
> ip addr add 3ffe:8001:000c:ffff::37/127 dev sit1
>  ip route add ::/0 via 3ffe:8001:000c:ffff::36 
> RTNETLINK answers: Invalid argument

This is not bug, but rather misconfiguration;
you cannot use prefix::, which is mandatory subnet routers 
anycast address, as unicast address.

Thank you.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
