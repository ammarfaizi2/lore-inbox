Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbULOB6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbULOB6D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 20:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbULOB5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 20:57:41 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:25860 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261804AbULOB5X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 20:57:23 -0500
Date: Wed, 15 Dec 2004 10:59:00 +0900 (JST)
Message-Id: <20041215.105900.27736391.yoshfuji@linux-ipv6.org>
To: bunk@stusta.de
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [2.6 patch] net/ipv6/: misc possible cleanups
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20041215005546.GA11972@stusta.de>
References: <20041215005546.GA11972@stusta.de>
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

In article <20041215005546.GA11972@stusta.de> (at Wed, 15 Dec 2004 01:55:46 +0100), Adrian Bunk <bunk@stusta.de> says:

> The patch below contains the following possible cleanups:
> - make some needlessly global code static
> - remove the following unused functions:
>   - exthdrs.c: ipv6_build_rthdr
>   - exthdrs.c: ipv6_build_exthdr
>   - exthdrs.c: ipv6_build_nfrag_opts
>   - exthdrs.c: ipv6_build_frag_opts
> - remove the following unused global variables:
>   - addrconf.c: in6addr_any
> - remove the following EXPORT_SYMBOL's:
>   - ipv6_syms.c: addrconf_lock
>   - ipv6_syms.c: in6addr_any
>   - ipv6_syms.c: in6addr_loopback
> 
> Please comment on which of these changes are correct and which conflict
> with pending patches.

Please keep addrconf_lock (for SCTP).
Please keep in6addr_any in addrconf.c (or enclose by #if 0 ... #endif)

> --- linux-2.6.10-rc3-mm1-full/include/net/ip.h.old	2004-12-14 05:20:46.000000000 +0100
> +++ linux-2.6.10-rc3-mm1-full/include/net/ip.h	2004-12-14 05:20:53.000000000 +0100
:

I think you attatched incorrect patch file.

--yoshfuji
