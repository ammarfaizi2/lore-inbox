Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266113AbTGLQIr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 12:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266164AbTGLQGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 12:06:50 -0400
Received: from yankee.rb.xcalibre.co.uk ([217.8.240.35]:59523 "EHLO
	yankee.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S266153AbTGLQGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 12:06:23 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair J Strachan <alistair@devzero.co.uk>
To: linux-kernel@vger.kernel.org
Subject: APIC & ACPI on EPoX 8RDA+ (nForce 2)
Date: Sat, 12 Jul 2003 17:21:05 +0100
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200307121721.05221.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A recent 2.5 kernel compiled with local and IO APIC support fails to boot on 
an EPoX 8RDA+ (nForce2) mainboard. It does not make any difference whether 
ACPI is enabled or disabled. Has anybody else had problems with this board 
and APIC? I've fiddled in the BIOS, but only disabling the BIOS APIC allows 
me to boot 2.5.75-mm1 (or, clearly, not compiling in APIC support).

The second (unrelated) issue is that if I allow the ACPI in 2.5 to control PCI 
routing, I observe loads of IRQ dropouts on the USB 1.1 and USB 2 IRQs (5, 
10, and 11 respectively). The number of interrupts shown in /proc/interrupts 
is an unrealistic constant for the IRQs and the devices (USB) are not 
initialised.

irq 5: nobody cared!
irq 10: nobody cared!
irq 11: nobody cared!
etc.

Not compiing in ACPI support fixes it, but I also discovered that passing in 
pci=noacpi allows the USB devices to initialise and everything works just 
fine. I don't get the "nobody cared" messages if pci=noacpi is added to the 
cmdline.

Are both of these known issues with the EPoX 8RDA+ mainboard? I've got the 
BIOS from the June 9th 2003, "06/09/2003", which I believe is the latest.

TIA,
Alistair.
