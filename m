Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264841AbRGCQh5>; Tue, 3 Jul 2001 12:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264843AbRGCQhr>; Tue, 3 Jul 2001 12:37:47 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:11282 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S264841AbRGCQhh>;
	Tue, 3 Jul 2001 12:37:37 -0400
Date: Tue, 3 Jul 2001 12:42:14 -0400
Message-Id: <200107031642.f63GgEG25604@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: linux-kernel@vger.kernel.org
Subject: Cross-reference analysis reveals problems in 2.4.6pre9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to my cross-reference generator, the following symbols have
missing help in 2.4.6-pre9:

CONFIG_AU1000_UART
CONFIG_BLUEZ_L2CAP
CONFIG_DDB5477
CONFIG_EVB_PCI1
CONFIG_FORWARD_KEYBOARD
CONFIG_GDB_CONSOLE
CONFIG_HD64465_IOBASE
CONFIG_IT8172_REVC
CONFIG_IT8172_SCR0
CONFIG_IT8172_SCR1
CONFIG_LL_DEBUG
CONFIG_MAPLE
CONFIG_MAPLE_KEYBOARD
CONFIG_MAPLE_MOUSE
CONFIG_MIDI_VIA82CXXX
CONFIG_MIPS_EV64120
CONFIG_MIPS_EV96100
CONFIG_MIPS_ITE8172
CONFIG_MIPS_IVR
CONFIG_MIPS_PB1000
CONFIG_MIPS_UNCACHED
CONFIG_MTD_OCELOT
CONFIG_NINO
CONFIG_NINO_16MB
CONFIG_NINO_4MB
CONFIG_NINO_8MB
CONFIG_ORION
CONFIG_SH_7751_SOLUTION_ENGINE
CONFIG_ST40_LMI_MEMORY
CONFIG_SYSCLK_100
CONFIG_SYSCLK_75
CONFIG_SYSCLK_83
CONFIG_TULIP_MMIO

This list exposes a couple of problems:

1. CONFIG_ORION has been removed from the main MIPS config.in but is
   still referenced in drivers/net/config.in.

2. The MIPS config.in sets CONFIG_AU1000 but does not reference it,
   then references CONFIG_AU1000_UART without ever setting it.  This
   probably indicates that one of these is a mistake.

I have already written help entries for three other symbols CONFIG_DDB5477,
CONFIG_QTRONIX_KEYBOARD, and CONFIG_AGP_SWORKS.  Would responsible
maintainers please supply help entries for the above?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Boys who own legal firearms have much lower rates of delinquency and
drug use and are even slightly less delinquent than nonowners of guns."
	-- U.S. Department of Justice, National Institute of
	   Justice, Office of Juvenile Justice and Delinquency Prevention,
	   NCJ-143454, "Urban Delinquency and Substance Abuse," August 1995.
