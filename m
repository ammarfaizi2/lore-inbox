Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbUKML4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbUKML4H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 06:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbUKML4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 06:56:07 -0500
Received: from mail8.spymac.net ([195.225.149.8]:41895 "EHLO mail8")
	by vger.kernel.org with ESMTP id S262631AbUKML4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 06:56:02 -0500
Message-ID: <41960458.7010404@spymac.com>
Date: Sat, 13 Nov 2004 13:55:52 +0100
From: Gunther Persoons <gunther_persoons@spymac.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
References: <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <41951380.2080801@spymac.com> <20041112201936.GA15133@elte.hu>
In-Reply-To: <20041112201936.GA15133@elte.hu>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>* Gunther Persoons <gunther_persoons@spymac.com> wrote:
>
>  
>
>>I cant use my pcmcia wireless network card with this version, i can
>>use it with V0.7.25-0. dhcpcd and ifconfig lock when i try to use
>>them.  config attached.
>>    
>>
>
>extremely weird - there simply was no change between -0 and -1 that
>could have affected it. If you do this on the -1 kernel:
>
>	echo 0 > /proc/sys/kernel/preempt_wakeup_timing
>	echo 1 > /proc/sys/kernel/debug_direct_keyboard
>
>then you'll get precisely the -0 kernel, bit for bit. (plus the symbol
>export fix in rtc.ko, which should have zero relevance to your setup.)
>
>[note that debug_direct_keyboard is dangerous.]
>
>so i believe the explanation has to be something else:
>
> - are you sure the build is correct?
>
> - are you sure it still works with the -0 kernel, maybe the bug is 
>   transient?
>
>	Ingo
>
>  
>
Removing every software update i did between 25.0 and 25.1 resolved the 
problem, i think there was something with my gentoo init scripts. 
Although 25.0 was working fine with the software updates. I am now going 
to reinstall the updates one by one to see which one caused it.
