Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268107AbUIWSKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268107AbUIWSKf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 14:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268197AbUIWSKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 14:10:35 -0400
Received: from smtp2.netcabo.pt ([212.113.174.29]:36228 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S268107AbUIWSKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 14:10:02 -0400
Message-ID: <48836.195.245.190.94.1095962870.squirrel@195.245.190.94>
In-Reply-To: <35929.195.245.190.93.1095956611.squirrel@195.245.190.93>
References: <20040908082050.GA680@elte.hu>      
    <1094683020.1362.219.camel@krustophenia.net>      
    <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu>      
    <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu>      
    <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu>      
    <20040923122838.GA9252@elte.hu>      
    <24137.195.245.190.93.1095946528.squirrel@195.245.190.93>      
    <20040923134000.GA15455@elte.hu>
    <35929.195.245.190.93.1095956611.squirrel@195.245.190.93>
Date: Thu, 23 Sep 2004 19:07:50 +0100 (WEST)
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S4
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 23 Sep 2004 18:09:59.0174 (UTC) FILETIME=[89C58260:01C4A198]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Nuno Capela (meself:) wrote:
>
> Yes, now it builds fine on my laptop.
>
> However, after a couple of reboots, there appears to be some verbose
> messages regarding PCI something, but the my main complaint is the USB
> subsystem which is failing miserably now.
>
> I guess these are the relevant log messages excerpt:
>
> [...]
> Mounted devfs on /dev
> Freeing unused kernel memory: 160k freed
> IRQ#8 thread started up.
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
> ACPI: PCI Interrupt Link [LNK8] enabled at IRQ 10
> ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 10 (level, low) -> IRQ 10
> ohci_hcd 0000:00:02.0: OHCI Host Controller
> requesting new irq thread for IRQ10...
> ohci_hcd 0000:00:02.0: irq 10, pci mem 0xd4000000
> ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
> ohci_hcd 0000:00:02.0: init err (00002edf 0000)
> ohci_hcd 0000:00:02.0: can't start
> ohci_hcd 0000:00:02.0: init error -75
> ohci_hcd 0000:00:02.0: remove, state 0
> ohci_hcd 0000:00:02.0: USB bus 1 deregistered
> ohci_hcd: probe of 0000:00:02.0 failed with error -75
> ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 10
> ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 10 (level, low) -> IRQ 10
> ohci_hcd 0000:00:0f.0: OHCI Host Controller
> ohci_hcd 0000:00:0f.0: irq 10, pci mem 0xd4009000
> ohci_hcd 0000:00:0f.0: new USB bus registered, assigned bus number 1
> ohci_hcd 0000:00:0f.0: init err (00002edf 0000)
> ohci_hcd 0000:00:0f.0: can't start
> ohci_hcd 0000:00:0f.0: init error -75
> ohci_hcd 0000:00:0f.0: remove, state 0
> ohci_hcd 0000:00:0f.0: USB bus 1 deregistered
> ohci_hcd: probe of 0000:00:0f.0 failed with error -75
> [...]
>
> Probably this isn't strictly related to VP, but surely it was introduced
> by mm1 and mm2. Can't tell for sure. And please don't count as hardware
> failure as it suffices to go back to 2.6.9-rc1 to get USB back to normal
> ;)
>
> Any thoughts?

This isn't related to VP at all. Sorry for the bandwidth waste.

Just noticed a post from Andre Eisenbach [1] a few moments ago, with the
this subject: "USB (OHCI) not working without pci=routeirq", and it's
exactly what is going on wrong here.

[1] http://lkml.org/lkml/2004/9/23/163

Thanks anyhow.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

