Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130913AbRARLVF>; Thu, 18 Jan 2001 06:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131378AbRARLU4>; Thu, 18 Jan 2001 06:20:56 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:42482 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S130913AbRARLUo>; Thu, 18 Jan 2001 06:20:44 -0500
Date: Thu, 18 Jan 2001 12:08:03 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andre Hedrick <andre@linux-ide.org>
cc: Dan Hollis <goemon@sasami.anime.net>, Martin Mares <mj@suse.cz>,
        Adam Lackorzynski <al10@inf.tu-dresden.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI-Devices and ServerWorks chipset
In-Reply-To: <Pine.LNX.4.10.10101180133460.20569-100000@master.linux-ide.org>
Message-ID: <Pine.GSO.3.96.1010118111629.8140F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2001, Andre Hedrick wrote:

> I can get any info needed, you just have to define the scope.

 Good.

> Then will not can and will not give out details on a generic form.

 Weird.  Others somehow are able to provide specs.  Documentation for the
entire line of Intel chipsets is available, for example.

> In short no one person can see the entire design docs or will they get
> them without a NDA.  I have seen why this is the case, cause the toy are
> cool.

 I don't need design docs -- I need programming specs.

> >  I was asking for a few I/O APIC details -- apparently there are problems
> > with 8254 interoperability and we have to use the awkward through-8259A
> > mode for the timer tick.
> 
> Narrow the point.

 The output of the 8254's timer 0 does not appear to be connected to any
I/O APIC input.  It is connected to the IR0 line of the master 8259A as
usual.  The 8254, both 8259As and both I/O APICs are all internal to the
chipset.

 The question is: "Is it possible to use the 8254 timer interrupt
natively, i.e. is it possible to reconfigure the chipset to route the
interrupt source to any I/O APIC with no 8259A logic in the way?"  It's
nice we have the through-8259A trick, but I developed it solely as a
workaround to support the old Intel 82350 EISA chipset, commonly used for
old APIC SMP systems, which did not route IRQ0 externally just because it
was designed long before the 82489DX APIC.  It just should not be used for
modern systems -- it's too fragile.

> >  And I don't actually care.  If they want to lose in the Linux area, it's
> > their own choice. 
> 
> You don't get it, they OEM board designs for Compaq and Dell.
> These guys will work with you on-site but in their sand-box not yours.

 What don't I get?  If Compaq and Dell chose the ServerWorks chipset, then
until (unless) docs are available, it's their problem to support Linux on
their systems.  It's certainly not mine. 

> I wish I could say more, but I have something more powerfully than any NDA
> ever written.  I have given my word and a handshake, and that has more
> value to me than any stupid NDA.  The very fact that I value this so much
> and so many in the industry know this about me, I have been shown things
> without NDA's that you never see otherwise.

 Nobody seems to push you to leak information you cannot give for a
reason, and certainly neither do I.

> They are very friendly to Linux, but can we be friendly to them?

 I'm neutral at the moment.  Their friendship appears to be purely
declarational at the moment.  They do neither provide docs nor answer
specific question.  I've already asked them the question I quoted above. 
I got no answer.  Neither did the user of the system affected, who
contacted them as well.  So I'm just sitting and watching the situation. 

> You just can not barge in and demand to see their IP.

 I do not demand anything.  I'm just not willing to work on problems with
hardware the manufacturer refuses to document.  Anyone feel free to
undertake this task.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
