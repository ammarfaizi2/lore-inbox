Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274505AbRJQERP>; Wed, 17 Oct 2001 00:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274549AbRJQERG>; Wed, 17 Oct 2001 00:17:06 -0400
Received: from jpnsmtp2w.core.hp.com ([128.88.255.115]:21771 "HELO
	jpnsmtp2w.jpn.hp.com") by vger.kernel.org with SMTP
	id <S274505AbRJQEQw>; Wed, 17 Oct 2001 00:16:52 -0400
Message-Id: <200110170417.f9H4H9g23739@hpujffg8.jpn.hp.com>
To: "David S. Miller" <davem@redhat.com>
cc: yumoto@jpn.hp.com, linux-kernel@vger.kernel.org
Subject: Re: New virtual ethernet driver submitting... 
In-Reply-To: Your message of "Tue, 16 Oct 2001 20:02:21 JST."
             <20011016.200221.30185716.davem@redhat.com> 
Date: Wed, 17 Oct 2001 13:17:09 +0900
From: Katsuyuki Yumoto <yumoto@jpn.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> "David" == David S Miller <davem@redhat.com> writes:

>    From: Katsuyuki Yumoto <yumoto@jpn.hp.com>
>    Date: Wed, 17 Oct 2001 11:47:07 +0900
   
>    I've already written new two drivers of virtual ethernet. These
>    aggregate(bundle) plural physical or virtual ethernet devices to
>    single.

> How is this different to, or more beneficial than, what
> drivers/net/bonding.c is doing?

Yes. I think what to want to do is same between bonding.c and veth
(link aggregation).  But veth has link aggretation maintenance
functionality(LACP) and TCP/UDP port number based distributing
algorithm. Of course, such things are optional features...

On the other hand, purpose of lr(link redundancy) is different of
yours and veth. It's a new link redundant technology rather than
aggregation.

By the way, it seems that your code don't have incoming packet handler
code, right? My drivers contains packet handler for incoming
packets. If your incoming packet handling method is better than mine,
I'd like to follow it. (I'm not sure its method yet.)

Regards,
Yumo (Katsuyuki Yumoto)
