Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266753AbTGFXIq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 19:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266759AbTGFXIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 19:08:46 -0400
Received: from pop.gmx.net ([213.165.64.20]:39125 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266753AbTGFXIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 19:08:44 -0400
Date: Mon, 7 Jul 2003 01:23:15 +0200
From: diemumiee@gmx.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ATI IGP Support and System Freeze when running hwclock
Message-ID: <20030706232315.GA32461@durix.hallo.net>
References: <20030706144114.GA23881@durix.hallo.net> <1057513936.1029.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057513936.1029.5.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
the ATI host bridge of igp mainboards is still not supported yet. 
Loading agpgart fails... 
lspci : 
00:00.0 Host bridge: ATI Technologies Inc: Unknown device cab0 (rev 13)
00:01.0 PCI bridge: ATI Technologies Inc PCI Bridge [IGP 320M] (rev 01)
00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 02)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:08.0 Modem: ALi Corporation Intel 537 [M5457 AC-Link Modem]
00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4)
00:11.0 Bridge: ALi Corporation M7101 PMU
00:12.0 Ethernet controller: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
01:05.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility U1
	
I installed 2.4.21-ac with acpi. Acpi works great, but the whole system
freezes when i try to run "hwclock --adjust --localtime". The module
rtc.o gets loaded before the call to hwclock. 

Regards, 
Andreas Pokorny

On Sun, Jul 06, 2003 at 06:52:17PM +0100, Alan Cox wrote:
> On Sul, 2003-07-06 at 15:41, diemumiee@gmx.de wrote:
> > Hi, 
> > Is there currently any work done at the ATI IGP 320 chipsets?
> > Any kernel patches that I could test?
> 
> It should work nicely with a 2.4.21-ac kernel built with ACPI support,
> or a 2.4.22pre kernel
