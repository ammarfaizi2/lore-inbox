Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318148AbSIJV21>; Tue, 10 Sep 2002 17:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318151AbSIJV21>; Tue, 10 Sep 2002 17:28:27 -0400
Received: from triton.neptune.on.ca ([205.233.176.2]:20411 "EHLO
	triton.neptune.on.ca") by vger.kernel.org with ESMTP
	id <S318148AbSIJV20>; Tue, 10 Sep 2002 17:28:26 -0400
Date: Tue, 10 Sep 2002 17:33:15 -0400 (EDT)
From: Steve Mickeler <steve@neptune.ca>
X-X-Sender: steve@triton.neptune.on.ca
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre6 tg3 compile errors
In-Reply-To: <20020910.142108.08824481.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0209101732350.17602-100000@triton.neptune.on.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, all I patched was tg3.c and tg3.h

Thanks.

On Tue, 10 Sep 2002, David S. Miller wrote:

>    From: Steve Mickeler <steve@neptune.ca>
>    Date: Tue, 10 Sep 2002 17:19:53 -0400 (EDT)
>
>    Compiling in tg3 support using the tg3.c and tg3.h from 2.4.20-pre6
>  ...
>    tg3.c: In function `tg3_rx':
>    tg3.c:1977: warning: implicit declaration of function `netif_receive_skb'
>
> I pretty sure you mispatched your tree.
>
> It's there in 2.4.20-pre6:
>
> bash$ egrep netif_receive_skb patch-2.4.20-pre6
> +                       netif_receive_skb (skb);
> +3) instead of netif_rx() we call netif_receive_skb() to pass the skb.
> +                       netif_receive_skb(skb);
> +       return (polling ? netif_receive_skb(skb) : netif_rx(skb));
> +extern int             netif_receive_skb(struct sk_buff *skb);
> +int netif_receive_skb(struct sk_buff *skb)
> +               netif_receive_skb(skb);
> +EXPORT_SYMBOL(netif_receive_skb);
> bash$
>



[-] Steve Mickeler [ steve@neptune.ca ]

[|] Todays root password is brought to you by /dev/random

[+] 1024D/9AA80CDF = 4103 9E35 2713 D432 924F  3C2E A7B9 A0FE 9AA8 0CDF

