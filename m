Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266485AbUIWQ0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266485AbUIWQ0b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 12:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266345AbUIWQ0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 12:26:31 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:38697 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S266485AbUIWQZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 12:25:30 -0400
Message-ID: <35929.195.245.190.93.1095956611.squirrel@195.245.190.93>
Date: Thu, 23 Sep 2004 17:23:31 +0100 (WEST)
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
References: <20040908082050.GA680@elte.hu>   
    <1094683020.1362.219.camel@krustophenia.net>   
    <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu>   
    <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu>   
    <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu>   
    <20040923122838.GA9252@elte.hu>   
    <24137.195.245.190.93.1095946528.squirrel@195.245.190.93>   
    <20040923134000.GA15455@elte.hu>
In-Reply-To: <20040923134000.GA15455@elte.hu>
X-OriginalArrivalTime: 23 Sep 2004 16:25:28.0774 (UTC) FILETIME=[F0526660:01C4A189]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> yeah, please re-download the -S4 patch, i fixed this meanwhile.
>

Yes, now it builds fine on my laptop.

However, after a couple of reboots, there appears to be some verbose
messages regarding PCI something, but the my main complaint is the USB
subsystem which is failing miserably now.

I guess these are the relevant log messages excerpt:

[...]
Mounted devfs on /dev
Freeing unused kernel memory: 160k freed
IRQ#8 thread started up.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LNK8] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:02.0: OHCI Host Controller
requesting new irq thread for IRQ10...
ohci_hcd 0000:00:02.0: irq 10, pci mem 0xd4000000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: init err (00002edf 0000)
ohci_hcd 0000:00:02.0: can't start
ohci_hcd 0000:00:02.0: init error -75
ohci_hcd 0000:00:02.0: remove, state 0
ohci_hcd 0000:00:02.0: USB bus 1 deregistered
ohci_hcd: probe of 0000:00:02.0 failed with error -75
ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:0f.0: OHCI Host Controller
ohci_hcd 0000:00:0f.0: irq 10, pci mem 0xd4009000
ohci_hcd 0000:00:0f.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:0f.0: init err (00002edf 0000)
ohci_hcd 0000:00:0f.0: can't start
ohci_hcd 0000:00:0f.0: init error -75
ohci_hcd 0000:00:0f.0: remove, state 0
ohci_hcd 0000:00:0f.0: USB bus 1 deregistered
ohci_hcd: probe of 0000:00:0f.0 failed with error -75
[...]

Probably this isn't strictly related to VP, but surely it was introduced
by mm1 and mm2. Can't tell for sure. And please don't count as hardware
failure as it suffices to go back to 2.6.9-rc1 to get USB back to normal
;)

Any thoughts?
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org




