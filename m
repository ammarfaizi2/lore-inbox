Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269742AbUICTIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269742AbUICTIm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269738AbUICTIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:08:42 -0400
Received: from [203.178.140.15] ([203.178.140.15]:10500 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S269747AbUICTGd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:06:33 -0400
Date: Sat, 04 Sep 2004 04:07:27 +0900 (JST)
Message-Id: <20040904.040727.72671952.yoshfuji@linux-ipv6.org>
To: jeffpc@optonline.net
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH 2.6] watch64: generic variable monitoring system
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200409031319.24863.jeffpc@optonline.net>
References: <200409031307.01240.jeffpc@optonline.net>
	<200409031319.24863.jeffpc@optonline.net>
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

In article <200409031319.24863.jeffpc@optonline.net> (at Fri, 03 Sep 2004 13:19:24 -0400), "Josef 'Jeff' Sipek" <jeffpc@optonline.net> says:

> The watch64 system allows the programmer to specify the approximate interval
> at which he wants his variables checked. If he tries to specify shorter
> interval than the minimum a default value of HZ/10 is used. To minimize
> locking, RCU and seqlock are used. On 64-bit systems, all is optimized away.

I agree with the basic principle; it is very similar to mine.
However, it is too complicated isn't it?
I would do per-"table" registration (instead of per-variable one);
watch64_getval() seems very ugly to me...

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
