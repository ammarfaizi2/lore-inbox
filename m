Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265641AbSJXT6h>; Thu, 24 Oct 2002 15:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265639AbSJXT5S>; Thu, 24 Oct 2002 15:57:18 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:43285 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S265637AbSJXT46>;
	Thu, 24 Oct 2002 15:56:58 -0400
Message-ID: <3DB85213.4020509@mvista.com>
Date: Thu, 24 Oct 2002 15:03:31 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Levon <levon@movementarian.org>
CC: dipankar@gamebox.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI request/release, version 5 - I think this one's ready
References: <20021022190818.GA84745@compsoc.man.ac.uk> <3DB5C4F3.5030102@mvista.com> <20021023230327.A27020@dikhow> <3DB6E45F.5010402@mvista.com> <20021024002741.A27739@dikhow> <3DB7033C.1090807@mvista.com> <20021024132004.A29039@dikhow> <3DB7F574.9030607@mvista.com> <20021024144632.GC32181@compsoc.man.ac.uk> <3DB81376.90403@mvista.com> <20021024171815.GA6920@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon wrote:

>On Thu, Oct 24, 2002 at 10:36:22AM -0500, Corey Minyard wrote:
>
>  
>
>>Is there any way to detect if the nmi watchdog actually caused the 
>>timeout?  I don't understand the hardware well enough to do it without 
>>    
>>
>
>You can check if the counter used overflowed :
>
>#define CTR_OVERFLOWED(n) (!((n) & (1U<<31)))
>#define CTRL_READ(l,h,msrs,c) do {rdmsr(MSR_P6_PERFCTR0, (l), (h));} while (0)
>
>                CTR_READ(low, high, msrs, i);
>                if (CTR_OVERFLOWED(low)) {
>			... found
>
Any way to do this for the IO_APIC case?

-Corey


