Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVCWMYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVCWMYa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 07:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVCWMYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 07:24:30 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:673 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261552AbVCWMYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 07:24:25 -0500
Date: Wed, 23 Mar 2005 13:24:23 +0100
From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
To: linux-kernel@vger.kernel.org
Subject: [Bug] invalid mac address after rebooting (kernel 2.6.11.5)
Message-ID: <20050323122423.GA24316@faui00u.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm hitting an annoying bug in kernel 2.6.11.5

Every time I _reboot_ (warmstart) my pc my two network cards won't get
recognized any longer.

Following error message appears on my screen:

PCI: Enabling device 0000:00:0b.0 (0000 -> 0003)
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0b.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1000. Vers LK1.1.19
PCI: Setting latency timer of device 0000:00:0b.0 to 64
*** EEPROM MAC address is invalid.
3c59x: vortex_probe1 fails.  Returns -22
3c59x: probe of 0000:00:0b.0 failed with error -22
PCI: Enabling device 0000:00:0d.0 (0000 -> 0003)
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 19 (level, low) -> IRQ 19
0000:00:0d.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1080. Vers LK1.1.19
PCI: Setting latency timer of device 0000:00:0d.0 to 64
*** EEPROM MAC address is invalid.
3c59x: vortex_probe1 fails.  Returns -22
3c59x: probe of 0000:00:0d.0 failed with error -22

This doesn't happen with older kernels (especially with 2.6.10) and so
I've done a binary search and narrowed it down to 2.6.11-rc5 where it
first hits me.

My config, lspci output and the dmesg output of the working and non-working
version can be found at [1]

Feel free to ask if any information is missing or if I am supposed to try
a patch.

Greetings,
  Peter Baumann

PS: Please reply to me directly as I am not subscribed to lkml

[1] http://wwwcip.informatik.uni-erlangen.de/~siprbaum/kernel
