Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262042AbSJZK0t>; Sat, 26 Oct 2002 06:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262070AbSJZK0e>; Sat, 26 Oct 2002 06:26:34 -0400
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:34316 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262061AbSJZKYq>; Sat, 26 Oct 2002 06:24:46 -0400
X-Envelope-From: pavel@bug.ucw.cz
Date: Thu, 24 Oct 2002 13:24:50 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jeff Dike <jdike@karaya.com>
Cc: Andi Kleen <ak@muc.de>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>, andrea <andrea@suse.de>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021024112450.GB783@elf.ucw.cz>
References: <20021019031002.GA16404@averell> <200210190450.XAA06161@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210190450.XAA06161@ccure.karaya.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Guess you'll have some problems then with UML on x86-64, which always
> > uses vgettimeofday. But it's only used for gettimeofday() currently,
> > perhaps it's  not that bad when the UML child runs with the host's
> > time.
> 
> It's not horrible, but it's still broken.  There are people who depend
> on UML being able to keep its own time separately from the host.
> 
> > I guess it would be possible to add some support for UML to map own
> > code over the vsyscall reserved locations. UML would need to use the
> > syscalls then. But it'll be likely ugly. 
> 
> Yeah, it would be.
> 
> My preferred solution would be for libc to ask the kernel where the vsyscall
> area is.  That's reasonably clean and virtualizable.  Andrea doesn't like it
> because it adds a few instructions to the vsyscall address calculation.

But sandboxed application could still "guess" where vsyscall address
is and get the data it is not supposed to get, right?
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
