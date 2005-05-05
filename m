Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVEEJwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVEEJwh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 05:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVEEJwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 05:52:37 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:60422 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S262005AbVEEJwZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 05:52:25 -0400
Date: Thu, 05 May 2005 18:55:03 +0900 (JST)
Message-Id: <20050505.185503.78606493.yoshfuji@linux-ipv6.org>
To: michaelc@cs.wisc.edu
Cc: linux-scsi@vger.kernel.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH 2/3] add open iscsi netlink interface to iscsi
 transport class
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <42798AC1.2010308@cs.wisc.edu>
References: <42798AC1.2010308@cs.wisc.edu>
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

In article <42798AC1.2010308@cs.wisc.edu> (at Wed, 04 May 2005 19:53:53 -0700), Mike Christie <michaelc@cs.wisc.edu> says:

> +struct iscsi_uevent {
:
> +} __attribute__ ((aligned (sizeof(unsigned long))));

I think it'd be better to use sizeof(uint64_t) or something.
Please check other spots, too. e.g.:

> +	struct iscsi_stats_custom custom[0]
> +		__attribute__ ((aligned (sizeof(unsigned long))));

--yoshfuji
