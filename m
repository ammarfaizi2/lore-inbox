Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269389AbUI3SO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269389AbUI3SO5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 14:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269384AbUI3SO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 14:14:57 -0400
Received: from viefep17-int.chello.at ([213.46.255.23]:5138 "EHLO
	viefep17-int.chello.at") by vger.kernel.org with ESMTP
	id S269389AbUI3SOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 14:14:11 -0400
Date: Thu, 30 Sep 2004 20:14:05 +0200 (CEST)
From: peter.gantner@stud.uni-graz.at
X-X-Sender: nephros@scourge.crownest.net
To: linux-kernel@vger.kernel.org
Subject: Re: OHCI_QUIRK_INITRESET (was: 2.6.9-rc2-mm2 ohci_hcd doesn't work)
Message-ID: <Pine.LNX.4.61.0409301414020.18259@scourge.crownest.net>
X-Iron-Prison: The Empire never ended.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The problem seems to affect more chipsets than suspected.
Is it possible that it is indeed not a quirk as David Brownell suspects?
I am getting this:

ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI interrupt 0000:02:00.0[D] -> GSI 19 (level, low) -> IRQ 19
ohci_hcd 0000:02:00.0: Advanced Micro Devices [AMD] AMD-768 [Opus] USB
ohci_hcd 0000:02:00.0: irq 19, pci mem 0xd3000000
ohci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:02:00.0: init err (00002edf 0000)
ohci_hcd 0000:02:00.0: can't start
ohci_hcd 0000:02:00.0: init error -75
ohci_hcd 0000:02:00.0: remove, state 0
ohci_hcd 0000:02:00.0: USB bus 1 deregistered
ohci_hcd: probe of 0000:02:00.0 failed with error -75


the deviceinfo from lspci -n/-v:

0000:02:00.0 Class 0c03: 1022:7449 (rev 07)

0000:02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev 07) (prog-if 10 [OHCI])
         Subsystem: Asustek Computer, Inc.: Unknown device 8044
         Flags: medium devsel, IRQ 19
         Memory at d3000000 (32-bit, non-prefetchable)


If wanted I will test with a USB debug enabled kernel as soon as I physically 
get to my box.

It would be nice if you'd cc me on Reply as I'm not subscribed.

Greets,
 	Peter G.

-- 
"I do not think the way you think I think."
     -- Kai, last of the Brunnen G
