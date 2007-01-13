Return-Path: <linux-kernel-owner+w=401wt.eu-S1751254AbXAMLvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbXAMLvl (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 06:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030179AbXAMLvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 06:51:41 -0500
Received: from torres.zugschlus.de ([85.10.211.154]:51911 "EHLO
	torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbXAMLvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 06:51:41 -0500
Date: Sat, 13 Jan 2007 12:51:39 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: PCI: Bus #05 (-#08) is hidden behind transparent bridge #02
Message-ID: <20070113115139.GA24858@torres.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when booting my hp compaq nc 8000, the 2.6.19.2 kernel log asks me to
report something to linux-kernel which I am doing now:

Jan 13 12:44:13 scyw00225 kernel: PCI: Probing PCI hardware (bus 00)
Jan 13 12:44:13 scyw00225 kernel: ACPI: Assume root bridge [\_SB_.C044] bus is 0
Jan 13 12:44:13 scyw00225 kernel: PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
Jan 13 12:44:13 scyw00225 kernel: PCI quirk: region 1100-113f claimed by ICH4 GPIO
Jan 13 12:44:13 scyw00225 kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Jan 13 12:44:13 scyw00225 kernel: Boot video device is 0000:01:00.0
Jan 13 12:44:13 scyw00225 kernel: PCI: Transparent bridge - 0000:00:1e.0
Jan 13 12:44:13 scyw00225 kernel: PCI: Bus #05 (-#08) is hidden behind transparent bridge #02 (-#05) (try 'pci=assign-busses')
Jan 13 12:44:13 scyw00225 kernel: Please report the result to linux-kernel to fix this permanently
Jan 13 12:44:13 scyw00225 kernel: PCI: Bus #09 (-#0c) is hidden behind transparent bridge #02 (-#05) (try 'pci=assign-busses')
Jan 13 12:44:13 scyw00225 kernel: Please report the result to linux-kernel to fix this permanently
Jan 13 12:44:13 scyw00225 kernel: ACPI: PCI Interrupt Routing Table [\_SB_.C044._PRT]
Jan 13 12:44:13 scyw00225 kernel: ACPI: PCI Interrupt Routing Table [\_SB_.C044.C045._PRT]
Jan 13 12:44:13 scyw00225 kernel: ACPI: PCI Interrupt Routing Table [\_SB_.C044.C056._PRT]
Jan 13 12:44:13 scyw00225 kernel: ACPI: Power Resource [C16D] (on)
Jan 13 12:44:13 scyw00225 kernel: ACPI: Power Resource [C184] (on)
Jan 13 12:44:13 scyw00225 kernel: ACPI: Power Resource [C18B] (on)
Jan 13 12:44:13 scyw00225 kernel: ACPI: Power Resource [C195] (on)
Jan 13 12:44:13 scyw00225 kernel: ACPI: Power Resource [C0E6] (on)

When I try pci=assign-busses on the kernel command line, the four
lines vanish:

Jan 13 12:29:29 scyw00225 kernel: PCI: Probing PCI hardware (bus 00)
Jan 13 12:29:29 scyw00225 kernel: ACPI: Assume root bridge [\_SB_.C044] bus is 0
Jan 13 12:29:29 scyw00225 kernel: PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
Jan 13 12:29:29 scyw00225 kernel: PCI quirk: region 1100-113f claimed by ICH4 GPIO
Jan 13 12:29:29 scyw00225 kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Jan 13 12:29:29 scyw00225 kernel: Boot video device is 0000:01:00.0
Jan 13 12:29:29 scyw00225 kernel: PCI: Transparent bridge - 0000:00:1e.0
Jan 13 12:29:29 scyw00225 kernel: ACPI: PCI Interrupt Routing Table [\_SB_.C044._PRT]
Jan 13 12:29:29 scyw00225 kernel: ACPI: PCI Interrupt Routing Table [\_SB_.C044.C045._PRT]
Jan 13 12:29:29 scyw00225 kernel: ACPI: PCI Interrupt Routing Table [\_SB_.C044.C056._PRT]
Jan 13 12:29:29 scyw00225 kernel: ACPI: Power Resource [C16D] (on)
Jan 13 12:29:29 scyw00225 kernel: ACPI: Power Resource [C184] (on)
Jan 13 12:29:29 scyw00225 kernel: ACPI: Power Resource [C18B] (on)
Jan 13 12:29:29 scyw00225 kernel: ACPI: Power Resource [C195] (on)
Jan 13 12:29:29 scyw00225 kernel: ACPI: Power Resource [C0E6] (on)

I do not have a single clue what that mean; the notebook runs fine
just with or without pci=assign-busses. 

Is there something I shold do? Is there something you should do with
the kernel?

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 621 72739835
