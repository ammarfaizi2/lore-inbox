Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262083AbSJZK0t>; Sat, 26 Oct 2002 06:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262042AbSJZK0a>; Sat, 26 Oct 2002 06:26:30 -0400
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:34828 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262070AbSJZKYy>; Sat, 26 Oct 2002 06:24:54 -0400
X-Envelope-From: pavel@bug.ucw.cz
Date: Thu, 24 Oct 2002 13:24:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@muc.de>
Cc: Jeff Dike <jdike@karaya.com>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>, andrea <andrea@suse.de>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021024112411.GA783@elf.ucw.cz>
References: <1034981832.4042.58.camel@cog> <200210190352.WAA05769@ccure.karaya.com> <20021019031002.GA16404@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021019031002.GA16404@averell>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Since no one really brought up any issues with the code itself
> > > (correct me if I'm wrong), here is the i386 vsyscall gettimeofday port
> > > I sent last night, synced up and ready for integration.
> > 
> > This vsyscall implementation breaks UML.  Any app that's run inside UML
> > that uses vsyscalls will get the host's vsyscalls rather than the UML
> > vsyscalls.
> 
> Ugh.
> 
> Guess you'll have some problems then with UML on x86-64, which always uses
> vgettimeofday. But it's only used for gettimeofday() currently, perhaps it's 
> not that bad when the UML child runs with the host's time.

Well, if you want to use UML for time shifting (pretty common use,
AFAICS)...

> I guess it would be possible to add some support for UML
> to map own code over the vsyscall reserved locations. UML would need
> to use the syscalls then. But it'll be likely ugly.

I guess this is the right solution. [Or UML could simply unmap that
area and handle the faults...].
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
