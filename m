Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262903AbVBEKvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbVBEKvF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 05:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbVBEKvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 05:51:04 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:4622 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S266621AbVBEKtn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 05:49:43 -0500
Date: Sat, 05 Feb 2005 19:50:39 +0900 (JST)
Message-Id: <20050205.195039.05988480.yoshfuji@linux-ipv6.org>
To: herbert@gondor.apana.org.au
Cc: davem@davemloft.net, mirko.parthey@informatik.tu-chemnitz.de,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, shemminger@osdl.org,
       yoshfuji@linux-ipv6.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20050205064643.GA29758@gondor.apana.org.au>
References: <20050205061110.GA18275@gondor.apana.org.au>
	<20050204221344.247548cb.davem@davemloft.net>
	<20050205064643.GA29758@gondor.apana.org.au>
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

In article <20050205064643.GA29758@gondor.apana.org.au> (at Sat, 5 Feb 2005 17:46:43 +1100), Herbert Xu <herbert@gondor.apana.org.au> says:

> If we wanted to preserve the split device semantics, then we
> can create a local GC list in IPv6 so that it can search based
> on rt6i_idev as well as the other keys.  Alternatively we can
> remove the dst->dev == dev check in dst_dev_event and dst_ifdown
> and move that test down to the individual ifdown functions.

Yes, IPv6 needs "split device" semantics
(for per-device statistics such as Ip6InDelivers etc),
and I like later solution.

Thanks.

--yoshfuji
