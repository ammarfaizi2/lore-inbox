Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbTHZFkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 01:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbTHZFkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 01:40:43 -0400
Received: from k-kdom.nishanet.com ([65.125.12.2]:44296 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S262618AbTHZFkm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 01:40:42 -0400
Message-ID: <3F4AEFD9.1030503@boxho.com>
Date: Tue, 26 Aug 2003 01:27:53 -0400
From: Resident Boxholder <resid@boxho.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0test4 ACPI with nForce2 "success"
References: <1061834424.2599.2.camel@aurora.localdomain> <200308251921.51305.alistair@devzero.co.uk>
In-Reply-To: <200308251921.51305.alistair@devzero.co.uk>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of turning the apic off in bios like I'm doing, either smp code 
or today's patch to turn apic off before on might do it for you. I have 
to do something with apic to get my pci netcard to work and not get "irq 
disabled". pci=noacpi wasn't it for me. Turning apic off in bios or 
using smp code on uniprocessor is not all, I disable everything to get 
errors and lockups to stop. Power management works. UDMA6 and irq 
unmasking and ide options work.

Alistair J Strachan wrote:

>On Monday 25 August 2003 19:00, Trever L. Adams wrote:
>  
>
>>I have been one of these people who have been having to boot with
>>pci=noacpi to get up with much of my hardware initialized.  My system is
>>now working without it.  It isn't getting shutoff on irq storms or
>>anything.
>>    
>>
>Likewise, my EPoX 8RDA+ board is working 100% perfectly since the nforce2-apic 
>fixes were merged in -mm. No spurious interrupts, no weird ACPI glitches, 
>everything from power management to PCI IRQ routing is just fine.
>
>BD> I have to turn the APIC off in BIOS, then linux turns it on and my rt8139c pci netcard will work. If I turn off parallel and serial ports and usb as well, and remove cd drives, I don't get lockups or see netdev watchdog failure to transmit and disable irq7 along with netcard failure. Needless to say the onboard ethernet controller and audio don't work. But I have another reliable textmode file server with an MSI nforce2 board. There are a few "correctable errors" trapped with slightly underclocked overtested csl2 pc3200 ram running at 2 channel 166 = 333. Altogether a very fine agp8 textmode linux box. Ecstatically, I can copy and paste script text with a mouse, but of course it's on a ps2 port, not usb. USB code, when not logging errors, doesn't recognize usb mouse or keyboard either booted or hot-plugged. I can hibernate with textmode agp8, writing scripts, while somebody hacks nforce2 and nvidia geforce 4200ti--no, I will not dump 2.6 for a 2.4 kernel patched with nvidia driver--more important things don't work in 2.4 than 2.6! 6-channel surround silence and frozen pizza...with the cd's pulled out md might not lockup when copies overflow the drive buffer cache!
>

