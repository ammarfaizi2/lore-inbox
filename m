Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbTLEMOx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 07:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264118AbTLEMOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 07:14:53 -0500
Received: from aun.it.uu.se ([130.238.12.36]:21655 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264113AbTLEMOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 07:14:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16336.30392.344028.347132@alkaid.it.uu.se>
Date: Fri, 5 Dec 2003 13:14:48 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Josh McKinney <forming@charter.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
In-Reply-To: <20031205083349.GA15152@forming>
References: <20031205045404.GA307@tesore.local>
	<16336.13962.285442.228795@alkaid.it.uu.se>
	<20031205083349.GA15152@forming>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh McKinney writes:
 > On approximately Fri, Dec 05, 2003 at 08:40:58AM +0100, Mikael Pettersson wrote:
 > > Jesse Allen writes:
 > >  > Hi,
 > >  > 
 > >  > I have a NForce2 board and can easily reproduce a lockup with grep on an IDE 
 > >  > hard disk at UDMA 100.  The lockup occurs when both Local APIC + IO-APIC are 
 > >  > enabled.  It was suggested to me to use NMI watchdog to catch it.  However, the 
 > >  > NMI watchdog doesn't seem to work.
 > >  > 
 > >  > When I set the kernel parameter "nmi_watchdog=1" I get this message in 
 > >  > /var/log/syslog:
 > >  > Dec  4 20:10:30 tesore kernel: ..MP-BIOS bug: 8254 timer not connected to 
 > >  > IO-APIC
 > >  > Dec  4 20:10:30 tesore kernel: timer doesn't work through the IO-APIC - 
 > >  > disabling NMI Watchdog!
 > >  > 
 > >  > "nmi_watchdog=2" seems to work at first, In /var/log/messages:
 > >  > Dec  4 20:13:11 tesore kernel: testing NMI watchdog ... OK.
 > >  > but it still locks up.
 > > 
 > > The NMI watchdog can only handle software lockups, since it relies on
 > > the CPU, and for nmi_watchdog=1 the I/O-APIC + bus, still running.
 > > Hardware lockups result in, well, hardware lockups :-(
 > 
 > So does this confirm that the lockups with nforce2 chipsets and apic
 > is actually a hardware problem after all? 

Confirm with very high probability. There may be quirks in nVidia's
chipset that we (unlike their Windoze drivers) don't know about.

Ask nVidia for detailed chipset documentation. Then maybe we can fix this.
