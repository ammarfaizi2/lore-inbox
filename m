Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290277AbSBKTpk>; Mon, 11 Feb 2002 14:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290284AbSBKTpa>; Mon, 11 Feb 2002 14:45:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49938 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290277AbSBKTpY>; Mon, 11 Feb 2002 14:45:24 -0500
Subject: Re: A7M266-D works?
To: jussi.laako@kolumbus.fi (Jussi Laako)
Date: Mon, 11 Feb 2002 19:59:04 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C681575.BED51812@kolumbus.fi> from "Jussi Laako" at Feb 11, 2002 09:03:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16aMbQ-0007jI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm considering to buy ASUS A7M266-D mobo and wondering if there is fix for
> the APIC problems or is there workaround to get that mobo work? If it not
> currently, is there some estimate if it will work in near future?

The current status on the board I'm using

-	The BIOS appears to misconfigure the PCI setup badly, so badly I've
	been sticking in PCI quirk fixups to make some drivers work
-	MP 1.4 locks solid MP 1.1 is ok - that may be a Linux bug. I have a
	patch to test there
-	The onboard USB was removed and swapped for a plug in card wasting
	a slot (but you do get USB2 now). The manual wasn't updated
-	The disk led appears to be marked wrongly. If you wire it the 
	board won't POST
-	If you put a 33Mhz card in the 64bit slots the board won't POST
	unless you configure the board the way the manual suggests you don't
-	Expect to want > 400W PSU if you have lots of disks. I ended up 
	using a 550W PSU
-	Use a _BIG_ case. With anything but a large tower and actual
	case fans you are not going to get enough ventilation or cable
	room

Having said all that - when you figure through the mess that ASUS calls
QA and documentation (and they should be firing people for shipping it in
its current state quite frankly) it goes like a bat out of hell. With dual
Athlon 1800MP+ processors and hardware raid for the filestore and swap its
building the entirity of XFree86 in 30 minutes wall time (5 of which are
doing non parallelisable work and 5 or so of which are spent in I/O wait)

Nice hardware, lousy docs, dreadful BIOS.
