Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264555AbTEPSqh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 14:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264559AbTEPSqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 14:46:36 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:1937 "EHLO gatekeeper.slim")
	by vger.kernel.org with ESMTP id S264555AbTEPSqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 14:46:34 -0400
Subject: PCMCIA always gives RequestIRQ: Resource in use kernel > 2.4.19
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1053111929.2707.10.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 May 2003 21:05:30 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am having no luck getting my PCMCIA card to work with regular kernels
other then 2.4.19. Somehow the kernels provided by RH do work but they
don't have (recent) ACPI support so that is not an option.

I have tried various kernels from plain 2.4.20 to 2.4.21pre's and ac's
to ck versions, they all give the same message:

cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcbfff
0xe0000-0xfffff
hermes.c: 5 Apr 2002 David Gibson <hermes@gibson.dropbear.id.au>
orinoco.c 0.11b (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.11b (David Gibson <hermes@gibson.dropbear.id.au> and
others)
orinoco_cs: RequestIRQ: Resource in use

Normally the orinoco driver gets IRQ 3 (I don't have any serial ports on
my laptop) but no luck with home compiled kernels while IRQ 3 is still
available. ACPI doesn't seem to be the problem, turning it off doesn't
help. Any solutions to this? I'd like to be able to use a more recent
kernel with ACPI support...:-(

Cheers,

Jurgen

===

lspci:

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 31)
00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev
d0)
00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
10/100 Ethernet (rev 82)
00:01.2 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB
Controller (rev 07)
00:01.3 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB
Controller (rev 07)
00:01.4 Multimedia audio controller: Silicon Integrated Systems [SiS]
SiS PCI Audio Accelerator (rev 02)
00:01.6 Modem: Silicon Integrated Systems [SiS] Intel 537 [56k Winmodem]
(rev a0)
00:02.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual
PCI-to-PCI bridge (AGP)
00:09.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 88)
00:09.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 88)
00:09.2 System peripheral: Ricoh Co Ltd: Unknown device 0576
00:0a.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21
IEEE-1394a-2000 Controller (PHY/Link)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]
SiS630 GUI Accelerator+3D (rev 31)





