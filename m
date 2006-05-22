Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWEVO2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWEVO2z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 10:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWEVO2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 10:28:55 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:11023 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750851AbWEVO2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 10:28:54 -0400
Message-ID: <4471CAA3.2030903@onelan.co.uk>
Date: Mon, 22 May 2006 15:28:51 +0100
From: Barry Scott <barry.scott@onelan.co.uk>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: broadcom 5752 in HP dc7600U works on 2.6.13 but does not working
 on 2.6.16
References: <4469E709.7080501@onelan.co.uk> <20060522035943.7829ee32.akpm@osdl.org> <200605222114.12165.kernel@kolivas.org>
In-Reply-To: <200605222114.12165.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Monday 22 May 2006 20:59, Andrew Morton wrote:
>   
>> It appears that the 2.6.13 kernel did not bring up the machine's io-APICs,
>> but 2.6.16 did.  However you are receiving eth0 interrupts on 2.6.16 so
>> perhaps that's not relevant.
>>     
>
> It looks like he's _not_ receiving eth0 interrupts if I'm not mistaken?
>
>   
Correct no interrupts received under 2.6.16
> and this:
>
>   
>> ENABLING IO-APIC IRQs
>> ..TIMER: vector=0x31 apic1=-1 pin1=-1 apic2=-1 pin2=-1
>> ...trying to set up timer (IRQ0) through the 8259A ...  failed.
>> ...trying to set up timer as Virtual Wire IRQ... works.
>>     
>
> looks suspiciously like a broken apic/code/workaround/whatever
>
> I'd go with Andrew's suggestion and disable apic in your bootparameters 
> (noapic and/or nolapic) and possibly in your config if it corrects i
Adding noapic works. I have ethernet back.

Do you need me to log a bug report somewhere about this?

Barry

