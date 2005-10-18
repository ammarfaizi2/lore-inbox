Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbVJRQWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbVJRQWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 12:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbVJRQWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 12:22:06 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:18445 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1750963AbVJRQWD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 12:22:03 -0400
Date: Wed, 19 Oct 2005 01:21:57 +0900 (JST)
Message-Id: <20051019.012157.11460212.yoshfuji@linux-ipv6.org>
To: yanzheng@21cn.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [BUG]NULL pointer dereference in ipv6_get_saddr()
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <435512F5.1040502@21cn.com>
References: <435512F5.1040502@21cn.com>
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

In article <435512F5.1040502@21cn.com> (at Tue, 18 Oct 2005 23:21:25 +0800), Yan Zheng <yanzheng@21cn.com> says:

> When I use command "ip -f inet6 route get fec0::1", kernel Oops occurs.
> I found it's due to ip_route_output return address of ip6_null_entry, ip6_null_entry.rt6i_idev is NULL.

I think this is already fixed in head.
I don't remember if we pushed this to stable...

--yoshfuji
