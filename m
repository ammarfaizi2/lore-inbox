Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTK1CFt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 21:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTK1CFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 21:05:49 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:19977 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S261868AbTK1CFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 21:05:48 -0500
Date: Fri, 28 Nov 2003 11:05:25 +0900 (JST)
Message-Id: <20031128.110525.113293143.yoshfuji@linux-ipv6.org>
To: felipe_alfaro@linuxmail.org
Cc: timo@kamph.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       davem@redhat.com, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH 2.6]: IPv4: strcpy -> strlcpy
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <1069970946.2138.13.camel@teapot.felipe-alfaro.com>
References: <20031127142125.GG8276@jdj5.mit.edu>
	<3FC67128.14704.30155D53@localhost>
	<1069970946.2138.13.camel@teapot.felipe-alfaro.com>
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

In article <1069970946.2138.13.camel@teapot.felipe-alfaro.com> (at Thu, 27 Nov 2003 23:09:06 +0100), Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> says:

> diff -uNr linux-2.6.0-test11.orig/net/ipv4/ipconfig.c linux-2.6.0-test11/net/ipv4/ipconfig.c
> --- linux-2.6.0-test11.orig/net/ipv4/ipconfig.c	2003-11-26 21:42:55.000000000 +0100
> +++ linux-2.6.0-test11/net/ipv4/ipconfig.c	2003-11-27 13:32:06.904650818 +0100
> @@ -299,7 +299,7 @@
>  	int err;
>  
>  	memset(&ir, 0, sizeof(ir));
> -	strcpy(ir.ifr_ifrn.ifrn_name, ic_dev->name);
> +	strlcpy(ir.ifr_ifrn.ifrn_name, ic_dev->name, sizeof(ir.ifr_ifrn.ifrn_name));

please use
	strlcpy(ir.ifr_name, ic_dev->name, sizeof(ir.ifr_name));
instead.

--yoshfuji
