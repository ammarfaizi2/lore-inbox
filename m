Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265311AbTLHDHH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 22:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265314AbTLHDHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 22:07:07 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:62731 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S265311AbTLHDHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 22:07:03 -0500
Message-ID: <3FD3EF21.2050701@nishanet.com>
Date: Sun, 07 Dec 2003 22:25:21 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Catching NForce2 lockup with NMI watchdog - found
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F87E@mail-sc-6.nvidia.com> <3FD1199E.2030402@gmx.de> <20031206081848.GA4023@localnet>
In-Reply-To: <20031206081848.GA4023@localnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cheuche+lkml@free.fr wrote:

> ...................If you experience crashes with apic and your bios 
> does not have such
>
>option, try athcool at
>http://members.jcom.home.ne.jp/jacobi/linux/softwares.html
>Its purpose is to *enable* cpu disconnect but can also disable it. Your
>best bet is to run it to disable cpu disconnect the soonest possible at
>boot.
>
>On the other hand, it isn't the cause of IRQ7 rogue interrupts. As I
>initially suspected, it seems now totally unrelated. The ACPI override
>handling may be buggy ? Since putting back the timer on IO-APIC-edge
>solves it.
>
>Nevertheless this is still a problem, other chipsets for Athlon
>processors seems to be able to have cpu disconnect and ioapic enabled
>without any crashes. But so far I don't see any thermal differences, I'm
>happy with that.
>
>Mathieu
>
I presently have /proc/interrupts
 0:  244393560          XT-PIC  timer

but when I tried nvnet driver and onboard
ethernet I think I saw both IRQ7 disabled
and some 8259A spurious interrupt err.

Presently there is no grep timer or TIMER
or 8259A in logs. 8259A has to do with
IO-APIC timer? It would make sense that
nvnet would see apic and lapic on in bios
and linux and look for io-apic timer as
well as apic table, then fail confused.

Is there a link to that patch? I keep deleting
this list it's huge so I lost a patch in a message.

-Bob

