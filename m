Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270533AbUJTUPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270533AbUJTUPX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 16:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270583AbUJTUOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 16:14:51 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:59657 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S270546AbUJTT5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:57:04 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] Make netif_rx_ni preempt-safe
Date: Wed, 20 Oct 2004 22:56:56 +0300
User-Agent: KMail/1.5.4
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       linux-kernel@gondor.apana.org.au, maxk@qualcomm.com,
       irda-users@lists.sourceforge.net,
       Linux Network Development <netdev@oss.sgi.com>,
       Alain Schroeder <alain@parkautomat.net>
References: <1098230132.23628.28.camel@krustophenia.net> <200410202214.31791.vda@port.imtp.ilyichevsk.odessa.ua> <1098302001.2268.5.camel@krustophenia.net>
In-Reply-To: <1098302001.2268.5.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410202256.56636.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, third try.
> 
> Signed-Off-By: Lee Revell <rlrevell@joe-job.com>
> 
> --- include/linux/netdevice.h~	2004-10-20 15:51:00.000000000 -0400
> +++ include/linux/netdevice.h	2004-10-20 15:51:54.000000000 -0400
> @@ -694,11 +694,14 @@
>  /* Post buffer to the network code from _non interrupt_ context.
>   * see net/core/dev.c for netif_rx description.
>   */
> -static inline int netif_rx_ni(struct sk_buff *skb)
> +static int netif_rx_ni(struct sk_buff *skb)

non-inline functions must not live in .h files
--
vda

