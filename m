Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161451AbWBUJqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161451AbWBUJqp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 04:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932722AbWBUJqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 04:46:45 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:18355 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932721AbWBUJqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 04:46:45 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 21 Feb 2006 10:44:47 +0100
To: schilling@fokus.fraunhofer.de, dhazelton@enter.net
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43FAE10F.nailD121QL6LN@burner>
References: <43EB7BBA.nailIFG412CGY@burner>
 <200602171502.20268.dhazelton@enter.net>
 <43F9D771.nail4AL36GWSG@burner>
 <200602201302.05347.dhazelton@enter.net>
In-Reply-To: <200602201302.05347.dhazelton@enter.net>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"D. Hazelton" <dhazelton@enter.net> wrote:

> > I do use autoconf in the only senseful way.
> >
> > And if you did have a look at the schily makefile system you would know
> > that it provides protability to more plaforms than you get from using an
> > GNU autoconf the way the GNU people tell you.
> >
> > If you like best portability, you need to use my version of autoconf inside
> > the schily makefile system and you need to use my smake instead of GNU
> > make.
> >
> > So my conclusion is that you did not understand portability. All my
> > software is using layered portability and if you did take a closer look at
> > the few FSF people who know what they are talking about, you would find
> > that e.g. Paul Eggert recently started to silently imitate my portability
> > methods.....
>
> I have taken a second look and it does appear that you are correct. But I 
> still have some doubts (none that I can quantify) - would it not make sense 
> to also use automake?

The way autoconf should be used acording to the autoconf manual is already
wrong and the creation of just another makefile generator, that even is 
incorrectly called "automake", is definitely a step into the wrong direction.

David Korn recently discovered that my makefile system basically does the same 
as his system. But while he need to write a "make successor" "nmake", I was able 
to do the same using "make".

The ideas that I am sucessfully using since more than 12 years is what researchers
did start around 1985. 

GNU autoconf (used the documented way) or "automake" is trying to do things in 
a way that did look apropriate in the 1970s. 

People should look at better solutions (like my makefile system) that do not 
need to modify makefiles in place but rather implement object oriented design
that depend on a "table like" master makefile and for this reason allow to 
concurrently compile on _all_ supported platforms on the same source tree
in case that the tree is mounted via NFS.


> > One problem is that GNU make is not working in a useful way on many
> > patforms that are listed to be working. GNU make is unmaintained since many
> > years and a serious bug I reported in 1999 still has not been fixed.
>
> Apparently true - the version of gmake I use is four years old. Too bad almost 
> everything on my system relies on the quirks and features of gmake...

Try to use my smake to find out whether you use non-portable constructs.
Smake warns you about the most common problems in makefiles.


> > When it turned out that the related people are not interested, all I could
> > do was to print warnings.
>
> Dodged the question there, didn't you? My question here goes unanswered. 
> Rather than putting workarounds in your code for the bugs you complain about 
> you've just put warnings in the code. Seems that that breaks orthagonality in 
> favor of complaining.

The more rotten Linux interfaces become, the harder it is to implement work
arounds.





> > The SCSI glue layer on Solaris is less than 50 kB. I did mention more than
> > once that a uniquely layered system could save a lot of code by avoiding to
> > implement things more than once.
>
> Does that glue code comprise the proposed SATL system? Recently I've come 
> across those whitepapers and opened a discussion about it on LKML.

??? Solaris supports SAS decives, is this your question?


> > Well, on such a system, a /dev/hd driver is not needed for the CD-ROM.
> > A SCSI disk driver would be sufficient.
>
> and? The ATA/IDE drivers are more compact that requiring the _entire_ SCSI 
> transport code and the specific SCSI driver for a device.

This is an unproven statement.


> > > I can see how the residual DMA count information might be impossible to
> > > get at - the Linux memory allocator has been changed quite a bit over the
> > > course of the past nine years.
> >
> > Most other OS provide this information.
> >
> > Is Linux really that underdeveloped for not being able to provide DMA
> > residual counts?
>
> No idea. All I said was that with the changes to how the memory allocator 
> works I can see where it might be impossible to get such information. I don't 
> think it is, though. What I think is that the developers of the allocator and 
> the DMA systems just forgot to include such a capability.

It seems that Linux is not used for developing SCSI applications, otherwise
I would not be the only person complaining about this missing feature.

I am using SunOS/Solaris for my SCSI programs since 1985, so I don't have 
problem. It seems that Linux users don't like to know if their software fails.



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
