Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbVJUI1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbVJUI1M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 04:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVJUI1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 04:27:11 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:49168 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S932556AbVJUI1L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 04:27:11 -0400
Date: Fri, 21 Oct 2005 17:27:09 +0900 (JST)
Message-Id: <20051021.172709.47930126.yoshfuji@linux-ipv6.org>
To: yanzheng@21cn.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]behavior of ip6_route_input() for link local address.
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <43572256.40101@21cn.com>
References: <43572256.40101@21cn.com>
Organization: USAGI/WIDE Project
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

Hello.

In article <43572256.40101@21cn.com> (at Thu, 20 Oct 2005 12:51:34 +0800), Yan Zheng <yanzheng@21cn.com> says:

> I find that linux will reply echo request destined to an address which belongs to an interface other than the one from which the request received.
> This behavior doesn't make sense for link local address.

Acked-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

Please note that sender does need to setup neighbor
entry by hand to reproduce this bug.
(Link-local address on eth1 is not visible on eth0,
from the point of view of neighbor discovery in IPv6.)

 +--------+               +--------+
 | sender |               | router |
 +---+----+               +-+----+-+
     |eth0              eth0|    |eth1
-----+----------------------+-  -+--------------

-- 
YOSHIFUJI Hideaki @ USAGI Project  <yoshfuji@linux-ipv6.org>
GPG-FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
