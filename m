Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263352AbVCKO4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263352AbVCKO4z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 09:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263350AbVCKO4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 09:56:55 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:38160 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S263366AbVCKO4j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 09:56:39 -0500
Date: Fri, 11 Mar 2005 08:58:15 -0600 (CST)
Message-Id: <20050311.085815.100748583.yoshfuji@linux-ipv6.org>
To: cat@zip.com.au
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, pekkas@netcore.fi,
       yoshfuji@linux-ipv6.org
Subject: Re: ipv6 and ipv4 interaction weirdness
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20050311121655.GE14146@zip.com.au>
References: <20050311121655.GE14146@zip.com.au>
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

In article <20050311121655.GE14146@zip.com.au> (at Fri, 11 Mar 2005 23:16:55 +1100), CaT <cat@zip.com.au> says:

> If it bound to :: port 22 then 0.0.0.0:22 would fail.
> 
> On the other hand if I got it to bind to each address individually then
> both ipv4 (2 addresses) and ipv6 (1 address) binds would succeed.
> 
> Maybe I'm just looking at it wrong but shouldn't ipv4 and ipv6 interfere
> with each other?

It is 100% intended, even it is not similar to BSD variants do.

IPv4 and IPv6 share address/port space.
:: and 0.0.0.0 is special "any" address, thus they confict.
::ffff:a.b.c.d and a.b.c.d also conflict.

--yoshfuji
