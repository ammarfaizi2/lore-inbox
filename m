Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265063AbUBOQHX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 11:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265078AbUBOQHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 11:07:23 -0500
Received: from web14903.mail.yahoo.com ([216.136.225.55]:46483 "HELO
	web14903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265063AbUBOQHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 11:07:21 -0500
Message-ID: <20040215160719.44114.qmail@web14903.mail.yahoo.com>
Date: Sun, 15 Feb 2004 08:07:19 -0800 (PST)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [BK PATCHES] 2.6.x libata update
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running RAID-1 on ICH5, 82801EB. One SATA and one IDE drive in array.
Hyperthread enabled CPU.

Is this right? My ATA drive is on ide0. Because of the RAID my IDE and SATA
drives should have about the same number of interrupts. But half of my IDE
interrupts are showing up on ide1, on CPU #1. There shouldn't be any interrupts
showing up on CPU#1 with hyperthreading.


[root@smirl proc]# cat interrupts
           CPU0       CPU1
  0:    2875672          0    IO-APIC-edge  timer
  1:       1917          0    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 12:         50          0    IO-APIC-edge  i8042
 14:      65443          0    IO-APIC-edge  ide0
 15:      59174          1    IO-APIC-edge  ide1
 16:          0          0   IO-APIC-level  uhci_hcd, uhci_hcd
 17:        688          0   IO-APIC-level  Intel ICH5
 18:     163152          0   IO-APIC-level  libata, uhci_hcd, eth0
 19:      54864          0   IO-APIC-level  uhci_hcd
 22:          3          0   IO-APIC-level  ohci1394
 23:          0          0   IO-APIC-level  ehci_hcd
NMI:          0          0
LOC:    2875702    2875706
ERR:          0
MIS:          0


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! Finance: Get your refund fast by filing online.
http://taxes.yahoo.com/filing.html
