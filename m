Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267334AbUHMVGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267334AbUHMVGy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 17:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267425AbUHMVGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 17:06:54 -0400
Received: from proxy.hsp-law.de ([62.48.88.110]:16074 "EHLO gjba.hsp-law.de")
	by vger.kernel.org with ESMTP id S267334AbUHMVGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 17:06:51 -0400
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: rc4-mm1 pci-routing
Cc: linux-kernel@vger.kernel.org, Ralf Gerbig <rge-news@quengel.org>
References: <200408111642.59938.bjorn.helgaas@hp.com>
From: Ralf Gerbig <rge-news@hsp-law.de>
Date: 13 Aug 2004 23:06:47 +0200
Message-ID: <m0brheycgo.fsf@test3.hsp-law.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Executive summery: Sorry for the noise.

> I'm sorry,  I'm completely lost.  You mention an oops, but I don't
> see one in the transcript you posted.

Sorry I should have have explained the mess.

> You originally mentioned a hang while alsa was starting up.  But
> the transcript you posted doesn't show a hang.  Does it work when
> the drivers are builtin, but hang when they are modules?

Here goes:

The on the first boot of rc4-mm1 the last line on the screen was about
starting ALSA, so I assumed that was what broke and sent the diff of 
the 'boot.msg' (SuSE 9.1) with and without pci=routeirq.

Then I compiled the intel8x0 driver into the kernel send the resulting
boot.msg with pci=routeirq. Thereafter I hooked up a serial console and 
found an oops from the 'wondershaper' and other unrelated breakage. 
Returning to my original .config and moving the shaper to a later
position in the boot process everything just worked even without
pci=routeirq. That is the last trace I sent.

> lspci shows some sort of ISDN card, but I don't see a driver for
> it.  Are you using that?

Yes, startmode is manual and it works:

ISDN subsystem Rev:1.1.2.3/1.1.2.3/1.1.2.2/1.1.2.3/none/1.1.2.2 loaded HiSax: LinuxDriver for passive ISDN cards
HiSax: Version 3.5 (module)
HiSax: Layer1 Revision 2.46.2.5
HiSax: Layer2 Revision 2.30.2.4
HiSax: TeiMgr Revision 2.20.2.3
HiSax: Layer3 Revision 2.22.2.3
HiSax: LinkLayer Revision 2.59.2.4
hisax_isac: ISAC-S/ISAC-SX ISDN driverv0.1.0
hisax_fcpcipnp: Fritz!Card PCI/PCIv2/PnP ISDN driver v0.0.1
HiSax: Card 1 Protocol EDSS1 Id=fcpcipnp0 (0)
HiSax: DSS1 Rev. 2.32.2.3
HiSax: 2 channels added
HiSax: MAX_WAITING_CALLS added
ACPI: PCI interrupt 0000:01:07.0[A] ->GSI 19 (level, high) -> IRQ 19
hisax_fcpcipnp: found adapter Fritz!Card PCI v2 at 0000:01:07.0

Ralf
-- 
Ralf Gerbig			// P:     Linus Torvalds
Dr. Heinz Schaefer & Partner	//-S:     Buried alive in diapers
				//+S:     Buried alive in reporters
				   patch-2.2.4
