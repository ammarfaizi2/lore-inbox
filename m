Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267052AbTAUN0E>; Tue, 21 Jan 2003 08:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267059AbTAUN0E>; Tue, 21 Jan 2003 08:26:04 -0500
Received: from vsmtp2.tin.it ([212.216.176.222]:61586 "EHLO smtp2.cp.tin.it")
	by vger.kernel.org with ESMTP id <S267052AbTAUN0D>;
	Tue, 21 Jan 2003 08:26:03 -0500
Message-ID: <3E2D4D15.4080001@tin.it>
Date: Tue, 21 Jan 2003 14:37:25 +0100
From: AnonimoVeneziano <voloterreno@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Spurious 8259A interrupt: IRQ7 ????
References: <3E2C8EFF.6020707@tin.it> <3E2C9623.60709@sktc.net>
In-Reply-To: <3E2C9623.60709@sktc.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David D. Hagood wrote:

> AnonimoVeneziano wrote:
>
>> What does it mean this message?
>>
>> Of what problem is the signal?
>
>
> It is most likely a hardware problem.
>
> When a device signals an interrupt, it asserts its interrupt pin. When 
> the CPU asks the interrupt controller what device generated the 
> interrupt, the interrupt controller tells the CPU.
>
> But if the interrupt line "goes away" before the CPU fetches the 
> vector, then the interrupt controller doesn't "know" what IRQ caused 
> the interrupt. So the interrupt controller sends an IRQ #7 to the CPU, 
> along with setting a bit in the interrupt controller's status register 
> that says in effect "this isn't really an IRQ 7, but I have no idea 
> what it was. Sorry."
>
> If you have ISA cards in your system, remove them from the system and 
> re-insert them (with the power off, of course) - they may have 
> developed some oxidization on the card edge connector. You can also 
> try scrubbing the card edge with some plain paper (a US dollar bill 
> works even better, but you might not have access to dead presidents in 
> Italy.)
>
> Ditto with PCI cards - remove them, polish the connector, then 
> re-insert them.
>
>
>
Thank you very much all of you for the answers.So, this should be an 
harmless message, I've tried to attach something to the parallel port , 
or disable it in the bios, but doesn't work, the only way to remove this 
problem is to load the parport_pc module, this message with the module 
loaded doesn't appear. I've tried with other bioses , and the problem 
appears on all of them. If I compile in the kernel UP-IO-ACPI the 
problem disappears, but I have a lot of other problems, because my 
system is quite young and the support for IO-APIC is not added yet for 
me.If I use only UP-APIC this problem appears, and if don't use apic 
this disappears.

I'll try to remove some HW and retry. Someone had this problem without 
APIC enabled?

Thank you

Bye

Marcello

