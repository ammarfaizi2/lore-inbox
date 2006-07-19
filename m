Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWGSD4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWGSD4b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 23:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWGSD4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 23:56:31 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:61708 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932488AbWGSD4a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 23:56:30 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: shemminger@osdl.org (Stephen Hemminger)
Subject: Re: [RFC PATCH 32/33] Add the Xen virtual network device driver.
Cc: chrisw@sous-sol.org, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       jeremy@goop.org, ak@suse.de, akpm@osdl.org, rusty@rustcorp.com.au,
       zach@vmware.com, ian.pratt@xensource.com,
       Christian.Limpach@cl.cam.ac.uk, netdev@vger.kernel.org
Organization: Core
In-Reply-To: <20060718114430.73985431@localhost.localdomain>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev,apana.lists.os.xen.devel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1G339V-0004z8-00@gondolin.me.apana.org.au>
Date: Wed, 19 Jul 2006 13:55:13 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger <shemminger@osdl.org> wrote:
> 
>> diff -r eadc12b20f35 drivers/xen/netfront/netfront.c
>> --- /dev/null Thu Jan 01 00:00:00 1970 +0000
>> +++ b/drivers/xen/netfront/netfront.c Fri Jun 09 15:03:12 2006 -0400
>> @@ -0,0 +1,1584 @@
> 
>> +static inline void init_skb_shinfo(struct sk_buff *skb)
>> +{
>> +     atomic_set(&(skb_shinfo(skb)->dataref), 1);
>> +     skb_shinfo(skb)->nr_frags = 0;
>> +     skb_shinfo(skb)->frag_list = NULL;
>> +}
> 
> Shouldn't this move to skbuff.h?

If and when my dom0=>domU GSO patches are applied, this will simply
disappear.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
