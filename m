Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278176AbRJLWOK>; Fri, 12 Oct 2001 18:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278177AbRJLWOA>; Fri, 12 Oct 2001 18:14:00 -0400
Received: from balu.sch.bme.hu ([152.66.208.40]:31709 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S278176AbRJLWNu>;
	Fri, 12 Oct 2001 18:13:50 -0400
Date: Sat, 13 Oct 2001 00:14:01 +0200 (MEST)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: Wakko Warner <wakko@animx.eu.org>
cc: Mike Panetta <mpanetta@applianceware.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, <andre@linux-ide.org>
Subject: Re: IDE Hot-Swap, does it work?, Conspiracy is afoot! (more questions)
In-Reply-To: <20011012172955.B12857@animx.eu.org>
Message-ID: <Pine.GSO.4.30.0110130008070.18155-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been too asked this question two times in the list, and i haven't
received any useful answer.

Wakko, could you tell me in detail how to use hdparm -R and -U, because i
couldn't get it work. Does it (or shoudl it) work for harddisks too?

What chipset/hardware supports ide-hot-swap, and which of these are
supported in linux?
Under The Other Operating System 2000 i have seen this working on a few
machines for example on an asus cusl2 mobo, so that chipset (i think
intel 815e) at least can got to do this job.

Please someone with more knowledge enlighten me, beaces i really hate
rebooting just to remove or add a harddisk.

On Fri, 12 Oct 2001, Wakko Warner wrote:

> I've done this with my IDE cdrom in my laptop.  It's hot swappable and I
> asked about this at one time.  In the source package for hdparm (i know it's
> in the debian's source package) there's a script for hot add/remove of ide
> devices.  there's a nice warning attached about ide hotswap
>
> > Ok, I have played with this a bit since I have recieved no
> > real respose other than one other person having the same
> > question, here is what I have found out...
> >
> > I have a piece of hardware that does have hot-swap IDE
> > chassis on it, so atleast the IDE bus xcvers should be
> > able to handle the swapping, as the connection to the
> > drive is disabled before the can comes all the way out
> > of the slot.
> >
> >  - I can remove a drive while the system is on and I have
> >    a software raid 5 on the 4 drives, everything is ok
> >    after about 2 minutes the system recovers and the software
> >    raid fails the drive I removed.  This makes sense.
> >  - After a few minutes I replace the drive I had just failed
> >    by removing it, and I try to readd it to the system via
> >    raidhotadd.  One of 2 things happens in this instance,
> >    depending on what kernel I have loaded.
> >     - If I have kernel 2.4.2-2 loaded (a stock redhat 7.1
> >       kernel), the drive reappears, and can be added back
> >       to the raid (and is added back).
> >     - If I am running kernel 2.4.10 or any later (AC or non)
> >       the machine fails to ever be able to read from the disk
> >       again.  I cannot readd the disk to the arry, nor can I
> >       fdisk it (or access it in any other way).
> >  - None of this solves the adding of a drive to the system
> >    where there was none before boot...  I tried the hdparm -R
> >    stuff but its useless and hangs my box no matter what I give
> >    it as paramaters.  This of course may be because I do not
> >    know how to use it very well...
> >
> > If anyone can help it would be greatly appreciated.  I am
> > really beginning to believe that IDE will never be as capable
> > as SCSI in this reguard, atleast not in linux, espically as
> > any (even if it was broken) support that used to be in the
> > kernel has disappeared. Please someone convince me otherwise!
> > Atleast point me in the correct direction as to what in the
> > kernel would have to be changed to make this work...
> >
> > Thanks,
> > Mike
> >
> > --
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> --
>  Lab tests show that use of micro$oft causes cancer in lab animals
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
Pozsar Balazs.

