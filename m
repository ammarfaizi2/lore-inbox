Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVD0Gr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVD0Gr5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 02:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVD0Gr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 02:47:57 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:2311 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261713AbVD0Gry
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 02:47:54 -0400
Date: Wed, 27 Apr 2005 15:50:18 +0900 (JST)
Message-Id: <20050427.155018.113894851.yoshfuji@linux-ipv6.org>
To: kamezawa.hiroyu@jp.fujitsu.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counting bounce buffer in vmstat
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <426F3445.9060701@jp.fujitsu.com>
References: <426F3445.9060701@jp.fujitsu.com>
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

In article <426F3445.9060701@jp.fujitsu.com> (at Wed, 27 Apr 2005 15:42:13 +0900), KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> says:

> diff -puN include/linux/page-flags.h~count_bounce include/linux/page-flags.h
> --- linux-2.6.12-rc2-mm3/include/linux/page-flags.h~count_bounce	2005-04-27 10:23:15.000000000 +0900
> +++ linux-2.6.12-rc2-mm3-kamezawa/include/linux/page-flags.h	2005-04-27 10:24:11.000000000 +0900
> @@ -89,6 +89,7 @@ struct page_state {
>  	unsigned long nr_page_table_pages;/* Pages used for pagetables */
>  	unsigned long nr_mapped;	/* mapped into pagetables */
>  	unsigned long nr_slab;		/* In slab */
> +	unsigned long nr_bounce;	/* pages for bounce buffers */
>  #define GET_PAGE_STATE_LAST nr_slab
>  
>  	/*

I think you need to change GET_PAGE_STATE_LAST as well.

--yoshfuji
