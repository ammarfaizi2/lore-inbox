Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbVEELwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVEELwz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 07:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVEELwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 07:52:55 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:63494 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S262054AbVEELww
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 07:52:52 -0400
Date: Thu, 05 May 2005 20:55:30 +0900 (JST)
Message-Id: <20050505.205530.107537707.yoshfuji@linux-ipv6.org>
To: herbert@gondor.apana.org.au
Cc: michaelc@cs.wisc.edu, linux-scsi@vger.kernel.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH 2/3] add open iscsi netlink interface to iscsi
 transport class
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <E1DTehn-0005gJ-00@gondolin.me.apana.org.au>
References: <20050505.185503.78606493.yoshfuji@linux-ipv6.org>
	<E1DTehn-0005gJ-00@gondolin.me.apana.org.au>
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

In article <E1DTehn-0005gJ-00@gondolin.me.apana.org.au> (at Thu, 05 May 2005 21:39:47 +1000), Herbert Xu <herbert@gondor.apana.org.au> says:

> YOSHIFUJI Hideaki / ???? <yoshfuji@linux-ipv6.org> wrote:
> > In article <42798AC1.2010308@cs.wisc.edu> (at Wed, 04 May 2005 19:53:53 -0700), Mike Christie <michaelc@cs.wisc.edu> says:
> > 
> >> +struct iscsi_uevent {
> > :
> >> +} __attribute__ ((aligned (sizeof(unsigned long))));
> > 
> > I think it'd be better to use sizeof(uint64_t) or something.
> 
> Is there a benefit in aligning on 64-bit boundaries for 32-bit platforms?

Well, this if for avoiding inconsistency between kernel and userspace.
If you use unsigned long, sizeof(unsigned long) may be inconssitent
between kernel and userland like this:
  kernel:    sizeof(unsigned long) == 8
  userspace: sizeof(unsigned long) == 4

--yoshfuji
