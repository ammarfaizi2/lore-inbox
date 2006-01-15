Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751856AbWAOEYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbWAOEYA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 23:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbWAOEX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 23:23:59 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:9890 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751856AbWAOEX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 23:23:59 -0500
Message-ID: <43C9CE62.9070302@ens-lyon.org>
Date: Sat, 14 Jan 2006 23:24:02 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-mm4
References: <43C919ED.8070801@ens-lyon.org> <20060115040741.GA23968@elte.hu>
In-Reply-To: <20060115040741.GA23968@elte.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>* Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
>
>  
>
>>Hi Andrew,
>>
>>I get the following badness when booting mm4 on my thinkpad T43:
>>
>>hdaps: IBM ThinkPad T43 detected.
>>hdaps: initial latch check good (0x01).
>>Time: acpi_pm clocksource has been installed.
>>input: hdaps as /class/input/input3
>>hdaps: driver successfully loaded.
>>Non-volatile memory driver v1.2
>>Badness in __mutex_trylock_slowpath at kernel/mutex.c:281
>> [<c01251cf>] mutex_trylock+0x5a/0xe7
>> [<e09c02d2>] hdaps_inputdev_poll+0xd/0xbd [hdaps]
>> [<c011befc>] run_timer_softirq+0x105/0x147
>> [<c0118a0b>] __do_softirq+0x34/0x7d
>> [<c0118a76>] do_softirq+0x22/0x26
>> [<c0104a64>] do_IRQ+0x22/0x2a
>> [<c01033ce>] common_interrupt+0x1a/0x20
>>kjournald starting.  Commit interval 5 seconds
>>    
>>
>
>Could you try the patch below?
>
>  
>

Yes, it does fix it. What's the bug ? The mutexes are supposed to work
where semaphores do, aren't they ?

Brice

