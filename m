Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbTCDWja>; Tue, 4 Mar 2003 17:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbTCDWja>; Tue, 4 Mar 2003 17:39:30 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:63499
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261934AbTCDWj3>; Tue, 4 Mar 2003 17:39:29 -0500
Date: Tue, 4 Mar 2003 17:46:35 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: raarts@office.netland.nl
cc: Linus Torvalds <torvalds@transmeta.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       "" <david.knierim@tekelec.com>, "" <alexander@netintact.se>,
       Donald Becker <becker@scyld.com>, Greg KH <greg@kroah.com>,
       jamal <hadi@cyberus.ca>, Jeff Garzik <jgarzik@pobox.com>,
       "" <kuznet@ms2.inr.ac.ru>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Olsson <Robert.Olsson@data.slu.se>
Subject: Re: PCI init issues
In-Reply-To: <3E650061.9050201@netland.nl>
Message-ID: <Pine.LNX.4.50.0303041742420.5867-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0303041046370.1426-100000@home.transmeta.com>
 <3E650061.9050201@netland.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Mar 2003, Ron Arts wrote:

> > So there are at least two potential reasons for that:
> > 
> >  - The MP table is simply wrong, and WinXP gets the routing information 
> >    from somewhere else (ie most likely ACPI)
> > 
> >  - The MP table is right, and only pin0 is connected, and WinXP only uses 
> >    pin0 (ie it puts the card in some state where all irqs are shared 
> >    across all of the four tulip chips).
> > 
> > Maybe somebody can come up with other schenarios.
> > 
> > It would be interesting to hear what "Device Manager" (or whatever it is
> > called) unde WinXP claims the interrupts are on this machine... Are they
> > all on irq 48 on XP too? Or has XP gotten magic knowledge somewhere
> > (ACPI?) and they are on different irq's?
> > 
> > 		Linus

How about using 'mptable' (Authored by Pete Zaitcev) to view the 
bus,pin and ioapic layout? It showed all the INTA,B,C,D pins on a 
troublesome system of mine and helped track down the problem.

http://people.redhat.com/zaitcev/linux/mptable-2.0.15a-1.i386.rpm
http://people.redhat.com/zaitcev/linux/mptable-2.0.15a-1.src.rpm

Regards,
	Zwane
-- 
function.linuxpower.ca
