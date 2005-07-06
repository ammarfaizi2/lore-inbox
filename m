Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVGFFXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVGFFXD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 01:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVGFFWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 01:22:18 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:46349 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261543AbVGFDm7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 23:42:59 -0400
Date: Wed, 06 Jul 2005 12:43:27 +0900 (JST)
Message-Id: <20050706.124327.72653748.yoshfuji@linux-ipv6.org>
To: nigel@suspend2.net
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] [17/48] Suspend2 2.1.9.8 for 2.6.12:
 500-version-specific-i386.patch
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <11206164413380@foobar.com>
References: <11206164393426@foobar.com>
	<11206164413380@foobar.com>
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

In article <11206164413380@foobar.com> (at Wed, 6 Jul 2005 12:20:41 +1000), Nigel Cunningham <nigel@suspend2.net> says:

>  #define local_flush_tlb() __flush_tlb()
> +#define local_flush_tlb_all() __flush_tlb_all();

You should remove ";".

>  extern void flush_tlb_page(struct vm_area_struct *, unsigned long);
> +extern void do_flush_tlb_all(void * info);
> +
> +#define local_flush_tlb_all() \
> +	do_flush_tlb_all(NULL);
>  

ditto

--yoshfuji
