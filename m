Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314085AbSFTMVb>; Thu, 20 Jun 2002 08:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSFTMVa>; Thu, 20 Jun 2002 08:21:30 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:55818 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S314085AbSFTMVa>; Thu, 20 Jun 2002 08:21:30 -0400
Message-ID: <3D11C8BC.5A14379C@aitel.hist.no>
Date: Thu, 20 Jun 2002 14:21:16 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.22nopreempt i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-kernel@vger.kernel.org
Subject: Re: The buggy APIC of the Abit BP6
References: <Pine.GSO.3.96.1020619144446.15094G-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" wrote:
> 
> On Tue, 18 Jun 2002, Robbert Kouprie wrote:
> 
> > Problem now is, in the ack_none function we only know about the
> > (illegal) vector we are getting, and not about the interrupt we need to
> > reset. Could there be some kind of link between these, so that
> > kick_IO_APIC_irq can be called from there?
> 
>  You get an invalid vector delivered due to massive transmission errors at
> the inter-APIC bus.  The errors are a serious hardware problem that cannot
> and should not be fixed in software.

Yes, the hardware is at fault.  I don't have money for 
other hardware though, so working around it seems a good idea.  

We could simplify the IDE driver a lot by dropping support for
all the broken controllers too. Or tell
people to not use DMA on them.


Of course such an option should default to OFF, and
perhaps live under "dangerous."  It can keep the
BP6 going much longer, which is good enough
for a home machine.

Failing due to a stuck NIC after one week seems worse
than crashing due to a scrambled IPI after some months.
There are more interrupts than IPI's.

This sort of fix don't really make things worse, the 
theoretical scrambled IPI will happen without it too.
The safe solution is NOAPIC, this fix simply makes it work
for a longer time using the bad apic.
 
> 
>  I'm told getting a better PSU may help, though.
Unfortunately not.  I got a nice PSU when I ordered the BP6, 
thinking that power was the only issue. (It was the only
cheap dual solution at the time.)

Helge Hafting
