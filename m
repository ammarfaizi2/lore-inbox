Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130509AbRASAa7>; Thu, 18 Jan 2001 19:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135463AbRASAaj>; Thu, 18 Jan 2001 19:30:39 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:30481
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130509AbRASAac>; Thu, 18 Jan 2001 19:30:32 -0500
Date: Thu, 18 Jan 2001 16:30:04 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: RE: [PATCH] PCI-Devices and ServerWorks chipset (fwd)
Message-ID: <Pine.LNX.4.10.10101181624230.23328-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


LKML,

Here is Kim's response to the two issues and they are working on it.
I removed address, email, phone numbers because it is my decission to do
so to protect the positive entry points that I have made to prevent a
flame mail box for this guy.

Flame me, you will get it back.
Evolution is now the key now that Revolution is established.

Regards,

Andre Hedrick
Linux ATA Development

---------- Forwarded message ----------
Date: Thu, 18 Jan 2001 14:44:00 -0800
From: Kim <snip>
To: Andre Hedrick <andre@linux-ide.org>
Cc: <snip>
Subject: RE: [PATCH] PCI-Devices and ServerWorks chipset (fwd)

Andre,

We really appreciate your keeping this in front of us.  As you can imagine,
support personnel are stretched really thin here.  The guy who is the expert
on this is out today, and it may be next week before we can get the answers
to the questions here.  However, from your comments below, it appears that
you understand we must defend our IP (the guts of it anyway) and that we
must be making good parts that are finding their way into lots of servers.
Linux is a keen focus here, as we do see it as the future, both as a
platform and as a business model.  It is putting pressure on proprietary
software makers to clean up their acts.  We are also hard at work getting
ready for the next generation of Intel servers that will come out later this
year.

We are working to put the documentation for the open interfaces (e.g. ATA,
AGP, SMBus) to our IP up on Linux web sites such as SourceForge so the Linux
community can make use of it.  Again, we appreciate your patience and hope
you and the Linux community can bear with us while we modify our business
model to better work with you folks.

Kim
VP, Business Development
<snip>
<snip>
<snip>



-----Original Message-----
From: Andre Hedrick [mailto:andre@linux-ide.org]
Sent: Thursday, January 18, 2001 9:58 AM
To: Kim <snip>
Subject: Re: [PATCH] PCI-Devices and ServerWorks chipset (fwd)



Second series of questions to be answered.

Cheers,

Andre Hedrick
Linux ATA Development

---------- Forwarded message ----------
Date: Thu, 18 Jan 2001 12:08:03 +0100 (MET)
From: Maciej W. Rozycki <macro@ds2.pg.gda.pl>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Dan Hollis <goemon@sasami.anime.net>, Martin Mares <mj@suse.cz>,
     Adam Lackorzynski <al10@inf.tu-dresden.de>,
     Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI-Devices and ServerWorks chipset

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

> >  I was asking for a few I/O APIC details -- apparently there are
problems
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

> >  And I don't actually care.  If they want to lose in the Linux area,
it's
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


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
