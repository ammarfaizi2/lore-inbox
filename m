Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317324AbSGXOdb>; Wed, 24 Jul 2002 10:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317316AbSGXOdb>; Wed, 24 Jul 2002 10:33:31 -0400
Received: from [210.78.134.243] ([210.78.134.243]:57354 "EHLO 210.78.134.243")
	by vger.kernel.org with ESMTP id <S317307AbSGXOda>;
	Wed, 24 Jul 2002 10:33:30 -0400
Date: Wed, 24 Jul 2002 22:38:24 +0800
From: zhengchuanbo <zhengcb@netpower.com.cn>
To: "Bill Rugolsky Jr." <brugolsky@yahoo.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: about the performance of netfilter
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <200207242241526.SM00796@zhengcb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i applied the NAPI patch. this did improved the performance. but i wonder if it is stable because it's new to me.
i used tc to apply the trffic control. that's a little complicated. and i have not tried policy routing. anyway that's a good idea adn i'll try latter.
i still wish there could be some way to simplify netfilter and improve the perform.

zhengchuanbo
zhengcb@netpower.com.cn
>On Wed, Jul 24, 2002 at 09:24:56PM +0800, zhengchuanbo wrote:
>> we use a linux router. i just tested the performance of the router. when the kernel  is build without netfilter support,the throughput of 64bytes frame is about 45%. when i build the kernel with netfilter (only the ip_filter module),the throughput dropped to 24%, without any rules.
>> so is there some way to improve the performance? i just want some simple packet filter. is netfilter no so good on the performance compare to ipchains due to the improved functionality?
>> please cc.  thanks.
> 
>If (1) your needs are simple, and (2) netfilter can't handle the throughput,
>then you can consider using the traffic control and policy routing features
>of the kernel in conbination with the u32 classifier.
>
>this requires extremely low-level bit manipulation (perhaps tcng provides
>a better interface?), but can probably hit very high throughput numbers for
>simple filtering tasks.
>
>Also, are you using the NAPI patches?  If not, get them and apply them.
>[search the last month of lkml for "napi".]
>
>regards,
>
>   bill rugolsky

