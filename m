Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317926AbSGPSdh>; Tue, 16 Jul 2002 14:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317929AbSGPSdg>; Tue, 16 Jul 2002 14:33:36 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:22201 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S317926AbSGPSdg>;
	Tue, 16 Jul 2002 14:33:36 -0400
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [GENERIC HDLC LAYER] Messages of a hdlc device
References: <200207151111.22555.henrique@cyclades.com>
	<m37kjvg6nq.fsf@defiant.pm.waw.pl>
	<20020716135818.GB1231@conectiva.com.br>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 16 Jul 2002 16:06:24 +0200
In-Reply-To: <20020716135818.GB1231@conectiva.com.br>
Message-ID: <m3ptxnbwdb.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo <acme@conectiva.com.br> writes:

> This is becoming a FAQ... see net/core/dev.c, line 907 on 2.5:
> 
>     /* skb->nh should be correctly
>        set by sender, so that the second statement is
>        just protection against buggy protocols.
>      */
>     skb2->mac.raw = skb2->data;
> 
>     if (skb2->nh.raw < skb2->data || skb2->nh.raw > skb2->tail) {
>             if (net_ratelimit())
>                     printk(KERN_DEBUG "protocol %04x is buggy, dev %s\n",
> 			   skb2->protocol, dev->name);
>             skb2->nh.raw = skb2->data;
>     }

Sure I know thats it, but I remember checking the code which resulted
in nothing. Don't remember details, so I'll look at it again.
-- 
Krzysztof Halasa
Network Administrator
