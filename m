Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274850AbRIZHBt>; Wed, 26 Sep 2001 03:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274851AbRIZHB3>; Wed, 26 Sep 2001 03:01:29 -0400
Received: from femail12.sdc1.sfba.home.com ([24.0.95.108]:61183 "EHLO
	femail12.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S274850AbRIZHBY>; Wed, 26 Sep 2001 03:01:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: linux-kernel@vger.kernel.org
Subject: Fighting with K7VZA (via KT133A/686B): Any news?
Date: Tue, 25 Sep 2001 23:01:15 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01092523011505.01149@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clearing bit 7 of register 0x55 didn't help: it wasn't set on this 
motherboard.  Compiling the kernel for "pentium classic" didn't help.   
Swapping the tulip network card for an ne2k-pci managed to get RedHat 7.1 
installed, but it still paniced trying to untar the 2.4.10 kernal tarball. 

Background: A friend of mine got a shiny new motherboard, and put a 
thunderbird 950 processor and 256 megs of pc133 ram into it.  It can run 
memtest86 like a champ, overnight even.  Just don't try to access the PCI bus 
or you're playing russian roulette.

It hangs.  It panics.  It's not overclocked.  I know there are veterans out 
there who have fought with this before: has anybody actually found a way to 
nail it to the wall?

Sometimes it goes for half an hour (at the command prompt with nobody 
touching it, although it's been known to hang there too, but that could be 
cron or some such), sometimes it dies in thirty seconds.  Trying to recompile 
the linux kernel reliably either panics or hangs.  Untarring the kernel 
tarball has a better than even chance of dying too. 

Compiled 2.2.10 on another box, booted that from a floppy.  This time the 
tarball untarred, but it hung (and, on a second attempt, paniced) trying to 
recompile it.

Twiddling every bios setting there is (and upgrading the bios to get more 
settings to twiddle) just wastes time.  It's not a heat problem, we've 
confirmed this not just with the built-in thermometers but by TOUCHING the 
heat sinks.

Compiling a kernel for "pentium classic" didn't help.  I heard athlon 
optimizations offended Via's bureaucracy, but removing them didn't appease it.

I tried the patch that wandered by last week for the 686.  Did nothing.  It 
doesn't even trigger: bit 0x80 of register 0x55 this box's register set 
doesn't seem to be on.  The "686 Via southbridge" fix -IS- triggering on 
every boot (vialatency), but it's not solving the problem.

Stuck in a printk to see if bit 80 of register 0x55 is set in this box's 
register set.  Doesn't seem to be, the value appears to be 0x0b.

I've searched the lists and found a lot of theories.  The last concrete 
information I heard was that Alan Cox had a cold, but unfortunately was not 
in a position to give it to VIA in person.

Is there some way we can help?  (Perhaps arranging for fed-ex to mail used 
tissues from Alan's house to the Via developers, perhaps?)

Does the best course of action at this point involve attempting to get money 
back, and if so, which motherboard can actually accept ~gigahertz athlon and 
PC133 memory and possibly even do something useful with it under any known or 
expected 2.4 kernel variant?

Thanks for your time.  (How much did Tom's Hardware get paid to recommend 
this motherboard as "Rock Solid"?  What, Talc?  Pumice?  Sandstone?  Perhaps 
a particularly flaky vein of mica?)

Rob
