Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbVH3Lye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVH3Lye (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 07:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbVH3Lye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 07:54:34 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:21455 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751391AbVH3Lyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 07:54:33 -0400
Message-ID: <431448F7.2020506@gentoo.org>
Date: Tue, 30 Aug 2005 12:54:31 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050820)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: Steve Kieu <haiquy@yahoo.com>, linux-kernel@vger.kernel.org,
       Netdev List <netdev@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Very strange Marvell/Yukon Gigabit NIC networking problems
References: <20050830105210.11849.qmail@web53602.mail.yahoo.com>
In-Reply-To: <20050830105210.11849.qmail@web53602.mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

This looks like an issue I reported previously. After you use a recent skge, 
you can't use any older drivers or the windows driver, but skge still works 
fine every time.

	http://marc.theaimsgroup.com/?l=linux-netdev&m=112268414417743&w=2

The Gentoo bug report is here:

	http://bugs.gentoo.org/show_bug.cgi?id=100258

I closed the Gentoo bug as I hoped this patch would solve it:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=0eedf4ac5b536c7922263adf1b1d991d2e2397b9;hp=acdd80d514a08800380c9f92b1bf4d4c9e818125

But according to Steve Kieu, the problem is still there in 2.6.13. It's 
slightly odd as Steve was previously a sk98lin user and initially reported 
this problem for sk98lin in 2.6.13 whereas it did not happen with sk98lin in 
2.6.12.

Any ideas?

Thanks.

Steve Kieu wrote:
> Tested , not broken, working now but the same problem,
> that is if I reboot to winXP or 2.6.12, 2.6.11, the
> NIC is unusaeble. In XP it always says link is down,
> or media disconnected (from ipconfig command output in
> XP)
> is it because the firmware of NIC has changed or any
> reason?
> 
> 
> I noticed  warning messages only with 2.6.13 
> 
> PCI: Failed to allocate mem resource #10:2000000@0 for
> 0000:02:01.0
> 
> and modem device in 2.6.13 IRQ is disabled.
> 
> ACPI: PCI Interrupt Link [LKMO] enabled at IRQ 20
> ACPI: PCI Interrupt 0000:00:06.1[B] -> Link [LKMO] ->
> GSI 20 (level, low) -> IRQ
>  17
> ACPI: PCI interrupt for device 0000:00:06.1 disabled
> 
> not sure if it gives more information.
> 
> skge addr 0xfeaf8000 irq 19 chip Yukon-Lite rev 9
> skge eth0: addr 00:11:d8:f2:1f:18
> ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKB] ->
> GSI 18 (level, low) -> IRQ
>  16
> Yenta: CardBus bridge found at 0000:02:01.0
> [1043:1987]
> skge eth0: enabling interface
> 
> skge eth0: Link is up at 10 Mbps, half duplex, flow
> control none
> 
> Not sure how can I restore this thing back to normal
> (sigh)
