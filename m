Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276996AbRJCVmi>; Wed, 3 Oct 2001 17:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276997AbRJCVm2>; Wed, 3 Oct 2001 17:42:28 -0400
Received: from Expansa.sns.it ([192.167.206.189]:53002 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S276996AbRJCVmS>;
	Wed, 3 Oct 2001 17:42:18 -0400
Date: Wed, 3 Oct 2001 23:42:52 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Kirill Ratkin <kratkin@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Netfilter problem
In-Reply-To: <20011003141144.98896.qmail@web11903.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0110032342010.10272-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

strange!
it compiled correctly fr mw with all 2.4 kernels, with gcc 2.95.3, and gcc
3.0.0/1

Luigi


On Wed, 3 Oct 2001, Kirill Ratkin wrote:

> Hi.
>
> I've a strange error when I try to check protocol type
> in netfilter hook function.
>
> I see this message:
> kping.c: In function `knet_hook':
> kping.c:116: dereferencing pointer to incomplete type
> make: *** [kping.o] Error 1
>
> This is part of my code:
> static
> unsigned int knet_hook(unsigned int hooknum,
>                       struct sk_buff** p_skb,
>                       const struct net_device* p_in,
>                       const struct net_device* p_out,
>                       int (*okfn)(struct sk_buff* ))
> {
>   ...
>   if((*p_skb)->nh.iph->protocol==
> 	(unsigned char)IPPROTO_ICMP)
>   {
>     printk("<1>ICMP Packet killed\n");
>     return NF_DROP;
>   }
>   ...
> }
>
> It had compiled on 2.4.1 version.
>
> I don't understand why ... .
>
>
> __________________________________________________
> Do You Yahoo!?
> Listen to your Yahoo! Mail messages from any phone.
> http://phone.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

