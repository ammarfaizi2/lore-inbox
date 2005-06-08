Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVFHOPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVFHOPu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 10:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVFHOPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 10:15:50 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:15886 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261231AbVFHOPZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 10:15:25 -0400
Date: Wed, 08 Jun 2005 23:15:31 +0900 (JST)
Message-Id: <20050608.231531.126041907.yoshfuji@linux-ipv6.org>
To: tglx@linutronix.de
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH -RT] Softirq splitting
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <1118239409.20785.628.camel@tglx.tec.linutronix.de>
References: <1118239409.20785.628.camel@tglx.tec.linutronix.de>
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

In article <1118239409.20785.628.camel@tglx.tec.linutronix.de> (at Wed, 08 Jun 2005 16:03:29 +0200), Thomas Gleixner <tglx@linutronix.de> says:

> diff --exclude='*~' -urN linux-2.6.12-rc6-rt/include/linux/interrupt.h linux-2.6.12-rc6-rt-work/include/linux/interrupt.h
> --- linux-2.6.12-rc6-rt/include/linux/interrupt.h	2005-06-08 00:38:35.000000000 +0200
> +++ linux-2.6.12-rc6-rt-work/include/linux/interrupt.h	2005-06-08 15:31:48.000000000 +0200
> @@ -113,6 +113,8 @@
>  	NET_RX_SOFTIRQ,
>  	SCSI_SOFTIRQ,
>  	TASKLET_SOFTIRQ
> +	/* Entries after this are ignored in the split softirq mode */
> +	MAX_SOFTIRQ,
>  };
>  

Hey, have you ever compiled?
You need comma after TASKLET_SOFTIRQ.

--yoshfuji
