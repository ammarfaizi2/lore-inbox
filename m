Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278514AbRJZOvg>; Fri, 26 Oct 2001 10:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278521AbRJZOvY>; Fri, 26 Oct 2001 10:51:24 -0400
Received: from web9602.mail.yahoo.com ([216.136.129.181]:36875 "HELO
	web9602.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S278514AbRJZOvP>; Fri, 26 Oct 2001 10:51:15 -0400
Message-ID: <20011026145150.94340.qmail@web9602.mail.yahoo.com>
Date: Fri, 26 Oct 2001 07:51:50 -0700 (PDT)
From: Tres Guinn <tresguinn@yahoo.com>
Subject: Re: PDC20265
To: David Grant <davidgrant79@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OE60CNAv9tZqiJBNDym00006d23@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have the exact message syntax, but I can tell
you what I was doing, and what happened.

I boot off my eide drive ( not off promise
controller),
load the modules ( insmod scsi_mod.o, and ft.o ( from
promise).

I get a message back from the insmod ft.o command
saying that it loaded the fasttrak software,
interesting enough is states IRQ7 ?  Weird cause the
CMOS boot messages state that the promise controller
is on IRQ10.

Anyway I do a fdisk /dev/sda and setup my partitions.

Then I issue a mkfs /dev/sda1 ( which defaults to ext2
).  It chunks along to around 140/537 and I receive a
TIMEOUT message from fasttrak, then there is a pause,
and then a Software Reset message.  A screen full on
I/O errors ( very quick output, can't get full text ).
and then the machine boots.

I don't know what is going on.  RH sees the drives
without the driver (ft.o) as ideE and ideG.  From what
I understand, after loading the ft.o module I am
supposed to access the Array as /dev/sda.

Thank you for your help,
Tres 
--- David Grant <davidgrant79@hotmail.com> wrote:
> No, not yet.  I had the same problem with Redhat 7.1
> as well.  I'm actually
> thinking it might have to do with the fact that I
> have some IRQ sharing
> going.  I actually was able to install Linux on this
> PC a few months ago.
> And I the only thing I changed since then, was that
> I added a network card
> (which I believe is now IRQ sharing with the Promise
> chip) and upgraded the
> BIOS.  I don't think the BIOS would cause a problem,
> so I think it might be
> the IRQ sharing, which also has something to do with
> ACPI, which is supposed
> to cause problems.
> 
> I really should unplug my network card, and see if
> that fixes things.  I
> just haven't gotten around to doing that yet.  Maybe
> I'll do it tonight.
> I'll keep you posted.
> 
> Another problem I just discovered it that my RAM has
> a few problems in it.
> I used memtest-86 and found a couple locations that
> are bad.  This may be
> causing a problem if the IDE drive writes to RAM and
> then checks if the
> write went okay.  If it discovers that the write did
> not occur properly, it
> will not send and IRQ back to the CPU, and maybe
> this is where the problem
> is.  RAM problems often cause unpredictable things.
> 
> Can you tell me the exact error messages you are
> getting?  And also post
> them to linux-kernel@vger.kernel.org?  Preferably,
> try using a new kernel,
> like 2.4.8 as included with Mandrake 7.1, or 2.4.7
> with Redhat 7.2.  I think
> some error messages may have changed across kernel
> revisions, but if you
> don't have easy access to new ISO's, don't worry
> about it.
> 
> David Grant
> 
> ----- Original Message -----
> From: "Tres Guinn" <tresguinn@yahoo.com>
> To: <davidgrant79@hotmail.com>
> Sent: Thursday, October 25, 2001 2:40 PM
> Subject: PDC20265
> 
> 
> > Did you ever get your controller working ?
> >
> > I have been trying to install REDHAT 7.1 using the
> > PDC20265 in RAID mode 0.  I get very similiar
> messages
> > to the ones your getting.
> >
> > I have gone to Promise and downloaded their
> drivers,
> > none of which seem to work.
> >
> > I could really use some help here.
> >
> > Tres
> >
> > __________________________________________________
> > Do You Yahoo!?
> > Make a great connection at Yahoo! Personals.
> > http://personals.yahoo.com
> >


__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
