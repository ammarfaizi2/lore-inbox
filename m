Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261751AbRESK6C>; Sat, 19 May 2001 06:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261757AbRESK5w>; Sat, 19 May 2001 06:57:52 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:58268 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S261751AbRESK5f>;
	Sat, 19 May 2001 06:57:35 -0400
Message-Id: <m1514OU-000OeJC@amadeus.home.nl>
Date: Sat, 19 May 2001 11:55:34 +0100 (BST)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: ben@kalifornia.com (Ben Ford)
Subject: Re: CML2 design philosophy heads-up
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <20010518034307.A10784@thyrsus.com> <E150fV9-0006q1-00@the-village.bc.nu> <20010518105353.A13684@thyrsus.com> <3B053B9B.23286E6C@redhat.com> <20010518112625.A14309@thyrsus.com> <20010518093414.A21164@qcc.sk.ca> <mailman.990252541.15890.linux-kernel2news@redhat.com> <200105190640.f4J6efG11140@devserv.devel.redhat.com> <3B064690.2040803@kalifornia.com>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3B064690.2040803@kalifornia.com> you wrote:
> Second, how many kernels does Redhat ship in order to have one for 
> 386/486/586/k6/Athlon . . . .

We build a lot of them :)

> Quite a pain in the ass.  And look at how much shit has to be built in 
> in order to get a kernel that works for everybody!  People bitch at 
> Microsoft for doing it, then turn around and do the same thing.

MODULES

> I said a custom kernel build at install time.  I said nothing about 
> having it automated.  I wouldn't trust an automated build anyways, 
> especially if it came from Redhat.  With the philosophy ESR is aiming 
> at, it would be all to easy to ask the user if they'd like to build a 
> custom kernel, then present them with Eric's interface.  And that has 
> everything to do with interaction with good ole Aunt Tillie.

There is one important point here: NOBODY objects to having a simple
interface. KDE people made one, ESR is cloning their idea, fine with me. 

I and several others object to TAKING AWAY the "advanced" tool that _does_
allow me to build a kernel for "my freak hardware". 

ESR's method is incompatible with that. He wants to not even ask the
questions that he considers weird for a particular machine. So if I connect
a cdromdrive to my iPAQ, I'll have to resort to vi/emacs. That's not
progress. 

There is a distinction between "true dependencies" on a sourcecode level (eg
the PDC202xx IDE driver requires the core IDE code to be built in) and
dependencies/requirements/auto-selects on an "Aunt Tillie" level (eg I have
a Dell Machine type FOO -> IDE + proper controller are selected and VooDoo7
3D cards are asked / looked up in PCI config space).

The current Config.in system is not much more than making the true
dependencies explicit. AND that is enough for some of the GUI kernel config
tools out there to make an Aunt Tillie level config program. Yes they need
to add extra information. Some of that can even be extracted from the PCI
tables in the driver-sourcecode. Taking away the true dependency information
and replacing it by things that are likely/unlikely is bad. It will work for
95% of the PC's out there, sure. 

There's freak hardware. People build freak kernels. Heck, when I build the
Red Hat Linux kernel, ESR would call that a freak kernel. Because it
supports hardware combinations that are VERY unlikely. The kernel both
supports ISA NIC's and 8way SMP servers. Yes you're a freak if you put a ISA
NIC in your 8way server. But YES the Red Hat kernel needs both, although
it's unlikely you need both on the same machine.

Greetings,
   Arjan van de Ven
