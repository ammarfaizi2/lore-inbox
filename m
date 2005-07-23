Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262307AbVGWDFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbVGWDFT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 23:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbVGWDFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 23:05:19 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:5893 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S262307AbVGWDFR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 23:05:17 -0400
Date: Fri, 22 Jul 2005 23:05:59 -0400 (EDT)
Message-Id: <20050722.230559.123762041.yoshfuji@linux-ipv6.org>
To: laforge@netfilter.org
Cc: davem@davemloft.net, johnpol@2ka.mipt.ru,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] 1 Wire drivers illegally overload NETLINK_NFLOG
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20050723125427.GA11177@rama>
References: <20050723125427.GA11177@rama>
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

In article <20050723125427.GA11177@rama> (at Sat, 23 Jul 2005 08:54:27 -0400), Harald Welte <laforge@netfilter.org> says:

> --- a/include/linux/netlink.h
> +++ b/include/linux/netlink.h
> @@ -20,7 +20,7 @@
>  #define NETLINK_IP6_FW		13
>  #define NETLINK_DNRTMSG		14	/* DECnet routing messages */
>  #define NETLINK_KOBJECT_UEVENT	15	/* Kernel messages to userspace */
> -#define NETLINK_TAPBASE		16	/* 16 to 31 are ethertap */
> +#define NETLINK_W1		16	/* 16 to 31 are ethertap */
>  
>  #define MAX_LINKS 32		
>  

Comment says that 16-31 are used for ethertap.
So, probably assigh NETLINK_W1 at 32, and bump MAX_LINKS?

--yoshfuji
