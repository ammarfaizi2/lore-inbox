Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315192AbSGQOg5>; Wed, 17 Jul 2002 10:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315191AbSGQOg5>; Wed, 17 Jul 2002 10:36:57 -0400
Received: from [210.78.134.243] ([210.78.134.243]:28423 "EHLO 210.78.134.243")
	by vger.kernel.org with ESMTP id <S315182AbSGQOgz>;
	Wed, 17 Jul 2002 10:36:55 -0400
Date: Wed, 17 Jul 2002 22:13:34 +0800
From: zhengchuanbo <zhengcb@netpower.com.cn>
To: Filip Sneppe (Yucom) <filip.sneppe@yucom.be>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: how to improve the throughput of linux network
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <200207172216104.SM00792@zhengcb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Tue, 2002-07-16 at 03:13, zhengchuanbo wrote:
>> 
>> we use linux as our router. i just tested the performance of the router with smartbits, and i found that the throughput of 64byte 
>> i looked for some solution,and found some article mentioned the NAPI. it changed the driver to polling mode,so that the interrupt is no too much. but i could not find  drivers for our router.(eepro100 card). has the polling mode driver been used in linux?

>Try this url:
>
>ftp://robur.slu.se/pub/Linux/net-development/NAPI/
>
>Also check out 2.5 kernels - they alreacdy have NAPI, there's is at
>least some documentation under linux/Documentation/
>
>Could you put some numbers online after your tests ?
>I already have this page, I don't have a Smartbits, though :-):
>
>http://www.filip.sneppe.yucom.be/linux/netfilter/performance/benchmarks.htm
>
>Regards,
>Filip

i got the patch for NAPI,and patched it on linux2.4.18. it worked. the throughput of 128bytes frame improve from 60% to more than 90%. it seems that it has no influnce to frames bigger than 256.

but there is still some problem. when i tested the throught of 64bytes frame,some error occured. in the begining it works well. but after several times of try the linux router can not receive any packets at all.(i found that by run ifconfig when the smartbits is testing). for the other frames it worked very well.

so what's wrong with my test? is there some problem with the patch?

regards,
chuanbo zheng


