Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVEACHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVEACHp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 22:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVEACHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 22:07:45 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:19207 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261510AbVEACHM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 22:07:12 -0400
Date: Sun, 01 May 2005 11:09:29 +0900 (JST)
Message-Id: <20050501.110929.34344394.yoshfuji@linux-ipv6.org>
To: juhl-lkml@dif.dk
Cc: acme@ghostprotocols.net, arnaldo.melo@gmail.com, davem@davemloft.net,
       herbert@gondor.apana.org.au, jkmaline@cc.hut.fi,
       jmorris@intercode.com.au, roque@di.fc.ul.pt, kuznet@ms2.inr.ac.ru,
       kunihiro@ipinfusion.com, mk@linux-ipv6.org,
       lksctp-developers@lists.sourceforge.net, andros@umich.edu,
       bfields@umich.edu, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH 4/4] resource release cleanup in net/ (take 2)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.LNX.4.62.0505010352210.2094@dragon.hyggekrogen.localhost>
References: <39e6f6c705043014264eb4c0c5@mail.gmail.com>
	<Pine.LNX.4.62.0505010341560.2094@dragon.hyggekrogen.localhost>
	<Pine.LNX.4.62.0505010352210.2094@dragon.hyggekrogen.localhost>
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

Hello.

In article <Pine.LNX.4.62.0505010352210.2094@dragon.hyggekrogen.localhost> (at Sun, 1 May 2005 03:55:37 +0200 (CEST)), Jesper Juhl <juhl-lkml@dif.dk> says:

> > 	4) whitespace changes
:

Please add me cc: next time...

>--- linux-2.6.12-rc3-mm1/net/ipv6/ah6.c.old3	2005-05-01 03:24:09.000000000 +0200
>+++ linux-2.6.12-rc3-mm1/net/ipv6/ah6.c	2005-05-01 03:24:20.000000000 +0200
>@@ -305,6 +305,7 @@
> 	skb_pull(skb, hdr_len);
> 	skb->h.raw = skb->data;
> 
>+
> 	kfree(tmp_hdr);
> 
> 	return nexthdr;

Why?

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
Homepage: http://www.yoshifuji.org/~hideaki/
GPG FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
