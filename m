Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbTLVNRG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 08:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264452AbTLVNRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 08:17:06 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:22545 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S264414AbTLVNRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 08:17:02 -0500
Message-ID: <3FE6EF3A.4090402@nishanet.com>
Date: Mon, 22 Dec 2003 08:18:50 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: nForce2 keeps crashing during network activity
References: <200312221451.06331.ross@datscreative.com.au> <200312221208.13218.cleanerx@au.hadiko.de>
In-Reply-To: <200312221208.13218.cleanerx@au.hadiko.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Kübler wrote:

>>If the noapic or acpi=off stabilizes it for you and you want to run with
>>apic and io-apic then my patches may help.
>>
>>You can find them in this thread
>>
>>Updated Lockup Patches, 2.4.22 - 23 Nforce2, apic timer ack delay, ioapic
>>edge for NMI debug
>>
>>If unsubscribed you can find it here
>>http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/4673.html
>>or here
>>http://lkml.org/lkml/2003/12/21/156
>>    
>>
>
>I played a bit around with apic off and on and still it had no effect. My 
>board keeps crashing. Seems not to be related to apic.
>
>Jens
>
I would not count on that if it's an nforce2 board.
It's virtually an faq that if nforce2 is unstable then
you may actually need apic, local apic, ioapic, a
bios update, these patches, maybe athcool utility.

My nforce2 motherboard had ERR count and
excessive MIS count in /proc/interrupts due to
sharing interrupts between two pci cards. I
removed the ethernet card, used the motherboard
ethernet and forcedeth driver, so I was not sharing
interrupts between pci cards, and that gave me
ERR 0 and minimal MIS. Shared interrupts might
be your problem.

Personally I found that noapic or acpi=off could
not do anything for me either. Currently I have
pre-emptive kernel, apic, acpi, local apic.

You can try a bios flash update. This is most
hopeful for Award bios. Save your old bios
just in case when the flash software asks if you
want to save your old bios. We heard from one
person who needed to go back to his old bios,
but several got rid of their nforce2 crashes by
a bios update.

You can try athcool utility turning cpu disconnect
off--"athcool off". This stopped crashing for a few.
I don't need that.

You can try the patches; they can't hurt and would
be easy to remove. To make them work you need apic
on in bios, apic and local apic on in kernel config.

-Bob
