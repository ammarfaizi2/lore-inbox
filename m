Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVCVVMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVCVVMb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 16:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVCVVMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 16:12:31 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:16580 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S261955AbVCVVMZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 16:12:25 -0500
Message-ID: <42408A2C.8060103@cosmosbay.com>
Date: Tue, 22 Mar 2005 22:12:12 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: buakaw@buakaw.homelinux.net
CC: Phil Oester <kernel@linuxace.com>, linux-kernel@vger.kernel.org
Subject: Re: dst cache overflow
References: <1144.192.168.0.37.1111351868.squirrel@buakaw.homelinux.net>	<20050321194022.491060c7.akpm@osdl.org>	<1297.192.168.0.37.1111480783.squirrel@buakaw.homelinux.net>	<20050322161657.GA18925@linuxace.com> <20050322190726.e1jiyi25xws0okss@buakaw.homelinux.net>
In-Reply-To: <20050322190726.e1jiyi25xws0okss@buakaw.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [62.23.185.226]); Tue, 22 Mar 2005 22:12:09 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

buakaw@buakaw.homelinux.net a écrit :
> I see on 2.6.10/2.6.11.3
> 


Hello

Could you give us the results of these commands :

# grep . /proc/sys/net/ipv4/route/*
# cat /proc/net/stat/rt_cache

Eric Dumazet

> Quoting Phil Oester <kernel@linuxace.com>:
> 
>> On Tue, Mar 22, 2005 at 10:39:43AM +0200, buakaw@buakaw.homelinux.net 
>> wrote:
>>
>>>
>>> computer's main job is to be router on small LAN with 10 users and  some
>>> services like qmail, apache, proftpd, shoutcast, squid, and ices on 
>>> slack
>>> 10.1. Iptables and tc are used to limit  bandwiwdth and the two 
>>> bandwidthd
>>>  daemons are running on eth0 interface and all the time the cpu is 
>>> used at
>>> about 0.4% and additional 12% by ices  when encoding mp3 on demand, and
>>> the proccess ksoftirqd/0 randomally starts to use 100% of 0 cpu in 
>>> normal
>>> situation and one time when the ksoftirqd/0 became crazy i noticed dst
>>> cache overflow messages in syslog but there are more of thies lines in
>>> logs  about 5 times in 10 days period
>>
>>
>> There was a problem fixed in the handling of fragments which caused dst
>> cache overflow in the 2.6.11-rc series.  Are you still seeing dst cache
>> overflow on 2.6.11?
>>
>> Phil
>>
> 
> 
> 
> ----------------------------------------------------------------
> This message was sent using IMP, the Internet Messaging Program.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

