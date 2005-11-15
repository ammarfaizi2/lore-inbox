Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbVKOBWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbVKOBWO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 20:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbVKOBWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 20:22:14 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:21259 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1751320AbVKOBWN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 20:22:13 -0500
Date: Tue, 15 Nov 2005 10:22:37 +0900 (JST)
Message-Id: <20051115.102237.101993116.yoshfuji@linux-ipv6.org>
To: yanzheng@21cn.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH]IPv6: small fix for ipv6_dev_get_saddr(...)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <43786A16.9070100@21cn.com>
References: <43786A16.9070100@21cn.com>
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

In article <43786A16.9070100@21cn.com> (at Mon, 14 Nov 2005 18:42:30 +0800), Yan Zheng <yanzheng@21cn.com> says:

> The "score.rule++" doesn't make any sense for me. 
> According to codes above, I think it should be "hiscore.rule++;" .

Oops, you're right.

> Signed-off-by: Yan Zheng<yanzheng@21cn.com>
Acked-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

>  			/* Rule 8: Use longest matching prefix */
> -			if (hiscore.rule < 8)
> +			if (hiscore.rule < 8) {
>  				hiscore.matchlen = ipv6_addr_diff(&ifa_result->addr, daddr);
> -			score.rule++;
> +				hiscore.rule++;
> +			}
>  			score.matchlen = ipv6_addr_diff(&ifa->addr, daddr);
>  			if (score.matchlen > hiscore.matchlen) {
>  				score.rule = 8;
> 

-- 
YOSHIFUJI Hideaki @ USAGI Project  <yoshfuji@linux-ipv6.org>
GPG-FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
