Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264681AbSKZMP4>; Tue, 26 Nov 2002 07:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264679AbSKZMP4>; Tue, 26 Nov 2002 07:15:56 -0500
Received: from inway106.cdi.cz ([213.151.81.106]:51862 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S264665AbSKZMPw>;
	Tue, 26 Nov 2002 07:15:52 -0500
Date: Tue, 26 Nov 2002 13:21:25 +0100 (CET)
From: devik <devik@cdi.cz>
X-X-Sender: <devik@devix>
To: <linux-smp@vger.kernel.org>
cc: <linux-kernel@vger.kernel.org>
Subject: IO-APIC on SiS P4 messes interrupts
Message-ID: <Pine.LNX.4.33.0211261307200.530-100000@devix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I used two MSI 8533 mobos for our 1U rack servers.
These mobos are for P4 and uses SiS 5513 chipset.
They have integrated VGA and NIC (RTL8139).

When I boot 2.4.19 or 2.4.20rc2 with IO-APIC enabled
the NIC doesn't work. It get IRQ 18 (instead of
IRQ 11 in non-ioapic mode) but IRQ routing is bad
because it got no irqs at that line.

When booting kernel complaints that APIC is unknown
and that I should write to linux-smp@vger.kernel.org.

I tried to use pirq=0,0,0,0,0,11 which assigns IRQ 11
to NIC but still it got no interrupts.

In order to keep this mail short, I placed dmesg,
lspci -vv and cat /proc/interrupts from all three
cases (noapic, apic, pirq) at:
http://luxik.cdi.cz/~devik/tmp/apic/

Let me know if I can do more (root access to the machine
would be possible during this week).

I'd appreciate if you Cc me in replies.
Best regards,
-------------------------------
    Martin Devera aka devik
Linux kernel QoS/HTB maintainer
  http://luxik.cdi.cz/~devik/

