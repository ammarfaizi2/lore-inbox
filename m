Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262284AbUKKQit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbUKKQit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 11:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbUKKQil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 11:38:41 -0500
Received: from mail8.spymac.net ([195.225.149.8]:52442 "EHLO mail8")
	by vger.kernel.org with ESMTP id S262281AbUKKQgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 11:36:53 -0500
Message-ID: <4193A335.5090304@spymac.com>
Date: Thu, 11 Nov 2004 18:36:53 +0100
From: Gunther Persoons <gunther_persoons@spymac.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-0
References: <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <41938D60.4070802@spymac.com> <20041111160819.GA26184@elte.hu> <20041111161235.GA26582@elte.hu> <20041111163030.GA27769@elte.hu>
In-Reply-To: <20041111163030.GA27769@elte.hu>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>* Ingo Molnar <mingo@elte.hu> wrote:
>
>  
>
>>just in case you are using UP-IOAPIC, could you enable CONFIG_SMP
>>(even if you are running an UP box) and see whether the lockup goes
>>away?  Which was the last -RT kernel that you tried that didnt lock up
>>in this fashion?
>>    
>>
>
>if with CONFIG_SMP it's more stable, could you try the following: turn
>off CONFIG_SMP again and edit arch/i386/kernel/io_apic.c and remove this
>string:
>
>	&& defined(CONFIG_SMP)
>
>(there should be only one occurence of this string.)
>
>this will turn the previous IO-APIC logic (used in -V0.7.24) back on.
>
>	Ingo
>
>  
>
It locked up after 20 minutes with CONFIG_SMP enabled.
