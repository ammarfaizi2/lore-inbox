Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161122AbWGNRAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161122AbWGNRAE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161267AbWGNRAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:00:04 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:28913 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1161122AbWGNRAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:00:03 -0400
Message-ID: <44B7CF00.8090204@gentoo.org>
Date: Fri, 14 Jul 2006 18:06:08 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
CC: Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, greg@kroah.com, harmon@ksu.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
References: <20060714095233.5678A8B6253@zog.reactivated.net>	 <44B77B1A.6060502@garzik.org> <44B78294.1070308@gentoo.org>	 <44B78538.6030909@garzik.org> <20060714074305.1248b98e.akpm@osdl.org>	 <20060714154240.GA23480@tuatara.stupidest.org>	 <44B7C37F.1050400@gentoo.org>  <44B7C521.5080009@gentoo.org> <1152895734.11043.5.camel@localhost.localdomain>
In-Reply-To: <1152895734.11043.5.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergio Monteiro Basto wrote:
>> I just confirmed this on my own system, at least partially. I removed 
>> the quirk and the system booted fine.
>>
>> This is with ACPI enabled, but APIC not enabled (hence the interrupts 
>> are XT-PIC). I cannot enable APIC on this system due to buggy BIOS.
>>
>> Daniel
> 
> Daniel, VIA_SATA is not in the list , so when you write remove , you
> remove what ? or you want say the opposite ?  
> Please rephrase your sentence .

Sorry, I should have been clearer. I do not own any VIA SATA hardware 
(that info was relayed from a Gentoo bug report). My own hardware is 
older, [Apollo KT266/A/333]. The quirk gets applied to my IDE controller 
only (both before and after Chris's changes), and I boot from a disk 
connected to this IDE controller.

00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo 
KT266/A/333 AGP]
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 23)
00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 23)
01:00.0 VGA compatible controller: nVidia Corporation NV15 [GeForce2 
GTS/Pro] (rev a3)

When I said I removed the quirk, I meant I removed the whole quirk, 
which prevented it from running on my hardware.

> Do you need quirk SATA with acpi=off  ?

Assuming you mean "quirk IDE", no.

> Do you need quirk with ACPI enabled ? 

No. But, my interrupts are always XT-PIC, I cannot enable IO-APIC (not 
sure how much relevance that has, possibly worth noting though).



Just for clarity, I'll respond to those 2 questions again with Aiko 
Barz's system in mind (the user on the Gentoo bug report) -- this is the 
one with the VIA SATA hardware.

 > Do you need quirk SATA with acpi=off  ?

No.

 > Do you need quirk with ACPI enabled ?

Yes.


Daniel
