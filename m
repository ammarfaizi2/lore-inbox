Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266453AbTBMEsf>; Wed, 12 Feb 2003 23:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267809AbTBMEse>; Wed, 12 Feb 2003 23:48:34 -0500
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:772
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S266453AbTBMEse>; Wed, 12 Feb 2003 23:48:34 -0500
Date: Wed, 12 Feb 2003 23:59:15 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: Adam Belay <ambx1@neo.rr.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Update on IRQ/DMA conflict w/ 2.5.60 and ISA PnP SB...
In-Reply-To: <Pine.LNX.4.44.0302121035420.147-100000@coredump.sh0n.net>
Message-ID: <Pine.LNX.4.44.0302122350330.183-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It appears if I disable IBM's OS PnP BIOS support. I get no more conflicts
with the SB card. As for the ISA PnP USRobotics modem, I can't tell if it
works or not.

ttyS0 at I/O 0x3f8 (irq = 3) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A

We report duplicate IRQs for COM1/COM2 however, the IBM BIOS *REFUSES*
all conflicts and will not allow shared communication ports. This is
bogus.

BIOS has this set:
ttyS0 = IRQ 4
ttyS1 = IRQ 3
-
ttyS2 = Determined by PnP

Shawn.

