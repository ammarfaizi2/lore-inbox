Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270544AbUJTUna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270544AbUJTUna (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 16:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270530AbUJTUn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 16:43:28 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:1802 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S269992AbUJTUck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 16:32:40 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] Make netif_rx_ni preempt-safe
Date: Wed, 20 Oct 2004 23:32:33 +0300
User-Agent: KMail/1.5.4
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       linux-kernel@gondor.apana.org.au, maxk@qualcomm.com,
       irda-users@lists.sourceforge.net,
       Linux Network Development <netdev@oss.sgi.com>,
       Alain Schroeder <alain@parkautomat.net>
References: <1098230132.23628.28.camel@krustophenia.net> <200410202256.56636.vda@port.imtp.ilyichevsk.odessa.ua> <1098303951.2268.8.camel@krustophenia.net>
In-Reply-To: <1098303951.2268.8.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410202332.33583.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 October 2004 23:25, Lee Revell wrote:
> > > --- include/linux/netdevice.h~	2004-10-20 15:51:00.000000000 -0400
> > > +++ include/linux/netdevice.h	2004-10-20 15:51:54.000000000 -0400
> > > @@ -694,11 +694,14 @@
> > >  /* Post buffer to the network code from _non interrupt_ context.
> > >   * see net/core/dev.c for netif_rx description.
> > >   */
> > > -static inline int netif_rx_ni(struct sk_buff *skb)
> > > +static int netif_rx_ni(struct sk_buff *skb)
> > 
> > non-inline functions must not live in .h files
> 
> Where do you suggest we put it?

Somewhere near this place:

http://lxr.linux.no/source/net/core/dev.c?v=2.6.8.1#L1555
--
vda

